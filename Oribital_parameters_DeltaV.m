% Define constants
mu = 3.986004418e14; % Earth's gravitational parameter (m^3/s^2)
R_earth = 6371e3; % Earth's radius (m)

% Define target orbit parameters
altitude_periapsis = 500e3; % Periapsis altitude (m)
altitude_apoapsis = 1000e3; % Apoapsis altitude (m)
inclination = 55; % Inclination (degrees)

% Calculate orbital parameters
r_periapsis = R_earth + altitude_periapsis; % Periapsis radius (m)
r_apoapsis = R_earth + altitude_apoapsis; % Apoapsis radius (m)
a = (r_periapsis + r_apoapsis) / 2; % Semi-major axis (m)
e = (r_apoapsis - r_periapsis) / (r_apoapsis + r_periapsis); % Eccentricity
period = 2*pi*sqrt(a^3/mu); % Orbital period (s)

% Calculate DeltaV for orbit raising (assuming Hohmann transfer)
v_circular_initial = sqrt(mu/R_earth); % Initial circular velocity (m/s)
v_transfer_periapsis = sqrt(mu*(2/r_periapsis - 1/a)); % Velocity at periapsis of transfer orbit
v_transfer_apoapsis = sqrt(mu*(2/r_apoapsis - 1/a)); % Velocity at apoapsis of transfer orbit
v_circular_final = sqrt(mu/r_apoapsis); % Final circular velocity (m/s)
DeltaV_orbit_raising_1 = v_transfer_periapsis - v_circular_initial; % DeltaV at periapsis
DeltaV_orbit_raising_2 = v_circular_final - v_transfer_apoapsis; % DeltaV at apoapsis
DeltaV_orbit_raising_total = DeltaV_orbit_raising_1 + DeltaV_orbit_raising_2; % Total DeltaV for orbit raising

% Calculate DeltaV for deorbiting (assuming Hohmann transfer)
r_deorbit = R_earth + 100e3; % Deorbit radius (m)
v_circular_deorbit = sqrt(mu/r_deorbit); % Circular velocity at deorbit altitude (m/s)
v_transfer_periapsis = sqrt(mu*(2/r_periapsis - 1/r_deorbit)); % Velocity at periapsis of transfer orbit
v_transfer_apoapsis = sqrt(mu*(2/r_apoapsis - 1/r_deorbit)); % Velocity at apoapsis of transfer orbit
DeltaV_deorbit_1 = v_circular_deorbit - v_transfer_periapsis; % DeltaV at periapsis
DeltaV_deorbit_2 = v_transfer_apoapsis - v_circular_final; % DeltaV at apoapsis
DeltaV_deorbit_total = DeltaV_deorbit_1 + DeltaV_deorbit_2; % Total DeltaV for deorbiting

% Display results
fprintf('Orbital Parameters:\n');
fprintf('Periapsis Radius: %.2f km\n', r_periapsis/1e3);
fprintf('Apoapsis Radius: %.2f km\n', r_apoapsis/1e3);
fprintf('Semi-major Axis: %.2f km\n', a/1e3);
fprintf('Eccentricity: %.4f\n', e);
fprintf('Orbital Period: %.2f minutes\n', period/60);

fprintf('\nDeltaV Calculations:\n');
fprintf('DeltaV for Orbit Raising (Periapsis): %.2f m/s\n', DeltaV_orbit_raising_1);
fprintf('DeltaV for Orbit Raising (Apoapsis): %.2f m/s\n', DeltaV_orbit_raising_2);
fprintf('Total DeltaV for Orbit Raising: %.2f m/s\n', DeltaV_orbit_raising_total);
fprintf('DeltaV for Deorbiting (Periapsis): %.2f m/s\n', DeltaV_deorbit_1);
fprintf('DeltaV for Deorbiting (Apoapsis): %.2f m/s\n', DeltaV_deorbit_2);
fprintf('Total DeltaV for Deorbiting: %.2f m/s\n', DeltaV_deorbit_total);