import consumer from "channels/consumer"

consumer.subscriptions.create("SwitcherChannel", {
  connected() {
    
    
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const switchContainer = document.getElementById('switch');
    if (!switchContainer) return;

    let switcher;
    try {
      switcher = JSON.parse(data);  // Ensure data is valid JSON
    } catch (error) {
      console.error('Invalid JSON received:', data);
      return;
    }
    // alert(switcher)
    
    // Use toggle to manage the 'off' class based on switcher.on
    switchContainer.classList.toggle('off', !switcher.on);

    if (switcher.on){
      alert(`Только что ${switcher.player} включил выключатель. Ура!`)
    }
    else{
      alert(`Ой, ой, свет выключили`)
    }
    
  }
});