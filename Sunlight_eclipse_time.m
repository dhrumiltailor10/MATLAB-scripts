% Define constants
mu = 3.986004418e14; % Earth's gravitational parameter (m^3/s^2)
R_earth = 6371e3; % Earth's radius (m)
sun_radius = 695700e3; % Sun's radius (m)
AU = 149.6e9; % Astronomical Unit (m)

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

% Calculate Earth-Sun distance
earth_sun_distance = AU; % Assuming average Earth-Sun distance

% Calculate the angle between the sun and the spacecraft's orbital plane
beta = acos(cos(inclination) * cos(deg2rad(23.44))); % 23.44 degrees is Earth's axial tilt

% Calculate the argument of the acos function
arg_acos = tan(beta) * tan(asin(sun_radius/earth_sun_distance));

% Ensure the argument is within the valid range for acos
if arg_acos > 1
    arg_acos = 1; % Set to 1 to avoid errors
elseif arg_acos < -1
    arg_acos = -1; % Set to -1 to avoid errors
end

% Calculate the duration of sunlight and eclipse
sunlight_time = period * (1 - acos(arg_acos) / (2*pi)); % Correctly divide by 2*pi
eclipse_time = period - sunlight_time;

% Display results
fprintf('Sunlight Time: %.2f minutes\n', sunlight_time/60);
fprintf('Eclipse Time: %.2f minutes\n', eclipse_time/60);