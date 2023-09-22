% Ler o arquivo de sequ�ncia de DNA
filename = 'hexokinase.txt'; % Substitua pelo nome do seu arquivo de sequ�ncia de DNA
fid = fopen(filename, 'r');
dna_sequence = fscanf(fid, '%s');
fclose(fid);

% Tamanho da janela deslizante para calcular a entropia local
window_size = 10; % Ajuste o tamanho da janela conforme necess�rio

% Inicializar vetores para armazenar a entropia local e as sequ�ncias com baixa entropia
entropy_values = [];
low_entropy_sequences = {};
low_entropy_positions = []; % Inicializa vetor para armazenar posi��es das sequ�ncias com baixa entropia

% Definir um limiar para identificar regi�es de baixa entropia
threshold = 1.1; % Ajuste o limiar conforme necess�rio

% Calcular a entropia local usando a fun��o textEntropy()
for i = 1:(length(dna_sequence) - window_size + 1)
    window = dna_sequence(i:i+window_size-1);
    
    % Chame a fun��o textEntropy() com a janela como argumento
    entropy = textEntropy(window); 
    
    if entropy < threshold % Usar o limiar definido
        entropy_values = [entropy_values, entropy];
        low_entropy_sequences{end+1} = window; % Armazena a sequ�ncia com baixa entropia
        low_entropy_positions = [low_entropy_positions, i]; % Armazena a posi��o da sequ�ncia com baixa entropia
    end
end

% Exibir as sequ�ncias de DNA com baixa entropia, suas entropias e posi��es
disp('Sequ�ncias de DNA com Baixa Entropia:');
for i = 1:length(low_entropy_sequences)
    sequence = low_entropy_sequences{i};
    entropy_value = textEntropy(sequence);
    position = low_entropy_positions(i);
    
    fprintf('Sequ�ncia de baixa entropia: %s ; Entropia calculada: %.4f ; Posi��o: %d\n', sequence, entropy_value, position);
end

% Exibir a entropia total do DNA
disp(['Entropia Total do DNA: ' num2str(textEntropy(dna_sequence))]);

% Plotar toda a sequ�ncia de DNA em azul
figure;
plot(1:length(dna_sequence), ones(size(dna_sequence)), 'b.', 'MarkerSize', 5); % Plota toda a sequ�ncia em azul
hold on;

% Destacar as regi�es de baixa entropia em vermelho
highlighted_regions = entropy_values < threshold;
plot(low_entropy_positions, ones(size(low_entropy_positions)), 'r.', 'MarkerSize', 5); % Plota as posi��es de baixa entropia em vermelho

title('Sequ�ncia de DNA com Regi�es de Baixa Entropia Destacadas');
xlabel('Posi��o na Sequ�ncia');
yticks([]); % Remover os valores do eixo y
legend('Sequ�ncia de DNA', 'Regi�es de Baixa Entropia', 'Location', 'Best');
