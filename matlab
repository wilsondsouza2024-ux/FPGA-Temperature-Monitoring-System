% generate_temp_signal.m
% Real-Time Temperature Monitoring using FPGA - PBL Project
% 1. Generates a synthetic body/ambient temperature signal
% 2. Adds random sensor noise to it
% 3. Quantizes the noisy signal to a 12-bit fixed-point format
% (value = temperature_in_Celsius * 10, so resolution = 0.1 C)
% 4. Writes the quantized samples as 12-bit BINARY strings to
% "temp_data.mem" -> this file is read by the Verilog
% testbench using $readmemb

clc; 
clear;
close all;
%% 1. Parameters
N = 100;
fs = 100;
t = (0:N-1)/fs;
BASE_TEMP = 37.0; % baseline temperature in Celsius (e.g. body temp)
AMPLITUDE = 1.5; % slow variation amplitude (C)
FREQ = 0.5; % slow variation frequency (Hz)
NOISE_STD = 0.4; % standard deviation of sensor noise (C)
DATA_WIDTH = 12; % bit-width for fixed point representation
SCALE = 10; % 1 LSB = 0.1 C -> value = temp*10

%% 2. Generate ideal (clean) temperature signal
clean_temp = BASE_TEMP + AMPLITUDE * sin(2*pi*FREQ*t);

%% 3. Add random Gaussian noise to simulate sensor noise
rng(1); % fixed seed for reproducibility
noise = NOISE_STD * randn(1, N);
noisy_temp = clean_temp + noise;

%% 4. Quantize to fixed point (12-bit unsigned)
scaled_data = round(noisy_temp * SCALE); % e.g. 36.7 C -> 367
scaled_data = max(0, min(scaled_data, 2^DATA_WIDTH - 1)); % clip to range

%% 5. Convert each sample to a 12-bit binary string and write to file
fid = fopen('temp_data.mem', 'w');
for k = 1:N
 bin_str = dec2bin(scaled_data(k), DATA_WIDTH);
 fprintf(fid, '%s\n', bin_str);
end
fclose(fid);
fprintf('File "temp_data.mem" written with %d samples (12-bit binary).\n', N);

%% 6. (Optional) Save the expected golden output of a 4-point
% moving average filter, for verification against the Verilog output
expected_avg = zeros(1, N);
for k = 1:N
 if k < 4
 % not enough samples yet, FPGA design outputs 0 / holds
 expected_avg(k) = 0;
 else
 expected_avg(k) = floor(sum(scaled_data(k-3:k)) / 4);
 end
end
fid = fopen('expected_output.mem', 'w');
for k = 1:N
 fprintf(fid, '%s\n', dec2bin(expected_avg(k), DATA_WIDTH));
end
fclose(fid);

%% 7. Plot for visualization
figure;
plot(t, clean_temp, 'g-', 'LineWidth', 1.5); hold on;
plot(t, noisy_temp, 'r.-');
plot(t, scaled_data/SCALE, 'b--');
plot(t, expected_avg/SCALE, 'k-', 'LineWidth', 2);
legend('Clean Signal', 'Noisy Signal', 'Quantized Input', ...
 'Expected MA Filter Output');
xlabel('Time (s)');
ylabel('Temperature (^{\circ}C)');
title('Synthetic Temperature Signal for FPGA Filter Testing');
grid on;
