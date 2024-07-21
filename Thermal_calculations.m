% MATLAB script to calculate the equilibrium temperatures of a satellite
% for hot and cold cases based on the provided thermal design information.

% Constants
sigma = 5.670 * 10^-8; % Stefan-Boltzmann constant in W/(m^2*K^4)
phi_sun = 1370; % Solar constant in W/m^2
qI = 237; % Average IR energy flux from Earth in W/m^2
alpha = 0.2; % Absorptivity for white paint
epsilon = 0.9; % Emissivity for white paint

% Satellite dimensions and properties
length = 0.3; % Length in meters
width = 0.2; % Width in meters
height = 0.1; % Height in meters
A_sat = 2 * (length * width + width * height + height * length); % Surface area in m^2

% Internal power dissipation
P_total_op = 25.5; % Total power in operational mode in W
P_total_ecl = 5.1; % Total power in eclipse mode in W
Q_internal_hot = 0.5 * P_total_op; % Internal heat dissipation in hot case in W
Q_internal_cold = 0.5 * P_total_ecl; % Internal heat dissipation in cold case in W

% Hot case conditions
Q_sun_hot = alpha * phi_sun * (width * length); % Sun radiation
Q_albedo_hot = alpha * phi_sun * (width * length) * 0.85; % Albedo radiation (assumed 85% of sun radiation)
Q_earth_hot = alpha * qI * (width * length); % Planetary radiation using largest area of the satellite

% Cold case conditions
Q_sun_cold = 0; % No Sun radiation
Q_albedo_cold = 0; % No Albedo radiation
Q_earth_cold = alpha * qI * (width * height); % Planetary radiation using smallest area of the satellite

% Temperature calculation for hot case
syms T_hot
Q_emitted_hot = epsilon * sigma * A_sat * T_hot^4;
Q_net_hot = Q_sun_hot + Q_albedo_hot + Q_earth_hot + Q_internal_hot - Q_emitted_hot;
T_hot_sol = solve(Q_net_hot == 0, T_hot);
T_hot_equilibrium = double(T_hot_sol);

% Temperature calculation for cold case
syms T_cold
Q_emitted_cold = epsilon * sigma * A_sat * T_cold^4;
Q_net_cold = Q_sun_cold + Q_albedo_cold + Q_earth_cold + Q_internal_cold - Q_emitted_cold;
T_cold_sol = solve(Q_net_cold == 0, T_cold);
T_cold_equilibrium = double(T_cold_sol);

% Display the results
fprintf('Equilibrium temperature for hot case: %.2f K\n', T_hot_equilibrium);
fprintf('Equilibrium temperature for cold case: %.2f K\n', T_cold_equilibrium);

% Check if radiator or heater is required
if T_hot_equilibrium > 350 % Assuming 350 K as the maximum allowable temperature
    fprintf('A radiator is required for the hot case.\n');
else
    fprintf('No radiator is required for the hot case.\n');
end

if T_cold_equilibrium < 250 % Assuming 250 K as the minimum allowable temperature
    fprintf('A heater is required for the cold case.\n');
    required_heater_power = epsilon * sigma * A_sat * (250^4 - T_cold_equilibrium.^4); % Power required to maintain 250 K
    fprintf('Heater power required: %.2f W\n', required_heater_power);
else
    fprintf('No heater is required for the cold case.\n');
end
