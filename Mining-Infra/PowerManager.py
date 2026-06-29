import time
import random

class ASICEMiningPowerManager:
    """
    Advanced Sovereign Infrastructure & Crypto Ecosystem (ASICE)
    Mining Infrastructure Load Balancing and Thermal Management System.
    Developed by Eng. Awsan Adel Abdulbari Ahmed Sultan
    Copyright © 2026 Eng. Awsan Sultan. All Rights Reserved.
    """
    def __init__(self):
        self.operator = "Eng. Awsan Adel Abdulbari Ahmed Sultan"
        self.national_id = "01010305468"
        self.max_safe_temperature = 75.0  # Celsius limit for secure computing
        self.infrastructure_online = True

    def monitor_hardware_telemetry(self, rig_id):
        """
        Simulates and reads secure live telemetry from the localized computing servers and PSU/UPS layers.
        """
        current_temp = round(random.uniform(50.0, 78.0), 2)
        current_load = round(random.uniform(65.0, 98.0), 2)
        
        print(f"[MONITOR] Rig {rig_id} -> Temperature: {current_temp}°C, Load: {current_load}%")
        
        if current_temp > self.max_safe_temperature:
            self.execute_emergency_shutdown(rig_id, current_temp)
            return "SHUTDOWN_TRIGGERED"
        return "STABLE"

    def execute_emergency_shutdown(self, rig_id, excessive_temp):
        """
        Protects the localized server farm and node cluster from physical infrastructure meltdowns.
        """
        print(f"[⚠️ WARNING] Temperature Breach on Rig {rig_id}: {excessive_temp}°C!")
        print(f"[ACTION] Initializing secure automated power down authorized by: {self.operator}...")
        self.infrastructure_online = False
        print(f"[SUCCESS] Rig {rig_id} isolated from power grid. Infrastructure protected.")

if __name__ == "__main__":
    power_engine = ASICEMiningPowerManager()
    print("ASICE Infrastructure Power Manager Activated Successfully.")
    print(f"Verified Grid Controller: {power_engine.operator}")
    
    # محاكاة سريعة لفحص البيانات البرمجية
    for i in range(1, 4):
        status = power_engine.monitor_hardware_telemetry(rig_id=f"ASICE-NODE-0{i}")
        if status == "SHUTDOWN_TRIGGERED":
            break
        time.sleep(0.5)
