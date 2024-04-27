% A cada 3 fonemas a função apresenta a palavra correspondente 
% aquele conjunto de fonemas

function classifica_fonema()
    predicoes = [];
    count = 1;

% -- Laço que espera e processa fonemas do usuários --%
    while(1)
        % Recuperando fonema da base
        fonema = get_fonema();
        if length(fonema) == 0
            continue
        end
        % passando fonema para a rede
        rede01(fonema);
        rede02(fonema);
        % Carregando predicao da rede para o fonema
        pred = readmatrix("predicoes_geral.csv");

        predicoes(count) = pred;
        count = count +1;

    
        % Compara os fonemas de saida da rede com os fornecidos pelo usuário e
        % apresenta a palavra correspondente
        if(length(predicoes) == 3)
            DIREITA = [1 2 3];
            ESQUERDA = [4 5 6];
            if(predicoes == DIREITA)
                fprintf("A palavra formada é Direita \n")
            elseif(predicoes == ESQUERDA)
                fprintf("A palavra formada é Esquerda \n")
            else
                fprintf("Nem direita e nem esquerda \n")
            end
            predicoes = [];
            count = 1;
        end
    end
end