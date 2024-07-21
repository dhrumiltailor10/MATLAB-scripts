% MATLAB Script for Optics Calculations for Event Camera
% You can modify the parameters in the "Parameters" section as needed
% CeleX-V Event sensor dimensions used
% Resolution: 1280 x 800 pixels
% Pixel Size: 14.1 µm (micrometers)

% Clear previous data
clear;
clc;

%% Parameters
% Altitude in meters
altitude = 500000;  % 500 km

% Pixel size in meters (14.1 micrometers)
pixel_size = 14.1e-6;

% Sensor resolution (width x height)
sensor_resolution = [1280, 800];

% Wavelength in meters (700 nm)
wavelength = 700e-9;

% Ground Sampling Distance (GSD) in meters
GSD = 1;

%% Calculate Focal Length
focal_length = (altitude * pixel_size) / GSD;

% Display Focal Length
fprintf('Focal Length: %.2f meters\n', focal_length);

%% Calculate Aperture Size
% Rayleigh criterion factor
rayleigh_factor = 2.44;

% Aperture diameter
aperture_diameter = rayleigh_factor * (wavelength * altitude) / GSD;

% Display Aperture Diameter
fprintf('Aperture Diameter: %.2f meters\n', aperture_diameter);

%% Calculate Field of View (FOV)
% Sensor dimensions in meters
sensor_width = sensor_resolution(1) * pixel_size;
sensor_height = sensor_resolution(2) * pixel_size;

% Angular FOV in radians
fov_horizontal = 2 * atan(sensor_width / (2 * focal_length));
fov_vertical = 2 * atan(sensor_height / (2 * focal_length));

% Convert FOV to degrees
fov_horizontal_deg = rad2deg(fov_horizontal);
fov_vertical_deg = rad2deg(fov_vertical);

% Display FOV
fprintf('Horizontal FOV: %.2f degrees\n', fov_horizontal_deg);
fprintf('Vertical FOV: %.2f degrees\n', fov_vertical_deg);

%% Calculate Scene Size
% Horizontal scene size in meters
scene_size_horizontal = 2 * altitude * tan(fov_horizontal / 2);

% Vertical scene size in meters
scene_size_vertical = 2 * altitude * tan(fov_vertical / 2);

% Display Scene Size
fprintf('Horizontal Scene Size: %.2f meters\n', scene_size_horizontal);
fprintf('Vertical Scene Size: %.2f meters\n', scene_size_vertical);

%% Example Usage for Different Altitudes
altitudes = [500000, 750000, 1000000];  % Altitudes in meters
fprintf('\nScene Size at Different Altitudes:\n');
for i = 1:length(altitudes)
    scene_size_h = calculate_scene_size(fov_horizontal, altitudes(i));
    scene_size_v = calculate_scene_size(fov_vertical, altitudes(i));
    fprintf('Altitude: %d meters - Horizontal Scene Size: %.2f meters, Vertical Scene Size: %.2f meters\n', ...
        altitudes(i), scene_size_h, scene_size_v);
end

%% Function to Calculate Scene Size for Different Altitudes
function scene_size = calculate_scene_size(fov, altitude)
    scene_size = 2 * altitude * tan(fov / 2);
end
