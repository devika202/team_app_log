let lastActivityTime = new Date();
let inactivityThreshold = 30000; // 30 seconds in milliseconds
let inactiveStatusShown = false;

function resetActivityTimer() {
  lastActivityTime = new Date();
  hideInactiveStatus();
}

function hideInactiveStatus() {
    let statusElement = document.getElementById('inactive-status');
    if (statusElement) {
      statusElement.style.display = 'none';
    }
    inactiveStatusShown = false;
  }
  
  function showInactiveStatus() {
    let statusElement = document.getElementById('inactive-status');
    if (statusElement) {
      let currentTime = new Date();
      let inactivityTime = currentTime - lastActivityTime;
      statusElement.innerHTML = `Inactive for ${inactivityTime / 1000} seconds`;
      statusElement.style.display = 'block';
      inactiveStatusShown = true;
    }
  }
  

document.addEventListener('mousemove', resetActivityTimer);
document.addEventListener('keydown', resetActivityTimer);

setInterval(() => {
    console.log('Checking inactivity...');
    let currentTime = new Date();
    let inactivityTime = currentTime - lastActivityTime;
    if (inactivityTime >= inactivityThreshold) {
      console.log(`Inactive for ${inactivityTime / 1000} seconds`);
      showInactiveStatus();
    }
  }, 1000); // Check every second
  