
function FileAPI (t, d, f) {

    var fileList = t,
        fileField = f,
        dropZone = d,
        fileQueue = new Array()
        preview = null;


    this.init = function () {
       
        fileField.onchange = this.addFiles;
        dropZone.addEventListener("dragenter",  this.stopProp, false);
        dropZone.addEventListener("dragleave",  this.dragExit, false);
        dropZone.addEventListener("dragover",  this.dragOver, false);
        dropZone.addEventListener("drop",  this.showDroppedFiles, false);
    }

    this.addFiles = function () {
       var count = $('#fileList li').length;
       var single_image = $("#single_image").val();
        if((single_image == "true") && (count > 0)){
            alert("You can upload only one Image");
        }
        else{
            addFileListItems(this.files);
        }
        
    }

    this.showDroppedFiles = function (ev) {
        ev.stopPropagation();
        ev.preventDefault();
        var files = ev.dataTransfer.files;
        addFileListItems(files);
    }

    this.clearList = function (ev) {
        ev.preventDefault();
        while (fileList.childNodes.length > 0) {
            fileList.removeChild(
                fileList.childNodes[fileList.childNodes.length - 1]
            );
        }
    }

    this.dragOver = function (ev) {
        ev.stopPropagation();
        ev.preventDefault();
        this.style["backgroundColor"] = "#F0FCF0";
        this.style["borderColor"] = "#3DD13F";
        this.style["color"] = "#3DD13F"
    }

    this.dragExit = function (ev) {
        ev.stopPropagation();
        ev.preventDefault();
        dropZone.style["backgroundColor"] = "#FEFEFE";
        dropZone.style["borderColor"] = "#CCC";
        dropZone.style["color"] = "#CCC"
    }

    this.stopProp = function (ev) {
        ev.stopPropagation();
        ev.preventDefault();
    }

    this.uploadQueue = function (ev) {
        ev.preventDefault();
        while (fileQueue.length > 0) {
	            var item = fileQueue.pop();
		 //   alert(fileQueue)
		    var p = document.createElement("p");
	            p.className = "loader";
	            var pText = document.createTextNode("Uploading...");
	            p.appendChild(pText);
	            item.li.appendChild(p);
		   // alert(item.file.type.search(/image\/.*/))
		    if (item.file.size < 1048576 && item.file.type.search(/image\/.*/) != -1) {
		        uploadFile(item.file, item.li);
	        } 
	        else if (item.file.size > 1048576){
					p.textContent = "File to large";
	                p.style["color"] = "red";
		    }
	        else {
	                p.textContent = "File type doesn't match";
	                p.style["color"] = "red";
	        }
        }
    }
    
    /*var addFileListItems = function (files) {
        for (var i = 0; i < files.length; i++) {
            var fr = new FileReader();
            fr.file = files[i];
            fr.onloadend = showFileInList;
            fr.readAsDataURL(files[i]);
        }
    }*/
     var addFileListItems = function (files) {
         var single_image = $("#single_image").val();
        for (var i = 0; i < files.length; i++) {
            if((single_image == "true") && (i > 0)){
                alert("You can upload only one Image");
                break;
            }
            var fr = new FileReader();
            fr.file = files[i];
            fr.onloadend = showFileInList;
            fr.readAsDataURL(files[i]);
            
       }
    }

    var showFileInList = function (ev) {
        var file = ev.target.file;
	if (file) {
            var li = document.createElement("li");
            if (file.type.search(/image\/.*/) != -1) {
                var thumb = new Image();
                thumb.src = ev.target.result;
                /* commented because we no need preview over here */
                /* thumb.addEventListener("mouseover", showImagePreview, false);
                thumb.addEventListener("mouseout", removePreview, false); */
                li.appendChild(thumb);
            }
            var h3 = document.createElement("h3");
            var h3Text = document.createTextNode(file.name);
            h3.appendChild(h3Text);
            li.appendChild(h3)
            var p = document.createElement("p");
            var pText = document.createTextNode(
                "File type: ("
                + file.type + ") - " +
                Math.round(file.size / 1024) + "KB"
            );
            p.appendChild(pText);
            li.appendChild(p);
            var divLoader = document.createElement("div");
            divLoader.className = "loadingIndicator";
            jQuery(li).append("<p><label>Title:</label> <input type='text' class='title' /></p>");
            jQuery(li).append("<p><label>Description:</label><textarea type='text' class='description' ></textarea></p>");
            jQuery(li).append("<p><label>Caption:</label><input type='text' class='caption' /></p>");
            li.appendChild(divLoader);
            fileList.appendChild(li);
            fileQueue.push({
                file : file,
                li : li
            });
        }
    }

    var showImagePreview = function (ev) {
        var div = document.createElement("div");
        div.style["top"] = (ev.pageY + 10) + "px";
        div.style["left"] = (ev.pageX + 10) + "px";
        div.style["opacity"] = 0;
        div.className = "imagePreview";
        var img = new Image();
        img.src = ev.target.src;
        div.appendChild(img);
        document.body.appendChild(div);
        document.body.addEventListener("mousemove", movePreview, false);
        preview = div;
        fadePreviewIn();
    }

    var movePreview = function (ev) {
        if (preview) {
            preview.style["top"] = (ev.pageY + 10) + "px";
            preview.style["left"] = (ev.pageX + 10) + "px";
        }
    }

    var removePreview = function (ev) {
        document.body.removeEventListener("mousemove", movePreview, false);
        document.body.removeChild(preview);
    }

    var fadePreviewIn = function () {
        if (preview) {
            var opacity = preview.style["opacity"];
            for (var i = 10; i < 250; i = i+10) {
                (function () {
                    var level = i;
                    setTimeout(function () {
                        preview.style["opacity"] = opacity + level / 250;
                    }, level);
                })();
            }
        }
    }

    var uploadFile = function (file, li) {
        if (li && file) {
            var xhr = new XMLHttpRequest(),
                upload = xhr.upload;
            upload.addEventListener("progress", function (ev) {
                if (ev.lengthComputable) {
                    var loader = li.getElementsByTagName("div")[0];
                    loader.style["width"] = (ev.loaded / ev.total) * 100 + "%";
                }
            }, false);
            upload.addEventListener("load", function (ev) {
                var ps = li.getElementsByTagName("p");
                var div = li.getElementsByTagName("div")[0];
                div.style["width"] = "100%";
                div.style["backgroundColor"] = "#0f0";
                for (var i = 0; i < ps.length; i++) {
                    if (ps[i].className == "loader") {
                        ps[i].textContent = "Upload complete";
                        ps[i].style["color"] = "#3DD13F";
                        break;
                    }
                }
            }, false);
            var single_image = $("#single_image").val();
            var path = window.location.host;
            var type = $(".active_page #type").val();
            pars = '&image[site_id]=' +document.getElementById("image_site_id").value+'&image[licence_type]=Universal rights granted to all users'+'&commit=Upload Image'+'&multiple_image=true' ;
            upload.addEventListener("error", function (ev) {console.log(ev);}, false);
            xhr.open(
                "POST",
                $("#multiple_image_upload").attr("action")+"?"+pars
            );
            xhr.onreadystatechange=function()
            {
                if (xhr.readyState == 4 && xhr.status == 200 && single_image == "true")
                {
                    window.location = "http://" + path + "/admin/image_details/insert_image_to_article?id=" + xhr.responseText
                }
                else if (xhr.readyState == 4 && xhr.status == 200 && type == "tiny_mce")
                {
                    window.location = "http://" + path + "/admin/image_details/imageset_list?popup=true&type=tiny_mce"
                }
                else if (xhr.readyState == 4 && xhr.status == 200)
                {
                    window.location = "http://" + path + "/admin/image_details/imageset_list"
                }
            }
            
            xhr.setRequestHeader("Cache-Control", "no-cache");
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            xhr.setRequestHeader("X-CSRF-Token",jQuery('meta[name="csrf-token"]').attr('content'));
            xhr.setRequestHeader("X-File-Name", file.name);
            xhr.send(file);
        }
    }
    
}

window.onload = function () {
   
    if (typeof FileReader == "undefined") alert ("Sorry your browser does not support for the Multiple Image upload feature");
    FileAPI = new FileAPI(
        document.getElementById("fileList"),
        document.getElementById("fileDrop"),
        document.getElementById("fileField")
    );
    FileAPI.init();
    var reset = document.getElementById("reset");
    reset.onclick = FileAPI.clearList;
    var upload = document.getElementById("upload");
    upload.onclick = FileAPI.uploadQueue;
}
