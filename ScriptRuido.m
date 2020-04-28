
function ScriptRuido(vector)
%Script de repeti��o



%vector=[0:10:30]; %Para valores pedidos no exerc�cio 3
for SNR=vector;

%3.1.1
Audio='Musica.wav'; 
%3.1.2
[Y, FS]=audioread(Audio);
FS2=4*10^6;
[Audio]=x_Audio_FS_Conversion(Y,FS,FS2);
%3.1.3
fc=1*10^6;% freq portadora n�o especificada, uso do mesmo valor da al�nea 2.4
ModAM =ammod(Audio,fc,FS2);
%3.2
%3.2.1
L=length(ModAM);
n = 2^nextpow2(L);
ModAM_fft=fft(ModAM,n);
%3.2.2
ModAM_SMR = awgn(ModAM,SNR,'measured','db');
%3.1.4
deMod=amdemod(ModAM_SMR,fc,FS2);
%3.1.5
Audio=x_Audio_FS_Conversion(deMod,FS2,FS);
%3.1.6
    %3.2.3
    display('O ruido adicionado em DB � de')
    SNR
    ruido='ruido.wav';
    audiowrite(ruido,Audio,FS);
    clear sound;
    sound(Audio, FS);
  
%Resposta: � medida que a rela��o sinal-ru�do aumenta, a qualidade do Audio tamb�m
%aumenta pois � medida que a amplitude do ru�do difere, mais se nota a
%m�sica
 
end
end