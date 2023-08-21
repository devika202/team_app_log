let lastActivityTime = new Date();
let inactivityThreshold = 30000; // 30 seconds in milliseconds
let inactiveStatusShown = false;

function resetActivityTimer() {
  lastActivityTime = new Date();
  hideInactiveStatus();
}

function showInactiveStatus() {
  if (!inactiveStatusShown) {
    let currentTime = new Date();
    let inactivityTime = currentTime - lastActivityTime;
    let statusElement = document.getElementById('inactive-status');
    statusElement.innerHTML = `Inactive for ${inactivityTime / 1000} seconds`;
    statusElement.style.display = 'block';
    inactiveStatusShown = true;
  }
}

function hideInactiveStatus() {
  let statusElement = document.getElementById('inactive-status');
  statusElement.style.display = 'none';
  inactiveStatusShown = false;
}

document.addEventListener('mousemove', resetActivityTimer);
document.addEventListener('keydown', resetActivityTimer);

setInterval(() => {
  let currentTime = new Date();
  let inactivityTime = currentTime - lastActivityTime;
  if (inactivityTime >= inactivityThreshold) {
    showInactiveStatus();
  }
}, 1000); // Check every second
;
