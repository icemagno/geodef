
!IMPLEMENTAÇÃO DLL MARÉ


SUBROUTINE ASTRO(MO,DELTAT,HI,IDIAS,IMES,IANO,N,KKK,F,U,AS)

!C     SUBROTINA PERTENCENTE AO PROGRAMA MAR138M3, SEGUNDA VERSAO.
!C     ESTA SUB-ROTINA CALCULA, PARA AS 37 COMPONENTES ASTRONOMICAS PRIN-
!C     CIPAIS E PARA QUALQUER EPOCA,OS ARGUMENTOS ASTRONOMICOS E OS FATO-
!C     RES PERINODAIS, ASSIM CHAMADOS PORQUE TANTO ELES COMO AS CORRE-
!C     COES DE FASE PARA O PERIODO DE 18.61 ANOS SAO CALCULADOS LEVANDO
!C     EM CONTA A LONGITUDE DO PERIGEU LUNAR, ALEM DA LONGITUDE DO NODO
!C     ASCENDENTE.

!c      DIMENSION AS(9),F(37),U(37),A(13,3),JM(12),X(13,3)
!c      DIMENSION B(37,13),C(37,13),GA(37,4),CA(37),ARC(13)

!c      Troca realizada em 09/11/89
        real*4  AS(9),F(37),U(37),A(13,3),X(13,3)
        real*4  B(37,13),C(37,13),GA(37,4),CA(37),ARC(13)

!c      alteracao feita em 13/09/90 o mes de fevereiro nao esta sendo reinicializado

        integer*4       jm(12)

      DATA JM/0,31,28,31,30,31,30,31,31,30,31,30/
      DATA X/5*0.,1.,7*2.,1.,2.,3.,0.,1.,0.,3*-1.,0.,1.,2.,3.,3*0.,2*2.,&
     &2*-1.,0.,1.,4*0./
      DATA B/2*0.,-.1306,.4143,.4142,.1885,.1884,.1884,.1882,.1885,-.245&
     &4,.1714,.1905,-.0078,-.0112,0.,.1158,.0190,-.0384,.1676,.1686,.639&
     &8,-.0373,-.0374,-.0375,-.0373,-.0373,-.0373,-.0448,-.0366,0.,.0022&
     &,0.,.2852,.4390,.4168,-.0564,2*0.,.0008,.0387,.0384,-.0063,-.0061,&
     &-.0057,-.0058,-.0058,-.0142,-.0054,2*0.,.0008,0.,-.0029,0.,-.0185,&
     &0.,-.0047,.1342,3*0.,.0005,0.,.0005,5*0.,.0324,.0488,.0467,0.,3*0.&
     &,-.0008,17*0.,.0086,15*0.,14*0.,-.0004,3*0.,.0132,13*0.,-.2535,4*0&
     &.,32*0.,.0141,4*0.,7*0.,.0008,17*0.,.0008,11*0.,4*0.,-.003,32*0.,3&
     &*0.,-.0028,5*0.,.0002,8*0.,.0106,2*0.,.0296,7*0.,.0047,7*0.,4*0.,-&
     &.0030,32*0.,2*0.,-.0534,.0432,.0180,0.,-.0087,-.0028,-.0576,-.0064&
     &,.0446,.3596,2*0.,-.0015,3*0.,.0344,0.,-.0152,.1496,4*0.,.0042,.00&
     &06,0.,-.2505,0.,.0001,2*0.,.0488,-.0078,0.,2*0.,-.0218,-.0023,4*0.&
     &,.0175,-.001,0.,.0665,2*0.,-.0003,0.,.0002,2*0.,.0300,-.0098,-.003&
     &7,4*0.,-.0036,.0002,0.,-.1102,4*0.,.0650,2*0.,2*0.,-.0059,0.,-.004&
     &0,-.0063,0.,-.0039,3*0.,-.0057,8*0.,-.0057,2*0.,-.0061,0.,-.0039,3&
     &*0.,-.0156,7*0.,4*0.,-.0017,2*0.,-.0007,29*0./
      DATA C/2*0.,.0008,.4143,.4142,-.1885,-.1884,-.1884,-.1882,-.1885,-&
     &.1886,.2294,.2469,.0078,.0112,0.,.1554,.0190,-.0384,.2310,.2274,.6&
     &398,.0373,.0374,.0373,.0373,.0373,.0373,.0448,.0366,0.,-.0022,0.,.&
     &3108,.4390,.4542,.0564,2*0.,-.0008,.0378,.0384,.0063,.0061,.0057,.&
     &0058,.0058,-.0142,-.0054,2*0.,-.0008,0.,-.0030,0.,-.0185,0.,-.0047&
     &,.1342,3*0.,-.0005,0.,-.0005,5*0.,.0324,.0488,.0467,0.,3*0.,-.0008&
     &,17*0.,.0086,15*0.,14*0.,-.0004,3*0.,-.0132,13*0.,-.2535,4*0.,32*0&
     &.,.0141,4*0.,7*0.,-.0008,17*0.,-.0008,11*0.,4*0.,.0030,32*0.,3*0.,&
     &.0028,5*0.,.0002,8*0.,-.0106,2*0.,-.0296,7*0.,.0047,7*0.,4*0.,.003&
     &0,32*0.,2*0.,-.0534,-.0432,-.0180,0.,-.0087,-.0028,-.0576,-.0064,-&
     &.0446,-.3596,2*0.,-.0015,3*0.,-.0344,0.,-.0152,-.1496,4*0.,.0042,.&
     &0006,0.,-.2505,0.,.0001,2*0.,-.0488,-.0078,0.,2*0.,-.0218,.0023,4*&
     &0.,.0175,-.0010,0.,-.0665,2*0.,-.0003,0.,-.0002,2*0.,-.0300,.0098,&
     &.0037,4*0.,-.0036,.0002,0.,-.1102,4*0.,-.0650,2*0.,2*0.,-.0059,0.,&
     &-.0040,.0063,0.,.0039,3*0.,.0057,8*0.,-.0057,2*0.,.0061,0.,.0039,3&
     &*0.,-.0156,7*0.,4*0.,-.0017,2*0.,.0007,29*0./
      DATA GA/5*0.,17*1.,14*2.,3.,2*0.,1.,2.,3.,2*-3.,2*-2.,2*-1.,2*0.,&
     &6*1.,2*2.,3.,-3.,2*-2.,2*-1.,0.,2*1.,4*2.,2*3.,0.,1.,2.,4*0.,2.,&
     &0.,2.,0.,2.,0.,2.,-3.,-2.,-1.,0.,1.,2.,-2.,2*0.,2.,0.,2.,0.,2.,0.,&
     &-2.,0.,-3.,-2.,-1.,0.,-2.,2*0.,2*0.,-1.,0.,-1.,2.,0.,1.,-1.,2*0.,&
     &1.,-1.,6*0.,1.,-1.,0.,1.,2.,0.,1.,-1.,0.,1.,-1.,4*0.,1.,-1.,0./
      DATA CA/5*0.,5*270.,3*90.,2*270.,180.,6*90.,6*0.,2*180.,2*0.,180.,&
     &3*0.,180./
      DATA ARC/.385091,.770182,1.555274,.000684,.385787,.809812,1.234875&
     &,1.235217,1.235559,1.620308,2.005399,2.39049,2.775581/

      PI=3.1415926
      AR=.0174533

!c      alteracao feita para que no retorno da subrotina a matriz A
!c      tenha os valores iniciais da matriz X. Para que a matriz A seja
!c      recalculada com os valores iniciais do DATA toda vez que se
!c      chamar a subrotina. 09/03/88.

        Do i = 1,13
          Do j = 1,3
                A (i,j) = X (i,j)
          end do
        end do


!C     CALCULO DAS LONGITUDES MEDIAS DA LUA (S0), DO SOL (H0), DO PERI-
!C     GEU LUNAR (P0), DO COMPLEMENTO DO NODO ASCENDENTE (DIFERENCA PARA
!C     360 GRAUS) (AN) E DO PERIELIO (P1) PARA 0 HORA DE 1/1 DO PRIMEIRO
!C     ANO DO SECULO.

!c      alteracao de 13/09/90
        jm (3) = 28

!c      ATENCAO iano e = ao ano anterior ao soliciatado pela previsao.

      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)JM(3)=29

!c--------------------------------------
!c      Alteracao feita em 24/04/2000 seguindo livro texto 1998

        isec1 = int (iano / 100)
        isec = isec1 + 1
        iii = mod (isec1,4)
        it1 = isec - 20
        t1 = it1
        c3 = 0
        if (it1 .ne. 0) then
                c3 = abs (isec - 20) / (isec - 20)
        end if
        t2 = t1 * t1 * c3
        c1 = int (c3 * ( 0.75 * abs (isec - 20) + 0.5))
   19 S0=277.0224+307.8831*T1+.0011*T2-13.1764*C1
      H0=280.1895+.7689*T1+.0003*T2-.9856*C1
      P0=334.3853+109.034*T1-.0103*T2-.1114*C1
      AN=100.7902+134.142*T1-.0021*T2-.053*C1
      P1=281.2208+1.7192*T1+.00045*T2-.000047*C1

!c      Calculo do numero de dias desde 01/01 a 30/11 do ano anterior a
!c      previsao (incluindo as datas extremas).

      DO 20 I=1,IMES
   20 IDIAS=IDIAS+JM(I)
      IDIAS=IDIAS-1
      IAN=ISEC1*100
      AI=int ((IANO-IAN-1)/4)   ! AI e o nr. inteiro de anos bissextos
      DI=IDIAS

!c      correcao de anos lunares = corr
        corr = int ((iano - 1) / 400) - 4
        adi = ai + di + corr
        bi = iano - 100 * (isec - 1)

!c      as longitude medias sao calculadas para zero hora de 1 de dezembro do
!c      ano anterior a previsao. 

!C     CALCULO DAS LONGITUDES MEDIAS ACIMA REFERIDAS PARA A DATA.
!C     OS VALORES DE A(7),A(8) E A(9) SAO OS VALORES DE A(4), A(5) E A(6)
!C     AJUSTADOS PARA O CENTRO DA SERIE,NO CASO DAS PREVISOES.

      AS(2)=S0+129.38481*BI+13.1764*ADI
      AS(3)=H0-.23872*BI+.98565*ADI
      AS(4)=P0+40.66249*BI+.1114*ADI
      AS(5)=AN+19.32818*BI+.05295*ADI
      AS(6)=P1+.01718*BI+.000047*ADI
      AN2=N*DELTAT*0.5
      AV=AN2
      SN=AV/10000.
      IF(MO.NE.0)GO TO 24
      HI=HI+AN2
      AN2=0.
   24 AS(1)=AS(3)-AS(2)
      AS(1)=AS(1)+HI*14.49205211
      AS(2)=AS(2)+HI*.54901653
      AS(3)=AS(3)+HI*.04106864
      AS(4)=AS(4)+HI*.00464183
      AS(5)=AS(5)+HI*.00220641
      AS(6)=AS(6)+HI*.00000196
      AS(7)=AS(4)+AN2*.00464183
      AS(8)=AS(5)+AN2*.00220641
      AS(9)=AS(6)+AN2*.00000196

!C     CALCULO DOS FATORES E ANGULOS PERINODAIS.

      IF(AS(1).LT.0.)AS(1)=AS(1)+360.
      DO 666 I=1,13
      IF(MO.NE.0)GO TO 25
      ALFA=ARC(I)*SN
      ALFA=SIN(ALFA)/ALFA
      GO TO 26
   25 ALFA=1.
   26 S=0.
      DO 667 J=1,3
      S=S+A(I,J)*AS(J+6)
  667 CONTINUE
      A(I,1)=S*AR
      A(I,3)=COS(A(I,1))*ALFA
  666 A(I,2)=SIN(A(I,1))*ALFA
      DO 668 J=1,37
      T=0.
      R=0.
      DO 669 I=1,13
      T=T+B(J,I)*A(I,3)
  669 R=R+C(J,I)*A(I,2)
      F(J)= SQRT ((1.+ T) **2 + R * R)
      U(J)= ATAN (R/(1.+T)) /AR
  668 CONTINUE

!C     CALCULO DAS CORRECOES DE AMPLITUDE (MULTIPLICATIVAS) E DE FASE
!C     (ADITIVAS) PARA AS ANALISES DE PERIODOS INFERIORES A 6 MESES. ES-
!C     SAS CORRECOES SAO APLICADAS, NO PROPRIO PROGRAMA, AOS FATORES PE-
!C     RINODAIS E AOS ARGUMENTOS ASTRONOMICOS.

      IF(KKK.EQ.0)GO TO 510
      Z1=2.*AS(3)
      A1=(Z1+U(17))*AR
      A2=(Z1-2.*AS(4))*AR
      A3=(Z1+U(34))*AR
      A4=(AS(3)-AS(6))*AR
      B1=.0014336*AV
      B2=.0012715*AV
      B3=B1*0.5
      B1=SIN(B1)/B1
      B2=SIN(B2)/B2
      B3=SIN(B3)/B3
      COEF1=.331*B1/F(17)
      COEF2=.190*B2
      COEF3=.261*B2*F(29)/F(30)
      COEF4=.272*B1*F(34)/F(32)
      IF(KKK.EQ.1)COEF4=0.
      COEF5=.059*B3/F(32)
      W1=1.-COEF1*COS(A1)
      W2=COEF1*SIN(A1)
      F2=SQRT(W1*W1+W2*W2)
      U2=ATAN2(W2,W1)/AR
      W3=1.+COEF2*COS(A2)
      W4=COEF2*SIN(A2)
      F3=SQRT(W3*W3+W4*W4)
      U3=ATAN2(W4,W3)/AR
      W5=1.+COEF3*COS(A2)
      W6=COEF3*SIN(A2)
      F4=SQRT(W5*W5+W6*W6)
      U4=ATAN2(W6,W5)/AR
      W7=1.+COEF4*COS(A3)+COEF5*COS(A4)
      W8=COEF4*SIN(A3)-COEF5*SIN(A4)
      F5=SQRT(W7*W7+W8*W8)
      U5=ATAN2(W8,W7)/AR
      F(8)=F(8)*F3
      U(8)=U(8)+U3
      F(17)=F(17)*F2
      U(17)=U(17)+U2
      F(21)=F(21)*F3
      U(21)=U(21)-U3
      IF(KKK.EQ.1)GO TO 509
      F(26)=F(26)*F3
      U(26)=U(26)+U3
  509 F(30)=F(30)*F4
      U(30)=U(30)+U4
      F(32)=F(32)*F5
      U(32)=U(32)+U5
  510 U(14)=U(14)+AS(9)
      U(18)=U(18)-AS(9)
      U(31)=U(31)+AS(9)
      U(33)=U(33)-AS(9)
      DO 235 K=1,37
      SS=0.
      DO 234 J=1,4
  234 SS=SS+GA(K,J)*AS(J)
      U(K)=U(K)+SS+CA(K)
      ML=U(K)/360.
      U(K)=U(K)-ML*360.
      IF(U(K).LT.0.)U(K)=U(K)+360.
  235 CONTINUE
      RETURN
      END

!C-----------------------------------------------------------------------------------------------------


SUBROUTINE ANALISE(arq_alt,arq_const,arq_reduc,arq_relat,arq_13_ciclos,arq_9_ciclos,klm1,const,niveis,del)

  !DEC$ ATTRIBUTES DLLEXPORT::ANALISE

!C            *************************************************
!C            *                                               *
!C            *                  MAR203M3                     *
!C            *                                               *
!C            *             ANALISE  HARMONICA                *
!C            *                                               *
!C            *************************************************  
!c
!C              ROTINAS PARA SEREM COMPILADAS COM O PROGRAMA
!C
!C      ASTRO, FOURT, ARRAY, MINV, CMAR E FATOR
!C

!c      Definicao do registro

        character*150 arq_alt  ! nome do arquivo de alturas
        character*150 arq_const ! nome do arquivo para gerar as constantes harmônicas
        character*150 arq_reduc ! nome do arquivo para gerar o cadastro de redução de sondagem
    character*150 arq_relat ! nome do arquivo para gerar o relatório de análise
        character*150 arq_13_ciclos ! nome do arquivo de 13 ciclos
        character*150 arq_9_ciclos ! nome do arquivo de 9 ciclos
        character*1     klm1     ! tipo de processamento
        character*1     const    ! Cadastramento das constantes (S/N)
        character*1     niveis   ! Cadastramento dos niveis de reducao (S/N)
        character*1     del      ! deletar arquivo de entrada (S/N)

!c      Variaveis tranformadas para o processamento

        real*4          deltat
        real*4          hi
        real*4          fuso
        integer*2       klm
        real*4          prob

!c      Variaveis lidas do registro mestre

        character*5     Nr_estacao
        character*2     dia_ini,mes_ini,dia_fim,mes_fim
        character*4     ano_fim,ano_ini
        character*38    porto
        character*2     grau_lat,min_lat,min_lon
        character*1     dec_lat,sentido_lat,dec_lon,sentido_lon
        character*3     grau_lon
        character*4     fuso1

