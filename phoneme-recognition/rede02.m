%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%           REDE 2          %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rede02(dados)
    % Carregando pesos da rede 2
    load("pesos_rede02.mat");
    dimensoes = size(dados);
    
    % Inicializando Parâmetros da rede
    k = 1; H = 7; I = dimensoes(2); n = dimensoes(1);
    
    predicoes_r2 = [];
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
        predicoes_r2(i) = Y;
        Xs(i) = i;
    end

    % Salvando predições da rede 2
    writematrix(predicoes_r2, "predicoes_r2.csv");
    % Carregando predições da rede 1
    predicoes_r1 = readmatrix("predicoes_r1.csv");
    % Somando predições da rede 1 e 2
    predicoes = round(predicoes_r1 + predicoes_r2);

    % Salvando predição final
    writematrix(predicoes, "predicoes_geral.csv");

end
