import "MusicDelegate.qml";

import "js/constants.js" as constants;

GridView
{
    id: musicView;
    property bool loading: false;
    cellWidth: constants.poster["width"] + 20;
    cellHeight: constants.poster["height"] + 85;
    visible: !loading;
    clip: true;
    delegate: MusicDelegate
    {
    }
    model: ListModel
    {
        id: musicModel;
    }
    function loadMusics(musics) 
    {
        musicView.loading = true;
        musicModel.reset();
        musics.forEach(function (musicItem) 
        {
            musicModel.append({poster: musicItem["posterUrl"],name:musicItem["name"] ,url: musicItem["videoUrl"]});
        });
        musicView.loading = false;
    }
}