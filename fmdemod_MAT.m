function z = fmdemod_MAT(y,Fc,Fs,freqdev,ini_phase)
%FMDEMOD Frequency demodulation.
%   Z = FMDEMOD(Y,Fc,Fs,FREQDEV) demodulates the FM modulated signal Y at
%   the carrier frequency Fc (Hz). Y and Fc have sample frequency Fs (Hz).
%   FREQDEV is the frequency deviation (Hz) of the modulated signal.
%
%   Z = FMDEMOD(Y,Fc,Fs,FREQDEV,INI_PHASE) specifies the initial phase of
%   the modulated signal.
%
%   See also FMMOD, PMMOD, PMDEMOD.

%    Copyright 1996-2018 The MathWorks, Inc.

narginchk(1,5);
% if(nargin>5)
%     error('Too many input arguments.');
% end

if(~isreal(y))
    error(message('comm:fmdemod:NonRealY'));
end

if(~isreal(Fs) || ~isscalar(Fs) || Fs<=0 )
    error(message('comm:fmdemod:InvalidFs'));
end

if(~isreal(Fc) || ~isscalar(Fc) || Fc<=0 )
    error(message('comm:fmdemod:InvalidFc'));
end

if(~isreal(freqdev) || ~isscalar(freqdev) || freqdev<=0)
    error(message('comm:fmdemod:InvalidFreqdev'));
end

if(nargin<5 || isempty(ini_phase) || (isStringScalar(ini_phase) && strlength(ini_phase)==0))
    ini_phase = 0; %#ok<NASGU>
elseif(~isreal(ini_phase) || ~isscalar(ini_phase)  )
    error(message('comm:fmdemod:InvalidIni_Phase'));
end

% check that Fs must be greater than 2*Fc
if(Fs<2*Fc)
    error(message('comm:fmdemod:FsLessThan2Fc'));
end

% --- Assure that Y, if one dimensional, has the correct orientation --- %
len = size(y,1);
if(len==1)
    y = y(:);
end


t = (0:1/Fs:((size(y,1)-1)/Fs))';
t = t(:,ones(1,size(y,2)));

% Do not use ini_phase since it will be eliminated with the diff
yq = hilbert(y).*exp(-1i*2*pi*Fc*t);
z = (1/(2*pi*freqdev))*[zeros(1,size(yq,2)); diff(unwrap(angle(yq)))*Fs];

% --- restore the output signal to the original orientation --- %
if(len == 1)
    z = z';
end




   