!C      Variaveis de trabalho

        integer*2       pag
        integer*2       cont_ciclo
        integer*2       linhas
        integer*2       cont_const
        integer*4       df,mf,af
        character*4     minuto_long
        integer*2       impre
        logical*1       houve_registro
        character*21    chave   ! Indica qual a chave para gravacao do arquivo
!c                                de niveis de reducao.
        character*10    nivel_ref

!c      DIMENSION F1(37),U1(37),F2(14),U2(14),AS(9)
!c      DIMENSION Q1(37),Q3(14),Q4(7),COM1(14),COM2(14),INAUX(14)
!c      DIMENSION X(2,18000),NN(3),WORK(36000)
!c      DIMENSION FMT(13),IX(35),SIMB1(35),SIMB2(35),Q(35),LM(14,35)
!c      DIMENSION A(35,400),B(35,400),AX(35,35),BX(35,35)
!c      DIMENSION LP(35),LK(35),Y(2,35)
!c      DIMENSION F(35),U(35),AMPL(180),SITU(180),CIA(180),CIF(180)
!c      DIMENSION A2(180),B2(180),A3(180),A4(180),A5(180),STAR(180)
!c      DIMENSION H1(7),G1(7),H2(14),G2(14),G3(14),G4(14)

!c      Toca feita em 09/11/89 para real* 4
        real*4  F1(37),U1(37),F2(14),U2(14),AS(9)
        real*4  Q1(37),Q3(14),Q4(7),COM1(14),COM2(14)
        real*4  X(2,18000),WORK(36000)
        real*4  FMT(13),SIMB1(35),SIMB2(35),Q(35)
        real*4  A(35,400),B(35,400),AX(35,35),BX(35,35)
        real*4  Y(2,35)
        real*4  F(35),U(35),AMPL(180),SITU(180),CIA(180),CIF(180)
        real*4  A2(180),B2(180),A3(180),A4(180),A5(180),STAR(180)
        real*4  H1(7),G1(7),H2(14),G2(14),G3(14),G4(14)

!c      Troca feita para integer*4
        integer*4       inaux(14)
        integer*4       nn(3),ix(35),lm(14,35),lp(35),lk(35)

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424074,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265119,&
     &43.4761563/
      DATA Q3/12.8542862,12.9271398,13.4715145,14.9178647,14.9589314,15.&
     &0821353,15.1232059,15.5125897,27.8953548,28.5125831,29.4556253,29.&
     &9589333,30.0410667,30.0821373/
      DATA Q4/13.3986609,13.9430356,15.0410686,15.5854433,28.4397295,28.&
     &9841042,30.0000000/
      DATA COM1/3H2Q1,3HSIG,3HRO1,3HPI1,3HP1 ,3HPSI,3HFI1,3HTET,3H2N2,&
     &3HNU2,3HLAM,3HT2 ,3HR2 ,3HK2 /
      DATA COM2/3H   ,3HMA1,3H   ,3H   ,3H   ,3H1  ,3H   ,3HA1 ,3H   ,&
     &3H   ,3HBD2,3H   ,3H   ,3H   /
      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/
      DATA X/36000*0./
      DATA ASTER/1H*/,BRANCO/1H /
        
        COMMON /IMPRE/ IMPRE
        common /teste/ houve_registro

!C******************************************************************************


