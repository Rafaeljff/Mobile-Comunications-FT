%4. MODULAÇÃO FM – PARTE I 

%4.1)
Audio='Musica_short.wav';
[Y, FS]=audioread(Audio);
display('Frequência de amostragem:') 
FS

%4.2)
FS2=4*10^6;
[Audio2]=x_Audio_FS_Conversion(Y,FS,FS2);

%4.3)
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

%4.4)
FREQDEV=75*10^3;
Fc=0.5*10^6;
Sinal_FM=fmmod(Audio2,Fc,FS2,FREQDEV);

%4.5)
L=length(Sinal_FM);
n = 2^nextpow2(L);
Sinal_FM_ftt=fft(Sinal_FM,n);
Sinal_FM_ftt=fftshift(Sinal_FM_ftt);
f = (-n/2:n/2-1)*FS2/n;
P = abs(Sinal_FM_ftt/n);
figure(2)
plot(f,20*log10(P)) 
 
title('Espetro do sinal FM')
xlabel('Frequencia(F)')
ylabel('Amplitude(DB)')

%4.6)
AudioOrig = fmdemod(Sinal_FM,Fc,FS2,FREQDEV);
%4.7)
L=length(AudioOrig);
n = 2^nextpow2(L);
AudioOrig_ftt=fft(AudioOrig,n);
AudioOrig_ftt=fftshift(AudioOrig_ftt);
f = (-n/2:n/2-1)*FS2/n;
P = abs(AudioOrig_ftt/n);
figure(3)
plot(f,20*log10(P)) 
 xlim([0 20*10^3])
title('Espetro do sinal Audio original com frequência 4MHZ')
xlabel('Frequencia(F)')
ylabel('Amplitude(DB)')

%4.8)
[AudioInicial]=x_Audio_FS_Conversion(AudioOrig,FS2,FS);

%4.9)
AUDIOFM='AudioFM.wav';
audiowrite(AUDIOFM,AudioInicial,FS);
sound(AudioInicial, FS);

