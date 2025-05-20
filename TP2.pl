% --- Probabilidades a priori ---

0.5::str(dry).            % 50% de chance da estrada estar seca
0.3::str(wet).            % 30% de chance da estrada estar molhada
0.2::str(snow_covered).   % 20% de chance da estrada estar coberta de neve

0.25::flw.                % 25% de chance do volante estar desgastado
0.75::not_flw :- \+flw.   % 75% de chance do volante estar normal (não desgastado)

0.85::b.                  % 85% de chance da lâmpada estar funcionando
0.8::k.                   % 80% de chance do cabo estar em bom estado


% --- Regras para o Dínamo Deslizante (R) ---

% Probabilidade do dínamo funcionar dependendo do estado do volante e da estrada

% Se o volante está desgastado:
0.6::r :- flw, str(dry).             % 60% de chance do dínamo funcionar em estrada seca
0.7::r :- flw, str(wet).             % 70% de chance do dínamo funcionar em estrada molhada
0.9::r :- flw, str(snow_covered).    % 90% de chance do dínamo funcionar em estrada com neve

% Se o volante está bom:
0.05::r :- \+flw, str(dry).          % 5% de chance do dínamo funcionar em estrada seca
0.3::r  :- \+flw, str(wet).          % 30% de chance do dínamo funcionar em estrada molhada
0.7::r  :- \+flw, str(snow_covered). % 70% de chance do dínamo funcionar em estrada com neve


% --- Regras para Tensão (V) ---

0.85::v :- r.        % Se o dínamo funciona, 85% de chance de gerar tensão
0.15::v :- \+r.      % Se o dínamo não funciona, ainda há 15% de chance de haver tensão residual


% --- Regras para Luz Ligada (Li) ---

% Quando há tensão:
0.99::li :- v, b, k.           % Luz acende com 99% se tensão, lâmpada e cabo estão bons
0.01::li :- v, b, \+k.         % Se o cabo falha, chance da luz acender cai para 1%
0.01::li :- v, \+b, k.         % Se a lâmpada falha, mesma queda para 1%
0.001::li :- v, \+b, \+k.      % Se lâmpada e cabo falham, luz quase nunca acende (0.1%)

% Quando não há tensão:
0.3::li :- \+v, b, k.          % Mesmo sem tensão, luz pode acender com 30% (erro ou interferência)
0.005::li :- \+v, b, \+k.      % Com falha no cabo, chance cai para 0.5%
0.005::li :- \+v, \+b, k.      % Com falha na lâmpada, também 0.5%
0.0::li :- \+v, \+b, \+k.      % Sem tensão e com ambas falhas, luz nunca acende


% --- Consulta: P(V = true | Str = snow_covered) ---

evidence(str(snow_covered), true).  % Evidência: sabemos que a estrada está coberta de neve
query(v).                           % Consulta: qual a probabilidade de haver tensão?