!C     DELTAT _ INTERVALO DE AMOSTRAGEM, EM FRACAO DECIMAL DA HORA.
!C     HI     _ HORA LOCAL, INICIO DAS OBSERVACOES.
!C     IDIAS  _ DIA INICIAL DAS ALTURAS HORARIAS.
!C     IMES   _ MES INICIAL DAS ALTURAS HORARIAS.
!C     IANO   _ ANO INICIAL DAS ALTURAS HORARIAS.
!C     N      _ E O NUMERO DE PONTOS AMOSTRADOS.
!C     NL     _ E O NUMERO DE ESPECIES OU NUMERO DE LOOPS.
!C     KKK    _ PERIODO A ANALISAR PODE SER :
!C              0 _ IGUAL OU SUPERIOR A 6 MESES.
!C              1 _ ENTRE 3 E 6 MESES.
!C              2 _ ENTRE 1 E 3 MESES.
!C              3 _ INFERIOR A 1 MES.
!C     LA     _ GRAUS DA LONGITUDE.
!C     ALONG  _ MINUTOS DA LONGITUDE.
!C     FUSO   _ FUSO HORARIO.
!C     KLM    _ DEFINE O TIPO DE SISTEMAS
!C              0 _ ANALISE DE ALTURAS HORARIAS (PROCESSAMENTO NORMAL).
!C              1 _ NIVEL MEDIO DO MAR COM TODAS AS COMP. NUM MESMO SISTEMA.
!C              2 _ DE NIVEL MEDIO COM AS COMP. EM VARIOS SISTEMAS (CADA SISTE_
!C                  MA COM COMPONENTES DE MESMO NUMERO APROX. DE CICLOS POR MES.
!C     KDSD   _ CHAVE PARA O CALCULO DAS COMPONENTES SEMIDIURNAS, PODE SER:
!C              0 _ NAO CALCULA.
!C              1 _ CALCULA.
!C     PROB   _ PROBABILIDADE, PARA CALCULO DO INTERVALO DE CONFIABILIDADE DAS
!C              AMPLITUDES, EM PORCENTAGEM * 0.01


!C******************************************************************************


   impre = 3

   open (unit = impre, file = arq_relat, status = 'new', iostat = ierroimpre)
   open (unit = 20, file = arq_reduc, status = 'new', iostat = ierroreduc)
   open (unit = 15, file = arq_const, status = 'new', iostat = ierro3)
      
!C      Transformar Variaveis da tela

!c      Decode (1,'(i1)', klm1 ) klm
    READ (klm1,'(i1)') klm


!c      Inicializar variaveis

        pag = 0
        deltat = 1.0
        hi = 0.0
        prob = 0.950

!C      Abrir um arquivo de trabalho para gravacao das constantes harmonicas
!c      caso a variavel const seja igual a 'S'

        !if (const .eq. 'S') then
                !open   (unit = 15, file = arq_const, status = 'new', iostat = ierro3)
        !if (ierro3 .ne. 0) then
                        !type*,' Erro na abertura do arquivo de TRABALHO'
                        !type*,' Chame analista responsavel'
                        !type*,' Programa CANCELADO'
                        !type*,' Erro numero - ',ierro3
                        !stop
                !endif
        !end if


!c      Abrir arquivo contendo as alturas horarias, sendo o primeiro registro
!c              o mestre

        open    (unit = 11, file = arq_alt, status = 'old', iostat = ierro)
    !if (ierro.ne.0) then
          !type*,' Erro na abertura do arquivo de alturas'
          !type*,' Chame analista responsavel'
          !type*,' Programa CANCELADO'
          !stop
        !endif

!C      Leitura do registro mestre

        read (unit = 11, fmt = 1001, iostat = ierro_le) nr_estacao,dia_ini,&
        &       mes_ini,ano_ini,dia_fim,mes_fim,ano_fim,porto,grau_lat,min_lat,&
        &       dec_lat,sentido_lat,grau_lon,min_lon,dec_lon,sentido_lon,fuso1
 1001   format (a5,a2,a2,a4,a2,a2,a4,a38,a2,a2,a1,a1,a3,a2,a1,a1,a4)

        !if (ierro_le.ne.0) then
          !type*,' Arquivo na leitura do registro mestre'
          !type*,' Chame analista responsavel'
          !type*,' Programa CANCELADO'
          !stop
        !endif

!c      Criacao da chave para o arquivo de Niveis de Reducao, PERIODOS DE 
!C      CONSTANTES E CADASTRO DE CONSTANTES

        chave (01:05) = nr_estacao
        chave (06:09) = ano_ini
        chave (10:11) = mes_ini
        chave (12:13) = dia_ini
        chave (14:17) = ano_fim
        chave (18:19) = mes_fim
        chave (20:21) = dia_fim

!c      Transformar variaveis do registro mestre

!c      decode (2, '(i2)' , dia_ini ) idias
    READ (dia_ini,'(i2)') idias
!c      decode (2, '(i2)' , mes_ini ) imes
    READ (mes_ini,'(i2)') imes
!c      decode (4, '(i4)' , ano_ini ) iano
    READ (ano_ini,'(i4)') iano

!c      decode (2, '(i2)' , dia_fim ) df
    READ (dia_fim,'(i2)') df
!c      decode (2, '(i2)' , mes_fim ) mf
    READ (mes_fim,'(i2)') mf
!c      decode (4, '(i4)' , ano_fim ) af
    READ (ano_fim,'(i4)') af

!C      af = af + 1900

!c      decode (3, '(i3)' , grau_lon ) la
    READ (grau_lon,'(i3)') la

        minuto_long = min_lon // '.' // dec_lon
        
!c      decode (4, '(f4.1)', minuto_long ) along
    READ (minuto_long,'(f4.1)') along
!c      Decode (4,'(f4.1)',   fuso1 ) fuso
    READ (fuso1,'(f4.1)') fuso

!C      CALL PREPIMPRE (11)

        call cabecalho_analise (nr_estacao,porto,grau_lat,min_lat,dec_lat,sentido_lat,&
        &       grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,mes_ini,ano_ini,&
        &       dia_fim,mes_fim,ano_fim,pag,fuso1)


!c      Indicar que existe registro para impressao

        houve_registro = .true.

!c      Inicializar variaveis

        if (klm .eq. 0) then
          kdsd   = 1
        else
          kdsd   = 0
        end if
        



!c      calculo do numero de dias e observacoes


        n_dias = fator(df,mf,af) - fator(idias,imes,iano) + 1
        n=n_dias*24

!c      escolha da tabela a ser lida (9 ou 13 ciclos)

        if (n_dias.ge.300) then
                nl = 13
                open (unit = 12, file = arq_13_ciclos, status = 'old', iostat = ierotab13)
                !if (ierotab13 .ne. 0) then
                        !type *,' Erro na abertura da TABELA DE 13 CICLOS'
                        !type *,' Avisar ao ANALISTA RESPONSAVEL '
                        !type *,' Erro numero = ',ierotab13
                        !close (unit = 11)
                        !close (unit = 3, dispose = 'delete')
                        !stop
                !end if
        else
                nl = 9
                open    (unit = 12, file = arq_9_ciclos, status = 'old', iostat = ierotab9)
                !if (ierotab9 .ne. 0) then
                        !type *,' Erro na abertura da TABELA DE 9 CICLOS'
                        !type *,' Avisar ao ANALISTA RESPONSAVEL '
                        !type *,' Erro numero = ',ierotab9
                        !close (unit = 11)
                        !close (unit = 3, dispose = 'delete')
                        !stop
                !end if
        end if

!c      identificacao do periodo de analise

        kkk = 0
        if (n_dias.lt.180) kkk = 1
        if (n_dias.lt.90)  kkk = 2
        if (n_dias.lt.30)  kkk = 3



!c     READ(1,5300)IDIAS,IMES,IANO,N,NL,KKK,LA,ALONG,FUSO,PROB
!c 5300 FORMAT(7I5,F5.1,F5.0,F5.3)

      ALONG=ALONG/60.+LA
      PROB=1.-PROB

!C     CALCULO DOS FATORES PERINODAIS E DOS ARGUMENTOS ASTRONOMICOS DAS
!C     37 COMPONENTES ASTRONOMICAS MAIS IMPORTANTES.

      CALL ASTRO(0,DELTAT,HI,IDIAS,IMES,IANO,N,KKK,F1,U1,AS)

      DO 1 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    1 CONTINUE
      PI=3.1415926
      VPI=180./PI
      AN=N
      AN1=N+1
      AN2=AN*DELTAT/360.
      AL=PI/AN
      AJ=PI*DELTAT/360.
      N2=N/2+1
      VN=2./AN

!C     LEITURA DAS ORDENADAS X(1,I)

        READ (11,8888) (X(1,I),I=1,N)
 8888 FORMAT (24F4.0)

      OI=X(1,1)
!C
      NN(1)=N
!C     ANALISE DE FOURIER DAS ORDENADAS LIDAS.
      CALL FOURT(X,NN,1,-1,0,WORK)

      ANM=X(1,1)/AN
      CORR=(OI-ANM)*VN
      DO 3 I=2,N2
      X(1,I)=X(1,I)*VN+CORR
    3 X(2,I)=X(2,I)*VN
      KJ=0
!c
!c+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!c
        cont_ciclo = 0
      DO 23 LOOP=1,NL
!C     M1 CONSTITUINTES NA ESPECIE M2
      READ (12,5700) M1,M2
 5700 FORMAT(2(I2,2X))

!C     LEITURA DOS ELEMENTOS DAS M1 COMPONENTES DA ESPECIE QUE VAI SER
!C     ANALISADA NO LOOP. PARA A COMPONENTE DE ORDEM I, IX(I)=1,0,2
!C     CONFORME SEJA A COMPONENTE ASTRONOMICA OU DE PEQUENO FUNDO OU
!C     ARBITRARIA. SIMB1(I), SIMB2(I) SIMBOLO DA COMPONENTE.
!C     Q(I) VELOCIDADE ANGULAR, EM GRAUS/HORA
!C     LM(J,I) MATRIZ PARA O CALCULO DO FATOR PERINODAL E DO ARGUMENTO
!C     ASTRONOMICO DA COMPONENTE, SE ELA NAO FOR ASTRONOMICA
   60 READ(12,5800)(IX(I),SIMB1(I),SIMB2(I),Q(I),(LM(J,I),J=1,14),I=1,M1)
 5800 FORMAT(I1,A3,A4,F10.7,14I2)
      IF(M1.EQ.1)GO TO 9060
      DO 62 I=2,M1
      IANT=I-1
      IF(Q(I)-Q(IANT))61,61,62
   61 WRITE(impre,6655)M2
 6655 FORMAT(1H ,2X,'CONSTITUINTES DA ESPECIE',1X,I2,1X,'NAO ESTAO EM OR&
     &DEM CRESCENTE DE VELOCIDADES ANGULARES')
      GO TO 23
   62 CONTINUE
!C     FORMACAO DOS SISTEMAS SUPERABUNDANTES EM AMPLITUDE*COS(FASE) E
!C     AMPLITUDE*SIN(FASE) CUJAS MATRIZES SAO ARMAZENADAS,RESPECTIVAMENTE
!C     EM A(J,K) E B(J,K).
 9060 JJ=1
      IF(M2.NE.0)JJ=AN2*Q(1)-1.5
      KK=AN2*Q(M1)+2.5
      L=KK-JJ+1
      DO 4 J=1,M1
      R=AJ*Q(J)
      JR=JJ-1
      DO 4 K=1,L
      JR=JR+1
      P=AL*JR
      D=P-R
      S=P+R
      DD=D*AN1
      SS=S*AN1
      E=AN1/AN
      IF(ABS(D).GT.1.E-10)E=SIN(DD)/(AN*SIN(D))
      S=SIN(SS)/(AN*SIN(S))
      RD=MOD(JR,2)
      SI=1.-RD-RD
      A(J,K)=(E+S)*SI
      B(J,K)=(E-S)*SI
    4 CONTINUE
!C     CALCULO E INVERSAO DAS MATRIZES AX(J,IJ) E BX(J,IJ) DAS EQUACOES
!C     NORMAIS E CALCULO DAS INCOGNITAS Y(1,I) E Y(2,I).
      DO 7 J=1,M1
      DO 7 IJ=1,M1
      S=0.
      T=0.
      DO 6 K=1,L
      S=S+A(J,K)*A(IJ,K)
    6 T=T+B(J,K)*B(IJ,K)
      AX(J,IJ)=S
      AX(IJ,J)=S
      BX(J,IJ)=T
    7 BX(IJ,J)=T
      CALL ARRAY(2,M1,M1,35,35,AX,AX)
      CALL MINV(AX,M1,DET,LP,LK)
      CALL ARRAY(1,M1,M1,35,35,AX,AX)
      CALL ARRAY(2,M1,M1,35,35,BX,BX)
      CALL MINV(BX,M1,DET,LP,LK)
      CALL ARRAY(1,M1,M1,35,35,BX,BX)
!C     CALCULO DOS FATORES PERINODAIS E DOS ARGUMENTOS ASTRONOMICOS
!C     CALCULO DAS AMPLITUDES AMPL(KJ) E DOS ATRASOS DE FASE SITU(KJ)
!C     EM RELACAO A ZONA HORARIA, A4(KJ) EM RELACAO AO MERIDIANO LOCAL E
!C     A5(KJ) EM RELACAO A GREENWICH
      DO 10 I=1,M1
      KJ=KJ+1
      A2(KJ)=SIMB1(I)
      B2(KJ)=SIMB2(I)
      A3(KJ)=Q(I)
      IF(KLM.NE.0.OR.KKK.EQ.3)M2=Q(I)/15.+.5
      AAA5=Q(I)*FUSO
      AAA4=AAA5-ALONG*M2
      IF(IX(I)-1)34,33,35
   33 DO 20 II=1,37
      IF(ABS(Q(I)-Q1(II)).GT..0001)GO TO 20
      F(I)=F1(II)
      U(I)=U1(II)
      GO TO 50
   20 CONTINUE
   34 F(I)=1.
      U(I)=0.
      DO 22 J=1,14
      F(I)=F(I)*F2(J)**IABS(LM(J,I))
      U(I)=U(I)+U2(J)*LM(J,I)
   22 CONTINUE
      GO TO 50
   35 F(I)=1.
      U(I)=0.
      DO 36 JK=1,6
   36 U(I)=U(I)+AS(JK)*LM(JK,I)
   50 S1=0.
      S2=0.
      JJAK=JJ
      DO 9 K=1,L
      C1=0.
      C2=0.
      DO 8 J=1,M1
      C1=C1+AX(I,J)*A(J,K)
    8 C2=C2+BX(I,J)*B(J,K)
      JJAK=JJAK+1
      S1=S1+X(1,JJAK)*C1
    9 S2=S2+X(2,JJAK)*C2
      Y(1,I)=S1
      Y(2,I)=S2
      R=SQRT(S1*S1+S2*S2)
      P=ATAN2(S2,S1)*VPI
      AMPL(KJ)=R/F(I)
      SS=U(I)-P

        SITU(KJ)=SS-IFIX(SS/360.)*360.

      IF(SITU(KJ).LT.0.)SITU(KJ)=SITU(KJ)+360.
      SS=SITU(KJ)+AAA5

        A5(KJ)=SS-IFIX(SS/360.)*360.

      IF(A5(KJ).LT.0.)A5(KJ)=A5(KJ)+360.
      SS=SITU(KJ)+AAA4

        A4(KJ)=SS-IFIX(SS/360.)*360.

      IF(A4(KJ).LT.0.)A4(KJ)=A4(KJ)+360.
      IF(KKK.EQ.0)GO TO 10
      IF(ABS(A3(KJ)-12.9271).GT.1.E-4)GO TO 10
      AMPL(KJ)=1.E20
      SITU(KJ)=1.E20
      A5(KJ)=1.E20
      A4(KJ)=1.E20
   10 CONTINUE
!C     CALCULO DO NUMERO DE GRAUS DE LIBERDADE IL,DA ENERGIA RESIDUAL S
!C     DO DESVIO PADRAO T E DA AMPLITUDE LIMITE RO. AS COMPONENTES COM
!C     AMPLITUDES INFERIORES A RO TEM SEUS SIMBOLOS, NA LISTAGEM FINAL,
!C     PRECEDIDOS DE UM ASTERISCO.
      J2=JJ
      DO 13 K=1,L
      S=0.
      T=0.
      DO 12 I=1,M1
      S=S+A(I,K)*Y(1,I)
   12 T=T+B(I,K)*Y(2,I)
      J2=J2+1
      X(1,J2)=S-X(1,J2)
   13 X(2,J2)=T-X(2,J2)
      JJ1=JJ+1
      KK1=KK+1
      S=0.
      DO 15 JT=JJ1,KK1
      X(1,JT)=X(1,JT)**2+X(2,JT)**2
   15 S=S+X(1,JT)
      IL=(L-M1)*2

      GL=IL

!C--------------------------------------------------------------------------
!C      ALTERACAO EM 03/02/94, 
!C      QUANDO IL FOR = 0, PARA QUE NAO  OCORRA A DIVISAO DE GL POR 0
!C      O VALOR DE GL FOI FORCADO A SER 1.0
        
        IF (IL .EQ. 0) GL = 1.
!C---------------------------------------------------------------------------

      T=SQRT(S/GL)
      S=S*0.5
      RO=T*SQRT(GL*(PROB**(-2./GL)-1.))
      I1=KJ-M1+1
      DO 32 I=I1,KJ
      IF(AMPL(I)-RO)31,31,9032
   31 STAR(I)=ASTER
      CIA(I)=1.E20
      CIF(I)=1.E20
      GO TO 32
 9032 STAR(I)=BRANCO
      CIA(I)=RO
      CIF(I)=ASIN(RO/AMPL(I))*57.29578
   32 CONTINUE

        linhas = ((kk1 - jj1) / 8 ) + 1
        if ((cont_ciclo + linhas) .gt. 45) then
          call cabecalho_analise (nr_estacao,porto,grau_lat,min_lat,dec_lat,&
        &       sentido_lat,grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,&
        &       mes_ini,ano_ini,dia_fim,mes_fim,ano_fim,pag,fuso1)
          cont_ciclo = linhas + 4
        else
          cont_ciclo = cont_ciclo + linhas + 4
        end if

      IF(KKK.EQ.3.OR.KLM.EQ.1) then
        write (impre,6651)
        GO TO 670
      END IF
        cont_ciclo = cont_ciclo + 1
      IF(KLM.EQ.2) then
        WRITE(impre,6650)M2
      else
        WRITE(impre,6500)M2
      end if

 6500 FORMAT(/,t11,'CICLOS POR DIA',1X,I2)
 6650 FORMAT(/,t11,'CICLOS POR MES',1X,I2)
 6651 format (' ')

  670 WRITE(impre,6700)IL,S,T,RO
 6700 FORMAT(t11,'GRAUS DE LIBERDADE - ',I3,t39,'ENERGIA RESIDUAL - ',&
     &F8.2,t70,'DESVIO PADRAO - ',F4.2,t95,'AMPLITUDE LIMITE - ',F8.2,/,&
     &t11,'ESPECTRO RESIDUAL DE AMPLITUDES',/,t11,8('GR/HORA  RES. '))
!C     CALCULO DO ESPECTRO RESIDUAL DE AMPLITUDES
      DO 16 JT=JJ,KK
      JT1=JT+1
      X(2,JT1)=JT/AN2
   16 X(1,JT1)=SQRT(X(1,JT1))

      WRITE(impre,6900) (X(2,J),X(1,J), J = JJ1,KK1)
 6900 FORMAT((t11,8(F7.3,1X,F5.2,1X)))
        

   23 CONTINUE
!c
!c+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!c
        call cabecalho_analise (nr_estacao,porto,grau_lat,min_lat,dec_lat,sentido_lat,&
        &       grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,mes_ini,ano_ini,&
        &       dia_fim,mes_fim,ano_fim,pag,fuso1)

      WRITE(impre,7000)
 7000 FORMAT(t55,'CONSTANTES HARMONICAS',///,t26,'NO',3X,&
     &'COMP.',5X,'GRAUS/HORA',6X,'H CM',7X,'+ -',3X,'G GRAUS',3X,&
     &'K GRAUS',2X,'GW GRAUS',7X,'+ -',/)
        cont_const = 0
        DO I = 1,KJ
        cont_const = cont_const + 1
        IF (cont_const .GT. 40 ) THEN
          call cabecalho_analise (nr_estacao,porto,grau_lat,min_lat,dec_lat,&
        &       sentido_lat,grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,&
        &       mes_ini,ano_ini,dia_fim,mes_fim,ano_fim,pag,fuso1)
          write (impre,7000)
          cont_const = 1
        END IF

      WRITE(impre,7100,IOSTAT=IERRO) I,STAR(I),A2(I),B2(I),A3(I),AMPL(I),&
     &CIA(I),SITU(I),A4(I),A5(I),CIF(I)

!c      Gravacao das constantes no arquivo de trabalho

        if  (star (i) .eq. BRANCO .and.& 
        &    ampl (i) .ne. 1.E20 .and.& 
        &    ampl (i) .ge. 0.5   .and.& 
        &    situ (i) .ne. 1.E20 )      then
             write (15,7777) a2(i), b2(i), a3(i), ampl(i), situ(i)
        end if
7777    format (a3,a4,f11.7,f8.2,f8.2)

        end do
 7100 FORMAT (t25,I3,2X,A1,A3,A4,2X,F11.7,6(2X,F8.2) )

        write (impre,7101)
 7101 format (///,t29,'OBS: AS COMPONENTES ASTERISCADAS NAO ESTAO DENTRO DO IN',&
        &       'TERVALO DE CONFIANCA.')
!c-----------------------------------------------------------------------------

!C
      IF(KLM.GT.0.OR.KDSD.EQ.0)GO TO 51
      DO 24 I=1,KJ
      DO 24 J=1,7
      IF(ABS(A3(I)-Q4(J)).GT.1.E-4)GO TO 24
      H1(J)=AMPL(I)
      G1(J)=SITU(I)
   24 CONTINUE
      IF(KKK.EQ.0)GO TO 28
!C     CALCULO DAS CONSTANTES NAO HARMONICAS EM FUNCAO DAS HARMONICAS
!C     INFERENCIA DE CONSTANTES NAS ANALISES DE PERIODOS INFERIORES A 6
!C     MESES.
      G12=G1(2)
      G13=G1(3)
      G16=G1(6)
      G17=G1(7)
      DG1=G12-G1(1)
      DG2=G13-G12
      DG3=G1(4)-G12
      DG4=G17-G16
      DG5=G16-G1(5)
      H13=H1(3)
      H17=H1(7)
      H2(1)=.025*H1(2)
      H2(2)=.031*H1(2)
      H2(3)=.19*H1(1)
      H2(4)=.019*H13
      H2(5)=.331*H13
      H2(6)=.008*H13
      H2(7)=.014*H13
      H2(8)=.191*H1(4)
      H2(9)=.132*H1(5)
      H2(10)=.19*H1(5)
      H2(11)=.007*H1(6)
      H2(12)=.059*H17
      H2(13)=.008*H17
      H2(14)=.272*H17
      G2(1)=G13-1.992*DG2
      G2(2)=G13-1.925*DG2
      G2(3)=G12-.866*DG1
      G2(4)=G13-.112*DG2
      G2(5)=G13-.075*DG2
      G2(6)=G13+.037*DG2
      G2(7)=G13+.075*DG2
      G2(8)=G12-.956*DG3
      G2(9)=G16-2.*DG5
      G2(10)=G16-.866*DG5
      G2(11)=G17-.536*DG4
      G2(12)=G17-.04*DG4
      G2(13)=G17+.04*DG4
      G2(14)=G17+.081*DG4
      DO 27 I=1,14
      G4(I)=Q3(I)*FUSO+G2(I)
      G3(I)=G4(I)-ALONG
      IF(I.GT.9)G3(I)=G3(I)-ALONG
      IF(G2(I).LT.0.)G2(I)=G2(I)+360.
      IF(G2(I).GE.360.)G2(I)=G2(I)-360.
      IF(G4(I).LT.0.)G4(I)=G4(I)+360.
      IF(G4(I).GE.360.)G4(I)=G4(I)-360.
      IF(G3(I).LT.0.)G3(I)=G3(I)+360.
   27 IF(G3(I).GE.360.)G3(I)=G3(I)-360.

        CALL cabecalho_analise (nr_estacao,porto,grau_lat,min_lat,dec_lat,&
        &       sentido_lat,grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,&
        &       mes_ini,ano_ini,dia_fim,mes_fim,ano_fim,pag,fuso1)
      WRITE(impre,7200)
 7200 FORMAT(///,T51,'CONSTANTES HARMONICAS INFERIDAS',///,T36,&
     &'NO',3X,'COMP.',5X,'GRAUS/HORA',6X,'H CM',3X,'G GRAUS',3X,&
     &'K GRAUS',2X,'GW GRAUS')
      WRITE(impre,7250)(I,COM1(I),COM2(I),Q3(I),H2(I),G2(I),G3(I),&
     &G4(I),I=1,14)
 7250 FORMAT((T35,I3,3X,A3,A4,2X,F11.7,4(2X,F8.2)))

!c      Gravacao das constantes inferidas no arquivo de trabalho

!c      write (15,7272) (com1 (j), com2 (j), q3 (j), h2 (j), g2 (j),j = 1,14)
        do j = 1,14
                if (h2 (j) .ge. 0.5) then
                   write (15,7272) com1 (j), com2 (j), q3 (j), h2 (j), g2 (j)
                end if
        end do

7272    format (a3,a4,f11.7,f8.2,f8.2)


!C
!C     CLASSIFICACAO DA MARE,NIVEL DE REDUCAO (DE SONDAGENS),ESTABELECI-
!C     MENTO DO PORTO,NIVEIS MEDIOS DAS PREAMARES E BAIXAMARES DE SIZI-
!C     GIA E QUADRATURA.

   28 CALL cabecalho_analise (nr_estacao,porto,grau_lat,min_lat,dec_lat,sentido_lat,&
        &       grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,mes_ini,ano_ini,&
        &       dia_fim,mes_fim,ano_fim,pag,fuso1)

      CALL CMAR(A3,AMPL,H2,H1,G1,ANM,KKK,KJ,niveis,chave,nivel_ref)


        call prepimpre (10)

!c      Verifica se sera gravada as contantes criadas neste processo

        !if (const .eq. 'S') then
                !close (unit = 15)
                !(CHECK)call lib$spawn ('sort/key=(pos:8,siz:11)' //&
        !&              ' trabalho_do_mar3_18.dat trabalho_do_mar3_18.dat')
                !call cadastra_constante (chave, nivel_ref)
                !(CHECK)call lib$spawn ('delete trabalho_do_mar3_18.dat;*')
        !else
                !close (unit = 15, dispose = 'delete')
        !end if 

!c      Verifica se o arquivo de alturas sera deletado

        !if (del .eq. 'S') then
                !close (unit = 11, dispose = 'delete')
        !else
                !close (unit = 11)
        !end if

51      close (unit = 12)
    close (unit = 11)
        close (unit = 20)
        close (unit = 15)
        close (unit = impre)

        RETURN
        END


SUBROUTINE CABECALHO_ANALISE (numero_da_estacao,nome_da_estacao,grau_lat,&
        &       min_lat,dec_lat,sentido_lat,grau_lon,min_lon,dec_lon,&
        &       sentido_lon,dia_ini,mes_ini,ano_ini,dia_fim,mes_fim,ano_fim,pag,&
        &       fuso1)

        CHARACTER*10    DATA_IMP
        INTEGER*2       PAG,IMPRE

!C      Variaveis de passagem para a subrotina

        Character*5   Numero_da_Estacao  
        Character*38  Nome_da_Estacao    
        Character*2   Grau_Lat           
        Character*2   Min_Lat            
        Character*1   Dec_Lat            
        Character*1   Sentido_Lat        
        Character*3   Grau_Lon           
        Character*2   Min_Lon            
        Character*1   Dec_Lon            
        Character*1   Sentido_Lon        
        Character*2   dia_ini
        Character*2   mes_ini
        Character*4   ano_ini
        Character*2   dia_fim
        Character*2   mes_fim
        Character*4   ano_fim
        Character*4   fuso1


        COMMON /IMPRE/ IMPRE
        COMMON /DATA/ DATA_IMP

!c-------------------------------------------------------------------------------
        
!C      CALL SALTAFOLHA

        PAG = PAG + 1
                
        WRITE (IMPRE,10) PAG
        WRITE (IMPRE,20) DATA_IMP
        WRITE (IMPRE,30)
        WRITE (IMPRE,40)

        write (impre,50) nome_da_estacao, FUSO1 (1:3), FUSO1 (4:4),&
        &       dia_ini, mes_ini, ano_ini, dia_fim, mes_fim, ano_fim

        write (impre,60) numero_da_estacao,grau_lat, min_lat, dec_lat,&
        &       sentido_lat, grau_lon, min_lon, dec_lon, sentido_lon
 

10      FORMAT  ('1',T11,'SISTEMA - MARES',T57,'MARINHA DO BRASIL',&
        &       T103,'PAGINA - ',I8)

20      FORMAT (' ',T11,'PROGRAMA - MAR3_18',T48,&
        &       'DIRETORIA DE HIDROGRAFIA E NAVEGACAO',T103,'DATA - ',A)

30      FORMAT (' ',T47,'BANCO NACIONAL DE DADOS OCEANOGRAFICOS',/)

40      FORMAT (' ',t47,'ANALISE ESTATISTICA E HARMONICA DA MARE',/)

50      FORMAT (' ',T11,'NOME - ',A,t58,'FUSO - ',A,'.',A,&
        &       T74,'PERIODO DE OBSERVACOES - ',A,'/',A,'/',A,&
        &       ' A ',A,'/',A,'/',A)

60      FORMAT (' ',T11,'NUMERO DA ESTACAO - ',A,T58,'LATITUDE - ',&
        &       A,' ',A,' ',A,' ',A,T100,'LONGITUDE - ',A,' ',A,' ',A,' ',A,/)

  RETURN
END


Function FATOR (dd,mm,aa)

!C      FUNACAO PARA CALCULAR O NUMERO DE DIAS ENTRE DUAS DATAS 
!C      O DIA ATUAL E CONTABILIZADO NO PROPRIO PROGRAMA PRINCIPAL.
!C
!C      MODO DE UTILIZACAO:
!C
!C      N_DIAS = FATOR (DF,MF,AF) - FATOR (DI,MI,AI) + 1
!C

  integer*4  dd, mm, aa, xx
  real*4     d, m, a, x1, x2

  d = floatj(dd)
  m = floatj(mm)
  a = floatj(aa)
  x1 = - jint(0.7+ (1./(1.+m)) )
  a  = a + x1
  x2 = (1.+m) - (12.*x1)
  fator = jint(x2*30.6001) + jint(a*365.25) + jint(d)
  return
end


SUBROUTINE FOURT(DATZ,NN,NDIM,ISIGN,IFORM,WORK)

!C SUBROTINA PERTENCENTE AO PROGRAMA MAR138M3.

!c DIMENSION DATZ(2),NN(1),WORK(1),IFACT(400)

!c      Troca realizada em 09/11/89
        real*4  DATZ(36000),WORK(36000)

        integer*4       nn(1),ifact(400)

      TWOPI=6.283185
      RTHLF=.7071068
      IF(NDIM-1)920,1,1
    1 NTOT=2
      DO 2 IDIM=1,NDIM
      IF(NN(IDIM))920,920,2
    2 NTOT=NTOT*NN(IDIM)
      NP1=2
      DO 910 IDIM=1,NDIM
      N=NN(IDIM)
      NP2=NP1*N
      IF(N-1)920,900,5
    5 M=N
      NTWO=NP1
      IFZ=1
      IDIV=2
   10 IQUOT=M/IDIV
      IREM=M-IDIV*IQUOT
      IF(IQUOT-IDIV)50,11,11
   11 IF(IREM)20,12,20
   12 NTWO=NTWO+NTWO
      IFACT(IFZ)=IDIV
      IFZ=IFZ+1
      M=IQUOT
      GO TO 10
   20 IDIV=3
      INON2=IFZ
   30 IQUOT=M/IDIV
      IREM=M-IDIV*IQUOT
      IF(IQUOT-IDIV)60,31,31
   31 IF(IREM)40,32,40
   32 IFACT(IFZ)=IDIV
      IFZ=IFZ+1
      M=IQUOT
      GO TO 30
   40 IDIV=IDIV+2
      GO TO 30
   50 INON2=IFZ
      IF(IREM)60,51,60
   51 NTWO=NTWO+NTWO
      GO TO 70
   60 IFACT(IFZ)=M
   70 ICASE=1
      IFMIN=1
      I1RNG=NP1
      IF(IDIM-4)71,100,100
   71 IF(IFORM)72,72,100
   72 ICASE=2
      I1RNG=NP0*(1+NPREV/2)
      IF(IDIM-1)73,73,100
   73 ICASE=3
      I1RNG=NP1
      IF(NTWO-NP1)100,100,74
   74 ICASE=4
      IFMIN=2
      NTWO=NTWO/2
      N=N/2
      NP2=NP2/2
      NTOT=NTOT/2
          I=1
      DO 80 J=1,NTOT
      DATZ(J)=DATZ(I)
   80 I=I+2
  100 IF(NTWO-NP2)200,110,110
  110 NP2HF=NP2/2
      J=1
      DO 150 I2=1,NP2,NP1
      IF(J-I2)120,130,130
  120 I1MAX=I2+NP1-2
      DO 125 I1=I2,I1MAX,2
      DO 125 I3=I1,NTOT,NP2
      J3=J+I3-I2
      TEMPR=DATZ(I3)
      TEMPI=DATZ(I3+1)
      DATZ(I3)=DATZ(J3)
      DATZ(I3+1)=DATZ(J3+1)
      DATZ(J3)=TEMPR
  125 DATZ(J3+1)=TEMPI
  130 M=NP2HF
  140 IF(J-M)150,150,145
  145 J=J-M
      M=M/2
      IF(M-NP1)150,140,140
  150 J=J+M
      GO TO 300
  200 NWORK=2*N
      DO 270 I1=1,NP1,2
      DO 270 I3=I1,NTOT,NP2
      J=I3
      DO 260 I=1,NWORK,2
      IF(ICASE-3)210,220,210
  210 WORK(I)=DATZ(J)
      WORK(I+1)=DATZ(J+1)
      GO TO 230
  220 WORK(I)=DATZ(J)
      WORK(I+1)=0.
  230 IFP2=NP2
      IFZ=IFMIN
  240 IFP1=IFP2/IFACT(IFZ)
      J=J+IFP1
      IF(J-I3-IFP2)260,250,250
  250 J=J-IFP2
      IFP2=IFP1
      IFZ=IFZ+1
      IF(IFP2-NP1)260,260,240
  260 CONTINUE
      I2MAX=I3+NP2-NP1
      I=1
      DO 270 I2=I3,I2MAX,NP1
      DATZ(I2)=WORK(I)
      DATZ(I2+1)=WORK(I+1)
  270 I=I+2
  300 IF(NTWO-NP1)600,600,305
  305 NP1TW=NP1+NP1
      IPAR=NTWO/NP1
  310 IF(IPAR-2)350,330,320
  320 IPAR=IPAR/4
      GO TO 310
  330 DO 340 I1=1,I1RNG,2
      DO 340 K1=I1,NTOT,NP1TW
      K2=K1+NP1
      TEMPR=DATZ(K2)
      TEMPI=DATZ(K2+1)
      DATZ(K2)=DATZ(K1)-TEMPR
      DATZ(K2+1)=DATZ(K1+1)-TEMPI
      DATZ(K1)=DATZ(K1)+TEMPR
  340 DATZ(K1+1)=DATZ(K1+1)+TEMPI
  350 MMAX=NP1
  360 IF(MMAX-NTWO/2)370,600,600
  370 CONTINUE
      MSSSS=MMAX/2
      IF(NP1TW-MSSSS)930,940,940
  930 LMAX=MMAX/2
      GO TO 950
  940 LMAX=NP1TW
  950 CONTINUE
      DO 570 L=NP1,LMAX,NP1TW
      M=L
      IF(MMAX-NP1)420,420,380
  380 THETA=-TWOPI*floatj(L)/floatj(4*MMAX)
      IF(ISIGN)400,390,390
  390 THETA=-THETA
  400 WR=COS(THETA)
      WI=SIN(THETA)
  410 W2R=WR*WR-WI*WI
      W2I=2.*WR*WI
      W3R=W2R*WR-W2I*WI
      W3I=W2R*WI+W2I*WR
  420 DO 530 I1=1,I1RNG,2
      KMIN=I1+IPAR*M
      IF(MMAX-NP1)430,430,440
  430 KMIN=I1
  440 KDIF=IPAR*MMAX
  450 KSTEP=4*KDIF
      IF(KSTEP-NTWO)460,460,530
  460 DO 520 K1=KMIN,NTOT,KSTEP
      K2=K1+KDIF
      K3=K2+KDIF
      K4=K3+KDIF
      IF(MMAX-NP1)470,470,480
  470 U1R=DATZ(K1)+DATZ(K2)
      U1I=DATZ(K1+1)+DATZ(K2+1)
      U2R=DATZ(K3)+DATZ(K4)
      U2I=DATZ(K3+1)+DATZ(K4+1)
      U3R=DATZ(K1)-DATZ(K2)
      U3I=DATZ(K1+1)-DATZ(K2+1)
      IF(ISIGN)471,472,472
  471 U4R=DATZ(K3+1)-DATZ(K4+1)
      U4I=DATZ(K4)-DATZ(K3)
      GO TO 510
  472 U4R=DATZ(K4+1)-DATZ(K3+1)
      U4I=DATZ(K3)-DATZ(K4)
      GO TO 510
  480 T2R=W2R*DATZ(K2)-W2I*DATZ(K2+1)
      T2I=W2R*DATZ(K2+1)+W2I*DATZ(K2)
      T3R=WR*DATZ(K3)-WI*DATZ(K3+1)
      T3I=WR*DATZ(K3+1)+WI*DATZ(K3)
      T4R=W3R*DATZ(K4)-W3I*DATZ(K4+1)
      T4I=W3R*DATZ(K4+1)+W3I*DATZ(K4)
      U1R=DATZ(K1)+T2R
      U1I=DATZ(K1+1)+T2I
      U2R=T3R+T4R
      U2I=T3I+T4I
      U3R=DATZ(K1)-T2R
      U3I=DATZ(K1+1)-T2I
      IF(ISIGN)490,500,500
  490 U4R=T3I-T4I
      U4I=T4R-T3R
      GO TO 510
  500 U4R=T4I-T3I
      U4I=T3R-T4R
  510 DATZ(K1)=U1R+U2R
      DATZ(K1+1)=U1I+U2I
      DATZ(K2)=U3R+U4R
      DATZ(K2+1)=U3I+U4I
      DATZ(K3)=U1R-U2R
      DATZ(K3+1)=U1I-U2I
      DATZ(K4)=U3R-U4R
  520 DATZ(K4+1)=U3I-U4I
      KDIF=KSTEP
      KMIN=4*(KMIN-I1)+I1
      GO TO 450
  530 CONTINUE
      M=M+LMAX
      IF(M-MMAX)540,540,570
  540 IF(ISIGN)550,560,560
  550 TEMPR=WR
      WR=(WR+WI)*RTHLF
      WI=(WI-TEMPR)*RTHLF
      GO TO 410
  560 TEMPR=WR
      WR=(WR-WI)*RTHLF
      WI=(TEMPR+WI)*RTHLF
      GO TO 410
  570 CONTINUE
      IPAR=3-IPAR
      MMAX=MMAX+MMAX
      GO TO 360
  600 IF(NTWO-NP2)605,700,700
  605 IFP1=NTWO
      IFZ=INON2
      NP1HF=NP1/2
  610 IFP2=IFACT(IFZ)*IFP1
      J1MIN=NP1+1
      IF(J1MIN-IFP1)615,615,640
  615 DO 635 J1=J1MIN,IFP1,NP1
      THETA=-TWOPI*floatj(J1-1)/floatj(IFP2)
      IF(ISIGN)625,620,620
  620 THETA=-THETA
  625 WSTPR=COS(THETA)
      WSTPI=SIN(THETA)
      WR=WSTPR
      WI=WSTPI
      J2MIN=J1+IFP1
      J2MAX=J1+IFP2-IFP1
      DO 635 J2=J2MIN,J2MAX,IFP1
      I1MAX=J2+I1RNG-2
      DO 630 I1=J2,I1MAX,2
      DO 630 J3=I1,NTOT,IFP2
      TEMPR=DATZ(J3)
      DATZ(J3)=DATZ(J3)*WR-DATZ(J3+1)*WI
  630 DATZ(J3+1)=TEMPR*WI+DATZ(J3+1)*WR
      TEMPR=WR
      WR=WR*WSTPR-WI*WSTPI
  635 WI=TEMPR*WSTPI+WI*WSTPR
  640 THETA=-TWOPI/floatj(IFACT(IFZ))
      IF(ISIGN)650,645,645
  645 THETA=-THETA
  650 WSTPR=COS(THETA)
      WSTPI=SIN(THETA)
      J2RNG=IFP1*(1+IFACT(IFZ)/2)
      DO 695 I1=1,I1RNG,2
      DO 695 I3=I1,NTOT,NP2
      J2MAX=I3+J2RNG-IFP1
      DO 690 J2=I3,J2MAX,IFP1

      J1MAX=J2+IFP1-NP1

      DO 680 J1=J2,J1MAX,NP1
      J3MAX=J1+NP2-IFP2
      DO 680 J3=J1,J3MAX,IFP2
      JMIN=J3-J2+I3
      JMAX=JMIN+IFP2-IFP1
      I=1+(J3-I3)/NP1HF
      IF(J2-I3)655,655,665
  655 SUMR=0.
      SUMI=0.
      DO 660 J=JMIN,JMAX,IFP1
      SUMR=SUMR+DATZ(J)
  660 SUMI =SUMI+DATZ(J+1)
      WORK(I)=SUMR
      WORK(I+1)=SUMI
      GO TO 680
  665 ICONJ=1+(IFP2-2*J2+I3+J3)/NP1HF
      J=JMAX
      SUMR=DATZ(J)
      SUMI=DATZ(J+1)
      OLDSR=0.
      OLDSI=0.
      J=J-IFP1
  670 TEMPR=SUMR
      TEMPI=SUMI
      SUMR=TWOWR*SUMR-OLDSR+DATZ(J)
      SUMI=TWOWR*SUMI-OLDSI+DATZ(J+1)
      OLDSR=TEMPR
      OLDSI=TEMPI
      J=J-IFP1
      IF(J-JMIN)675,675,670
  675 TEMPR=WR*SUMR-OLDSR+DATZ(J)
      TEMPI=WI*SUMI
      WORK(I)=TEMPR-TEMPI
      WORK(ICONJ)=TEMPR+TEMPI
      TEMPR=WR*SUMI-OLDSI+DATZ(J+1)
      TEMPI=WI*SUMR
      WORK(I+1)=TEMPR+TEMPI
      WORK(ICONJ+1)=TEMPR-TEMPI
  680 CONTINUE
      IF(J2-I3)685,685,686
  685 WR=WSTPR
      WI=WSTPI
      GO TO 690
  686 TEMPR=WR
      WR=WR*WSTPR-WI*WSTPI
      WI=TEMPR*WSTPI+WI*WSTPR
  690 TWOWR=WR+WR
      I=1
      I2MAX=I3+NP2-NP1
      DO 695 I2=I3,I2MAX,NP1
      DATZ(I2)=WORK(I)
      DATZ(I2+1)=WORK(I+1)
  695 I=I+2
      IFZ=IFZ+1
      IFP1=IFP2
      IF(IFP1-NP2)610,700,700
  700 GO TO (900,800,900,701),ICASE
  701 NHALF=N
      N=N+N
      THETA=-TWOPI/floatj(N)
      IF(ISIGN)703,702,702
  702 THETA=-THETA
  703 WSTPR=COS(THETA)
      WSTPI=SIN(THETA)
      WR=WSTPR
      WI=WSTPI
      IMIN=3
      JMIN=2*NHALF-1
      GO TO 725
  710 J=JMIN
      DO 720 I=IMIN,NTOT,NP2
      SUMR=(DATZ(I)+DATZ(J))/2.
      SUMI=(DATZ(I+1)+DATZ(J+1))/2.
      DIFR=(DATZ(I)-DATZ(J))/2.
      DIFI=(DATZ(I+1)-DATZ(J+1))/2.
      TEMPR=WR*SUMI+WI*DIFR
      TEMPI=WI*SUMI-WR*DIFR
      DATZ(I)=SUMR+TEMPR
      DATZ(I+1)=DIFI+TEMPI
      DATZ(J)=SUMR-TEMPR
      DATZ(J+1)=-DIFI+TEMPI
  720 J=J+NP2
      IMIN=IMIN+2
      JMIN=JMIN-2
      TEMPR=WR
      WR=WR*WSTPR-WI*WSTPI
      WI=TEMPR*WSTPI+WI*WSTPR
  725 IF(IMIN-JMIN)710,730,740
  730 IF(ISIGN)731,740,740
  731 DO 735 I=IMIN,NTOT,NP2
  735 DATZ(I+1)=-DATZ(I+1)
  740 NP2=NP2+NP2
      NTOT=NTOT+NTOT
      J=NTOT+1
      IMAX=NTOT/2+1
  745 IMIN=IMAX-2*NHALF
      I=IMIN
      GO TO 755
  750 DATZ(J)=DATZ(I)
      DATZ(J+1)=-DATZ(I+1)
  755 I=I+2
      J=J-2
      IF(I-IMAX)750,760,760
  760 DATZ(J)=DATZ(IMIN)-DATZ(IMIN+1)
      DATZ(J+1)=0.
      IF(I-J)770,780,780
  765 DATZ(J)=DATZ(I)
      DATZ(J+1)=DATZ(I+1)
  770 I=I-2
      J=J-2
      IF(I-IMIN)775,775,765
  775 DATZ(J)=DATZ(IMIN)+DATZ(IMIN+1)
      DATZ(J+1)=0.
      IMAX=IMIN
      GO TO 745
  780 DATZ(1)=DATZ(1)+DATZ(2)
      DATZ(2)=0.
      GO TO 900
  800 IF(I1RNG-NP1)805,900,900
  805 DO 860 I3=1,NTOT,NP2
      I2MAX=I3+NP2-NP1
      DO 860 I2=I3,I2MAX,NP1
      IMIN=I2+I1RNG
      IMAX=I2+NP1-2
      JMAX=2*I3+NP1-IMIN
      IF(I2-I3)820,820,810
  810 JMAX=JMAX+NP2
  820 IF(IDIM-2)850,850,830
  830 J=JMAX+NP0
      DO 840 I=IMIN,IMAX,2
      DATZ(I)=DATZ(J)
      DATZ(I+1)=-DATZ(J+1)
  840 J=J-2
  850 J=JMAX
      DO 860 I=IMIN,IMAX,NP0
      DATZ(I)=DATZ(J)
      DATZ(I+1)=-DATZ(J+1)
  860 J=J-NP0
  900 NP0=NP1
      NP1=NP2
  910 NPREV=N
  920 RETURN
END


SUBROUTINE CMAR(A3,AMPL,H2,H1,G1,S0,KKK,KJ,grava,chave,nivel_ref)

!C     SUBROTINA PERTENCENTE AO PROGRAMA MAR138M3, SEGUNDA VERSAO.
!C     SUBROTINA CMAR - CALCULO DAS CONSTANTES NAO HARMONICAS

!c      Alterada para gravacao dos parametros preamar e baixamar de sizigia,
!c      preamar e baixamar de quadratura em SET/89 por AHF
!c
!c      Alterada em NOV/89 pelo Almte. FRANCO para calculo da preamar superior 
!c      e inferior e da baixamar superior e inferior quando a mare for desigual-
!c      dades diurnas.
!c
!c      variaveis para alteracao

        real*4  k,gm2,hm2,gs2,hs2,gk1,hk1,go1,ho1,c,s,coef,cc,cs
        real*4  mhhw,mlhw,mhlw,mllw
        integer*2       ichave  ! = a 1 identifica que a mare e' DESIGUALDADE
!C                                                                      DIURNAS
!c----------------------------------------------------------------------------

        character*1     grava
        character*21    chave
        integer*2       status_op, status_wr
        integer*2       indice ! identifica a mare para a subrotina
        character*7     s0_aux,a_aux,cnr_aux,chws_aux,chwn_aux,clm_aux
        character*7     clws_aux,clwn_aux
        character*2     ihwfcm_aux,ihwfch_aux
        character*21    tabela (4)
        character*10    nivel_ref       ! nivel medio para cadastrar as
!c                                        constantes

        
!c      Definicao das variáveis de REDUCAO

        character*5     Num_est                 ! 01:05 Chave primaria //
        character*4     Ano_inicial                     ! 06:09 Chave primaria //
        character*2     Mes_inicial                     ! 10:11 Chave primaria //
        character*2     Dia_inicial                     ! 12:13 Chave primaria //
        character*4     Ano_final                       ! 14:17 Chave primaria //
        character*2     Mes_final                       ! 18:19 Chave primaria //
        character*2     Dia_final                       ! 20:21 Chave primaria //
        character*4     Nivel_medio1            ! 22:25
        character*2     Nivel_medio2            ! 26:27
        character*4     valor_class1            ! 28:31
        character*2     valor_class2            ! 32:33
        character*21    classificacao   ! 34:54
        character*4     z01                             ! 55:58
        character*2     z02                             ! 59:60
        character*4     nivel_de_reducao1               ! 61:64
        character*2     nivel_de_reducao2               ! 65:66
        character*2     hora                            ! 67:68
        character*2     minuto                  ! 69:70
        character*4     preamar_sizigia1                ! 71:74
        character*2     preamar_sizigia2                ! 75:76
        character*4     preamar_quadratura1     ! 77:80
        character*2     preamar_quadratura2     ! 81:82
        character*4     baixamar_sizigia1               ! 83:86
        character*2     baixamar_sizigia2               ! 87:88
        character*4     baixamar_quadratura1    ! 89:92
        character*2     baixamar_quadratura2    ! 93:94
        character*72    observacoes1    ! 95:166
        character*72    observacoes2    ! 167:238
        character*72    observacoes3    ! 239:310
        character*72    observacoes4    ! 311:382
        character*72    observacoes5    ! 383:454
        character*72    observacoes6    ! 455:526

!c      DIMENSION A3(1),AMPL(1),H2(1),H1(1),G1(1)

!c      Troca realizada em 09/11/89
        real*4  A3(1),AMPL(1),H2(1),H1(1),G1(1)

        data    tabela  /'SEMIDIURNA           ','DESIGUALDADES DIURNAS',&
        &                'MISTA                ','DIURNA               '/

!C------------------------------------------------------------------------
        
        ICHAVE = 0
      HO1=H1(2)
      GO1=G1(2)
      HK1=H1(3)
      GK1=G1(3)
      HN2=H1(5)
      HM2=H1(6)
      GM2=G1(6)
      HS2=H1(7)
      GS2=G1(7)
      IF(KKK.EQ.0)GO TO 5
      HP1=H2(5)
      HK2=H2(14)
      GO TO 8
    5 DO 6 JC=1,KJ
      IF(ABS(A3(JC)-14.9589).LE..001)HP1=AMPL(JC)
      IF(ABS(A3(JC)-30.0821).LE..001)HK2=AMPL(JC)
    6 CONTINUE
!C     CALCULO DO NIVEL DE REDUCAO
    8 WRITE(3,79)S0
   79 FORMAT(6(/),T58,'REDUCAO DE SONDAGEM',///,T33,'NIVEL MEDIO  (S0)',40X&
     &,F8.2,2X,'CM')
      HO1K1=HO1+HK1
      HM2S2=HM2+HS2
      CLM=HO1K1/HM2S2
      IF(CLM.GT..25)GO TO 20
!C--------------------------    Semidiurna
      A=HN2+HM2S2+HK2
      WRITE(3,85)CLM
      INDICE = 1        ! mare SEMIDIURNA
   85 FORMAT(T33,'CLASSIFICACAO DA MARE ',F6.2,29X,'(SEMIDIURNA)')
      GO TO 80
   20 IF(CLM.GT.1.5)GO TO 60
!c-------------------------     Desigualdades Diurnas
!c      Alteracao feita em 21/05/90 pela Maria Helena para o calculo do
!c      Nivel de Reducao em mares de desigualdades diurnas
!c-----------------------------------------------
!c      C=.7*HO1K1                              !
!c      D=(GM2-GO1-GK1)*.00873                  !
!c      A=C*ABS(SIN(D))+HM2S2                   !
!c-----------------------------------------------

        A = hm2 + hs2 + hk1 + ho1 + hp1

        WRITE(3,86)CLM
   86 FORMAT(T33,'CLASSIFICACAO DA MARE ',F6.2,18X,'(DESIGUALDADES DIU&
     &RNAS)')
        INDICE = 2      ! mare DESIGUALDADES DIURNAS

!c      Alteracao do Almte. Franco

        write (3,1010) a        ! Z0
        cnr = s0 - a
        write (3,1020) cnr      ! NIVEL DE REDUCAO
        ichave = 1


      GO TO 80

   60 IF(CLM-3.)70,70,75
!C----------------------------- Mista
   70 A=HO1K1+HM2S2
      WRITE(3,87)CLM
      INDICE = 3        ! mare MISTA
   87 FORMAT(T33,'CLASSIFICACAO DA MARE ',F6.2,34X,'(MISTA)')
      GO TO 80
!c----------------------------  Diurna
   75 A=HO1K1+HP1+HM2S2
      WRITE(3,88)CLM
      INDICE = 4        ! mare DIURNA
   88 FORMAT(T33,'CLASSIFICACAO DA MARE ',F6.2,33X,'(DIURNA)')

!C     ESTABELECIMENTO DO PORTO
   80 D=(GS2-GM2)*.01745
      RH=.9661*HM2/HS2
      AR=SIN(D)/(RH+COS(D))
      DIVID=(ATAN(AR)*57.29578+GM2)/28.9841
      IHWFCH=DIVID
      IHWFCM=(DIVID-IHWFCH)*60.+.5
      CNR=S0-A
!C     NIVEL MEDIO DAS PREAMARES DE SIZIGIA
      CHWS=A+HM2S2
!C     NIVEL MEDIO DAS PREAMARES DE QUADRATURA
      CHWN=A+HM2-HS2
!C     NIVEL MEDIO DAS BAIXAMARES DE SIZIGIA
      CLWS=A-HM2S2
!C     NIVEL MEDIO DAS BAIXAMARES DE QUADRATURA
      CLWN=A-HM2+HS2


        if (ichave .eq. 1) then         ! desigualdades diurnas
                write (3,1030) ihwfch,ihwfcm

                k = (gm2 - gk1 - go1) / 2
                k = k - ifix (k / 360) * 360
                if (k .lt. 0) k = k + 360
                k = k * 0.017453
                c = ABS (COS (k))
                s = ABS (SIN (k))
                coef = .707 * (hk1 + ho1)
                cc = c * coef
                cs = s * coef
                mhhw = a + hm2 + hs2 + cc
                mlhw = a + hm2 + hs2 - cc
                mhlw = a - hm2 - hs2 + cs
                mllw = a - hm2 - hs2 - cs

                write (3,1000) mhhw     ! preamar superior
                write (3,1001) mlhw     ! preamar inferior
                write (3,1002) mhlw     ! baixamar superior
                write (3,1003) mllw     ! baixamar inferior

!c              fazendo com que os valores calculados sejam passados para as
!c              vaiaveis que seram processadas mais abaixo para a gravacao no
!c              arquivo de reducao. se for desigaualdades diurnas.

                chws = mhhw             ! preamar de sizigia
                chwn = mlhw             ! preamar de quadratura
                clws = mhlw             ! baixamar de sizigia
                clwn = mllw             ! baixamar de quadratura

                write (3,1040)
                write (3,1050)



        else

                WRITE (3,90)  A
                WRITE(3,89)CNR,IHWFCH,IHWFCM,CHWS,CHWN,CLWS,CLWN
        end if

   89 FORMAT(T33,'NIVEL DE REDUCAO ',38X,F10.2,'  CM',/,&
     &T33,'ESTABELECIMENTO DO PORTO ',31X,I3,' H ',I3,' MIN',//,&
     &T33,'NIVEL MEDIO DAS PREAMARES DE SIZIGIA  ',17X,F10.2,'  CM',/,&
     &T33,'NIVEL MEDIO DAS PREAMARES DE QUADRATURA ',15X,F10.2,'  CM',/,&
     &T33,'NIVEL MEDIO DAS BAIXAMARES DE SIZIGIA   ',15X,F10.2,'  CM',/,&
     &T33,'NIVEL MEDIO DAS BAIXAMARES DE QUADRATURA ',14X,F10.2,'  CM',//,&
     &T33,'NIVEIS MEDIO E DE REDUCAO REFERIDOS AO ZERO DO MAREGRAFO.',/,&
     &T33,'NIVEIS MEDIOS DE PREAMARES E BAIXAMARES DE SIZIGIA E QUADRATURA REFERIDOS AO NIVEL DE REDUCAO.')
   90 FORMAT (/,T33,'NIVEL DE REDUCAO ABAIXO DO NIVEL MEDIO (Z0)',12X,F10&
     &.2,'  CM')

 1010 format (t33,'NIVEL DE REDUCAO ABAIXO DO NIVEL MEDIO (Z0)',13X,F10.2,' CM')
 1020 format (t33,'NIVEL DE REDUCAO (NR)',35X,F10.2,' CM')
 1030 format (t33,'ESTABELECIMENTO DO PORTO',32X,I3,' H ',I3,' MIN',/)
 1040 format (/,t33,'NIVEIS MEDIO E DE REDUCAO REFERIDOS AO ZERO DO MAREGRAFO.')
 1050 format (T33,'ALTURAS DAS PREAMARES E BAIXAMARES REFERIDAS AO NIVEL DE REDUCAO.')
 1000 format (t33,'ALTURA DA PREAMAR SUPERIOR',30X,F10.2,' CM')
 1001 format (t33,'ALTURA DA PREAMAR INFERIOR',30X,F10.2,' CM')
 1002 format (t33,'ALTURA DA BAIXAMAR SUPERIOR',29X,F10.2,' CM')
 1003 format (t33,'ALTURA DA BAIXAMAR INFERIOR',29X,F10.2,' CM',/)
!c--------------------------------------------------------------------------
!c      Deste ponto em diante o processamento sera dedicado para gravacao
!c      no arquivo de REDUCAO

!C      OS CALCULOS SERAM FEITOS MESMO QUE GRAVA SEJA IGUAL A 'N' 
!C      PARA QUE SE POSSA ENVIAR O NIVEL DE REFERENCIA PARA A SUBROTINA
!C      CADASTRA CONSTANTE

        num_est = chave (01:05)
        ano_inicial = chave (06:09)
        mes_inicial = chave (10:11)
        dia_inicial = chave (12:13)
        ano_final       = chave (14:17)
        mes_final       = chave (18:19)
        dia_final       = chave (20:21)
        classificacao = tabela (indice)
        observacoes1 = ' '
        observacoes2 = ' '
        observacoes3 = ' '
        observacoes4 = ' '
        observacoes5 = ' '
        observacoes6 = ' '

!c      Formatacao do Nivel Medio

!c      encode (7,'(f7.2)', s0_aux) s0
    WRITE (s0_aux,'(f7.2)') s0


!C      call padron (s0_aux (1:4), s0_aux (1:4) )
!C      call padron (s0_aux (6:7), s0_aux (6:7) )
        nivel_medio1    = s0_aux (1:4)
        nivel_medio2    = s0_aux (6:7)

!c      Formatacao da Classificacao da Mare

!C      encode (7,'(f7.2)', clm_aux) clm
    WRITE (clm_aux,'(f7.2)') clm

!C      call padron (clm_aux (1:4), clm_aux (1:4) )
!C      call padron (clm_aux (6:7), clm_aux (6:7) )
        valor_class1    = clm_aux (1:4)
        valor_class2    = clm_aux (6:7)

!c      Formatacao do Nivel de reducao abaixo do nivel medio (Z0)

!c      encode (7,'(f7.2)', a_aux) a
    WRITE (a_aux,'(f7.2)') a

!C      call padron (a_aux (1:4), a_aux (1:4) )
!C      call padron (a_aux (6:7), a_aux (6:7) )
        z01     = a_aux (1:4)
        z02     = a_aux (6:7)


!C      Nivel de reducao para a subrotina cadastra constantes

        nivel_ref = a_aux (1:4) // '.' // a_aux (6:7) // '   '

!c      Formatacao do Nivel de Reducao

!c      encode (7,'(f7.2)', cnr_aux) cnr
    WRITE (cnr_aux,'(f7.2)') cnr

!C      call padron (cnr_aux (1:4), cnr_aux (1:4) )
!C      call padron (cnr_aux (6:7), cnr_aux (6:7) )
        nivel_de_reducao1       = cnr_aux (1:4)
        nivel_de_reducao2       = cnr_aux (6:7)

!c      Formatacao da Hora

!c      encode (2,'(i2)', ihwfch_aux) ihwfch
    WRITE (ihwfch_aux,'(i2)') ihwfch

!C      call padron (ihwfch_aux (1:2), ihwfch_aux (1:2) )
        hora = ihwfch_aux (1:2)

!C      Formatacao do Minuto

!c      encode (2,'(i2)', ihwfcm_aux) ihwfcm
    WRITE (ihwfcm_aux,'(i2)') ihwfcm

!C      call padron (ihwfcm_aux (1:2), ihwfcm_aux (1:2) )
        minuto = ihwfcm_aux (1:2)

!C      Formatacao de Preamar de sizigia

!c      encode (7,'(f7.2)', chws_aux) chws
    WRITE (chws_aux,'(f7.2)') chws

!C      call padron (chws_aux (1:4), chws_aux (1:4) )
!C      call padron (chws_aux (6:7), chws_aux (6:7) )
        preamar_sizigia1        = chws_aux (1:4)
        preamar_sizigia2        = chws_aux (6:7)

!C      Formatacao de Preamar de quadratura

!c      encode (7,'(f7.2)', chwn_aux) chwn
    WRITE (chwn_aux,'(f7.2)') chwn

!C      call padron (chwn_aux (1:4), chwn_aux (1:4) )
!C      call padron (chwn_aux (6:7), chwn_aux (6:7) )
        preamar_quadratura1     = chwn_aux (1:4)
        preamar_quadratura2     = chwn_aux (6:7)

!C      Formatacao de Baixamar de sizigia

!c      encode (7,'(f7.2)', clws_aux) clws
    READ (clws_aux,'(f7.2)') clws

!C      call padron (clws_aux (1:4), clws_aux (1:4) )
!C      call padron (clws_aux (6:7), clws_aux (6:7) )
        baixamar_sizigia1       = clws_aux (1:4)
        baixamar_sizigia2       = clws_aux (6:7)

!C      Formatacao de Baixamar de quadratura

!c      encode (7,'(f7.2)', clwn_aux) clwn
    WRITE (clwn_aux,'(f7.2)') clwn

!C      call padron (clwn_aux (1:4), clwn_aux (1:4) )
!C      call padron (clwn_aux (6:7), clwn_aux (6:7) )
        baixamar_quadratura1 = clwn_aux (1:4)
        baixamar_quadratura2 = clwn_aux (6:7)

        !if (grava .eq. 'S') then       ! SERAM GRAVADOS OS NIVEIS DE REDUCAO

!c              Abertura do arquivo NIVEIS DE REDUCAO e teste se ok.
!c              Este arquivo sera aberto com status igual a old porque foi
!c              criado pelo mar3_32.

        !OPEN(    unit          =       10,&
        !&       file           =       'REDUCOES_DE_SONDAGEM',&
        !&       status         =       'old',&
        !&        organization  =       'INDEXED',&
        !&       access         =       'KEYED',&
        !&        recordtype     =       'FIXED',&
        !&        form           =       'UNFORMATTED',&
        !&        key            =       (1:5:CHARACTER),&
        !&        recl           =       132,&
        !&       iostat         =       STATUS_OP,&
        !&      shared)


                !IF (STATUS_OP .ne. 0) then
                        !WRITE (6,10) STATUS_OP
!10             FORMAT (//,' * * *  ATENCAO  * * *',//,' Erro na abertura do',&
        !&       ' cadastro de REDUCOES DE SONDAGEM',&
        !&       /,' Informe ao analista ',&
        !&       'responsavel os dados abaixo :',/,' ERRO NUMERO : ',&
        !&      i2,/,' NA SUBROTINA CMAR ',///)
                        !STOP
                !endif 


                WRITE (20, 656)num_est, ano_inicial, mes_inicial, dia_inicial,&
        &       ano_final, mes_final, dia_final, nivel_medio1,&
        &       nivel_medio2, valor_class1, valor_class2,&
        &       classificacao, z01, z02, nivel_de_reducao1,&
        &       nivel_de_reducao2, hora, minuto,&
        &       preamar_SIZIGIA1, preamar_SIZIGIA2,&
        &       preamar_quadratura1, preamar_quadratura2,&
        &       baixamar_SIZIGIA1, baixamar_SIZIGIA2,&
        &       baixamar_quadratura1, baixamar_quadratura2
        !&      observacoes1, observacoes2, observacoes3,&
        !&      observacoes4, observacoes5, observacoes6
                
        656 FORMAT(a,a,a,a,a,a,a,a,'.',a,a,'.',a,a,a,'.',a,a,'.',a,a,a,a,'.',a,a,'.',a,a,'.',a,a,'.',a)


                !IF (STATUS_WR .ne. 0) then
                        !WRITE (6,15) STATUS_WR
!15             FORMAT (//,' * * *  ATENCAO  * * *',//,' Erro na GRAVACAO no',&
        !&       ' cadastro de REDUCOES DE SONDAGEM',&
        !&       /,' Informe ao analista ',&
        !&       'responsavel os dados abaixo :',/,' ERRO NUMERO : ',&
        !&      i2,/,' NA SUBROTINA CMAR ',///)
                        !STOP
                !endif 

                !CLOSE (UNIT = 10)

        !end if

    RETURN
END


SUBROUTINE ARRAY(MODE,I,J,N,M,S,D)

!C     SUBROTINA PERTENCENTE AO PROGRAMA MAR138M3, SEGUNDA VERSAO.
!C     SUBROTINA ARRAY - ARRANJO DOS ELEMENTOS DE MATRIZ

!c      DIMENSION S(1),D(1)

!c      Troca realizada em 09/11/89
        real*4  S(1),D(1)

      NI=N-I
      IF(MODE-1) 100,100,120
  100 IJ=I*J+1
      NM=N*J+1
      DO 110 K=1,J
      NM=NM-NI
      DO 110 L=1,I
      IJ=IJ-1
      NM=NM-1
  110 D(NM)=S(IJ)
      GO TO 140
  120 IJ=0
      NM=0
      DO 130 K=1,J
      DO 125 L=1,I
      IJ=IJ+1
      NM=NM+1
  125 S(IJ)=D(NM)
  130 NM=NM+NI
  140 RETURN
END


SUBROUTINE TERP(X,MM,N,W)

!C SUBROTINA TERP - INTERPOLACAO P/ DETERMINACAO DE MAXIMO OU MINIMO

!c      DIMENSION X(1),W(80),Z(40)
                                 
!c      Alteracao em 09/11/89
      real*4    X(1),W(80),Z(40)
                             
      W(1)=X(MM-3)
      W(2)=X(MM-2)
      W(3)=X(MM-1)
      W(4)=X(MM)
      W(5)=X(MM+1)
      W(6)=X(MM+2)
      W(7)=X(MM+3)
      LL=1
      KK=4
      DO 3 I=1,N
      A=W(2)
      DO 1 J=1,KK
    1 Z(J)=-.0625*(W(J)+W(J+3))+.5625*(W(J+1)+W(J+2))
      M1=KK+1
      DO 2 K=1,KK
      M1=M1-1
      M=M1+2
      L1=M1+M1
      L=L1+1
      W(L)=W(M)
    2 W(L1)=Z(M1)
      W(1)=A
      LL=LL+LL
      KK=KK+LL
    3 CONTINUE
      RETURN
END


SUBROUTINE      ANDIA (D,M,A)

!C
!C         * * *  ROTINA DE DETERMINACAO DA DATA SEGUINTE A UMA DA- * * *
!C         * * *  TA FORNECIDA                                      * * *
!C
      INTEGER*4  D,M,A,R,F(12)
      DATA F/31,28,31,30,31,30,31,31,30,31,30,31/

      R=MOD(A,4)
      IF (R.EQ.0) then
        F(2) = 29
      else
        F(2) = 28
      end if
      D=D+1
      IF (D.LE.F(M)) RETURN
      D=1
      M=M+1
      IF (M.LE.12) RETURN
      M=1
      A=A+1
      RETURN
END


SUBROUTINE MINV(A,N,D,L,M)

!C     SUBROTINA PERTENCENTE AO PROGRAMA MAR138M3, SEGUNDA VERSAO.
!C     SUBROTINA MINV - INVERSAO DE MATRIZ

!c      DIMENSION A(1),L(1),M(1)

!c      Troca realizada em 09/11/89
        real*4  A(1)

        integer*4       l(1),m(1)

      D=1.
      NK=-N
      DO 80 K=1,N
      NK=NK+N
      L(K)=K
      M(K)=K
      KK=NK+K
      BIGA=A(KK)
      DO 20 J=K,N
      IZ=N*(J-1)
      DO 20 I=K,N
      IJ=IZ+I
   10 IF(ABS(BIGA)-ABS(A(IJ))) 15,20,20
   15 BIGA=A(IJ)
      L(K)=I
      M(K)=J
   20 CONTINUE
      J=L(K)
      IF(J-K) 35,35,25
   25 KI=K-N
      DO 30 I=1,N
      KI=KI+N
      HOLD=-A(KI)
      JI=KI-K+J
      A(KI)=A(JI)
   30 A(JI)=HOLD
   35 I=M(K)
      IF(I-K) 45,45,38
   38 JP=N*(I-1)
      DO 40 J=1,N
      JK=NK+J
      JI=JP+J
      HOLD=-A(JK)
      A(JK)=A(JI)
   40 A(JI)=HOLD
   45 IF(BIGA) 48,46,48
   46 D=0.
      RETURN
   48 DO 55 I=1,N
      IF(I-K) 50,55,50
   50 IK=NK+I
      A(IK)=A(IK)/(-BIGA)
   55 CONTINUE
      DO 65 I=1,N
      IK=NK+I
      HOLD=A(IK)
      IJ=I-N
      DO 65 J=1,N
      IJ=IJ+N
      IF(I-K) 60,65,60
   60 IF(J-K) 62,65,62
   62 KJ=IJ-I+K
      A(IJ)=HOLD*A(KJ)+A(IJ)
   65 CONTINUE
      KJ=K-N
      DO 75 J=1,N
      KJ=KJ+N
      IF(J-K) 70,75,70
   70 A(KJ)=A(KJ)/BIGA
   75 CONTINUE
      D=D*BIGA
      A(KK)=1./BIGA
   80 CONTINUE
      K=N
  100 K=K-1
      IF(K) 150,150,105
  105 I=L(K)
      IF(I-K) 120,120,108
  108 JQ=N*(K-1)
      JR=N*(I-1)
      DO 110 J=1,N
      JK=JQ+J
      HOLD=A(JK)
      JI=JR+J
      A(JK)=-A(JI)
  110 A(JI)=HOLD
  120 J=M(K)
      IF(J-K) 100,100,125
  125 KI=K-N
      DO 130 I=1,N
      KI=KI+N
      HOLD=A(KI)
      JI=KI-K+J
      A(KI)=-A(JI)
  130 A(JI)=HOLD
      GO TO 100
  150 RETURN
END


SUBROUTINE      PREPIMPRE (CPP)

                COMMON / IMPRE / IMPRE


                INTEGER*2       CPP,IMPRE
                CHARACTER*1     A

                
                IF      (CPP.EQ.11) THEN
                                A = '1'
                ELSE IF (CPP.EQ.12) THEN
                                A = '2'
                ELSE IF (CPP.EQ.20) THEN
                                A = '5'
                ELSE
                                A = '0'
                END IF

                WRITE(IMPRE,*) CHAR(27) // 'R' // CHAR(0)
                WRITE(IMPRE,*) CHAR(30) // A

                RETURN
END


Subroutine cadastra_constante (chave, nivel_de_referencia)

!c      Objetivo:       Cadastrar o periodo de constante processado que se
!c                      encontra no arquivo trabalho_do_mar3-18.dat, O pe-
!c                      riodo ja foi verificado na subrotina crtitica_const.
!c                      Apos o cadastramento o arquivo sera deletado.
!c                      A subrotina chamara a subrotina INCLUI_PERIODO para
!c                      o cadastramento do periodo.

        character*21    chave   ! Contem o numero da estacao e os periodos
!c                                inicial e final para cadastramento.
        character*10    nivel_de_referencia
        integer*2       nr_de_const

        integer*2       ind
        integer*2       status_op, status_wr, status_op2, status_le

!c      Vriaveis do arquivo de trabalho

        CHARACTER*7     NOME
        CHARACTER*11    VELOC
        CHARACTER*8     H1
        CHARACTER*8     G1


!c      Definicao do registro das CONSTANTES

        character*5     Num_est          ! 01:05 Chave primaria //
        character*4     Ano_inicial      ! 06:07 Chave primaria //
        character*2     Mes_inicial      ! 08:09 Chave primaria //
        character*2     Dia_inicial      ! 10:11 Chave primaria //
        character*4     Ano_final        ! 12:13 Chave primaria //
        character*2     Mes_final        ! 14:15 Chave primaria //
        character*2     Dia_final        ! 16:17 Chave primaria //
        character*10    Nivel_ref        ! 18:27
        character*1     Padrao           ! 28:28
        integer*2       Num_de_comp      ! 29:30
        character*7     Nome_da_comp(172)! 31:37 (MAX   31:1234)
        character*8     H           (172)! 38:45 (MAX 1235:2610)
        character*8     G           (172)! 46:53 (MAX 2611:3986)

        
!c      Abertura do cadastro de constante e teste se ok. 

        !OPEN(    unit          =       1,&
        !&       file           =       'CADASTRO_DE_CONSTANTES',&
        !&       status         =       'old',&
        !&        organization  =       'INDEXED',&
        !&       access         =       'KEYED',&
        !&        recordtype     =       'VARIABLE',&
        !&        form           =       'UNFORMATTED',&
        !&        key            =       (1:21:CHARACTER),
        !&        recl           =       998,&
        !&       iostat         =       STATUS_OP,&
        !&      shared)


        !IF (STATUS_OP .ne. 0) then
          !WRITE (6,10) STATUS_OP
!10       FORMAT (//,' * * *  ATENCAO  * * *',//,' Erro na abertura do',&
        !&       ' cadastro de CONSTANTES',&
        !&       /,' Informe ao analista ',&
        !&       'responsavel os dados abaixo :',/,' ERRO NUMERO : ',&
        !&      i2,/,' NA SUBROTINA CADASTRA CONSTANTES',///)
          !STOP
        !endif 


!C      Abertura do arquivo de trabalho para leitura das constantes harmonicas

        open    (unit = 15, file = 'C:\constantes_geradas.rtf', status = 'old', iostat = status_op2)

        !IF (STATUS_OP2 .ne. 0) then
          !WRITE (6,30) STATUS_OP2
!30       !FORMAT (//,' * * *  ATENCAO  * * *',//,' Erro na abertura do',&
        !&       ' ARQUIVO DE TRABALHO_DO_MAR3_18.DAT',&
        !&       /,' Informe ao analista ',&
        !&       'responsavel os dados abaixo :',/,' ERRO NUMERO : ',&
        !&      i2,/,' NA SUBROTINA CADASTRA CONSTANTES',///)
         !STOP
        !endif 

        READ (15, 40, iostat = status_le) NOME, VELOC, H1, G1
40      format (a,a,a,a)

        IF (STATUS_le .ne. 0) then
          WRITE (6,50) STATUS_le
50        FORMAT (//,' * * *  ATENCAO  * * *',//,' Erro na 1 leitura do',&
        &       ' ARQUIVO DE TRABALHO_DO_MAR3_18.DAT',&
        &       /,' Informe ao analista ',&
        &       'responsavel os dados abaixo :',/,' ERRO NUMERO : ',&
        &       i2,/,' NA SUBROTINA CADASTRA CONSTANTES',///)
          !STOP
        endif 
        nr_de_const = 0 

!c
        DO WHILE (status_le .eq. 0)



!c      retirado o alinhamento pois o padron estava duplicando os valores onde
!c      deveria colocar zeros a esquerda. as variaveis character estao
!c      alinhadas pela direita.

!c         call padron (h, h)
!c         call padron (g, g)

           nr_de_const = nr_de_const + 1
           nome_da_comp (nr_de_const) = nome
           h        (nr_de_const) = h1
           g        (nr_de_const) = g1
           READ (15, 40, iostat = status_le ) NOME, VELOC, H1, G1
        END DO


        close (unit = 15, status = 'delete')

        num_est = chave (01:05)
        ano_inicial     = chave (06:09)
        mes_inicial = chave (10:11)
        dia_inicial = chave (12:13)
        ano_final       = chave (14:17)
        mes_final       = chave (18:19)
        dia_final       = chave (20:21)

        padrao  = 'N'
        !call padron (nivel_de_referencia, nivel_de_referencia)
        nivel_ref       = nivel_de_referencia
        num_de_comp = nr_de_const

        !WRITE (1, iostat = STATUS_WR)& 
        !&   REG.NUM_EST, REG.ANO_INICIAL, REG.MES_INICIAL, REG.DIA_INICIAL,&
        !&      REG.ANO_FINAL, REG.MES_FINAL, REG.DIA_FINAL, REG.NIVEL_REF,&
        !&      REG.PADRAO, REG.NUM_DE_COMP, (REG.NOME_DA_COMP (IND),& 
        !&      REG.H (IND), REG.G (IND), IND = 1, REG.NUM_DE_COMP)

        !IF (STATUS_WR .NE. 0) THEN
          !WRITE (6,20) STATUS_WR
!20       FORMAT (//,' * * *  ATENCAO  * * *',//,' Erro de GRAVACAO NO',&
        !&       ' CADASTRO DE CONSTANTES',&
        !&       /,' Informe ao analista ',&
        !&       'responsavel os dados abaixo :',/,' ERRO NUMERO : ',&
        !&      i2,/,' NA SUBROTINA CADASTRA CONSTANTES',///)
          !STOP
        !END IF

        CLOSE (UNIT = 1)

!C      Cadastramento do periodo

        !call inclui_periodo (chave, nr_de_const)

        RETURN
END


!SUBROUTINE     padron (number)

!c      objetivo:       Alinha um string 'a direita,colocando zeros 'a esquerda.
!c      variaveis:
!c        de entrada:   NUMBER
!c        de saida  :   NUMBER
!c      modulos
!c      referenciados:  STR$, DHN$

        !character*(*)  NUMBER
        !integer*2      TAM
        !integer*4      COMP
        !character*9    ZEROS /'000000000'/

        !(CHECK)CALL dhn$_deblank (NUMBER, NUMBER, COMP)
        !(CHECK)CALL str$trim (NUMBER, NUMBER, TAM)
        !NUMBER = ZEROS (1 : len (NUMBER) - TAM) // NUMBER      

        !RETURN
!END


SUBROUTINE      NIMED (arq_alt,filtro,listagem,deleta,grava,arq_cotas,dia_anter,dia_poster,arq_impre)

  !DEC$ ATTRIBUTES DLLEXPORT::NIMED

!C     IMPRESSAO DAS ALTURAS HORARIAS E FILTRAGEM DAS
!C     MESMAS PARA A OBTENCAO DO NIVEL MEDIO DIARIO - NIMEDIO

!C     N1=24 PARA S24*S24*S25 E N1=25 PARA S24*S25*S25;FMT E O FORMATO
!C     EM QUE SERAO LIDAS AS ALTURAS HORARIAS,IDI=NUMERO DO DIA INICIAL
!C     E IAN=ANO CORRESPONDENTE.NL E IMES SAO O NUMERO DE MESES E O NUME-
!C     RO DO MES NO ANO EM QUESTAO.
!C     LL=0 SE AS ALTURAS HORARIAS FOREM OBSERVADAS NAS HORAS CERTAS E
!C     LL=1 SE ESSAS ALTURAS FOREM OBSERVADAS NAS MEIAS HORAS.
!C     HI = hora inicial das observacoes, normalmente 0 horas.

!C------------------------------------------------------------------------------

!C      DIMENSION IX(17664),Y(49),Z(25),FMT(8)
!C      DIMENSION IXNM(800)
!C      DIMENSION AX(17664)

        INTEGER*4       NUMEROS
        INTEGER*4       IX(17664)
        INTEGER*4       IXNM(800)
        REAL*4          AX(17664),Y(49),Z(25),FMT(8)

!C----------------------------------------------------------------------------

        character*10    data1,data2
        integer*2       fim
        character*150 arq_alt
        character*150 arq_cotas
        character*150 arq_impre
        character*96 dia_anter
        character*96 dia_poster
        character*2     filtro
        character*1     listagem
        character*1     deleta
        integer*2       n1
        integer*4       dd,mm,aa
        character*2     dia1,mes1
        character*4     ano1
        REAL*4          vetor (12)
        integer*2       dia_inicial,mes_inicial,ano_inicial
        integer*2       dia_final,mes_final,ano_final

        integer*2       dia_anterior,mes_anterior,ano_anterior
        character*2     dia_ant,mes_ant
        character*4     ano_ant
        character*13    chave
        integer         dia_posterior,mes_posterior,ano_posterior
        character*2     dia_pos,mes_pos
        character*4     ano_pos
        character*132   aster
        character*123   aster1
        character*10    data_imp
        integer*2       pagina
        integer*2       impre
        logical*1       houve_registro
        character*1     grava
        character*4 saida

!c      Variaveis lidas no registro MESTRE (1 registro do arq. de alturas)

        character*5     estacao
        character*2     dia_ini
        character*2     mes_ini
        character*4     ano_ini
        character*2     dia_fim
        character*2     mes_fim
        character*4     ano_fim
        character*38    nome_da_estacao
        character*2     grau_lat
        character*2     min_lat
        character*1     dec_lat
        character*1     sentido_lat
        character*3     grau_lon
        character*2     min_lon
        character*1     dec_lon
        character*1     sentido_lon
        character*4     fuso


!c      Registro lido do CADASTRO DE ALTURAS HORARIAS

        !Structure /estrut/

        !character*5    estacao_alt
        !character*4    ano_alt
        !character*2    mes_alt
        !character*2    dia_alt
        !character*4    alt (24)

        !End structure
        !Record /estrut/ reg1

!c----------------------------------------------------------------------------

        common /teste/ houve_registro
        COMMON /DATA/ DATA_IMP,aster,aster1
        COMMON /IMPRE / IMPRE
        COMMON  /BLOCO1/ ESTACAO,DIA_INI,MES_INI,ANO_INI,DIA_FIM,MES_FIM,&
        &       ANO_FIM,NOME_DA_ESTACAO,GRAU_LAT,MIN_LAT,DEC_LAT,SENTIDO_LAT,&
        &       GRAU_LON,MIN_LON,DEC_LON,SENTIDO_LON

        Common  /pagina/ pagina

!C---------------------------------------------------------------------------

!c      Verifica se deseja gravar as cotas diarias em um arquivo

        if (grava .eq. 'S') then
                        open (unit = 17, file = arq_cotas, status = 'new', iostat = ierro)
                        
                        !if (ierro .ne. 0) then
                                !type *,' Erro na abertura do arquivo arq_cotas'
                                !type *, 'Na subrotina NIMED'
                                !type *,' Erro numero - ',ierro
                                !stop
                        !end if
        end if

!C---------------------------------------------------------------------------



        impre = 3
        pagina = 0

!C      call prepimpre (11)

    
        open (unit = impre, file = arq_impre, status = 'new', iostat = ierro)


!c--------------------------------------------

!C      Abertura do arquivo de alturas para o processamento do nivel medio.

        open (unit = 11, file = arq_alt, status = 'old', iostat = ierro)

        !if (ierro .ne. 0) then
          !type *, ' Arquivo de alturas nao encontrado '
          !type *, ' na subrotina filtragem. '
          !type *, ' Chame o ANALISTA RESPONSAVEL. '
          !stop
        !end if

!c--------------------------------------------

!c      Leitura do primeiro registro do arquivo de alturas (MESTRE)

        read (11, 902) estacao, dia_ini, mes_ini, ano_ini, dia_fim, mes_fim,&
        &               ano_fim, nome_da_estacao, grau_lat, min_lat, dec_lat,&
        &               sentido_lat, grau_lon, min_lon, dec_lon, sentido_lon,&
        &               fuso

 902    format (a5,a2,a2,a4,a2,a2,a4,a38,a2,a2,a1,a1,a3,a2,a1,a1,a4)

!c      decode (2,'(i2)', dia_ini) dia_inicial
    READ (dia_ini,'(i2)') dia_inicial
!c      decode (2,'(i2)', mes_ini) mes_inicial
    READ (mes_ini,'(i2)') mes_inicial
!c      decode (4,'(i4)', ano_ini) ano_inicial
    READ (ano_ini,'(i4)') ano_inicial

!c      ano_inicial = ano_inicial + 1900
        
!c      decode (2,'(i2)', dia_fim ) dia_final
    READ (dia_fim,'(i2)') dia_final
!c      decode (2,'(i2)', mes_fim ) mes_final
    READ (mes_fim,'(i2)') mes_final
!c  decode (4,'(i4)', ano_fim ) ano_final
    READ (ano_fim,'(i4)') ano_final

!c      ano_final = ano_final + 1900


        !dia_anterior = dia_inicial
        !mes_anterior = mes_inicial
        !ano_anterior = ano_inicial

        !call tira_dia (dia_anterior,mes_anterior,ano_anterior)


        !encode (2,'(i2)', dia_ant) dia_anterior
        !encode (2,'(i2)', mes_ant) mes_anterior
        !encode (4,'(i4)', ano_ant) ano_anterior

        !if (dia_anterior .lt. 10) then
                !dia_ant (1:1) = '0'
        !end if

        !if (mes_anterior .lt. 10) then
                !mes_ant (1:1) = '0'
        !end if

        !chave = estacao // ano_ant // mes_ant // dia_ant

!c      Abertura do arquivo de ALTURAS HORARIAS para leituras dos
!c      dias anterior e posterior do arquivo selecionado.


        !Open   (unit           = 1,
        !1      file            = 'cadastro_de_alturas',
        !1      status          = 'old',
        !1      organization    = 'indexed',
        !1      access          = 'keyed',
        !1      recordtype      = 'fixed',
        !1      form            = 'unformatted',
        !1      key             = (1:13:character,1:5:character),
        !1      recl            = 28,
        !1      iostat          = ierro_op,
        !1      shared,
        !1      readonly)

        !if (ierro_op .ne. 0) then
          !type *, ' Erro na abertura do cadastro de alturas '
          !type *, ' para leituras dos dias anterior e posterior '
          !type *, ' Chame o analista responsavel '
          !close (unit = 11)
          !stop
        !end if


!c      Leitura do dia ANTERIOR a partir da data inicial lida no registro mestre
!c      do arquivo selecionado (unit=11)

        !read (unit = 1, keyeq = chave, keyid= 0, iostat= ierro_le) reg1


        !if (ierro_le .ne. 0) then              ! Nao encontrando registro com
                !dia_ant        = dia_ini       ! a data anterior a proxima 
                !mes_ant        = mes_ini       ! chave sera com a data inicial
                !ano_ant        = ano_ini
                !chave = estacao // ano_ant  // mes_ant // dia_ant
!c              Leitura com a propria data inicial fornecida pelo mestre
                !read (unit = 1, keyeq = chave,keyid = 0,iostat =ierro_le_2) reg1
                !if (ierro_le_2 .ne. 0) then
                        !type *,' Nao foi encontrado registro de alturas com '
                        !type *,' a data inicial fornecida pelo registro mestre '
                        !type *,' Erro numero - ',ierro_le_2
                        !type *,' Chame o analista responsavel '
                        !close (unit = 11)
                        !close (unit = 1)
                        !stop
                !end if
        !end if

!c      Colocar as alturas lidas nas primeiras 24 posicoes do vetor IX
    
        index = 1
        do idx1 = 1,24
      do idx2 = 1,4 
            saida (idx2:idx2)= dia_anter(index:index)
                index= index+1
          end do
!c        decode (4, '(i4)', saida) ix(idx1)
      READ (saida,'(i4)') ix(idx1)
        end do

!c      Leituras das alturas no arquivo selecionado anteriormente.
!c      As alturas selecionadas seram colocadas no vetor IX (25) em diante

        ii = 0
        if = 0
        j2 = 0
        fim = 0
        do while (fim.eq.0)
                ii = 25 + j2 * 24
                if = ii + 23
                j2 = j2 + 1
                read (11,1016,iostat=fim) (ix(j),j=ii,if)
        end do


 1016   FORMAT (24I4)
!c----------------------------------------------------------------------

!c      Inicializar os indices para as 24 ultimas alturas (posteriores)


        k = j
        m = j + 23

!c      Leitura do dia POSTERIOR

        !decode (2,'(i2)', dia_fim)     dia_posterior
        !decode (2,'(i2)', mes_fim)     mes_posterior
        !decode (4,'(i4)', ano_fim)     ano_posterior

!c      ano_posterior = ano_posterior + 1900


        !call andia (dia_posterior,mes_posterior,ano_posterior)

        !encode (2,'(i2)', dia_pos ) dia_posterior
        !encode (2,'(i2)', mes_pos ) mes_posterior
        !encode (4,'(i4)', ano_pos ) ano_posterior

        !if (dia_posterior .lt. 10) dia_pos (1:1) = '0'
        !if (mes_posterior .lt. 10) mes_pos (1:1) = '0'

        !chave = estacao // ano_pos // mes_pos // dia_pos


        !read (unit = 1, keyeq = chave,keyid = 0,iostat =ierro_le_3) reg1

        !if (ierro_le_3 .ne. 0 ) then
                !dia_pos        = dia_fim
                !mes_pos        = mes_fim
                !ano_pos        = ano_fim
                !chave = estacao // ano_pos  // mes_pos // dia_pos
                !read (unit = 1, keyeq = chave,keyid = 0,iostat =ierro_le_4) reg1
                !if (ierro_le_4 .ne. 0) then
                        !type *,' Nao foi encontrado registro de alturas com '
                        !type *,' a data final fornecida pelo registro mestre '
                        !type *,' Chame o analista responsavel '
                        !close (unit = 11)
                        !close (unit = 1)
                        !stop
                !end if
        !end if


!c      Colocar as ultimas 24 alturas do dia posterior ao periodo no vetor IX

        
        index = 1
        do idx1 = k,m
      do idx2 = 1,4 
            saida (idx2:idx2)= dia_poster(index:index)
                index= index+1
          end do
!c        decode (4, '(i4)', saida) ix(idx1)
          READ (saida,'(i4)') ix(idx1)
        end do
        
                
        !ind = 1
        !do j = k,m
                !decode (4, '(i4)', reg1.alt (ind) ) ix (j)
                !ind = ind + 1
        !end do


!c      Fechar o arquivo de alturas Horarias

        !close (unit = 1)



!c      Inicializar variaveis

        data1 = dia_ini // '/' // mes_ini // '/' // ano_ini
        data2 = dia_fim // '/' // mes_fim // '/' // ano_fim


        idi = dia_inicial
        imes = mes_inicial
        if (ano_inicial .eq. ano_final) then
                nl = (mes_final - mes_inicial) + 1
        else
                        nl = (12 - mes_inicial) + mes_final + 1
        end if


        hi = 0.0
        ll = 0
        ian = ano_inicial
!c      decode (2,'(i2)', filtro ) n1
    READ (filtro,'(i2)') n1

!c      Indicar que ha registro de impresao

        houve_registro = .true.

!c----------------------------------------------------------------------


      D1=N1*600
      JD=365
      ID=MOD(IAN,4)
      IB=MOD(IAN,100)
      IA=MOD(IAN,400)
      IF((IB.NE.0.AND.ID.EQ.0).OR.IA.EQ.0)JD=366


  222 N=J-1
      JN=N+24

        if (ll .ne. 0) then
                do jj = 1,jn
                        a = ix (22 + jj)
                        b = ix (23 + jj)
                        c = ix (24 + jj)
                        d = ix (25 + jj)
                        ix (jj) = -.0625 * (a+b) + .5625 * (b+c)
                end do
        end if
        if (listagem .eq. 'S') then
                CALL ALTHOR(IX,IMES,JD,NL)
        end if
        call cabecalho_32 (estacao,nome_da_estacao,grau_lat,min_lat,dec_lat,&
        &       sentido_lat,grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,&
        &       mes_ini,ano_ini,dia_fim,mes_fim,ano_fim)

      HIF=HI
      HI=N1/2.-1.+HI
      IF (HI.LT.24.) GO TO 20
      HI=HI-24.
      IDI=IDI+1
      IF(IDI.LE.JD)GO TO 20
      IDI=IDI-JD
      IAN=IAN+1
      IA=MOD(IAN,400)
      IB=MOD(IAN,100)
      ID=MOD(IAN,4)
      JD=365
      IF((IB.NE.0.AND.ID.EQ.0).OR.IA.EQ.0)JD=366
   20 WRITE(impre,80) filtro
      S0=0.
      DO 15 I=24,JN
   15 S0=S0+IX(I)
      S0=S0/N
      WRITE(impre,88)
      IV=1
      LL=1
      MM=24
      GO TO 2
    1 IV=IV+1
      MM=LL-1
      LL=LL-24
    2 A=0.
      DO 3 I=LL,MM
    3 A=A+IX(I)
      Y(1)=A
      DO 4 I=2,49
      J=I-1
      MM=MM+1
      Y(I)=Y(J)-IX(LL)+IX(MM)
    4 LL=LL+1
      A=0.
      DO 5 I=1,N1
    5 A=A+Y(I)
      Z(1)=A
      DO 6 I=2,25
      J=I-1
      K=I+N1-1
    6 Z(I)=Z(J)-Y(J)+Y(K)
      A=0.
      DO 7 I=1,25
    7 A=A+Z(I)
      IXNM(IV)=A/D1+.5
      IF(MM-N) 1,8,8
    8 IDI=IDI-12

!c      calculo da media das cotas      
        amedia = 0.0
        do ll = 1, iv
                amedia = amedia + ixnm (ll)
        end do
        amedia = amedia / iv

!c__________________________________________
!c      Gravacao da cotas diarias no arquivo de cotas

        if (grava .eq. 'S') then

                write (17,17) estacao, dia_ini, mes_ini, ano_ini, dia_fim,&
        &                     mes_fim, ano_fim, nome_da_estacao, grau_lat,&
        &                     min_lat, dec_lat, sentido_lat, grau_lon, min_lon,&
        &                     dec_lon, sentido_lon, fuso, amedia

17      format (1x,17a,f7.2)

                do i = 1, iv, 16
                        j = i + 15
                        if (j .gt. iv) j = iv
                        write (17,18) (ixnm (k), k =i,j)
                end do
18      format (16i5)
        end if
                        
!c__________________________________________

        dd = dia_inicial
        mm = mes_inicial
        aa = ano_inicial

        do i = 1,iv,12
          idi = idi + 12
          j = i + 11
          if (j .gt. iv) j = iv
          if (idi .gt. jd) then
                idi = idi - jd
                jd = 365
                ian = ian + 1
                ia = MOD (ian,400)
                ib = MOD (ian,100)
                id = MOD (ian,4)
                if ((ib .ne. 0 .and. id .eq. 0) .or. ia .eq. 0) jd = 366
          end if
!c        ENCODE (2,'(I2)', Dia1 ) dd
      WRITE (Dia1,'(i2)') dd

!c        ENCODE (2,'(I2)', Mes1 ) mm
      WRITE (Mes1,'(i2)') mm

!c        ENCODE (4,'(I4)', Ano1 ) aa
      WRITE (Ano1,'(i4)') aa

          if (dd .lt. 10) dia1 (1:1) = '0'
          if (mm .lt. 10) mes1 (1:1) = '0'
          write (impre,100) dia1,mes1,ano1,(ixnm (k), k =i,j)
          do ind = 1,12
                call andia (dd,mm,aa)
          end do
        end do

      WRITE(impre,110) dia_ini,mes_ini,ano_ini,dia_fim,mes_fim,ano_fim,amedia
      DO 40 I=1,N
   40 AX(I)=IX(I+21)

!C      A VARIAVEL VETOR CONTEM AS MEDIAS DAS COTAS MENSAIS

      CALL MEDMEN(IXNM,IAN,IMES,NL,dia_inicial,dia_final,mes_final,vetor)
        call cabecalho_32 (estacao,nome_da_estacao,grau_lat,min_lat,dec_lat,&
        &       sentido_lat,grau_lon,min_lon,dec_lon,sentido_lon,dia_ini,&
        &       mes_ini,ano_ini,dia_fim,mes_fim,ano_fim)

      CALL MAXMIN(AX,dia_inicial,IMES,ano_inicial,NL,HIF,S0,dia_final,mes_final,vetor)

        !if (deleta .eq. 'S') then
                !close (unit = 11, dispose = 'delete')
        !else
                !close (unit=11)
        !end if

!c      Fechamento do arquivo de cotas

        !if (grava .eq. 'S') then
                !close (unit = 17)
        !else
                !close (unit = 17, dispose = 'delete')
        !end if
    
   70 FORMAT(9A5/2A5,1X,2A5,I4,3I5,F5.2)
   80 FORMAT(////39X,'COTAS DIARIAS DO NIVEL MEDIO ACIMA DO ZERO DO MARE&
     &GRAFO'/52X,'TIPO DO FILTRO PROCESSADO - ',a/41X,'NOTA: AS DATAS CORRESPONDEM A PRI&
     &MEIRA COTA DA LINHA'/56X'COTAS EM CENTIMETROS')
   88 FORMAT(//30X,'DD/MM/AA',31X,'COTAS',/)
   90 FORMAT(I2,1X,I2,1X,8A5)
  100 format (30x,a,'/',a,'/',a,2x,12i5)
  110 FORMAT(////35X,'MEDIA DAS COTAS NO PERIODO DE ',A,'/',A,'/',A,' A ',A,'/',A,'/',A,' = ',F6.2)

    close (unit = 11)
        close (unit = impre)
        close (unit = 17)


  RETURN
END

SUBROUTINE      CABECALHO_32 (numero_da_estacao,nome_da_estacao,grau_lat,&
        &       min_lat,dec_lat,sentido_lat,grau_lon,min_lon,dec_lon,&
        &       sentido_lon,d1,m1,a1,d2,m2,a2)

        CHARACTER*10    DATA_IMP
        INTEGER*2       PAGINA,IMPRE


!C      Variaveis de passagem para a subrotina

        Character*5   Numero_da_Estacao  
        Character*38  Nome_da_Estacao    
        Character*2   Grau_Lat           
        Character*2   Min_Lat            
        Character*1   Dec_Lat            
        Character*1   Sentido_Lat        
        Character*3   Grau_Lon           
        Character*2   Min_Lon            
        Character*1   Dec_Lon            
        Character*1   Sentido_Lon        
        CHARACTER*2     D1,M1,D2,M2
        character*4     a1,a2

        character*131   aster
        character*122   aster1

        COMMON /IMPRE/ IMPRE
        COMMON /DATA/ DATA_IMP,aster,aster1
        COMMON /PAGINA/ PAGINA

!c-------------------------------------------------------------------------------
        
        CALL SALTAFOLHA
        PAGINA = PAGINA + 1
                
        WRITE (IMPRE,10) PAGINA
        WRITE (IMPRE,20) DATA_IMP
        WRITE (IMPRE,30)
        WRITE (IMPRE,40)  nome_da_estacao,D1,M1,A1,D2,M2,A2
        WRITE (IMPRE,50)  numero_da_estacao,grau_lat, min_lat, dec_lat,& 
        &       sentido_lat,grau_lon, min_lon, dec_lon, sentido_lon




 10     FORMAT  (1x,'SISTEMA - MARES',T57,'MARINHA DO BRASIL',&
        &       T116,'PAGINA - ',I8)

 20     FORMAT (1x,'PROGRAMA - MAR3_21',T48,&
        &       'DIRETORIA DE HIDROGRAFIA E NAVEGACAO',T116,'DATA - ',A)

 30     FORMAT (56X,'BANCO NACIONAL DE DADOS OCEANOGRAFICOS',/)

 40     FORMAT (11X,'NOME - ',A,T79,'PERIODO DE OBSERVACOES - 'A,'/',A,'/',A,' A ',A,'/',A,'/',A)

 50     FORMAT (11X,'NUMERO DA ESTACAO - ',A,T79,'LATITUDE - ',&
        &       A,' ',A,' ',A,' ',A,T101,'LONGITUDE - ',A,' ',A,' ',A,' ',A,/)


        RETURN
        END


SUBROUTINE      MAXMIN (AX,dia_inicial,IMES,IAN,NL,HIF,S0,dia_final,mes_final,vetor)

!c      A variavel (VETOR) retorna da subroutina MEDMEN as medias mensais
!c      calculadas para cada mes no periodo processado

        integer*2       dia_inicial,dia_final,mes_final
        integer*2       ian
        integer*2       indice
        integer*2       nr_dias
        REAL*4          vetor (12)
        character*10    data_imp
        character*131   aster
        character*122   aster1

        character*5     estacao
        character*2     dia_ini
        character*2     mes_ini
        character*4     ano_ini
        character*2     dia_fim
        character*2     mes_fim
        character*4     ano_fim
        character*38    nome_da_estacao
        character*2     grau_lat
        character*2     min_lat
        character*1     dec_lat
        character*1     sentido_lat
        character*3     grau_lon
        character*2     min_lon
        character*1     dec_lon
        character*1     sentido_lon

!C      DIMENSION AX(1),P(21),IV1(4),IV2(4),MES(12)

        REAL*4          AX(1),P(21)
        INTEGER*4       IV1(4),IV2(4),MES(12)

        INTEGER*2       TAB_MES (12)

        integer*2       im(13)
      DATA MES/4HJAN.,4HFEV.,4HMAR.,4HABR.,4HMAI.,&
     &4HJUN.,4HJUL.,4HAGO.,4HSET.,4HOUT.,4HNOV.,4HDEZ./
!c      DATA IM/00,31,28,31,30,31,30,31,31,30,31,30,31/

        DATA TAB_MES /31,28,31,30,31,30,31,31,30,31,30,31/

        common /impre/impre
        common /data/ data_imp,aster,aster1
        COMMON  /BLOCO1/ ESTACAO,DIA_INI,MES_INI,ANO_INI,DIA_FIM,MES_FIM,&
        &       ANO_FIM,NOME_DA_ESTACAO,GRAU_LAT,MIN_LAT,DEC_LAT,SENTIDO_LAT,&
        &       GRAU_LON,MIN_LON,DEC_LON,SENTIDO_LON


!c      Inicializar o vetor IM

        im  (1) = 00
        im  (2) = 31
        im  (3) = 28
        im  (4) = 31
        im  (5) = 30
        im  (6) = 31
        im  (7) = 30
        im  (8) = 31
        im  (9) = 31
        im (10) = 30
        im (11) = 31
        im (12) = 30
        im (13) = 31

        IND1 = 0

        TAB_MES (2) = 28

      MB=MOD(IAN,4)
      MC=MOD(IAN,100)
      MD=MOD(IAN,400)
        IF ((MB.EQ.0.AND.MC.NE.0).OR.(MD.EQ.0)) THEN
                IM(3)=29
                TAB_MES (2) = 29
        END IF

        im (imes+1) = (im (imes+1) - dia_inicial) + 1
        if (dia_final .ne. im (mes_final+1) ) then
                im (mes_final+1) =  dia_final
        end if


      JX=4
      JY=3
      WRITE (impre,100)
      DO 40 LOOP=1,NL
      IV1(4)=S0
      IV2(4)=S0
      IALT=S0
      JV=IMES+LOOP-1
      JV=JV+1

        if (jv .gt. 13) then
                nr_dias = im (jv - 12)
        else
                nr_dias = im (jv)
        end if
        jy = jy + 24 * nr_dias

      MM=0

      DO 10 II=JX,JY
      A=AX(II-1)
      B=AX(II)
      C=AX(II+1)
      IF((A.LE.B.AND.B.GE.C).OR.(A.GE.B.AND.B.LE.C))MM=II
      IF(II.NE.MM)GO TO 10
      CALL TERP(AX,MM,3,P)
      DO 20 J=4,18
      A=P(J-1)
      B=P(J)
      C=P(J+1)
      IF((A.LE.B.AND.B.GE.C).OR.(A.GE.B.AND.B.LE.C))JJ=J
   20 CONTINUE
      CALL TERP(P,JJ,2,P)
      DO 25 K=4,10
      A=P(K-1)
      B=P(K)
      C=P(K+1)
      IF((A.LE.B.AND.B.GE.C).OR.(A.GE.B.AND.B.LE.C))KK=K
   25 CONTINUE
      HORA=HIF+MM-JX-1.4375+(JJ-1)*.125+(KK-1)*.03125
      IHORA=HORA
      MIN=(HORA-IHORA)*60.+.5
      IDIA=IHORA/24+1
      IHORA=MOD(IHORA,24)
      IF(ABS(IALT-P(KK)).LT..5.OR.IHORA.LT.0)GO TO 10
      IALT=P(KK)+.5

      IF(IALT.LT.IV1(4))GO TO 30
        if ( (dia_inicial .ne. 01) .and. (loop .eq. 1) )   then
                iv1 (1) = (idia + dia_inicial) - 1
        else
                IV1(1)=IDIA
        end if
      IV1(2)=IHORA
      IV1(3)=MIN
      IV1(4)=IALT
   30 IF(IALT.GT.IV2(4))GO TO 10
        if ( (dia_inicial .ne. 01) .and. (loop .eq. 1) )   then
                iv2 (1) = (idia + dia_inicial) - 1
        else
                IV2(1)=IDIA
        end if
      IV2(2)=IHORA
      IV2(3)=MIN
      IV2(4)=IALT
   10 CONTINUE

        if (jv .gt. 13) then
                indice = indice + 1
        else
                indice = jv - 1
        end if

!C      VERIFICA O NUMERO DE DIAS NO MES

        IF (IMES .EQ. INDICE) THEN
                NUM_DIAS = ( TAB_MES (INDICE) - DIA_INICIAL ) + 1
        ELSE IF (INDICE .EQ. MES_FINAL) THEN
                NUM_DIAS = DIA_FINAL
        ELSE
                NUM_DIAS = TAB_MES (INDICE)
        END IF

        IND1 = IND1 + 1
        write (impre,110) mes (indice), ian, VETOR (IND1), NUM_DIAS
        WRITE (impre,150)(IV1(J),J=1,4)
        WRITE (impre,160)(IV2(J),J=1,4)


        if (jv .eq. 13) then
                indice = 0
                ian = ian + 1
        end if


   40 JX=JY+1


  100 FORMAT(46X,'MAXIMOS MINIMOS E MEDIAS MENSAIS - EM CENTIMETROS')
  110 FORMAT(/,36X,1A4,1X,I4,3X,'DIA',8X,'HORA MIN    ALTURAS      MEDIA = ',&
        &       F6.2,5X,'NUMERO DE DIAS = ',I2)
  150 FORMAT(49X,I2,9X,I2,3X,I2,3X,'MAX. ',I3,7X)
  160 FORMAT(49X,I2,9X,I2,3X,I2,3X,'MIN. ',I3,7X)


      RETURN
      END


SUBROUTINE      ALTHOR(IX,IMES,NA,NL)

        COMMON  /BLOCO1/ ESTACAO,DIA_INI,MES_INI,ANO_INI,DIA_FIM,MES_FIM,&
        &       ANO_FIM,NOME_DA_ESTACAO,GRAU_LAT,MIN_LAT,DEC_LAT,SENTIDO_LAT,&
        &       GRAU_LON,MIN_LON,DEC_LON,SENTIDO_LON


        common /impre/impre
        common /data/ data_imp,aster,aster1

        character*5     estacao
        character*2     dia_ini
        character*2     mes_ini
        character*4     ano_ini
        character*2     dia_fim
        character*2     mes_fim
        character*4     ano_fim
        character*38    nome_da_estacao
        character*2     grau_lat
        character*2     min_lat
        character*1     dec_lat
        character*1     sentido_lat
        character*3     grau_lon
        character*2     min_lon
        character*1     dec_lon
        character*1     sentido_lon

        character*10    data_imp
        character*131   aster
        character*122   aster1
        integer*2       impre

!C      DIMENSION IX(1)

        INTEGER*4       IX(1)


        INTEGER*4       DI,MI,AI,DF,MF,AF,D,M,A,DIAS,MES_ANT
        CHARACTER*4     MES (12)
        CHARACTER*2     D1,M1
        CHARACTER*4     A1
        DATA MES /'JAN.','FEV.','MAR.','ABR.','MAI.',&
        &       'JUN.','JUL.','AGO.','SET.','OUT.','NOV.','DEZ.'/


!c      DECODE (2,'(I2)', DIA_INI) DI
    READ (DIA_INI,'(i2)') DI
!c      DECODE (2,'(I2)', MES_INI) MI
    READ (MES_INI,'(i2)') MI
!c      DECODE (4,'(I4)', ANO_INI) AI
    READ (ANO_INI,'(i4)') AI
!c      DECODE (2,'(I2)', DIA_FIM) DF
    READ (DIA_FIM,'(i2)') DF
!c      DECODE (2,'(I2)', MES_FIM) MF
    READ (MES_FIM,'(i2)') MF
!c      DECODE (4,'(I4)', ANO_FIM) AF
    READ (ANO_FIM,'(i4)') AF

!c      AI = AI + 1900
!c      AF = AF + 1900

        DIAS = FATOR (DF,MF,AF) - FATOR (DI,MI,AI) + 1


        D = DI
        M = MI
        A = AI
        L = 0
        MES_ANT = 0

        DO I1 = 1, DIAS
                IF (M .NE. MES_ANT) THEN
                        call cabecalho_32 (estacao,nome_da_estacao,grau_lat,&
        &               min_lat,dec_lat,sentido_lat,grau_lon,min_lon,dec_lon,&
        &               sentido_lon,dia_ini,mes_ini,ano_ini,dia_fim,mes_fim,&
        &               ano_fim)
                        write (impre,20)
                        write (impre,30) aster
                        write (impre,40)
                        write (impre,50)
                        write (impre,60)
                        write (impre,70)
                        write (impre,80) aster1
                        write (impre,90)
                        MES_ANT = M
                END IF
                L = L + 24
!c              ENCODE (2,'(I2)', D1 ) D
        WRITE (D1,'(i2)') D
!c              ENCODE (2,'(I2)', M1 ) M
        WRITE (M1,'(i2)') M
!c              ENCODE (4,'(I4)', A1 ) A
        WRITE (A1,'(i4)') A
                
                if (d .lt. 10) d1 (1:1) = '0'
                if (m .lt. 10) m1 (1:1) = '0'
                WRITE (impre,100) D1,M1,A1,(IX(L+J),J=1,24)
                CALL ANDIA (D,M,A)
        END DO

20      format (/t53,'ALTURAS HORARIAS OBSERVADAS'/)
30      format (1x,a)
40      format (2x,'* HORAS *')
50      format (4x,'*     *  00   01   02   03   04   05   06   07   08   09',&
        &       '   10   11   12   13   14   15   16   17   18   19   20   21',&
        &       '   22   23')
60      format (6x,'*   *')
70      format (8x,'* *')
80      format (1x,'DD MM AA ',a)
90      format (132x)
100     format (1X,A,' ',A,' ',A,' * ',24(I4,1X))

      RETURN
      END


SUBROUTINE      MEDMEN (IXNM,IAN,IMES,NL,dia_inicial,dia_final,mes_final,vetor)

        integer*2       dia_inicial,dia_final,mes_final
        integer*2       loop,jv,nn
        integer*2       jm (12)
        integer*2       ind,indice
        REAL*4          vetor (12)

!C      DIMENSION IXNM(1)

        INTEGER*4       IXNM(1)

!c      DATA JM/31,28,31,30,31,30,31,31,30,31,30,31/

!c      Inicializar o vetor JM

        jm  (1) = 31
        jm  (2) = 28
        jm  (3) = 31
        jm  (4) = 30
        jm  (5) = 31
        jm  (6) = 30
        jm  (7) = 31
        jm  (8) = 31
        jm  (9) = 30
        jm (10) = 31
        jm (11) = 30
        jm (12) = 31

        ind = 0
        indice = 0


      MB=MOD(IAN,4)
      MC=MOD(IAN,100)
      MD=MOD(IAN,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.(MD.EQ.0))JM(2)=29

        jm (imes) = jm (imes) - dia_inicial + 1
        if (dia_final .ne. jm (mes_final))  then
                jm (mes_final) = dia_final
        end if

      K=0
      DO 40 LOOP=1,NL
      JV=IMES+LOOP-1
        if (jv .gt. 12) then
                ind = ind + 1
                nn = jm (ind)
        else
                nn = jm (jv)
        end if

      S=0.

      DO 5 J=1,NN
      K=K+1
    5 S=S+IXNM(K)

        ANN = NN
        AMED = S / ANN
        indice = indice + 1
40      vetor (indice) = Amed


      RETURN
      END


SUBROUTINE      SALTAFOLHA

                COMMON /IMPRE / IMPRE
                integer*2       impre
        
                WRITE(IMPRE,*) CHAR(12) 

  RETURN
END

