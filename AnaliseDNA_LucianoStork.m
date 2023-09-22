% Ler o arquivo de sequência de DNA
filename = 'hexokinase.txt'; % Substitua pelo nome do seu arquivo de sequência de DNA
fid = fopen(filename, 'r');
dna_sequence = fscanf(fid, '%s');
fclose(fid);

% Tamanho da janela deslizante para calcular a entropia local
window_size = 10; % Ajuste o tamanho da janela conforme necessário

% Inicializar vetores para armazenar a entropia local e as sequências com baixa entropia
entropy_values = [];
low_entropy_sequences = {};
low_entropy_positions = []; % Inicializa vetor para armazenar posições das sequências com baixa entropia

% Definir um limiar para identificar regiões de baixa entropia
threshold = 1.1; % Ajuste o limiar conforme necessário

% Calcular a entropia local usando a função textEntropy()
for i = 1:(length(dna_sequence) - window_size + 1)
    window = dna_sequence(i:i+window_size-1);
    
    % Chame a função textEntropy() com a janela como argumento
    entropy = textEntropy(window); 
    
    if entropy < threshold % Usar o limiar definido
        entropy_values = [entropy_values, entropy];
        low_entropy_sequences{end+1} = window; % Armazena a sequência com baixa entropia
        low_entropy_positions = [low_entropy_positions, i]; % Armazena a posição da sequência com baixa entropia
    end
end

% Exibir as sequências de DNA com baixa entropia, suas entropias e posições
disp('Sequências de DNA com Baixa Entropia:');
for i = 1:length(low_entropy_sequences)
    sequence = low_entropy_sequences{i};
    entropy_value = textEntropy(sequence);
    position = low_entropy_positions(i);
    
    fprintf('Sequência de baixa entropia: %s ; Entropia calculada: %.4f ; Posição: %d\n', sequence, entropy_value, position);
end

% Exibir a entropia total do DNA
disp(['Entropia Total do DNA: ' num2str(textEntropy(dna_sequence))]);

% Plotar toda a sequência de DNA em azul
figure;
plot(1:length(dna_sequence), ones(size(dna_sequence)), 'b.', 'MarkerSize', 5); % Plota toda a sequência em azul
hold on;

% Destacar as regiões de baixa entropia em vermelho
highlighted_regions = entropy_values < threshold;
plot(low_entropy_positions, ones(size(low_entropy_positions)), 'r.', 'MarkerSize', 5); % Plota as posições de baixa entropia em vermelho

title('Sequência de DNA com Regiões de Baixa Entropia Destacadas');
xlabel('Posição na Sequência');
yticks([]); % Remover os valores do eixo y
legend('Sequência de DNA', 'Regiões de Baixa Entropia', 'Location', 'Best');
