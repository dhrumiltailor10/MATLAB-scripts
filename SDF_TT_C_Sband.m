% S_Band calculations

uplink_parameters = struct( ...
    'transmit_power_w', 100, ...       % W
    'transmit_gain_db', 24, ...        % dBi
    'receive_gain_db', 6.5, ...        % dBi
    'frequency_hz', 2.2e9, ...         % Hz
    'line_loss_db', 2, ...             % dB
    'distance_km', 800, ...            % km
    'bandwidth_hz', 1e6, ...           % Hz
    'noise_temperature_k', 614 ...     % K
);

downlink_parameters = struct( ...
    'transmit_power_w', 2, ...         % W
    'transmit_gain_db', 6.5, ...       % dBi
    'receive_gain_db', 24, ...         % dBi
    'frequency_hz', 2.2e9, ...         % Hz
    'line_loss_db', 2, ...             % dB
    'distance_km', 800, ...            % km
    'bandwidth_hz', 1e6, ...           % Hz
    'noise_temperature_k', 135 ...     % K
);

links = {'Uplink', 'Downlink'};
parameters = {uplink_parameters, downlink_parameters};

for i = 1:length(links)
    link = links{i};
    params = parameters{i};
    
    transmit_power_dbw = watts_to_dbw(params.transmit_power_w);
    path_loss_db = free_space_loss(params.distance_km, params.frequency_hz);
    received_power_dbw = received_power(transmit_power_dbw, params.transmit_gain_db, params.receive_gain_db, path_loss_db, params.line_loss_db);
    received_power_w = dbw_to_watts(received_power_dbw);
    
    snr = calculate_snr(received_power_w, params.bandwidth_hz, params.noise_temperature_k);
    snr_db = 10 * log10(snr);
    
    channel_capacity_bps = calculate_channel_capacity(params.bandwidth_hz, snr);
    
    fprintf('\n%s Link:\n', link);
    fprintf('Transmit Power: %.2f W (%.2f dBW)\n', params.transmit_power_w, transmit_power_dbw);
    fprintf('Free Space Path Loss: %.2f dB\n', path_loss_db);
    fprintf('Received Power: %.2f dBW (%.2e W)\n', received_power_dbw, received_power_w);
    fprintf('SNR: %.2f (%.2f dB)\n', snr, snr_db);
    fprintf('Channel Capacity: %.2f bps\n', channel_capacity_bps);
    fprintf('Channel Capacity: %.2f mbps\n', channel_capacity_bps / 1e6);
end

% Watts to dBW function
function power_dbw = watts_to_dbw(power_w)
    power_dbw = 10 * log10(power_w);
end

% Free space path loss funtion
function loss_db = free_space_loss(distance_km, frequency_hz)
    C = 299792458; % Speed of light in m/s
    PI = pi;
    distance_m = distance_km * 1000; % Convert distance to meters
    loss_db = 20 * log10(distance_m) + 20 * log10(frequency_hz) + 20 * log10((4 * PI) / C);
end

% Received power function
function power_dbw = received_power(transmit_power_dbw, transmit_gain_db, receive_gain_db, path_loss_db, line_loss_db)
    power_dbw = transmit_power_dbw + transmit_gain_db + receive_gain_db - path_loss_db - line_loss_db;
end

% dBW to Watts function
function power_w = dbw_to_watts(power_dbw)
    power_w = 10^(power_dbw / 10);
end

% SNR function
function snr = calculate_snr(received_power_w, bandwidth_hz, noise_temperature_k)
    BOLTZMANN_CONSTANT = 1.38e-23; % Boltzmann constant in J/K
    noise_power_w = BOLTZMANN_CONSTANT * noise_temperature_k * bandwidth_hz;
    snr = received_power_w / noise_power_w;
end

% Channel capacity function
function capacity_bps = calculate_channel_capacity(bandwidth_hz, snr)
    capacity_bps = bandwidth_hz * log2(1 + snr);
end
