# speech-recognition
## TP2 de MNA

1. Instalar Octave
	* apt-get install octave liboctave-dev
	* liboctave-dev es necesario para instalar paquetes de Octave Forge
2. Instalar la libreria signal
	* (en Octave) pkg install -forge signal
	* hay que instalar las dependecias de signal io y control

## Reconocimiento de voz
### Agregar una persona
1. poner muestras de entrenamiento (wav) de subJectName en data/training/subjectName/
2. ejecutar addSpeaker(subjectName)
### Reconocer una muestra
1. poner la muestra (wav) en data/test/
2. ejecutar recognizeSpeaker(sampleName) 


### Recorder
1. Instalar el paquete de audio 
	* (en Octave) pkg install -forge audio
2. Instalar sox
	* apt-get install sox
3. Instalar alsa-oss
	* apt-get alsa-oss
4. Invocar aoss y correr Octave
	* aoss octave
5. Utilizar la funcion recorder
	recorder(fileName, seconds, samplingFrecuency)	

