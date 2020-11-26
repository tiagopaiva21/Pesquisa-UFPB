clear all; close all; clc

%%definindo variaveis

f = 50; %HZ

periodo = 10^-4; %%segundos

tempo = 10^-4;%segundos

amp = 2; %amplitude da senoide (V)

E = 10; %tensão da fonte (V);

t = [0:periodo/10:2/f]; %tempo para gerar a senoide

k=0; %constante que vai ser utilizada no if

%%Gerando ondas defasadas

sinal = amp*sin(2*pi*f*t); % Geração onda senoidal 1
sinal2 = amp*sin(2*pi*f*t-(2*pi/3)); % Geração onda senoidal 2 (defasada em -120)
sinal3 = amp*sin(2*pi*f*t+(2*pi/3)); % Geração onda senoidal 3 (defasada em +120)

%%Gerando PWM

n=length(t); % Essa função vai pegar o comprimento do vetor t
for i=1:n
    
  tau1(i) = (sinal(i)/E + 1/2)*periodo; % Cálculo tau 1
  tau2(i) = (sinal2(i)/E + 1/2)*periodo;% Cálculo tau 2
  tau3(i) = (sinal3(i)/E + 1/2)*periodo;% Cálculo tau 3
  
  % Gerando PWM1
    if tau1(i)>=k
        pwm1(i) = E/2;
    else
        pwm1(i) = -E/2;
    end
    
  % Gerando PWM2 
    if tau2(i)>=k
        pwm2(i) = E/2;
    else
        pwm2(i) = -E/2;
    end
    
    % Gerando PWM3
    if tau3(i)>=k
        pwm3(i) = E/2;
    else
        pwm3(i) = -E/2;
    end
    
    k=k+periodo/10; % constante que vai aumetando os passos

    if k > periodo
        k=0; % Recomeça a cada periodo
    end    
    
    
end  

%%Tensões de linha

V12 = pwm1 - pwm2; % Tensão de linha entre as cargas 1 e 2 
V23 = pwm2 - pwm3; % Tensão de linha entre as cargas 2 e 3
V31 = pwm3 - pwm1; % Tensão de linha entre as cargas 3 e 1

%%Plotando todos os dados

% PWM1 junto com sinal1
tm=1000*t; % pra usar t em ms
figure
plot(tm,pwm1,tm,sinal)
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('pwm1','onda 1')

% PWM2 junto com sinal2
figure
plot(tm,pwm2,tm,sinal2)
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('pwm2','onda 2')

% PWM3 junto com sinal3
figure
plot(tm,pwm3,tm,sinal3)
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('pwm3','onda 3')

% Tensões de referencia e PWMs
figure
subplot (2,1,1)
plot(tm,sinal,tm,sinal2,tm,sinal3)
axis([0 40 -3 3])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('onda 1','onda 2','onda 3')
subplot (2,1,2)
plot(tm,pwm1,tm,pwm2,tm,pwm3)
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('pwm1','pwm2','pwm3')

% Tensões de linha
figure
subplot (3,1,1)
plot(tm,V12,'r')
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('V12')
subplot (3,1,2)
plot(tm,V23,'m')
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('V23')
subplot (3,1,3)
plot(tm,V31,'b')
axis([0 40 -10 10])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('Tensão (v)','Interpreter','LaTex','FontSize',18)
legend('V32')

% Taus
figure
subplot (3,1,1)
plot(tm,tau1,'r')
axis([0 40 0 10^-4])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('tau (s)','Interpreter','LaTex','FontSize',18)
legend('tau 1')
subplot (3,1,2)
plot(tm,tau2,'m')
axis([0 40 0 10^-4])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('tau (s)','Interpreter','LaTex','FontSize',18)
legend('tau 2')
subplot (3,1,3)
plot(tm,tau3,'b')
axis([0 40 0 10^-4])
set(gca,'FontSize',16)
xlabel('tempo (ms)','Interpreter','LaTex','FontSize',18)
ylabel('tau (s)','Interpreter','LaTex','FontSize',18)
legend('tau 3')