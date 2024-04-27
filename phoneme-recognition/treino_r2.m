%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% FUNÇÃO DE TREINO - REDE 2 %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function treino_r2(treino, D)
    % Carregando dados
    dimensoes = size(treino);

    %INICIALIZANDO PARÂMETROS DA REDE
    eta = 0.01; k = 1; H = 11; I = dimensoes(2); n = dimensoes(1); 
    
    MSE = 0;
    n_treino = 0;
    media_dos_MSE = [];
    
    while(n_treino < 10)
        soma_MSE = 0;
        n_treino;
    
        Woh = rand(1,H) - 0.5;
        Whi = rand(H,I) - 0.5;
        for epoca = 1:4000
            
            % inicializando vetor vazio que irá armazenar os erros
            % da Rede 2
            erros_r2 = [];
            soma = 0;
            
            for i = 1:n
                % Calcular a entrada da camada escondida
                X = treino(i, :)';
                net_h = Whi * X;
                % Calcular a saida da camada escondida
                Yh = logsig(net_h);
                % Calcular a entrada da camada de saida
                if(epoca==1)
                    [l, c]= size(Woh);
                    Woh = zeros(l,c);
                end
                net_o = Woh * Yh;
                % Calcular a saida rede neural
                Y = k *net_o;
                % Calcular o erro de saida
                E = D(i)- Y;
                erros_r2(i) = E;
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
    
    % Salvando erros da rede 2
    writematrix(erros_r2', "erros_r2.csv");
    
    % Plotando gráfico do erro da rede 2
    plot(1:4000, media_dos_MSE)
    title('Média dos MSE em relação à Época ');
    xlabel('Época');
    ylabel('MSE');
    % Salvando pesos para rede 2
    save('pesos_rede02.mat', "Woh","Whi");
end        
