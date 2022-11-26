import controls.Player;
import controls.Media;
import controls.Spinner;
Player
{
    id:partyTimePlayer;
    focus:true;
    visible:true;
    isFullscreen: true;
    function PlayVideo(url)
    {
        partyTimePlayer.abort();
        partyTimePlayer.playUrl(url);
        searchPanel.visible = false;
        partyTimePlayer.setFocus();
    }
    
    onFinished:
    {
        partyTimePlayer.abort();
        partyTimeApp.hidePlayer();
       
    }
    
    onBackPressed:
    {
      musicPlayer.abort();
      partyTimeApp.hidePlayer();
    }
}