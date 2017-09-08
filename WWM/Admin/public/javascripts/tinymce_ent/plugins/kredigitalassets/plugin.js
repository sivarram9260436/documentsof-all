tinymce.PluginManager.add('kredigitalassets', function(editor, url) {
    // Add a button that opens a window
    editor.addButton('kredigitalassets', {
        text: '',
        title: 'Digital Asset',
        image: '/javascripts/tinymce_ent/plugins/kredigitalassets/assetimage.png',
        icon: true,
        onclick: function() {
            // Open window
            editor.windowManager.open({
                title: 'Insert/Edit Digital Assets',
                url:"/admin/digital_assets/article_asset?popup=true&&tiny_mce=true",
                width:900,
                height:500,
                onsubmit: function(e) {
                   editor.insertContent('Title: ' + e.data.title);
                }
            });
        }
    });
});
