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
    console.log(switcher);
    
    
    const last_name = document.getElementById('last_name');
    if (last_name) {
      switcher.player && (last_name.textContent = switcher.player);
    }
    const last_time = document.getElementById('last_time')
    if (last_time) {
      switcher.time && (last_time.textContent = switcher.time);
    }
    const total_count = document.getElementById('total_count')
    if (total_count) {
      switcher.count && (total_count.textContent = switcher.count.toString());
    }
    const on_time = document.getElementById('on_time')
    if (on_time) {
      switcher.on_time && (on_time.textContent = switcher.on_time);
    }
    const off_time = document.getElementById('off_time')
    if (off_time) {
      switcher.off_time && (off_time.textContent = switcher.off_time);
    }

    const best_on_players = document.getElementById('best_on_players')
    if (best_on_players) {
      best_on_players.innerHTML = '';
      if (switcher.best_on_players && switcher.best_on_players.length > 0) {
        for (const player of switcher.best_on_players) {
          const p = document.createElement('p');
          p.innerHTML = `Игрок ${player.name} включил ${player.count} раз(а).`;
          best_on_players.appendChild(p);
        }
      }
    }
    const best_off_players = document.getElementById('best_off_players')
    if (best_off_players) {
      best_off_players.innerHTML = '';
      if (switcher.best_off_players && switcher.best_off_players.length > 0) {
        for (const player of switcher.best_off_players) {
          const p = document.createElement('p');
          p.innerHTML = `Игрок ${player.name} выключил ${player.count} раз(а).`;
          best_off_players.appendChild(p);
        }
      }
    }
    
    // Use toggle to manage the 'off' class based on switcher.on
    switchContainer.classList.toggle('off', !switcher.on);
    
  }
});