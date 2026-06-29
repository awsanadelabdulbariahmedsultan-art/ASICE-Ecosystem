/**
 * ASICE Ecosystem - Pi Network SDK Integration Bridge
 * Designed explicitly for secure execution inside Pi Browser Sandbox
 */

window.addEventListener('DOMContentLoaded', () => {
    console.log("ASICE Infrastructure Web Node Core Initialized.");
    bindPiWalletContext();
});

function bindPiWalletContext() {
    // التحقق الفوري من تهيئة حزمة المطورين المضمنة لشبكة باي (Pi App Container)
    if (window.Pi) {
        const walletStatus = document.getElementById('pi-wallet-status');
        walletStatus.innerHTML = "<i class='fa-solid fa-circle-check'></i> Pi Browser: Connected";
        walletStatus.style.background = "#2b9348";
        walletStatus.style.borderColor = "#1b4332";
        console.log("Sovereign Node authentication context bound to Pi Network sandbox backend.");
    } else {
        console.log("Standard runtime web node detected. Running modules in simulation mode.");
    }
}
