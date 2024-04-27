function processaAudios()
    clear();
    % Gerando uma matriz para cada fonema %
    fonemasDI = carregaFonemas("DI/", "*.WAV", 1);
    fonemasREI = carregaFonemas("REI/", "*.WAV", 2);
    fonemasTA = carregaFonemas("TA/", "*.WAV", 3);
    fonemasES = carregaFonemas("ES/", "*.WAV", 4);
    fonemasQUER = carregaFonemas("QUER/", "*.WAV", 5);
    fonemasDA = carregaFonemas("DA/", "*.WAV", 6);
    
    % Mesclando matrizes dos diferentes fonemas em uma unica matriz %
    dados = [fonemasDI; fonemasREI; fonemasTA;
             fonemasES; fonemasQUER; fonemasDA];
    % Salvando matriz em formato csv %
    writematrix(dados, "dados.csv");
end

% Função que carrega os audios das pastas e os processa/converte para servirem de
% entrada para rede
function fonemas = carregaFonemas(caminho, formato, classe)
    filePattern = fullfile(caminho, formato);
    theFiles = dir(filePattern);
    fonemas = [];
    
    for k = 1 : length(theFiles)
        baseFileName = theFiles(k).name;
        fullFileName = fullfile(theFiles(k).folder, baseFileName);
        fprintf(1, 'Lendo %s\n', fullFileName);
        
        % Lendo audio da pasta do fonema atual %
        [data, fs] = audioread(fullFileName);
        x = data;
        aux = abs(fft(x));

        % Zerando amplitudes inferiores a 0.3 %
        [cols] = find(aux(1:end)< 0.3);
        aux(cols) = 0;

        % Pegando metade dos dados dados pela fft %
        tam = length(aux);
        y = aux(1:floor(tam/2));
        
        % Fixando quantidade de grupos em 100 e 
        % Definindo tamanho dos grupos %
        qtd_grupos = 100;
        tam = length(y);
        tamanhoGrupo =  floor(tam/qtd_grupos);
        
        % Compactando dados %
        indice = 1;
        count = 1;
        medias = [];
        fimGrupo = tamanhoGrupo;
        while(count <= qtd_grupos)
            if(count == qtd_grupos)
                medias(count) = sum(y(indice:end)) / tamanhoGrupo;
            else
                medias(count) = sum(y(indice:fimGrupo)) / tamanhoGrupo;
            end
            indice = fimGrupo + 1;
            fimGrupo = fimGrupo + tamanhoGrupo;
            count = count + 1;
        end
        fonema = medias;
        fonema(1, end+1) = classe;
        fonemas = [fonemas; fonema];
    end
    fonemas = fonemas;
end

