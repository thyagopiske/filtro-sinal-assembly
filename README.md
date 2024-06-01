Baixar o programa DOSBox-X
Ele vai ser instalado em C:/DOSBox-X
Descompactar o frasm.zip e pegar os arquivos nasm.bat, nasm16.exe e freelink.exe
e colocá-los em C:DOSBox-X/drivez. Colocar também os arquivos dentro de "scripts" pra automatizar a execução e o debug

Crie uma pasta em C:/ chamada codigosSE por exemplo
Abra o DOSBox e digite:
mount c c:codigosSE
depois:
C:
Agora, pra gerar o executável considerando que exista um arquivo prog.asm em codigosSE:
nasm prog
freelink prog
Pra executar:
prog

Main > Configuration Tool > Autoexec.bat > insira o seguinte texto:
mount c c:/codigosSE
c:
cls
desse modo, sempre que abrir o DOSBox ele vai estar na pasta correta