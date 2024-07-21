% Satellite Parameters
P_event_camera = 5; % Event Camera power consumption (W)
P_obcs = 30; % Nvidia Jetson OBCS power consumption (W)
P_propulsion = 20; % Electric Propulsion System power consumption (W)
P_thermal = 15; % Thermal System power consumption (W)

P_avg = P_event_camera + P_obcs + P_propulsion + P_thermal; % Total average power consumption (W)
t_orb = 100.723 * 60; % Orbital period (s) (100.723 minutes)
t_eclipse = 25.4 * 60; % Eclipse time (s) (25.4 minutes)
t_sunlight = t_orb - t_eclipse; % Sunlight time (s)

% Battery Parameters
V_battery = 28; % Battery voltage (V)
DOD = 0.8; % Depth of discharge

% Solar Array Parameters
eta_array = 0.3; % Solar cell efficiency
eta_battery = 0.9; % Battery charging efficiency
I_sun = 1361; % Solar constant (W/m²)

% Battery capacity calculation (Ah)
C_battery = (P_avg * t_eclipse) / (V_battery * DOD);

% Solar array power calculation (W)
P_array = (P_avg * t_orb) / (t_sunlight * eta_array * eta_battery);

% Solar array area calculation (m²)
A_array = P_array / I_sun;

% Display results
fprintf('Battery Capacity: %.2f Ah\n', C_battery);
fprintf('Solar Array Power: %.2f W\n', P_array);
fprintf('Solar Array Area: %.2f m²\n', A_array);