% Função retorna fonema da base de dados conforme entrada do usuário
function fonema = get_fonema()
    clear();

    % ------------- Lendo fonemas --------------%
    dados = readmatrix("dados.csv");
    dados = dados(:,1:end-1);

    prompt = "Entre com um fonema:";
    fon = input(prompt, "s");
    fon = upper(fon);
    fonema = [];
   % ------------- Acessando fonema da base --------------%
    if(fon == "DI")
        idx = randperm(length(dados(1:60)),1);
        fonema = dados(idx, :);     
    elseif(fon == "REI")
        idx = randperm(length(dados(61:120)),1);
        idx = idx + 60;
        fonema = dados(idx, :);
    elseif(fon == "TA")
        idx = randperm(length(dados(121:180)),1);
        idx = idx + 120;
        fonema = dados(idx, :);
    elseif(fon == "ES")
        idx = randperm(length(dados(181:240)),1);
        idx = idx + 180;
        fonema = dados(idx, :);
    elseif(fon == "QUER")
        idx = randperm(length(dados(241:300)),1);
        idx = idx + 240;
        fonema = dados(idx, :);
    elseif(fon == "DA")
        idx = randperm(length(dados(301:360)),1);
        idx = idx + 300;
        fonema = dados(idx, :);
    else
        fprintf("Nem direita e nem esquerda. Tente de novo! \n")
    end
    fonema = fonema;
end