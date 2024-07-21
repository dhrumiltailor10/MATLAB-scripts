% Constants
total_orbital_period = 100.723; % in minutes
eclipse_period = 19.68; % in minutes
sunlit_period = total_orbital_period - eclipse_period; % in minutes
solar_constant = 1361; % Solar constant in W/m^2
solar_panel_efficiency = 0.22; % Solar panel efficiency
battery_charging_efficiency = 0.9; % Battery charging efficiency
depth_of_discharge = 0.8; % Depth of Discharge (DoD)
battery_voltage = 28; % Battery Voltage in V

% Power Consumption (Average Power Consumption in W)
event_camera_power = 4; % Event Camera
obcs_power = 30; % OBCS (Nvidia Jetson)
thermal_system_power = 11.9; % Thermal System
chemical_propulsion_power = 75; % Chemical Propulsion
payload_accessories_power = 40.25; % Payload Accessories
adcs_power = 14; % ADCS
ttc_power = 51.7; % TT&C
power_subsystem_power = 41.9; % Power Subsystem
margin = 0.15;

% Total average power consumption
average_power_consumption = (event_camera_power + obcs_power + thermal_system_power + ...
                            chemical_propulsion_power + payload_accessories_power + ...
                            adcs_power + ttc_power + power_subsystem_power)*(1+margin);

% Solar Panel Sizing Calculation
energy_required_per_orbit = average_power_consumption * total_orbital_period * 60; % in Joules
energy_generated_per_orbit = solar_constant * solar_panel_efficiency * sunlit_period * 60 * battery_charging_efficiency;
solar_panel_area = energy_required_per_orbit / energy_generated_per_orbit; % in m^2

% Battery Sizing Calculation
battery_energy_required_during_eclipse = average_power_consumption * eclipse_period * 60; % in Joules
battery_capacity_required = battery_energy_required_during_eclipse / (battery_voltage * depth_of_discharge); % in Ah

% Output results
fprintf('Solar Panel Area: %.3f m^2\n', solar_panel_area);
fprintf('Battery Capacity Required: %.3f Ah\n', battery_capacity_required);
fprintf('Total Average Power Consumption: %.3f W\n', average_power_consumption);
