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
        addFileListItems(this.files);
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


this.uploadQueue = function (ev) {  //start of upload uploadQueue

        ev.preventDefault();
        	var seq_name = jQuery("#image_sequence_name").attr('value')
                var filelist = jQuery('#fileList li').size();
		if(seq_name == '' && filelist==0 ){
                            alert('* Gallery title should not be blank\n* Image list should not be blank');
                            return false;
                }
                else if(seq_name == '' && filelist>0){
			alert('* Gallery title should not be blank');
                        return false;
		}
		else if(seq_name != '' && filelist==0){
			alert('* Image list should not be blank');
                        return false;
		}
                else{
			
               
        if(fileQueue.length>0){
                //alert('image upload');
                if(document.getElementById('gallery_type').value=="gallery" || document.getElementById('gallery_type').value=="article"){
//alert('gallery')
                                jQuery.ajax({
                                        type:'POST',
                                        url:'/admin/image_details/gallery_sequence_path',

                              data:'&image_sequence[publish_date]=' +document.getElementById("image_sequence_publish_date_id").value+'&image_sequence[tag]=' +document.getElementById("image_sequence_tag").value+'&image_sequence[name]=' +document.getElementById("image_sequence_name").value,
                                        success:function (data){
//alert(data);
                                                        jQuery('#gallery_path_id').attr('value',data);
                                                while (fileQueue.length > 0) {
                    var item = fileQueue.pop();
                 //   alert(fileQueue)
                    var p = document.createElement("p");
                    p.className = "loader";
                    var pText = document.createTextNode("Uploading...");
                    p.appendChild(pText);
                    item.li.appendChild(p);
                   // alert(item.file.type.search(/image\/.*/))
                    if (item.file.size < 10485760 && item.file.type.search(/image\/.*/) != -1) {
                        uploadFile(item.file, item.li);
                }
                else if (item.file.size > 10485760){
                                        p.textContent = "File to large";
                        p.style["color"] = "red";
                    }
                else {
                        p.textContent = "File type doesn't match";
                        p.style["color"] = "red";
                }
        }

                                        }
                                });
               }


        }
		}
  }  //end of upload uploadQueue

   var addFileListItems = function (files) {
        for (var i = 0; i < files.length; i++) {
            var fr = new FileReader();
            fr.file = files[i];
            fr.onloadend = showFileInList;
            fr.readAsDataURL(files[i]);
        }
    }

    var showFileInList = function (ev) {
var gallery_type = document.getElementById('gallery_type').value;
        var file = ev.target.file;
        if (file) {
            var li = document.createElement("li");
            if (file.type.search(/image\/.*/) != -1) {
                var thumb = new Image();
                thumb.src = ev.target.result;
                thumb.addEventListener("mouseover", showImagePreview, false);
                thumb.addEventListener("mouseout", removePreview, false);
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

        if(gallery_type=="gallery"){
            jQuery(li).append("<p><label>Title:</label> <input type='text' class='title' /></p>");
            jQuery(li).append("<p><label>Description:</label><textarea type='text' class='description' ></textarea></p>");
            jQuery(li).append("<p><label>Caption:</label><input type='text' class='caption' /></p>");

         }
        else if(gallery_type=="article"){
            jQuery(li).append("<p><label>Title:</label> <input type='text' class='title' /></p>");
            jQuery(li).append("<p><label>Description:</label><textarea type='text' class='description' ></textarea></p>");
            jQuery(li).append("<p><label>Caption:<input type='text' class='caption' /></p>");
        }


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

            var final_action = null;
            var pars = null;
            var gallery_type = document.getElementById('gallery_type').value;
            var form_action = document.getElementById('gallery_form_action').value;
            if(gallery_type == "gallery"){
              final_action = form_action;
             // pars = '&gallery_list='+document.getElementById('gallery_list').value+'&image_sequence_id='+document.getElementById("image_sequence_id").value+'&image[site_id]=' +document.getElementById("image_site_id").value+'&image[licence_type]=Universal rights granted to all users'+'&commit=Upload Image'+'&multiple_image=true' ;
             pars = '&image_sequence[publish_date]=' +document.getElementById("image_sequence_publish_date_id").value+'&image_sequence[tag]=' +document.getElementById("image_sequence_tag").value+'&image_sequence[name]=' +document.getElementById("image_sequence_name").value+'&gallery_list='+document.getElementById('gallery_list').value+'&image_sequence_id='+document.getElementById("image_sequence_id").value+'&image[site_id]=' +document.getElementById("image_site_id").value+'&image[licence_type]=Universal rights granted to all users'+'&commit=Upload Image'+'&multiple_image=true&site_id='+jQuery('#image_sequence_data_proxy_id').attr('value') ;


//alert(pars);
                }
           else if(gallery_type=="image") {
              final_action = form_action;
             pars = '&image[site_id]=' +document.getElementById("image_site_id").value+'&image[licence_type]=Universal rights granted to all users'+'&commit=Upload Image'+'&multiple_image=true' ;

            }
        else if(gallery_type=="article"){
              final_action = form_action;
              pars = '&gallery_list='+document.getElementById('gallery_list').value+'&image_sequence_id='+document.getElementById("image_sequence_id").value+'&image[site_id]=' +document.getElementById("image_site_id").value+'&image[licence_type]=Universal rights granted to all users'+'&commit=Upload Image'+'&multiple_image=true' ;
        }

            upload.addEventListener("error", function (ev) {console.log(ev);}, false);
             xhr.onreadystatechange=function(){
                 if (xhr.readyState==4 && xhr.status==200){
                        //if(document.getElementById('gallery_type').value == "gallery"){
                          //  window.location = document.getElementById('redirect').value;
                        //}
                        if(document.getElementById('gallery_type').value=="article"){
                                jQuery.ajax({
                                        type:'POST',
                                        url:'/admin/image_details/gallery_image_path',
                                        //data:'image_sequence_id='+document.getElementById("image_sequence_id").value,
                                         data:'image_sequence_id='+document.getElementById("gallery_path_id").value,
                                        success:function (data){
                                         jQuery('#image_path').attr('value',data);
                                        //insert_gallery_to_article(data,document.getElementById("image_sequence_id").value)
                                        }
                                });
                        }
                }
             }
            xhr.open("POST",final_action,true);
            xhr.setRequestHeader("Cache-Control", "no-cache");
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            xhr.setRequestHeader("X-File-Name", file.name);
            xhr.setRequestHeader('X-CSRF-Token', document.getElementById('form_authen').value);
            var formData = new FormData();
            formData.append("image[site_id]",document.getElementById("image_site_id").value );

            if(gallery_type != "image"){
                formData.append('image_sequence_id',document.getElementById("gallery_path_id").value );
                formData.append('image_sequence[publish_date]',document.getElementById("image_sequence_publish_date_id").value );
                formData.append('image_sequence[tag]',document.getElementById("image_sequence_tag").value );
                formData.append('image_sequence[name]',document.getElementById("image_sequence_name").value );
               // formData.append('image_sequence_image_orientation',document.getElementById("image_sequence_image_orientation").value );

            }
            formData.append("image[licence_type]","Universal rights granted to all users");
            formData.append("commit","Upload Image");
            formData.append("multiple_image",true);
            formData.append("image_property[title]", jQuery(".title",jQuery(li)).val());
            formData.append("image_property[description]", jQuery(".description",jQuery(li)).val());
            formData.append("image_property[caption]", jQuery(".caption",jQuery(li)).val());
            formData.append("fileToUpload",file);
            xhr.send(formData);

            //xhr.send(file);
                /* if(document.getElementById('gallery_type').value == "gallery"){
                    window.location = 'http://192.168.18.11:4000/admin/image_details/gallery_list'
                }*/
      }
    }


}

window.onload = function () {
    if (typeof FileReader == "undefined") alert ("Sorry your browser does not support the File API and this demo will not work for you");
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

