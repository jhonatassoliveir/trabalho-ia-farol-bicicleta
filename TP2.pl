% --- Probabilidades a priori ---

0.5::str(dry).
0.3::str(wet).
0.2::str(snow_covered).

0.25::flw.  % volante desgastado
0.75::not_flw :- \+flw.

0.85::b.    % lâmpada boa
0.8::k.     % cabo bom


% --- Regras para o Dínamo Deslizante (R) ---

% P(R = true | Flw, Str)
0.6::r :- flw, str(dry).
0.7::r :- flw, str(wet).
0.9::r :- flw, str(snow_covered).

0.05::r :- \+flw, str(dry).
0.3::r  :- \+flw, str(wet).
0.7::r  :- \+flw, str(snow_covered).


% --- Regras para Tensão (V) ---

0.85::v :- r.
0.15::v :- \+r.


% --- Regras para Luz Ligada (Li) ---

0.99::li :- v, b, k.
0.01::li :- v, b, \+k.
0.01::li :- v, \+b, k.
0.001::li :- v, \+b, \+k.

0.3::li :- \+v, b, k.
0.005::li :- \+v, b, \+k.
0.005::li :- \+v, \+b, k.
0.0::li :- \+v, \+b, \+k.


% --- Consulta: P(V = true | Str = snow_covered) ---

evidence(str(snow_covered), true).
query(v).
