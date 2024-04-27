%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% FUNÇÃO DE TREINO - REDE 1 %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function treino_r1()
    % Carregando dados
    clear();
    dados = readmatrix("dados.csv");
    
    % Dividindo base de dados
    dimensoes = size(dados);
    P = 0.70 ;
    idx = randperm(dimensoes(1));
    treino = dados(idx(1:round(P*dimensoes(1))),:);

    % Saidas Desejadas
    D = treino(:, end);
    treino = treino(:,1:end-1);

    % Definindo e salvando dados de treino
    writematrix(treino, "dados_treino.csv");   
    
    % Definindo e salvando dados para validação e teste
    dados_val_teste = dados(idx(round(P*dimensoes(1))+1:end),:);
    writematrix(dados_val_teste, "dados_val_teste.csv");  
    dimensoes = size(treino);

    %INICIALIZANDO PARÂMETROS DA REDE
    eta = 0.01; k = 1; H = 7; I = dimensoes(2); n = dimensoes(1); 
    
    MSE = 0; 
    n_treino = 0;
    media_dos_MSE = [];  
    while(n_treino < 10)
        soma_MSE = 0;
        n_treino;

        %Inicializando os pesos
        Whi = rand(H,I) - 0.5;
        Woh = rand(1,H) - 0.5;

        for epoca = 1:4000

            % inicializando vetor vazio que irá armazenar os erros
            % da Rede 1
            erros_r1 = [];
            soma = 0;

            for i = 1:n
                % Calcular a entrada da camada escondida
                X = treino(i, :)';
                net_h = Whi * X;
                % Calcular a saida da camada escondida
                Yh = logsig(net_h);
                % Calcular a entrada da camada de saida
                net_o = Woh * Yh;
                % Calcular a saida rede neural
                Y = k *net_o;
                % Calcular o erro de saida
                E = D(i)- Y;
                erros_r1(i) = E;
                soma = soma + power(E, 2);
                %Calcular variação dos pesos entre as camadas de saída escondida
                df = k*ones(size(net_o));
                delta_Woh = eta *(E.* df)* Yh';
                % Calcular erro retropropagado
                Eh = -Woh'*(E.* df);
                % Calcular variação dos pesos entre as camadas escondida e de entrada
                df = logsig(net_h)-(logsig(net_h).^2);
                delta_Whi = -eta *(Eh.* df)* X';
        
                Whi = Whi + delta_Whi;
                Woh = Woh + delta_Woh;
            end
            MSE = soma/n;
            soma_MSE = soma_MSE + MSE;
            MSE_EP = soma_MSE/epoca;
            media_dos_MSE(epoca) = MSE_EP;
        end
        n_treino = n_treino + 1 ;
    end
    % Salvando erros da rede 1
    writematrix(erros_r1, "erros_r1.csv");
    
    % Plotando gráfico do erro da rede 1
    plot(1:4000, media_dos_MSE)
    title('Média dos MSE em relação à Época ');
    xlabel('Época');
    ylabel('MSE');
    % Salvando pesos para rede 1
    save('pesos_rede01.mat', "Woh","Whi");
end
