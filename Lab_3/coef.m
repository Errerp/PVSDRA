clear; clc;

N = 6;               % Порядок фильтра
WL = 12;             % Разрядность (Q1.11)
Fcut = 0.3;          % Нормализованная частота среза

% --- 1. Коэффициенты фильтра (пример: низкочастотный FIR)
h = fir1(N-1, Fcut);   % fir1(5, 0.3)
fprintf('Коэффициенты FIR:\n');
disp(h);

% --- 2. Разбиваем на две группы по 3 коэффициента
h1 = h(1:3);
h2 = h(4:6);

% --- 3. Расчёт ROM1 и ROM2 (в десятичном виде)
rom1 = zeros(8,1);
rom2 = zeros(8,1);

for addr = 0:7
    bits = bitget(addr, [1 2 3]);  % [b0,b1,b2]
    rom1(addr+1) = bits(1)*h1(1) + bits(2)*h1(2) + bits(3)*h1(3);
    rom2(addr+1) = bits(1)*h2(1) + bits(2)*h2(2) + bits(3)*h2(3);
end

% --- 4. Преобразуем в формат Q1.11 (умножаем на 2^11)
Q = 2^(WL-1);
rom1_q = round(rom1 * Q);
rom2_q = round(rom2 * Q);

% --- 5. Выводим таблицы
fprintf('\nROM1 (Q1.11):\n');
disp(rom1_q.');

fprintf('ROM2 (Q1.11):\n');
disp(rom2_q.');
