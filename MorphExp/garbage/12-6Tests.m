
pitch = 300+0*sin((1:250)/250*3*2*pi);
pitchspec = HarmonicSpectrogram(pitch,512,16000);
[ypitch ypitchrecon] = SpectrumInversion(pitchspec,64,256);

justPitch=MakeVowel(16000,300,16000,0,0,0);
justSpec = ComplexSpectrum(justPitch,64,256);
[yjust yjustrecon] = SpectrumInversion(justSpec,64,256);

subplot(2,2,1);
plot([ypitch(1:500)' yjust(1:500)'])
title('ypitch vs. yjust')
subplot(2,2,2);
plot(abs([yjustrecon(1:100,10) ypitchrecon(1:100,10)]));
title('yjustrecon vs. ypitchrecon');
drawnow;
sound([justPitch ypitch yjust],16000);

a = TestVowelSpectrum('a',16000, 512);
aspec = (a*ones(1,length(pitch))).*pitchspec;
[ya yarecon]=SpectrumInversion(aspec,64,256);

realA = MakeVowel(16000,300,16000,'a');
realASpec = ComplexSpectrum(realA,64,256);
[yrealA yrealArecon] = SpectrumInversion(realASpec,64,256);

subplot(2,2,3);
plot([ya(1:500)' yrealA(1:500)'])
title('ya vs. yrealA')
subplot(2,2,4);
plot(abs([yarecon(1:100,10) yrealArecon(1:100,10)]));
title('yarecon vs. yrealArecon');
drawnow;
sound([realA ya yrealA],16000);
