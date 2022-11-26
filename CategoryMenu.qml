import controls.Button;
import "CategoryDelegate.qml";
import "js/constants.js" as cc;
ListView
{
    id:partyTimeCategories;
    anchors.fill: parent;
    focus:true;

    model: ListModel
    {
    }

    delegate: CategoryDelegate
    {
    }

    onCompleted:{
        loadData("http://api.energy-rust.ru/GSLabs/PartyTimes");
    }

    function loadData(url) {
        var request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if (request.readyState !== XMLHttpRequest.DONE)
                return;

            if (request.status && request.status === 200) {
                var data = JSON.parse(request.responseText);
                data["categories"].forEach((catalogItem) => {
                    model.append({title: catalogItem["name"], musics: catalogItem["partyTimes"]});
                });
                musicView.loadMusics(model.get(0).musics)
            }
        }
        request.open("GET", url, true);
        request.send();
    }
}
