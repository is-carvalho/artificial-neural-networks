%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%           REDE 1          %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rede01(dados)

    % Carregando pesos da rede 1
    load("pesos_rede01.mat");
    dimensoes = size(dados);
    
    % Inicializando Parâmetros da rede
    k = 1; H = 7; I = dimensoes(2); n = dimensoes(1); 
    predicoes = [];
    Xs = [];
    
    for i = 1:n
        % Calcular a entrada da camada escondida
        % Definindo se a entra é um conjunto de fonemas ou um fonema apenas
        if n ~= 1
            X = dados(i, :)';
        else
            X = dados';
        end
        net_h = Whi * X;   
        % Calcular a saida da camada escondida
        Yh = logsig(net_h);
        % Calcular a entrada da camada de saida
        net_o = Woh * Yh;
        % Calcular a saida rede neural
        Y = k *net_o;
        predicoes(i) = Y;
        Xs(i) = i;
    end
    % Salvando predições da rede 1
    writematrix(predicoes, "predicoes_r1.csv");
end