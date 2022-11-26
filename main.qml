import "CategoryMenu.qml";
import "MusicView.qml";
import "PartyTimePlayer.qml";
import controls.Button;
import controls.Edit;
import controls.FloatingText;
import controls.Spinner;
Application
{
  id: partyTimeApp;

  Item
  {
    id: searchPanel;
    anchors.left:parent.left;
    anchors.right:parent.right;
    anchors.top:parent.top;
    height: 50;
    Text
    {
      id: fieldSearch;
      anchors.fill:parent;
      font: titleFont;
      text: keyBoardObj.text ? "Поиск: " + keyBoardObj.text : "Поиск";
      color: colorTheme.activeTextColor;
    }
    VirtualKeyboard
    {
      id: keyBoardObj;
      onAccepted:
      {
         partyTimeApp.SearchMusics("http://api.energy-rust.ru/GSLabs/PartyTimes?name=" + encodeURIComponent(text));
         if (musicView.model.count >= 1)
      {
        musicView.setFocus();
      } else {categoryMenu.setFocus();}
      }
    }

  }

  Item
  {
    id: categoriesBlock;
    anchors.left:parent.left;
    anchors.right:musicView.left;
    anchors.top:searchPanel.bottom;
    anchors.bottom:parent.bottom;
    width: 350;
    anchors.topMargin:15;
    CategoryMenu
    {
      id: categoryMenu;
      anchors.left:parent.left;
      anchors.right:parent.right;
      anchors.bottom:parent.bottom;
      spacing: 30;
      onKeyPressed:
      {
        if (key === "Select" || key === "Right") {
          musicView.visible = true;
          var currentCategory = model.get(categoryMenu.currentIndex);
          musicView.loadMusics(currentCategory.musics);
          musicView.setFocus();
        }
        if (key === "Up" && categoryMenu.currentIndex === 0) {
          fieldSearch.setFocus();
          keyBoardObj.visible = true;
        }
      }
    }
  }

  MusicView
  {
    id: musicView;
    anchors.top:searchPanel.bottom;
    anchors.left:categoriesBlock.right;
    anchors.right:parent.right;
    anchors.bottom:parent.bottom;
    anchors.topMargin:15;
    onSelectPressed:
    {
      this.visible = false;
      categoriesBlock.visible = false;
      var currentCategory = model.get(musicView.currentIndex);
      musicPlayer.PlayVideo(currentCategory.url);
    }
    onLeftPressed:
    {
      if (!this.moveCurrentIndexLeft())
      {
        categoryMenu.setFocus();
      }
    }

  }

  PartyTimePlayer
  {
    id: musicPlayer;
    visible:false;
    anchors.fill:parent;
  }
  onBackPressed:
  {
    keyBoardObj.text="";
    musicView.loadMusics(partyTimeCategories.model.get(0).musics);
   
    appManager.closeCurrentApp();
  }

  function hidePlayer() {
    categoriesBlock.visible = true;
    musicView.visible = true;
    searchPanel.visible = true;
    musicPlayer.visible = false;
    musicView.setFocus();
  }

  function SearchMusics(url) {

    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
      if (request.readyState !== XMLHttpRequest.DONE)
        return;
      if (request.status && request.status === 200) {
        musicView.loadMusics(JSON.parse(request.responseText)["musics"]);
      }
    }
    request.open("GET", url, true);
    request.send();
  }
}