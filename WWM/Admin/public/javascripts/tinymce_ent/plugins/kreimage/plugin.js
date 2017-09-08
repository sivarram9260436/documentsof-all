tinymce.PluginManager.add('kreimage', function(editor, url) {
    // Add a button that opens a window
    editor.addButton('kreimage', {
        text: '',
        icon: true,
        title: 'Insert/Edit Image',
        image: '/javascripts/tinymce_ent/plugins/kreimage/imageicon.png',
        onclick: function() {
            // Open window
            editor.windowManager.open({
            	
                title: 'Insert/Edit Image',
                url:"/admin/image_details/imageset_list?popup=true&type=tiny_mce",
                width:900,
                height:500,
                onsubmit: function(e) {
                   editor.insertContent('Title: ' + e.data.title);
                }
            });
        }
    });
});
