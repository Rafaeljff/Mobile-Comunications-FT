%MODULAÇÃO AM – PARTE I 

%2.1)
clear 
Audio='Musica_short.wav';
[Y, FS]=audioread(Audio);
display('Frequência de amostragem:') 
FS

%2.2)
FS2=4*10^6;
[Audio2]=x_Audio_FS_Conversion(Y,FS,FS2);

%2.3)

L=length(Audio2);
n = 2^nextpow2(L);
Audio2_ftt=fft(Audio2,n);
Audio2_ftt=fftshift(Audio2_ftt);
f = (-n/2:n/2-1)*FS2/n;
P = abs(Audio2_ftt/n);
figure(1)
plot(f,20*log10(P)) 
 xlim([0 20*10^3])
title('Espetro do sinal Audio com frequência 4MHZ')
xlabel('Frequencia(F)')
ylabel('Amplitude(DB)')

%2.4)
 
fc=1*10^6;
ModAM =ammod(Audio2,fc,FS2);

%2.5)
L=length(ModAM);
n = 2^nextpow2(L);
ModAM_fft=fft(ModAM,n);
ModAM_fft=fftshift(ModAM_fft);
P = abs(ModAM_fft/n);
figure(2)
plot(f,20*log10(P))  

title('Espetro do sinal AM modulado')
xlabel('Frequencia(F)')
ylabel('Amplitude(DB)')

%2.6)

deMod=amdemod(ModAM,fc,FS2);

%2.7)
L=length(deMod);
n = 2^nextpow2(L);
deMod_ftt=fft(deMod,n);
deMod_ftt=fftshift(deMod_ftt);
P = abs(deMod_ftt/n);
figure(3)
plot(f,20*log10(P))   

xlim([0 20*10^3])
title('Espetro do sinal AM desmodulado')
xlabel('Frequencia(F)')
ylabel('Amplitude(DB)')

%2.8)
Audio_final=x_Audio_FS_Conversion(deMod,FS2,FS);

%2.9)

filename='deModAudio.wav';
audiowrite(filename,Audio_final,FS);


