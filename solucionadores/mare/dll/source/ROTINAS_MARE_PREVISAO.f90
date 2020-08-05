
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

SUBROUTINE TERP(X,MM,N,W)
                               
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

!C-----------------------------------------------------------------------------------------------------

SUBROUTINE CABECALHO (numero_da_estacao,nome_da_estacao,grau_lat,&
        &       min_lat,dec_lat,sentido_lat,grau_lon,min_lon,dec_lon,&
        &       sentido_lon,d1,m1,a1,d2,m2,a2,nr_comp,anivel,fuso,data_relatorio)

        
        INTEGER*2 PAG,IMPRE

!C      Variaveis de passagem para a subrotina

        CHARACTER*5   Numero_da_Estacao  
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
        INTEGER*2       NR_COMP
        real*4          ANIVEL
        character*4     fuso
        character*10 data_relatorio

        COMMON /IMPRE/ IMPRE

!c-------------------------------------------------------------------------------
        PAG = 0        
        CALL SALTAFOLHA
        
        PAG = PAG + 1
                
        WRITE (IMPRE,10) PAG
        WRITE (IMPRE,20) data_relatorio
        WRITE (IMPRE,30)
        write (impre,40) numero_da_estacao, nome_da_estacao,&
        &       fuso (1:3),fuso (4:4),&
        &       grau_lat, min_lat, dec_lat, sentido_lat,&
        &       grau_lon, min_lon, dec_lon, sentido_lon


        WRITE (IMPRE,50) D1,M1,A1,D2,M2,A2,NR_COMP,ANIVEL




10      FORMAT  (T3,'SISTEMA - MARES',T57,'MARINHA DO BRASIL',&
        &       T116,'PAGINA - ',I8)

20      FORMAT (T3,'PROGRAMA - MAR3_08',T48,&
        &       'DIRETORIA DE HIDROGRAFIA E NAVEGACAO',T116,'DATA - ',A)

30      FORMAT (T47,'BANCO NACIONAL DE DADOS OCEANOGRAFICOS',/)

40      FORMAT (T3,'NR. DA ESTACAO - ',A,T27,'NOME - ',A,&
        &       T74,'FUSO - ',A,'.',A,T88,'LATITUDE - ',&
        &       A,' ',A,' ',A,' ',A,T110,'LONGITUDE - ',A,' ',A,' ',A,' ',A,/)

50      FORMAT (T17,'PERIODO DE OBSERVACOES - 'A,'/',A,'/',A,' A ',A,'/',A,'/',&
        &       A,T66,'NR. DE COMPONENTES - ',I3,T95,'NIVEL MEDIO = ',f5.2,&
        &       ' M.',/)


        RETURN
        END

!C-----------------------------------------------------------------------------------------------------

SUBROUTINE SALTAFOLHA

  COMMON /IMPRE / IMPRE
  integer*2     impre
        
  WRITE(IMPRE,*) CHAR(12)

  RETURN
END

!C-----------------------------------------------------------------------------------------------------


Subroutine PREVISAO (arq_const,arq_prev,tipo,di,mi,ai,df,mf,af,nivel,op,SIM,data_relatorio)

  !DEC$ ATTRIBUTES DLLEXPORT::PREVISAO


!C     TABUA DE MARES - CALCULOS E IMPRESSAO (tranformado para previsao)
!C     ESTE PROGRAMA CHAMA AS SUB-ROTINAS DE USO COMUM NO SISTEMA DE MARE
!C     ASTRO  
!C     TERP   


!c      Variaveis passadas para a subrotina

        character*150   arq_const               ! nome do arquivo de constantes
        character*1     tipo            ! se = 0 imprime preamar e baixamar
!c                                      ! se = 1 imprime alturas horarias
!c                                      ! se = 2 imprime ambos
        character*2     di,mi,df,mf
        character*4     ai,af
        character*10    nivel   
        character*1     op              ! se s deleta o arquivo de constantes

        CHARACTER*1     SIM             ! DESEJA GRAVAR ARQUIVO DE ALTURA E OU PREVISAO.
        character*150 arq_prev
        character*10 data_relatorio

!c      Variaveis do registro mestre

        integer*2       m1
        character*10    nivel_medio
        character*2     dd1,dd2,mm2,MM1
        character*4     aa1,aa2
        character*5     nr_estacao
        character*38    nome_estacao
        character*2     xlatg,min_lat
        character*1     dec_lat,hem
        character*3     xlong
        character*2     min_lon
        character*1     dec_lon,ori
        character*4     fuso_horario
        CHARACTER*5     FUSO

!c      Variaveis de trabalho

        logical*1       houve_registro
        integer*2       impre
        integer*2       dia_ini, mes_ini, ano_ini, dia_fim, mes_fim, ano_fim
        character*129   aster
        character*125   aster2
        character*9     tab_mes (12)
        logical*1       primeira_vez
        character*80    arq_sai
        character*13    instituicao
        character*4     carta
        character*80    brancos

!c------------------------------------------------------------------------------

!c      REAL MESA(12),MESB(12),MESC(12),WRIFI(24)
       REAL MESA(12),MESB(12),MESC(12)

        character*4     wrifi (24)
        character*4     br3,br4
        character*4     hora1,minu1,alt1


!c      DIMENSION C(1801),IM(12),P(21)
!c      DIMENSION LM(14),F(180),U(180),Q(180)
!c      DIMENSION F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14),INAUX(14)
!c      DIMENSION AH(9000),KTANO(3300),KTMES(3300),KTDIA(3300)
!c      DIMENSION KTHOR(3300),KTMIN(3300),ATAB(3300)
!c      DIMENSION LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)


        real*4  C(1801),P(21)
        real*4  F(180),U(180),Q(180)
        real*4  F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14)
        real*4  AH(9000),ATAB(3300)
        real*4  aatab
        integer*4       KTHOR(3300),KTMIN(3300)
        integer*4       LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)
        integer*4       im(12),lm(14),inaux(14)
        integer*4       KTANO(3300),KTMES(3300),KTDIA(3300)

        CHARACTER*2     VETDIA (9)
        CHARACTER*2     VETHOR (9)
        CHARACTER*2     VETMIN (9)
        CHARACTER*4     VETALT (9)
        INTEGER*2       IND
        INTEGER*4       DIA_ANT
        REAL*4          AMAXI,AMINI

        INTEGER*2       IWAH(24)

        data tab_mes /' JANEIRO ','FEVEREIRO','  MARCO  ','  ABRIL  ',&
        &             '   MAIO  ','  JUNHO  ','  JULHO  ','  AGOSTO ',&
        &             'SETEMBRO ',' OUTUBRO ','NOVEMBRO ','DEZEMBRO '/




!c------------------------------------------------------------------------------
        

!c      DATA IM/31,28,31,30,31,30,31,31,30,31,30,31/

!C     Q1 FREQUENCIAS, EM GRAUS POR HORA, DAS 37 COMPONENTES ASTRONOMICAS
!C     PRINCIPAIS.

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424078,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265120,&
     &43.4761563/

      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/


        common  /impre/ impre
        common  /relatorio/ houve_registro

!C     INAUX INDICE DAS 14 COMPONENTES ASTRONOMICAS QUE ENTRAM USUALMENTE
!C     NA FORMACAO DAS COMPONENTES DE PEQUENO FUNDO
!C     DELTAT INTERVALO, EM FRACAO DECIMAL DA HORA, ENTRE DUAS ALTURAS
!C     CONSECUTIVAS PREVISTAS. HI,IDIAS,IMES HORA, DIA E MES DO INICIO
!C     DA PREVISAO. NL NUMERO DE MESES DA PREVISAO. APOS A PREVISAO,
!C     EXTREMOS SAO CALCULADOS POR INTERPOLACAO.
!C     DATA DELTAT,HI,IDIAS,IMES,NL/1.,-3.,1,12,14/
!C     IANO ANO DA PREVISAO
!C     JH NUMERO DE PORTOS


!c      Inicializar variaveis




        im (01) = 31
        im (02) = 28    
        im (03) = 31
        im (04) = 30
        im (05) = 31
        im (06) = 30
        im (07) = 31
        im (08) = 31
        im (09) = 30
        im (10) = 31
        im (11) = 30
        im (12) = 31

        DO I = 1,129
                ASTER (I:I) = '*'
        END DO

        DO I = 1,125
                ASTER2 (I:I) = '*'
        END DO


        deltat = 1.0
        hi = -3.0
        idias = 1
        imes = 12
        nl = 14

        brancos = ' '
        instituicao = ' '
        carta = ' '

!c      abertura dos arquivos de saida tanto de alturas como previsao se foi
!c      solicitado pelo usuario
    impre=3
        open (unit = impre, file=arq_prev, status='new', iostat=ierro)

        if (sim .eq. 'S') then

          if (tipo .eq. '2') then

!c              Abertura do arquivo de alturas


                arq_sai = 'TEMP.ALT'

                open    (unit = 22,&
        &       file = ARQ_SAI,&
        &       status = 'NEW',&
        &       iostat = ierro)

                !if (ierro .ne. 0) then
                 !type *,'Erro na abertura do arquivo de ALTURAS PARA GRAVACAO'
                 !type *,'Avisar Analista Responsavel'
                 !type *,'Erro numero - ',ierro
                 !stop
                !end if


!c              Abertura do arquivo de PREVISAO

                arq_sai = 'TEMP.PRV'

                open    (unit = 33,&
        &       file = ARQ_SAI,&
        &       status = 'NEW',&
        &       iostat = ierro)

                !if (ierro .ne. 0) then
                  !type *,'Erro na abertura do arquivo de PREVISAO PARA GRAVACAO'
                  !type *,'Avisar Analista Responsavel'
                  !type *,'Erro numero - ',ierro
                  !stop
                !end if
          else
                if (tipo .eq. '1') then 
!c                      Abertura do arquivo de ALTURAS
        
                        arq_sai = 'TEMP.ALT'

                        open    (unit = 22,&
        &               file = ARQ_SAI,&
        &               status = 'NEW',&
        &               iostat = ierro)

                        !if (ierro .ne. 0) then
                          !type *,'Erro na abertura do arquivo de PREVISAO PARA GRAVACAO'
                          !type *,'Avisar Analista Responsavel'
                          !type *,'Erro numero - ',ierro
                          !stop
                        !end if
                else
!c                      Abertura do arquivo de PREVISAO

                        arq_sai = 'TEMP.PRV'

                        open    (unit = 33,&
        &               file = ARQ_SAI,&
        &               status = 'NEW',&
        &               iostat = ierro)

                        !if (ierro .ne. 0) then
                          !type *,'Erro na abertura do arquivo de ALTURAS PARA GRAVACAO'
                          !type *,'Avisar Analista Responsavel'
                          !type *,'Erro numero - ',ierro
                          !stop
                        !end if
                end if
          end if

        END IF


!C      Transformar variaveis passadas para a subrotina

!C      MODIFICACAO FEITA POR CARLOS MAGNO ABREU EM 14/06/2020
!C        decode(2,'(i2)', di) dia_ini
       READ (di,'(i2)') dia_ini
!C        decode(2,'(i2)', mi) mes_ini
       READ (mi,'(i2)') mes_ini
!C        decode(4,'(i4)', ai) ano_ini
       READ (ai,'(i4)') ano_ini
!C        decode(2,'(i2)', df) dia_fim
       READ (df,'(i2)') dia_fim
!C        decode(2,'(i2)', mf) mes_fim
       READ (mf,'(i2)') mes_fim       
!C        decode(4,'(i4)', af) ano_fim
       READ (af,'(i4)') ano_fim
!C        decode(10, '(f10.2)', nivel ) s0
       READ (nivel,'(f10.2)') s0
        SOMET=S0/100.

        iano = ano_ini

!c      Abertura do arquivo de constantes.
        open    (unit = 11,&
        &       file = arq_const,&
        &       status = 'old',&
        &       iostat = ierro)

        !if (ierro .ne. 0) then
          !type *,'Erro na abertura do arquivo de constantes na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ierro
          !close (unit = 11)
          !stop
        !end if

!c      Inicializar jh com o valor de 1 para o loop ser de um porto de cada vez.

        jh = 1



!C     CONSTRUCAO DA TABELA DE COSSENOS C(I), PARA UM INTERVALO DE 0.2 DO
!C     GRAU.
      AR=3.1415926/180.
      AV=AR*DELTAT
      DELTAX=.2*AR
      AA=COS(DELTAX)
      AB=SIN(DELTAX)
      BB=1.
      BC=0.
      C(1)=1.
      DO 3 I=1,1800
      Z=AA*BB-AB*BC
      BC=AB*BB+AA*BC
      BB=Z
    3 C(I+1)=Z
      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)IM(2)=29
      N=(399+IM(2))*24+6
      KANO=IANO-1

!C     CALCULO DOS ARGUMENTOS ASTRONOMICOS E DOS FATORES PERINODAIS DAS
!C     37 COMPONENTES ASTRONOMICAS PRINCIPAIS.

      CALL ASTRO(1,DELTAT,HI,IDIAS,IMES,KANO,N,0,F1,U1,AS)

      DO 4 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    4 CONTINUE
      DO 1500 LI=1,JH
      KANO=IANO-1
      JV=IMES-1


!C-------------------------------------------------------------------------------
!c      Leitura do primeiro registro do arquivo de constantes com os seguintes
!c      campos para processamento
!c
!c      Numero de componentes           = M1 (i3)               = i3
!c      Nivel medio                     = nivel_medio (char*10) = s0 (f10.2)
!c      periodo inicial da analise(DMA) = data_inic char*6      = 
!c      periodo final da analise (DMA)  = data_fim char*6       =
!c      numero da estacao               = nr_estacao char*5     =
!c      nome da estacao                 = nome_estacao char*38  =
!c      grau_da_latitude                = xlatg char*2          = xlatg
!c      minuto_da_latitude              = min_lat char*2        = min_lat
!c      decimo_da_latitude              = dec_lat char*1        = dec_lat
!c      sentido_da_latitude             = hem char*1            = hem
!c      grau_da_longitude               = xlong char*3          = xlong
!c      minuto_da_longitude             = min_lat char*2        = min_lon
!c      decimo_da_longitude             = dec_lat char*1        = dec_lon
!c      sentido_da_longitude            = ori char*1            = ori
!c      fuso_horario                    = fuso_horario char*4   = fuso char*5


        read (unit = 11, fmt = 6000, iostat = ierro_le_1) m1,nivel_medio,dd1,&
        &       mm1,aa1,dd2,mm2,aa2,nr_estacao,nome_estacao,xlatg,min_lat,&
        &       dec_lat,hem,xlong,min_lon,dec_lon,ori,fuso_horario

 6000   format (i3,18a)

        FUSO = FUSO_HORARIO (1:3) // '.' // FUSO_HORARIO (4:4)

!C       MODIFICACAO FEITA POR CARLOS MAGNO EM 14/06/2020
!C        decode (10, '(f10.2)', nivel_medio ) s0_anterior
       READ (nivel_medio,'(f10.2)') s0_anterior

!c------------------------------------------------------------------------------

      DO 30 I=1,M1
!C     IX=1 SE A COMPONENTE FOR ASTRONOMICA E IX=0 SE FOR DE PEQUENO FUN-
!C     DO. IX=2 PARA COMPONENTES ARBITRARIAS.
!C     Q VELOC ANG, LM COMBINACOES, H,G CTES HARM

      READ (11,2) IX,Q(I),(LM(J),J=1,14),H,G
    2 FORMAT(I1,7X,F11.7,14I2,2F8.2)
      IF(1-IX)17,15,16
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ASTRONOMICAS.
   15 DO 5 JK=1,37
      IF(ABS(Q1(JK)-Q(I)).GE..0001)GO TO 5
      F(I)=F1(JK)*H
      U(I)=U1(JK)-G
      GO TO 30
    5 CONTINUE
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES DE PEQUENO FUNDO.
   16 AA=1.
      BB=0.
      DO 6 M=1,14
      AA=AA*F2(M)**IABS(LM(M))
    6 BB=BB+U2(M)*LM(M)
      F(I)=AA*H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
      GO TO 30
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ARBITRARIAS.
   17 BB=0.
      DO 7 J=1,6
    7 BB=BB+AS(J)*LM(J)
      F(I)=H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
   30 Q(I)=Q(I)*DELTAT
      INDEX=0


!C      GRAVACAO DO PRIMEIRO REGISTRO DO ARQUIVO DE ALTURAS
!cahf
        if (sim .eq. 'S') then
                if (tipo .ne. '0') then
                        write (22,2201) nr_estacao,di,mi,ai,df,mf,af,&
        &               nome_estacao,xlatg,min_lat,dec_lat,hem,xlong,min_lon,&
        &               dec_lon,ori,FUSO_HORARIO,brancos (1:20)
                end if
        end if
2201    format (18(a))

!C-------------------------------------------------------------------------------

!C     CALCULO DAS ALTURAS SUCESSIVAS.

        IND_MES = 0     ! VARIAVEL QUE IDENTIFICA O MES REAL QUE ESTA SENDO
!C                        PROCESSADO 

      DO 1000 LOOP=1,NL
        IND_MES = IND_MES + 1
      JV=JV+1
      IF(JV-12)32,32,9030
 9030 JV=1
      KANO=KANO+1
   32 IH=IM(JV)*24+6
      DO 22 K=1,IH
      S=S0
      DO 23 J=1,M1
      AA=U(J)
      IK=ABS(AA/.2)+1.5
      AA=AA+Q(J)
      U(J)=AA-IFIX(AA/360.)*360.
   23 S=S+C(IK)*F(J)
      AH(K)=S


   22 CONTINUE
      DO 24 I=1,M1
      U(I)=U(I)-6.*Q(I)
      MA=U(I)/360.
      U(I)=U(I)-MA*360.
      IF(U(I).LT.0.)U(I)=U(I)+360.
   24 CONTINUE

!c      relatorio das alturas horarias
!c      so imprime se tipo for diferente de 0

        if ( tipo .ne. '0') then

                if ( ( (ind_mes - 1) .ge. mes_ini ) .and.&
        &            ( (ind_mes - 1) .le. mes_fim )) then
                        HOUVE_REGISTRO = .TRUE.
                        call cabecalho (nr_estacao,nome_estacao,xlatg,min_lat,&
        &                       dec_lat,hem,xlong,min_lon,dec_lon,ori,dd1,mm1,&
        &                       aa1,dd2,mm2,aa2,m1,somet,fuso_horario,data_relatorio)
                        write (impre,198) di, tab_mes (mes_ini), ano_ini,&
        &                                 df, tab_mes (mes_fim), ano_fim
                        write (impre,199) tab_mes (ind_mes - 1)
                        write (impre,2001) aster
                        write (impre,201)
                        write (impre,202)
                        write (impre,203)
                        write (impre,204)
                        write (impre,205) aster2

                        k1 = 3
                        ind1 = im (ind_mes - 1)
                        do ind2 = 1, ind1
                                do ind3 = 1,24
                                        k1 = k1 + 1
                                        iwah (ind3) = int (ah (k1),2)
                                end do
!C                              impressao so dos dias desejados
                                if (mes_ini .eq. mes_fim) then
                                  if (ind2 .ge. dia_ini .and. ind2 .le. dia_fim) then
                                      write (impre,354) ind2,(iwah (l1),l1=1,24)
                                      if (sim .eq. 'S' ) then
                                        write (22,2202) (iwah (l1),l1=1,24)
                                      end if
                                  end if
                                else
                                    if ( (ind_mes - 1) .eq. mes_ini) then
                                          if (ind2 .ge. dia_ini) then
                                             write (impre,354) ind2,(iwah (l1),l1=1,24)
                                             if (sim .eq. 'S') then
                                                write (22,2202) (iwah (l1),l1=1,24)
                                             end if
                                          end if
                                    else
                                        if ((ind_mes - 1) .eq. mes_fim) then
                                           if (ind2 .le. dia_fim) then
                                                write (impre,354) ind2,(iwah (l1),l1=1,24)
                                                if (sim .eq. 'S') then
                                                  write (22,2202) (iwah (l1),l1=1,24)
                                                end if
                                           end if
                                        else
                                                write (impre,354) ind2,(iwah (l1),l1=1,24)
                                                if (sim .eq. 'S') then
                                                   write (22,2202) (iwah (l1),l1=1,24)
                                                end if
                                        end if
                                    end if
                                end if
                        end do
2202    format (24(i4))
!c                      impressao da linha de obs para cada mes.
                        if (s0 .ne. s0_anterior ) then
                                write (impre, 356)
                        else
                                write (impre, 355)
                        end if
                end if
        end if
!c--------------------------------------------------------------------
!C

        if (tipo .eq. '1') go to 1000   ! SO IMPRIME ALTURAS

!c      RELATORIO DE PREAMARES E BAIXAMARES
!C      SO PASSARA POR AQUI SE TIPO FOR DIFERENTE DE 1

!c-----------------------------------------------------------------------
!C     CALCULO POR INTERPOL DE DATAS E ALTURAS DE PREAMARES E BAIXAMARES
      IL=IH-3
      M=0
      ALT=S0
      DO 160 I=4,IL
      IF(AH(I-1).LE.AH(I).AND.AH(I).GE.AH(I+1))M=I
      IF(AH(I-1).GE.AH(I).AND.AH(I).LE.AH(I+1))M=I
      IF(I-M)160,99,160
   99 CALL TERP(AH,M,3,P)
      DO 100 J=4,18
      IF(P(J-1).LE.P(J).AND.P(J).GE.P(J+1))JJ=J
      IF(P(J-1).GE.P(J).AND.P(J).LE.P(J+1))JJ=J
  100 CONTINUE
      CALL TERP(P,JJ,2,P)
      DO 110 K=4,10
      IF(P(K-1).LE.P(K).AND.P(K).GE.P(K+1))KK=K
      IF(P(K-1).GE.P(K).AND.P(K).LE.P(K+1))KK=K
  110 CONTINUE
      HORA=M-4-1.4375+(JJ-1)*.125+(KK-1)*.03125
      IHORA=HORA
      MIN=(HORA-IHORA)*60.+.5
      IDIA=IHORA/24+1
      IHORA=MOD(IHORA,24)
      IF(ABS(ALT-P(KK)).LT.0.5.OR.IHORA.LT.0)GO TO 160
      ALT=P(KK)
      INDEX=INDEX+1
      KTANO(INDEX)=KANO
      KTMES(INDEX)=JV
      KTDIA(INDEX)=IDIA
      KTHOR(INDEX)=IHORA
      KTMIN(INDEX)=MIN
      ATAB(INDEX)=ALT
  160 CONTINUE
 1000 CONTINUE

!C      NESTA PARTE SO SERA EXECUTADO SE TIPO FOR DIFERENTE DE 1

        if (tipo .eq. '1') go to 1501   ! SO IMPRIME ALTURAS

!C      A PARTIR DAQUI JA ESTAO CALCULADOS TODAS AS PREAMEARES E BAIXAMARES

!C      Altercao feita em 17/09/90 para que ao encontrar o minuto negativo
!c      nao altere a data de janeiro para dezembro.
!c
!C     CORRECAO DE MINUTOS NEGATIVOS
!c      MADEX=INDEX
!c      DO 1100 INDEX=1,MADEX
!c      IF(KTMIN(INDEX))1010,1100,1100
!c 1010 IF(KTMES(INDEX)-1)1020,1020,1040
!c 1020 KTANO(INDEX)=KTANO(INDEX)-1
!c      KTMES(INDEX)=12
!c      KTDIA(INDEX)=31
!c      GO TO 1050
!c 1040 JV=KTMES(INDEX)-1
!c      KTMES(INDEX)=JV
!c      KTDIA(INDEX)=IM(JV)
!c 1050 KTHOR(INDEX)=23
!c      KTMIN(INDEX)=KTMIN(INDEX)+60
!c 1100 CONTINUE


!C     CORRECAO DE MINUTOS NEGATIVOS

      MADEX=INDEX

        do index = 1, madex
                if (ktmin (index) .lt. 0) then
                        if (ktmes (index) .eq. 1) then
                                ktdia (index) = 1
                                kthor (index) = 0
                                ktmin (index) = 0
                        else
                                jv = ktmes (index) - 1
                                ktmes (index) = jv
                                ktdia (index) = im (jv)
                                kthor (index) = 23
                                ktmin (index) = ktmin (index) + 60
                        end if
                end if
        end do


!C     AJUSTE DE INDICES E CONVERSAO DOS EXTREMOS EM METROS.
      DO 1120 INDEX=1,MADEX
      IF(KTANO(INDEX)-IANO)1120,1150,1150
 1120 CONTINUE
 1150 INDIN=INDEX
      DO 1170 INDEX=INDIN,MADEX
      IF(KTANO(INDEX)-IANO)1170,1170,1190
 1170 CONTINUE
 1190 INDFI=INDEX-1
      INDEX=0
      DO 1200 M=INDIN,INDFI
      INDEX=INDEX+1
      KTANO(INDEX)=KTANO(M)
      KTMES(INDEX)=KTMES(M)
      KTDIA(INDEX)=KTDIA(M)
      KTHOR(INDEX)=KTHOR(M)
      KTMIN(INDEX)=KTMIN(M)
      ATAB (INDEX)=ATAB (M)
!c------------------------------------------------------------------------------
!c       ATAB(INDEX)=ATAB(M)/100.
!c      substituido para tirar o sinal do -0.0
!c      AHF 30/04/87
!c
!c      atab (index) = aint (atab (m) / 10.) / 10.
!c------------------------------------------------------------------------------

 1200 CONTINUE

!c      MADEX=INDEX

!c      Loop para impressao das preamares e baixamares



        primeira_vez = .true.

        do i = 1, index

                if (ktmes (i) .ge. mes_ini .and. ktmes (i) .le. mes_fim) then

                        if (primeira_vez) then
                                houve_registro = .true.
                                call cabecalho (nr_estacao,nome_estacao,xlatg,&
        &                       min_lat,dec_lat,hem,xlong,min_lon,dec_lon,ori,&
        &                       dd1,mm1,aa1,dd2,mm2,aa2,m1,somet,fuso_horario,data_relatorio)
                                write (impre, 111) tab_mes (ktmes (i)), ktano(i)
                                write (impre, 112)
                                write (impre, 113)
                                write (impre, 114)
                                mes_ant = ktmes (i)
                                amaxi = 0.0
                                amini = 999.99
                                ind = 0
                                dia_ant = ktdia (i)
                                primeira_vez = .false.

!C      verifica se deseja gravar as previsoes
                                if (sim .eq. 'S') then
                                        write (33,3301) nome_estacao,brancos (1:57)
3301    format ('1',a,a)
                                        write (33,3302) xlatg,min_lat,dec_lat,&
        &                               hem,xlong,min_lon,dec_lon,ori,&
        &                               FUSO,instituicao,somet,carta,m1,&
        &                               dd1,mm1,aa1,dd2,mm2,aa2,brancos (1:34)
3302    format ('2',a,a,'.',a,a,a,a,'.',a,a,a,a,f5.2,a,i3,7(a))
                                end if

                        end if

!c              teste para a quebra do mes , impressao e gravacao 
!c              do ultimo dia do mes anterior e da maxima e minima

                        if (ktmes (i) .ne. mes_ant) then

                                write (33,3303) kiano ,  mes_ant, dia_ant,&
        &                       ind, (vethor(j),vetmin(j),vetalt(j), j = 1,ind)
 
                                WRITE (IMPRE ,225) (VETDIA (J), VETHOR (J),& 
        &                       VETMIN (J), VETALT (J), J = 1, IND)
                                write (impre, 555)
                                amaxii = amaxi / 100
                                write (impre, 333) idima,ihoma,imima,amaxii
                                write (impre, 222)
                                aminii = amini / 100
                                write (impre, 333) idimi,ihomi,imimi,aminii

                                if (s0 .ne. s0_anterior) then
                                        write (impre, 224)
                                else
                                        write (impre, 223)
                                end if
                                call cabecalho (nr_estacao,nome_estacao,xlatg,&
        &                       min_lat,dec_lat,hem,xlong,min_lon,dec_lon,ori,&
        &                       dd1,mm1,aa1,dd2,mm2,aa2,m1,somet,fuso_horario,data_relatorio)
                                write (impre, 111) tab_mes (ktmes(i)), ktano(i)
                                write (impre, 112)
                                write (impre, 113)
                                write (impre, 114)
                                mes_ant = ktmes (i)
                                amaxi = 0.0
                                amini = 999.99
                                ind = 0
                                dia_ant = ktdia (i)
                        end if

!c                      teste para guardar a maxima e minima
                        if (atab (i) .gt. amaxi) then
                                amaxi = atab (i)
                                idima = ktdia (i)
                                ihoma = kthor (i)
                                imima = ktmin (i)
                        end if
                        if (atab (i) .lt. amini) then
                                amini = atab (i)
                                idimi = ktdia (i)
                                ihomi = kthor (i)
                                imimi = ktmin (i)
                        end if
        


                        IF (KTDIA (I) .NE. DIA_ANT) THEN

!C                              ALTERCAO FEITA EM 25/10/91 PARA FAZER UMA
!C                              PREVISAO PARA 1831 DESTE MODO DA VALOR NEGATIVO.
!C                              kiano = ktano (i) - 1900
!c----------------------------------------------------------------------------
!c      alteracao feita em 20/10/98 para gravar o ano com 4 digitos
!c      foi colocado como comentario essas linhas
!c                              KIANO = KTANO (I) / 100
!c                              KIANO = KIANO * 100
!c                              KIANO = KTANO (I) - KIANO
                                kiano = ktano (i)
!c---------------------------------------------------------------------------


                                write (33,3303) kiano , ktmes (i), dia_ant,&
        &                       ind, (vethor(j),vetmin(j),vetalt(j), j = 1,ind)
                        
                                WRITE (IMPRE ,225) (VETDIA (J), VETHOR (J),& 
        &                               VETMIN (J), VETALT (J), J = 1, IND)
                                

                                DIA_ANT = KTDIA (I)

                                IND = 0
                                DO K = 1, 9
                                        VETDIA (K) = ' '
                                        VETHOR (K) = ' '
                                        VETMIN (K) = ' '
                                        VETALT (K) = ' '
                                END DO
                        END IF
                        IND = IND + 1
                        IF (IND .GT. 9) THEN
                                write (impre,1225)
                                ind = 9
                                stop
                        END IF
!C       MODIFICACAO FEITA POR CARLOS MAGNO ABREU EM 14/06/2020
!C                        encode (2,'(I2)', VETDIA (IND) ) KTDIA (I)
                        WRITE (VETDIA (IND),'(i2)') KTDIA (I)    
!C                        encode (2,'(I2)', VETHOR (IND) ) KTHOR (I)
                        WRITE (VETHOR (IND),'(i2)') KTHOR (I)
!C                        encode (2,'(I2)', VETMIN (IND) ) KTMIN (I)
                        WRITE (VETMIN (IND),'(i2)') KTMIN (I)
                        AATAB = (ATAB (I) /10.) / 10.
!C                        encode (4,'(F4.1)', VETALT (IND) ) AATAB
                        WRITE (VETALT (IND),'(f4.1)') AATAB
                        IF (KTHOR (I) .EQ. 0) VETHOR (IND) = ' 0'
                        IF (KTMIN (I) .LT. 10) VETMIN (IND) (1:1) = '0'
                end if
        end do

!c      impressao e gravacao do ultimo dia do ANO

        WRITE (IMPRE,225) (VETDIA (J),VETHOR (J),VETMIN (J),VETALT (J), J=1,IND)

        write (33,3303) kiano , mes_ant, dia_ant,&
        &                       ind, (vethor(j),vetmin(j),vetalt(j), j = 1,ind)
!C------------------------------------------------------------------------------

!c      impressao da maxima e minima do mes

        write (impre, 555)
        amaxii = amaxi / 100
        write (impre, 333) idima,ihoma,imima,amaxii
        write (impre, 222)
        aminii = amini / 100
        write (impre, 333) idimi,ihomi,imimi,aminii
        if (s0 .ne. s0_anterior) then
                write (impre, 224)
        else
                write (impre, 223)
        end if
!c--------------------------------------------------------

 1500 CONTINUE

1501    if (op .eq. 'S') then
                close (unit = 11, status = 'delete')
        else
                close (unit = 11)
        end if

111     format (t42,'PREAMARES E BAIXAMARES - MES ',a,' - ANO - ',i4,/)
112     format (t3,9('     HORA  ALT'))
113     FORMAT (T5,9('DIA           '))
114     FORMAT (T2,9('       H M   M'))
225     FORMAT (4x,9(A2,' ',A2,A2,' ',A4,'  '))
555     FORMAT (//,21X,'MAXIMA DO MES - DIA   HORA MINUTO     ALTURA')
333     FORMAT (38X,I2,4X,I2,3X,I2,5X,F8.2)
222     FORMAT (21X,'MINIMA DO MES - DIA    HORA MINUTO     ALTURA')
223     FORMAT (/,T38,'OBS: ALTURAS EM METROS EM RELACAO AO NIVEL DE REDUCAO (NR).')
224     FORMAT (/,T38,'OBS: ALTURAS EM METROS EM RELACAO AO ZERO DA REGUA.')
1225    format (t5,'*****  ATENCAO NESTE DIA HOUVE MAIS DE NOVE VALORES MAXIMOS E MINIMOS, AVISAR AO ANALISTA RESPONSAVEL. *****')


198     format (t19,'PREVISAO DE ALTURAS HORARIAS PARA O PERIODO DE ',A,' DE ',&
        &       A,' DE ',I4,' A ',A,' DE ',A,' DE ',I4,/)

199     FORMAT (T60,A,/)

2001    FORMAT (T3,A)

201     FORMAT (T3,'HORAS *',T131,'*')

202     FORMAT (T4,'*    *    0    1    2    3    4    5    6    7    8    9',&
        &       '   10   11   12   13   14   15   16   17   18   19   20   21',&
        &       '   22   23 *')

203     FORMAT (T5,'*   *',T131,'*')

204     FORMAT (T6,'*  *',T131,'*')

205     FORMAT (T3,'DIAS',A)

354     FORMAT (T5,I2,'  *',24(' ',I4),' *')

355     FORMAT (///,T35,'OBS: ALTURAS EM CENTIMETROS EM RELACAO AO NIVEL DE REDUCAO (NR).')

356     FORMAT (///,T40,'OBS: ALTURAS EM CENTIMETROS EM RELACAO AO ZERO DA REGUA')
3303    format ('3',i4,i2,i2,i2,9(a2,a2,a4))


        if (sim .eq. 'S') then
                if (tipo .eq. '2') then
                        close (unit = 22, status = 'delete')
                        close (unit = 33, status = 'delete')
                else
                        if (tipo .eq. '1') then
                                close (unit = 22, status = 'delete')
                        else
                                close (unit = 33, status = 'delete')
                        end if
                end if
        end if

       close(unit = impre)

       RETURN
       END



Subroutine PREVISAO_ALTURAS_EXCEL (arq_const,arq_prev,tipo,di,mi,ai,df,mf,af,nivel,op)

  !DEC$ ATTRIBUTES DLLEXPORT::PREVISAO_ALTURAS_EXCEL


!C     TABUA DE MARES - CALCULOS E IMPRESSAO (tranformado para previsao)
!C     ESTE PROGRAMA CHAMA AS SUB-ROTINAS DE USO COMUM NO SISTEMA DE MARE
!C     ASTRO  
!C     TERP   


!c      Variaveis passadas para a subrotina

        character*150   arq_const               ! nome do arquivo de constantes
        character*1     tipo            ! se = 0 imprime preamar e baixamar
!c                                      ! se = 1 imprime alturas horarias
!c                                      ! se = 2 imprime ambos
        character*2     di,mi,df,mf
        character*4     ai,af
        character*10    nivel   
        character*1     op              ! se s deleta o arquivo de constantes

!C                                      ! PREVISAO.
        CHARACTER*150   arq_prev                ! NOME DO ARQUIVO PARA ALTURA E PREVISAO
!C                                      ! SE ALTURA SERA ALT_nome passado
!c                                      ! SE PREVISAO SERA PREV_nome passado


!c      Variaveis do registro mestre

        integer*2       m1
        character*10    nivel_medio
        character*2     dd1,mm1,dd2,mm2
        character*4     aa1,aa2
        character*5     nr_estacao
        character*38    nome_estacao
        character*2     xlatg,min_lat
        character*1     dec_lat,hem
        character*3     xlong
        character*2     min_lon
        character*1     dec_lon,ori
        character*4     fuso_horario
        CHARACTER*5     FUSO

!c      Variaveis de trabalho

        logical*1       houve_registro
        integer*2       impre
        integer*2       dia_ini, mes_ini, ano_ini, dia_fim, mes_fim, ano_fim
        character*129   aster
        character*125   aster2
        character*9     tab_mes (12)
        logical*1       primeira_vez
        character*13    instituicao
        character*4     carta
        character*80    brancos

!c------------------------------------------------------------------------------

!c      REAL MESA(12),MESB(12),MESC(12),WRIFI(24)
       REAL MESA(12),MESB(12),MESC(12)

        character*4     wrifi (24)
        character*4     br3,br4
        character*4     hora1,minu1,alt1


!c      DIMENSION C(1801),IM(12),P(21)
!c      DIMENSION LM(14),F(180),U(180),Q(180)
!c      DIMENSION F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14),INAUX(14)
!c      DIMENSION AH(9000),KTANO(3300),KTMES(3300),KTDIA(3300)
!c      DIMENSION KTHOR(3300),KTMIN(3300),ATAB(3300)
!c      DIMENSION LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)


        real*4  C(1801),P(21)
        real*4  F(180),U(180),Q(180)
        real*4  F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14)
        real*4  AH(9000),ATAB(3300)
        real*4  aatab
        integer*4       KTHOR(3300),KTMIN(3300)
        integer*4       LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)
        integer*4       im(12),lm(14),inaux(14)
        integer*4       KTANO(3300),KTMES(3300),KTDIA(3300)

        CHARACTER*2     VETDIA (9)
        CHARACTER*2     VETHOR (9)
        CHARACTER*2     VETMIN (9)
        CHARACTER*4     VETALT (9)
        INTEGER*2       IND
        INTEGER*4       DIA_ANT
        REAL*4          AMAXI,AMINI


        CHARACTER*2     AHORA
        CHARACTER*4     AIWAH

        CHARACTER*2     DIA_S,MES_S
        character*4     ANO_S

        INTEGER*2       IWAH(24)

        data tab_mes /' JANEIRO ','FEVEREIRO','  MARCO  ','  ABRIL  ',&
        &             '   MAIO  ','  JUNHO  ','  JULHO  ','  AGOSTO ',&
        &             'SETEMBRO ',' OUTUBRO ','NOVEMBRO ','DEZEMBRO '/




!c------------------------------------------------------------------------------
        

!c      DATA IM/31,28,31,30,31,30,31,31,30,31,30,31/

!C     Q1 FREQUENCIAS, EM GRAUS POR HORA, DAS 37 COMPONENTES ASTRONOMICAS
!C     PRINCIPAIS.

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424078,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265120,&
     &43.4761563/

      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/


        common  /impre/ impre
        common  /relatorio/ houve_registro

!C     INAUX INDICE DAS 14 COMPONENTES ASTRONOMICAS QUE ENTRAM USUALMENTE
!C     NA FORMACAO DAS COMPONENTES DE PEQUENO FUNDO
!C     DELTAT INTERVALO, EM FRACAO DECIMAL DA HORA, ENTRE DUAS ALTURAS
!C     CONSECUTIVAS PREVISTAS. HI,IDIAS,IMES HORA, DIA E MES DO INICIO
!C     DA PREVISAO. NL NUMERO DE MESES DA PREVISAO. APOS A PREVISAO,
!C     EXTREMOS SAO CALCULADOS POR INTERPOLACAO.
!C     DATA DELTAT,HI,IDIAS,IMES,NL/1.,-3.,1,12,14/
!C     IANO ANO DA PREVISAO
!C     JH NUMERO DE PORTOS


!c      Inicializar variaveis




        im (01) = 31
        im (02) = 28    
        im (03) = 31
        im (04) = 30
        im (05) = 31
        im (06) = 30
        im (07) = 31
        im (08) = 31
        im (09) = 30
        im (10) = 31
        im (11) = 30
        im (12) = 31

        DO I = 1,129
                ASTER (I:I) = '*'
        END DO

        DO I = 1,125
                ASTER2 (I:I) = '*'
        END DO


        deltat = 1.0
        hi = -3.0
        idias = 1
        imes = 12
        nl = 14

        brancos = ' '
        instituicao = ' '
        carta = ' '

!c      abertura dos arquivos de saida tanto de alturas como previsao



!c      Abertura do arquivo de ALTURAS  TIPO .XLS
        
                open    (unit = 22, file = arq_prev, status = 'NEW', iostat = ierro)

                !if (ierro .ne. 0) then
                          !type *,'Erro na abertura do arquivo de ALTURAS PREVISTA PARA GRAVACAO'
                          !type *,'Avisar Analista Responsavel'
                          !type *,'Erro numero - ',ierro
                          !stop
                !END IF


!C      Transformar variaveis passadas para a subrotina

!C      MODIFICACOES FEITAS POR CARLOS MAGNO ABREU EM 14/06/2020
!C        decode (2, '(i2)', di ) dia_ini
       READ (di,'(i2)') dia_ini 
!C        decode (2, '(i2)', mi ) mes_ini
       READ (mi,'(i2)') mes_ini
!C        decode (4, '(i4)', ai ) ano_ini
       READ (ai,'(i4)') ano_ini
!C        decode (2, '(i2)', df ) dia_fim
       READ (df,'(i2)') dia_fim
!C        decode (2, '(i2)', mf ) mes_fim
       READ (mf,'(i2)') mes_fim
!C        decode (4, '(i4)', af ) ano_fim
       READ (af,'(i4)') ano_fim
!C        decode (10, '(f10.2)', nivel ) s0
       READ (nivel,'(f10.2)') s0

        SOMET=S0/100.

        iano = ano_ini

!c      Abertura do arquivo de constantes.
        open    (unit = 11, file = arq_const, status = 'old', iostat = ierro)

        !if (ierro .ne. 0) then
          !type *,'Erro na abertura do arquivo de constantes na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ierro
          !close (unit = 11)
          !stop
        !end if

!c      Inicializar jh com o valor de 1 para o loop ser de um porto de cada vez.

        jh = 1



!C     CONSTRUCAO DA TABELA DE COSSENOS C(I), PARA UM INTERVALO DE 0.2 DO
!C     GRAU.
      AR=3.1415926/180.
      AV=AR*DELTAT
      DELTAX=.2*AR
      AA=COS(DELTAX)
      AB=SIN(DELTAX)
      BB=1.
      BC=0.
      C(1)=1.
      DO 3 I=1,1800
      Z=AA*BB-AB*BC
      BC=AB*BB+AA*BC
      BB=Z
    3 C(I+1)=Z
      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)IM(2)=29
      N=(399+IM(2))*24+6
      KANO=IANO-1

!C     CALCULO DOS ARGUMENTOS ASTRONOMICOS E DOS FATORES PERINODAIS DAS
!C     37 COMPONENTES ASTRONOMICAS PRINCIPAIS.

      CALL ASTRO(1,DELTAT,HI,IDIAS,IMES,KANO,N,0,F1,U1,AS)

      DO 4 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    4 CONTINUE


      DO 1500 LI=1,JH
      KANO=IANO-1
      JV=IMES-1


!C-------------------------------------------------------------------------------
!c      Leitura do primeiro registro do arquivo de constantes com os seguintes
!c      campos para processamento
!c
!c      Numero de componentes           = M1 (i3)               = i3
!c      Nivel medio                     = nivel_medio (char*10) = s0 (f10.2)
!c      periodo inicial da analise(DMA) = data_inic char*6      = 
!c      periodo final da analise (DMA)  = data_fim char*6       =
!c      numero da estacao               = nr_estacao char*5     =
!c      nome da estacao                 = nome_estacao char*38  =
!c      grau_da_latitude                = xlatg char*2          = xlatg
!c      minuto_da_latitude              = min_lat char*2        = min_lat
!c      decimo_da_latitude              = dec_lat char*1        = dec_lat
!c      sentido_da_latitude             = hem char*1            = hem
!c      grau_da_longitude               = xlong char*3          = xlong
!c      minuto_da_longitude             = min_lat char*2        = min_lon
!c      decimo_da_longitude             = dec_lat char*1        = dec_lon
!c      sentido_da_longitude            = ori char*1            = ori
!c      fuso_horario                    = fuso_horario char*4   = fuso char*5


        read (unit = 11, fmt = 6000, iostat = ierro_le_1) m1,nivel_medio,dd1,&
        &       mm1,aa1,dd2,mm2,aa2,nr_estacao,nome_estacao,xlatg,min_lat,&
        &       dec_lat,hem,xlong,min_lon,dec_lon,ori,fuso_horario

 6000   format (i3,18a)


        FUSO = FUSO_HORARIO (1:3) // '.' // FUSO_HORARIO (4:4)

!C      modificado por carlos magno abreu em 14/06/2020
!C        decode (10, '(f10.2)', nivel_medio ) s0_anterior
        READ (nivel_medio,'(f10.2)') s0_anterior  

!c------------------------------------------------------------------------------

      DO 30 I=1,M1
!C     IX=1 SE A COMPONENTE FOR ASTRONOMICA E IX=0 SE FOR DE PEQUENO FUN-
!C     DO. IX=2 PARA COMPONENTES ARBITRARIAS.
!C     Q VELOC ANG, LM COMBINACOES, H,G CTES HARM

      READ (11,2) IX,Q(I),(LM(J),J=1,14),H,G
    2 FORMAT(I1,7X,F11.7,14I2,2F8.2)
      IF(1-IX)17,15,16
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ASTRONOMICAS.
   15 DO 5 JK=1,37
      IF(ABS(Q1(JK)-Q(I)).GE..0001)GO TO 5
      F(I)=F1(JK)*H
      U(I)=U1(JK)-G
      GO TO 30
    5 CONTINUE
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES DE PEQUENO FUNDO.
   16 AA=1.
      BB=0.
      DO 6 M=1,14
      AA=AA*F2(M)**IABS(LM(M))
    6 BB=BB+U2(M)*LM(M)
      F(I)=AA*H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
      GO TO 30
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ARBITRARIAS.
   17 BB=0.
      DO 7 J=1,6
    7 BB=BB+AS(J)*LM(J)
      F(I)=H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
   30 Q(I)=Q(I)*DELTAT
      INDEX=0


!C      GRAVACAO DO PRIMEIRO REGISTRO DO ARQUIVO DE ALTURAS ANO COM 4 DIGITOS
!cahf
        write (22,2201) di,mi,ai,df,mf,af,NOME_ESTACAO
2201    format (A2,'/',A2,'/',A4,' A ',A2,'/',A2,'/',A4,' ',A38)

!C-------------------------------------------------------------------------------

!C     CALCULO DAS ALTURAS SUCESSIVAS.

        IND_MES = 0     ! VARIAVEL QUE IDENTIFICA O MES REAL QUE ESTA SENDO
!C                        PROCESSADO 

      DO 1000 LOOP=1,NL
        IND_MES = IND_MES + 1
      JV=JV+1
      IF(JV-12)32,32,9030
 9030 JV=1
      KANO=KANO+1
   32 IH=IM(JV)*24+6
      DO 22 K=1,IH
      S=S0
      DO 23 J=1,M1
      AA=U(J)
      IK=ABS(AA/.2)+1.5
      AA=AA+Q(J)
      U(J)=AA-IFIX(AA/360.)*360.
   23 S=S+C(IK)*F(J)
      AH(K)=S


   22 CONTINUE
      DO 24 I=1,M1
      U(I)=U(I)-6.*Q(I)
      MA=U(I)/360.
      U(I)=U(I)-MA*360.
      IF(U(I).LT.0.)U(I)=U(I)+360.
   24 CONTINUE

!c      relatorio das alturas horarias
!c      so imprime se tipo for diferente de 0

        if ( tipo .ne. '0') then

          if ( ( (ind_mes - 1) .ge. mes_ini ) .and.&
        &       ( (ind_mes - 1) .le. mes_fim )) then
                HOUVE_REGISTRO = .TRUE.
                k1 = 3
                ind1 = im (ind_mes - 1)
                do ind2 = 1, ind1
                        do ind3 = 1,24
                                k1 = k1 + 1
                                iwah (ind3) = int (ah (k1),2)
                        end do
!C                      impressao so dos dias desejados
                        if (mes_ini .eq. mes_fim) then
                           if (ind2 .ge. dia_ini .and. ind2 .le. dia_fim) then
!C                                      write (22,2202) (iwah (l1),l1=1,24)
                                DO K = 1,24
                                        IHORA = K - 1
!C       MODIFICACAO FEITA POR CARLOS MAGNO ABREU EM 14/06/2020										
!C                                        encode (2, '(I2)', AHORA) IHORA
                                        WRITE(AHORA,'(i2)') IHORA
                                        IF (K .LE. 10) AHORA (1:1) = '0'
!C                                        encode (4, '(I4)', AIWAH ) IWAH (K)
                                        WRITE(AIWAH,'(i4)') IWAH (K)
!C                                      TRANFORMAR A DATA EM ALFA PARA GRAVACAO
!C                                        encode (2, '(I2)', DIA_S ) IND2
                                        WRITE(DIA_S,'(i2)') IND2
                                        IF (IND2 .LT. 10) DIA_S (1:1) = '0'
!C                                        encode (2, '(I2)', MES_S) (IND_MES - 1)
                                        WRITE(MES_S,'(i2)') (IND_MES - 1)
                                        IF ((IND_MES - 1).LT.10) MES_S(1:1)='0'
!C                                        encode (4,'(I4)', ANO_S) KANO
                                        WRITE(ANO_S,'(i4)') KANO
                                        WRITE (22,3000) DIA_S,MES_S,ANO_S,AIWAH, AHORA
                                END DO

                           end if
                        else
                           if ( (ind_mes - 1) .eq. mes_ini) then
                                if (ind2 .ge. dia_ini) then
!C                                      write (22,2202) (iwah (l1),l1=1,24)
                                        DO K = 1,24
                                         IHORA = K - 1
!C                                         encode (2, '(I2)', AHORA) IHORA
										 WRITE(AHORA,'(i2)') IHORA
                                         IF (K .LE. 10) AHORA (1:1) = '0'
!C                                         encode (4, '(I4)', AIWAH ) IWAH (K)
										 WRITE(AIWAH,'(i4)') IWAH (K)
!C                                       TRANFORMAR A DATA EM ALFA PARA GRAVACAO
!C                                         encode (2, '(I2)', DIA_S ) IND2
										 WRITE(DIA_S,'(i2)') IND2
                                         IF (IND2 .LT. 10) DIA_S (1:1) = '0'
!C                                         encode (2, '(I2)', MES_S) (IND_MES -1)
										 WRITE(MES_S,'(i2)') (IND_MES - 1)
                                         IF ((IND_MES-1).LT.10) MES_S (1:1)='0'
!C                                         encode (4,'(I4)', ANO_S) KANO
										 WRITE(ANO_S,'(i4)') KANO
                                         WRITE (22,3000) DIA_S,MES_S,ANO_S,AIWAH, AHORA
                                        END DO
                                  end if
                            else
                                  if ((ind_mes - 1) .eq. mes_fim) then
!C                                      GRAVACAO DO MES FINAL
                                     if (ind2 .le. dia_fim) then
!C                                      write (22,2202) (iwah (l1),l1=1,24)
                                        DO K = 1,24
                                         IHORA = K - 1
!C                                         encode (2, '(I2)', AHORA) IHORA
										 WRITE(AHORA,'(i2)') IHORA
                                         IF (K .LE. 10) AHORA (1:1) = '0'
!C                                         encode (4, '(I4)', AIWAH ) IWAH (K)
										 WRITE(AIWAH,'(i4)') IWAH (K)
!C                                       TRANFORMAR A DATA EM ALFA PARA GRAVACAO
!C                                         encode (2, '(I2)', DIA_S ) IND2
										 WRITE(DIA_S,'(i2)') IND2
                                         IF (IND2 .LT. 10) DIA_S (1:1) = '0'
!C                                         encode (2, '(I2)', MES_S) (IND_MES -1)
										 WRITE(MES_S,'(i2)') (IND_MES -1)
                                         IF ((IND_MES-1).LT.10) MES_S(1:1)= '0'
!C                                         encode (4,'(I4)', ANO_S) KANO
										 WRITE(ANO_S,'(i4)') KANO
                                         WRITE (22,3000) DIA_S,MES_S,ANO_S,AIWAH, AHORA
                                        END DO
                                       end if
                                     else
!C                                      write (22,2202) (iwah (l1),l1=1,24)
                                        DO K = 1,24
                                         IHORA = K - 1
!C                                         encode (2, '(I2)', AHORA) IHORA
										 WRITE(AHORA,'(i2)') IHORA
                                         IF (K .LE. 10) AHORA (1:1) = '0'
!C                                         encode (4, '(I4)', AIWAH ) IWAH (K)
										 WRITE(AIWAH,'(i4)') IWAH (K)
!C                                       TRANFORMAR A DATA EM ALFA PARA GRAVACAO
!C                                         encode (2, '(I2)', DIA_S ) IND2
										 WRITE(DIA_S,'(i2)') IND2
                                         IF (IND2 .LT. 10) DIA_S (1:1) = '0'
!C                                         encode (2, '(I2)', MES_S) (IND_MES - 1)
										 WRITE(MES_S,'(i2)') (IND_MES - 1)
                                         IF ((IND_MES-1).LT.10) MES_S(1:1)='0'
!C                                         encode (4,'(I4)', ANO_S) KANO
										 WRITE(ANO_S,'(i4)') KANO
                                         WRITE (22,3000) DIA_S,MES_S,ANO_S,AIWAH, AHORA
                                        END DO
                                       end if
                                    end if
                                end if
                        end do
                end if
        end if

2202    format (24(i4))
!C3000  FORMAT (A4,' ',A2,':00')
3000    FORMAT (A2,'/',A2,'/',A4,' ',A4,' ',A2,':00')
!c--------------------------------------------------------------------
 1000 CONTINUE
 1500 CONTINUE

1501    if (op .eq. 'S') then
                close (unit = 11, status = 'delete')
        else
                close (unit = 11)
        end if


        close (unit = 22)




111     format (t42,'PREAMARES E BAIXAMARES - MES ',a,' - ANO - ',i4,/)
112     format (t3,9('     HORA  ALT'))
113     FORMAT (T5,9('DIA           '))
114     FORMAT (T2,9('       H M   M'))
225     FORMAT (4x,9(A2,' ',A2,A2,' ',A4,'  '))
555     FORMAT (//,21X,'MAXIMA DO MES - DIA   HORA MINUTO     ALTURA')
333     FORMAT (38X,I2,4X,I2,3X,I2,5X,F8.2)
222     FORMAT (21X,'MINIMA DO MES - DIA    HORA MINUTO     ALTURA')
223     FORMAT (/,T38,'OBS: ALTURAS EM METROS EM RELACAO AO NIVEL DE REDUCAO (NR).')
224     FORMAT (/,T38,'OBS: ALTURAS EM METROS EM RELACAO AO ZERO DA REGUA.')


198     format (t19,'PREVISAO DE ALTURAS HORARIAS PARA O PERIODO DE ',A,' DE ',&
        &       A,' DE ',I4,' A ',A,' DE ',A,' DE ',I4,/)

199     FORMAT (T60,A,/)

2001    FORMAT (T3,A)

201     FORMAT (T3,'HORAS *',T131,'*')

202     FORMAT (T4,'*    *    0    1    2    3    4    5    6    7    8    9',&
        &       '   10   11   12   13   14   15   16   17   18   19   20   21',&
        &       '   22   23 *')

203     FORMAT (T5,'*   *',T131,'*')

204     FORMAT (T6,'*  *',T131,'*')

205     FORMAT (T3,'DIAS',A)

354     FORMAT (T5,I2,'  *',24(' ',I4),' *')

355     FORMAT (///,T35,'OBS: ALTURAS EM CENTIMETROS EM RELACAO AO NIVEL DE REDUCAO (NR).')

356     FORMAT (///,T40,'OBS: ALTURAS EM CENTIMETROS EM RELACAO AO ZERO DA REGUA')
1225    format (t5,'*****  ATENCAO NESTE DIA HOUVE MAIS DE NOVE VALORES MAXIMOS E MINIMOS, AVISAR AO ANALISTA RESPONSAVEL. *****')
1226    FORMAT  ('****** ',I2,'/',I2,'/',I2,' ******')
3303    format ('3',i4,i2,i2,i2,9(a2,a2,a4))
3301    format ('1',a,a)





       RETURN
       END


Subroutine PREVISAO_MAXMIN_EXCEL (arq_const,arq_prev,tipo,di,mi,ai,df,mf,af,nivel,op,SIM)

  !DEC$ ATTRIBUTES DLLEXPORT::PREVISAO_MAXMIN_EXCEL


!C     TABUA DE MARES - CALCULOS E IMPRESSAO (tranformado para previsao)
!C     ESTE PROGRAMA CHAMA AS SUB-ROTINAS DE USO COMUM NO SISTEMA DE MARE
!C     ASTRO  
!C     TERP   


!c      Variaveis passadas para a subrotina

        character*150   arq_const               ! nome do arquivo de constantes
        character*1     tipo            ! se = 0 imprime preamar e baixamar
!c                                      ! se = 1 imprime alturas horarias
!c                                      ! se = 2 imprime ambos
        character*2     di,mi,df,mf
        character*4     ai,af
        character*10    nivel   
        character*1     op              ! se s deleta o arquivo de constantes

        CHARACTER*1     SIM             ! DESEJA GRAVAR ARQUIVO DE ALTURA E OU
!C                                      ! PREVISAO.
        CHARACTER*150   arq_prev                ! NOME DO ARQUIVO PARA ALTURA E PREVISAO
!C                                      ! SE ALTURA SERA ALT_nome passado
!c                                      ! SE PREVISAO SERA PREV_nome passado


!c      Variaveis do registro mestre

        integer*2       m1
        character*10    nivel_medio
        character*2     dd1,dd2,mm2,MM1
        character*4     aa1,aa2
        character*5     nr_estacao
        character*38    nome_estacao
        character*2     xlatg,min_lat
        character*1     dec_lat,hem
        character*3     xlong
        character*2     min_lon
        character*1     dec_lon,ori
        character*4     fuso_horario
        CHARACTER*5     FUSO

!c      Variaveis de trabalho

        logical*1       houve_registro
        integer*2       impre
        integer*2       dia_ini, mes_ini, ano_ini, dia_fim, mes_fim, ano_fim
        character*129   aster
        character*125   aster2
        character*9     tab_mes (12)
        logical*1       primeira_vez
        character*80    arq_sai
        character*13    instituicao
        character*4     carta
        character*80    brancos

!c------------------------------------------------------------------------------

!c      REAL MESA(12),MESB(12),MESC(12),WRIFI(24)
       REAL MESA(12),MESB(12),MESC(12)

        character*4     wrifi (24)
        character*4     br3,br4
        character*4     hora1,minu1,alt1


!c      DIMENSION C(1801),IM(12),P(21)
!c      DIMENSION LM(14),F(180),U(180),Q(180)
!c      DIMENSION F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14),INAUX(14)
!c      DIMENSION AH(9000),KTANO(3300),KTMES(3300),KTDIA(3300)
!c      DIMENSION KTHOR(3300),KTMIN(3300),ATAB(3300)
!c      DIMENSION LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)


        real*4  C(1801),P(21)
        real*4  F(180),U(180),Q(180)
        real*4  F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14)
        real*4  AH(9000),ATAB(3300)
        real*4  aatab
        integer*4       KTHOR(3300),KTMIN(3300)
        integer*4       LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)
        integer*4       im(12),lm(14),inaux(14)
        integer*4       KTANO(3300),KTMES(3300),KTDIA(3300)

        CHARACTER*2     VETDIA
        CHARACTER*2     VETHOR
        CHARACTER*2     VETMIN
        CHARACTER*4     VETALT
        character*2     vetmes
        character*4     vetano

        INTEGER*2       IND
        INTEGER*4       DIA_ANT
        REAL*4          AMAXI,AMINI

        INTEGER*2       IWAH(24)

        data tab_mes /' JANEIRO ','FEVEREIRO','  MARCO  ','  ABRIL  ',&
        &             '   MAIO  ','  JUNHO  ','  JULHO  ','  AGOSTO ',&
        &             'SETEMBRO ',' OUTUBRO ','NOVEMBRO ','DEZEMBRO '/




!c------------------------------------------------------------------------------
        

!c      DATA IM/31,28,31,30,31,30,31,31,30,31,30,31/

!C     Q1 FREQUENCIAS, EM GRAUS POR HORA, DAS 37 COMPONENTES ASTRONOMICAS
!C     PRINCIPAIS.

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424078,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265120,&
     &43.4761563/

      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/


        common  /impre/ impre
        common  /relatorio/ houve_registro

!C     INAUX INDICE DAS 14 COMPONENTES ASTRONOMICAS QUE ENTRAM USUALMENTE
!C     NA FORMACAO DAS COMPONENTES DE PEQUENO FUNDO
!C     DELTAT INTERVALO, EM FRACAO DECIMAL DA HORA, ENTRE DUAS ALTURAS
!C     CONSECUTIVAS PREVISTAS. HI,IDIAS,IMES HORA, DIA E MES DO INICIO
!C     DA PREVISAO. NL NUMERO DE MESES DA PREVISAO. APOS A PREVISAO,
!C     EXTREMOS SAO CALCULADOS POR INTERPOLACAO.
!C     DATA DELTAT,HI,IDIAS,IMES,NL/1.,-3.,1,12,14/
!C     IANO ANO DA PREVISAO
!C     JH NUMERO DE PORTOS


!c      Inicializar variaveis




        im (01) = 31
        im (02) = 28    
        im (03) = 31
        im (04) = 30
        im (05) = 31
        im (06) = 30
        im (07) = 31
        im (08) = 31
        im (09) = 30
        im (10) = 31
        im (11) = 30
        im (12) = 31

        DO I = 1,129
                ASTER (I:I) = '*'
        END DO

        DO I = 1,125
                ASTER2 (I:I) = '*'
        END DO


        deltat = 1.0
        hi = -3.0
        idias = 1
        imes = 12
        nl = 14

        brancos = ' '
        instituicao = ' '
        carta = ' '

!c      abertura dos arquivos de saida tanto de alturas como previsao se foi
!c      solicitado pelo usuario



!c              Abertura do arquivo de PREVISAO

                open    (unit = 33, file = arq_prev, status = 'NEW', iostat = ierro)

                !if (ierro .ne. 0) then
                  !type *,'Erro na abertura do arquivo de PREVISAO PARA GRAVACAO'
                  !type *,'Avisar Analista Responsavel'
                  !type *,'Erro numero - ',ierro
                  !stop
                !end if


!C      Transformar variaveis passadas para a subrotina


!C        decode (2, '(i2)', di ) dia_ini
		READ (di,'(i2)') dia_ini
!C        decode (2, '(i2)', mi ) mes_ini
		READ (mi,'(i2)') mes_ini
!C        decode (4, '(i4)', ai ) ano_ini
		READ (ai,'(i4)') ano_ini
!C        decode (2, '(i2)', df ) dia_fim
		READ (df,'(i2)') dia_fim
!C        decode (2, '(i2)', mf ) mes_fim
		READ (mf,'(i2)') mes_fim
!C        decode (4, '(i4)', af ) ano_fim
		READ (af,'(i4)') ano_fim
!C        decode (10, '(f10.2)', nivel ) s0
		READ (nivel,'(f10.2)') s0
        SOMET=S0/100.

        iano = ano_ini

!c      Abertura do arquivo de constantes.
        open    (unit = 11,     file = arq_const, status = 'old', iostat = ierro)

        !if (ierro .ne. 0) then
          !type *,'Erro na abertura do arquivo de constantes na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ierro
          !close (unit = 11)
          !stop
        !end if

!c      Inicializar jh com o valor de 1 para o loop ser de um porto de cada vez.

        jh = 1



!C     CONSTRUCAO DA TABELA DE COSSENOS C(I), PARA UM INTERVALO DE 0.2 DO
!C     GRAU.
      AR=3.1415926/180.
      AV=AR*DELTAT
      DELTAX=.2*AR
      AA=COS(DELTAX)
      AB=SIN(DELTAX)
      BB=1.
      BC=0.
      C(1)=1.
      DO 3 I=1,1800
      Z=AA*BB-AB*BC
      BC=AB*BB+AA*BC
      BB=Z
    3 C(I+1)=Z
      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)IM(2)=29
      N=(399+IM(2))*24+6
      KANO=IANO-1

!C     CALCULO DOS ARGUMENTOS ASTRONOMICOS E DOS FATORES PERINODAIS DAS
!C     37 COMPONENTES ASTRONOMICAS PRINCIPAIS.

      CALL ASTRO(1,DELTAT,HI,IDIAS,IMES,KANO,N,0,F1,U1,AS)

      DO 4 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    4 CONTINUE
      DO 1500 LI=1,JH
      KANO=IANO-1
      JV=IMES-1


!C-------------------------------------------------------------------------------
!c      Leitura do primeiro registro do arquivo de constantes com os seguintes
!c      campos para processamento
!c
!c      Numero de componentes           = M1 (i3)               = i3
!c      Nivel medio                     = nivel_medio (char*10) = s0 (f10.2)
!c      periodo inicial da analise(DMA) = data_inic char*6      = 
!c      periodo final da analise (DMA)  = data_fim char*6       =
!c      numero da estacao               = nr_estacao char*5     =
!c      nome da estacao                 = nome_estacao char*38  =
!c      grau_da_latitude                = xlatg char*2          = xlatg
!c      minuto_da_latitude              = min_lat char*2        = min_lat
!c      decimo_da_latitude              = dec_lat char*1        = dec_lat
!c      sentido_da_latitude             = hem char*1            = hem
!c      grau_da_longitude               = xlong char*3          = xlong
!c      minuto_da_longitude             = min_lat char*2        = min_lon
!c      decimo_da_longitude             = dec_lat char*1        = dec_lon
!c      sentido_da_longitude            = ori char*1            = ori
!c      fuso_horario                    = fuso_horario char*4   = fuso char*5


        read (unit = 11, fmt = 6000, iostat = ierro_le_1) m1,nivel_medio,dd1,&
        &       mm1,aa1,dd2,mm2,aa2,nr_estacao,nome_estacao,xlatg,min_lat,&
        &       dec_lat,hem,xlong,min_lon,dec_lon,ori,fuso_horario

 6000   format (i3,18a)

        FUSO = FUSO_HORARIO (1:3) // '.' // FUSO_HORARIO (4:4)

!C        decode (10, '(f10.2)', nivel_medio ) s0_anterior
		READ (nivel_medio,'(f10.2)') s0_anterior
!c------------------------------------------------------------------------------

      DO 30 I=1,M1
!C     IX=1 SE A COMPONENTE FOR ASTRONOMICA E IX=0 SE FOR DE PEQUENO FUN-
!C     DO. IX=2 PARA COMPONENTES ARBITRARIAS.
!C     Q VELOC ANG, LM COMBINACOES, H,G CTES HARM

      READ (11,2) IX,Q(I),(LM(J),J=1,14),H,G
    2 FORMAT(I1,7X,F11.7,14I2,2F8.2)
      IF(1-IX)17,15,16
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ASTRONOMICAS.
   15 DO 5 JK=1,37
      IF(ABS(Q1(JK)-Q(I)).GE..0001)GO TO 5
      F(I)=F1(JK)*H
      U(I)=U1(JK)-G
      GO TO 30
    5 CONTINUE
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES DE PEQUENO FUNDO.
   16 AA=1.
      BB=0.
      DO 6 M=1,14
      AA=AA*F2(M)**IABS(LM(M))
    6 BB=BB+U2(M)*LM(M)
      F(I)=AA*H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
      GO TO 30
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ARBITRARIAS.
   17 BB=0.
      DO 7 J=1,6
    7 BB=BB+AS(J)*LM(J)
      F(I)=H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
   30 Q(I)=Q(I)*DELTAT
      INDEX=0


!C-------------------------------------------------------------------------------

!C     CALCULO DAS ALTURAS SUCESSIVAS.

        IND_MES = 0     ! VARIAVEL QUE IDENTIFICA O MES REAL QUE ESTA SENDO
!C                        PROCESSADO 

      DO 1000 LOOP=1,NL
        IND_MES = IND_MES + 1
      JV=JV+1
      IF(JV-12)32,32,9030
 9030 JV=1
      KANO=KANO+1
   32 IH=IM(JV)*24+6
      DO 22 K=1,IH
      S=S0
      DO 23 J=1,M1
      AA=U(J)
      IK=ABS(AA/.2)+1.5
      AA=AA+Q(J)
      U(J)=AA-IFIX(AA/360.)*360.
   23 S=S+C(IK)*F(J)
      AH(K)=S


   22 CONTINUE
      DO 24 I=1,M1
      U(I)=U(I)-6.*Q(I)
      MA=U(I)/360.
      U(I)=U(I)-MA*360.
      IF(U(I).LT.0.)U(I)=U(I)+360.
   24 CONTINUE

!c--------------------------------------------------------------------
!C

        if (tipo .eq. '1') go to 1000   ! SO IMPRIME ALTURAS

!c      RELATORIO DE PREAMARES E BAIXAMARES
!C      SO PASSARA POR AQUI SE TIPO FOR DIFERENTE DE 1

!c-----------------------------------------------------------------------
!C     CALCULO POR INTERPOL DE DATAS E ALTURAS DE PREAMARES E BAIXAMARES
      IL=IH-3
      M=0
      ALT=S0
      DO 160 I=4,IL
      IF(AH(I-1).LE.AH(I).AND.AH(I).GE.AH(I+1))M=I
      IF(AH(I-1).GE.AH(I).AND.AH(I).LE.AH(I+1))M=I
      IF(I-M)160,99,160
   99 CALL TERP(AH,M,3,P)
      DO 100 J=4,18
      IF(P(J-1).LE.P(J).AND.P(J).GE.P(J+1))JJ=J
      IF(P(J-1).GE.P(J).AND.P(J).LE.P(J+1))JJ=J
  100 CONTINUE
      CALL TERP(P,JJ,2,P)
      DO 110 K=4,10
      IF(P(K-1).LE.P(K).AND.P(K).GE.P(K+1))KK=K
      IF(P(K-1).GE.P(K).AND.P(K).LE.P(K+1))KK=K
  110 CONTINUE
      HORA=M-4-1.4375+(JJ-1)*.125+(KK-1)*.03125
      IHORA=HORA
      MIN=(HORA-IHORA)*60.+.5
      IDIA=IHORA/24+1
      IHORA=MOD(IHORA,24)
      IF(ABS(ALT-P(KK)).LT.0.5.OR.IHORA.LT.0)GO TO 160
      ALT=P(KK)
      INDEX=INDEX+1
      KTANO(INDEX)=KANO
      KTMES(INDEX)=JV
      KTDIA(INDEX)=IDIA
      KTHOR(INDEX)=IHORA
      KTMIN(INDEX)=MIN
      ATAB(INDEX)=ALT
  160 CONTINUE
 1000 CONTINUE

!C      NESTA PARTE SO SERA EXECUTADO SE TIPO FOR DIFERENTE DE 1

        if (tipo .eq. '1') go to 1501   ! SO IMPRIME ALTURAS

!C      A PARTIR DAQUI JA ESTAO CALCULADOS TODAS AS PREAMEARES E BAIXAMARES

!C      Altercao feita em 17/09/90 para que ao encontrar o minuto negativo
!c      nao altere a data de janeiro para dezembro.
!c
!C     CORRECAO DE MINUTOS NEGATIVOS
!c      MADEX=INDEX
!c      DO 1100 INDEX=1,MADEX
!c      IF(KTMIN(INDEX))1010,1100,1100
!c 1010 IF(KTMES(INDEX)-1)1020,1020,1040
!c 1020 KTANO(INDEX)=KTANO(INDEX)-1
!c      KTMES(INDEX)=12
!c      KTDIA(INDEX)=31
!c      GO TO 1050
!c 1040 JV=KTMES(INDEX)-1
!c      KTMES(INDEX)=JV
!c      KTDIA(INDEX)=IM(JV)
!c 1050 KTHOR(INDEX)=23
!c      KTMIN(INDEX)=KTMIN(INDEX)+60
!c 1100 CONTINUE


!C     CORRECAO DE MINUTOS NEGATIVOS

      MADEX=INDEX

        do index = 1, madex
                if (ktmin (index) .lt. 0) then
                        if (ktmes (index) .eq. 1) then
                                ktdia (index) = 1
                                kthor (index) = 0
                                ktmin (index) = 0
                        else
                                jv = ktmes (index) - 1
                                ktmes (index) = jv
                                ktdia (index) = im (jv)
                                kthor (index) = 23
                                ktmin (index) = ktmin (index) + 60
                        end if
                end if
        end do


!C     AJUSTE DE INDICES E CONVERSAO DOS EXTREMOS EM METROS.
      DO 1120 INDEX=1,MADEX
      IF(KTANO(INDEX)-IANO)1120,1150,1150
 1120 CONTINUE
 1150 INDIN=INDEX
      DO 1170 INDEX=INDIN,MADEX
      IF(KTANO(INDEX)-IANO)1170,1170,1190
 1170 CONTINUE
 1190 INDFI=INDEX-1
      INDEX=0
      DO 1200 M=INDIN,INDFI
      INDEX=INDEX+1
      KTANO(INDEX)=KTANO(M)
      KTMES(INDEX)=KTMES(M)
      KTDIA(INDEX)=KTDIA(M)
      KTHOR(INDEX)=KTHOR(M)
      KTMIN(INDEX)=KTMIN(M)
      ATAB (INDEX)=ATAB (M)
!c------------------------------------------------------------------------------
!c       ATAB(INDEX)=ATAB(M)/100.
!c      substituido para tirar o sinal do -0.0
!c      AHF 30/04/87
!c
!c      atab (index) = aint (atab (m) / 10.) / 10.
!c------------------------------------------------------------------------------

 1200 CONTINUE

!c      MADEX=INDEX

!c      Loop para gravacao das preamares e baixamares

!C      gravar os cabecalhos

        write (33,3301) nome_estacao,brancos (1:42)
3301    format (a,a)
        write (33,3302) xlatg,min_lat,dec_lat,&
        &               hem,xlong,min_lon,dec_lon,ori,&
        &               FUSO,instituicao,somet,carta,m1,&
        &               dd1,mm1,aa1,dd2,mm2,aa2,brancos (1:16)
3302    format (a,a,'.',a,a,a,a,'.',a,a,a,a,f5.2,a,i3,7(a))


        primeira_vez = .true.

        do i = 1, index

                if (ktmes (i) .ge. mes_ini .and. ktmes (i) .le. mes_fim) then
                        if (ktdia (i) .ge. dia_ini .and. ktdia (i) .le. dia_fim) then
!C          MODIFICACAO FEITA POR CARLOS MAGNO ABREU EM 14/06/2020                        
!C                                encode (4,'(I4)', VETano  ) KTANO (I)
								WRITE(VETano,'(i4)') KTANO (I)
!C                                encode (2,'(I2)', VETmes  ) KTMES (I)
								WRITE(VETmes,'(i2)') KTMES (I)
!C                                encode (2,'(I2)', VETDIA  ) KTDIA (I)
                                WRITE(VETDIA,'(i2)') KTDIA (I)
!C                                encode (2,'(I2)', VETHOR  ) KTHOR (I)
                                WRITE(VETHOR,'(i2)') KTHOR (I)
!C                                encode (2,'(I2)', VETMIN  ) KTMIN (I)
                                WRITE(VETMIN,'(i2)') KTMIN (I)
                                AATAB = (ATAB (I) /10.) / 10.
!C                                encode (4,'(F4.1)', VETALT  ) AATAB
                                WRITE(VETALT,'(f4.2)') AATAB

                                IF (KTHOR (I) .lt. 10) VETHOR (1:1) = '0'
                                IF (KTMIN (I) .LT. 10) VETMIN (1:1) = '0'
                                if (ktmes (i) .lt. 10) vetmes (1:1) = '0'
                                if (ktdia (i) .lt. 10) vetdia (1:1) = '0'
        
                                write (33,4303) vetdia,vetmes,vetano,vethor,vetmin,vetalt
                        end if
                end if
        end do


 1500 CONTINUE

1501    if (op .eq. 'S') then
                close (unit = 11, status = 'delete')
        else
                close (unit = 11)
        end if

 4303   format (a2,'/',a2,'/',a4,' ',a2,':',a2,' ',a4,59x)

        close (unit = 33)



       RETURN
       END


Subroutine PREVISAO_DISQUETE (arq_const,arq_prev_alt,arq_prev_maxmin,tipo,di,mi,ai,df,mf,af,nivel,op)

  !DEC$ ATTRIBUTES DLLEXPORT::PREVISAO_DISQUETE


!C     TABUA DE MARES - CALCULOS E IMPRESSAO (tranformado para previsao)
!C     ESTE PROGRAMA CHAMA AS SUB-ROTINAS DE USO COMUM NO SISTEMA DE MARE
!C     ASTRO  
!C     TERP   


!c      Variaveis passadas para a subrotina

        character*150   arq_const               ! nome do arquivo de constantes
        character*1     tipo            ! se = 0 imprime preamar e baixamar
!c                                      ! se = 1 imprime alturas horarias
!c                                      ! se = 2 imprime ambos
        character*2     di,mi,df,mf
        character*4     ai,af
        character*10    nivel   
        character*1     op              ! se s deleta o arquivo de constantes

!C                                      ! PREVISAO.
        character*150   arq_prev_alt            ! NOME DO ARQUIVO PARA ALTURA
        character*150   arq_prev_maxmin     ! NOME DO ARQUIVO PARA MÁXIMAS E MÍNIMAS
!C                                      


!c      Variaveis do registro mestre

        integer*2       m1
        character*10    nivel_medio
        character*2     dd1,mm1,dd2,mm2
        CHARACTER*4     AA1,AA2
        character*5     nr_estacao
        character*38    nome_estacao
        character*2     xlatg,min_lat
        character*1     dec_lat,hem
        character*3     xlong
        character*2     min_lon
        character*1     dec_lon,ori
        character*4     fuso_horario
        CHARACTER*5     FUSO

!c      Variaveis de trabalho

        logical*1       houve_registro
        integer*2       impre
        integer*2       dia_ini, mes_ini, ano_ini, dia_fim, mes_fim, ano_fim
        character*129   aster
        character*125   aster2
        character*9     tab_mes (12)
        logical*1       primeira_vez
        character*13    instituicao
        character*4     carta
        character*80    brancos

!c------------------------------------------------------------------------------

!c      REAL MESA(12),MESB(12),MESC(12),WRIFI(24)
       REAL MESA(12),MESB(12),MESC(12)

        character*4     wrifi (24)
        character*4     br3,br4
        character*4     hora1,minu1,alt1


!c      DIMENSION C(1801),IM(12),P(21)
!c      DIMENSION LM(14),F(180),U(180),Q(180)
!c      DIMENSION F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14),INAUX(14)
!c      DIMENSION AH(9000),KTANO(3300),KTMES(3300),KTDIA(3300)
!c      DIMENSION KTHOR(3300),KTMIN(3300),ATAB(3300)
!c      DIMENSION LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)


        real*4  C(1801),P(21)
        real*4  F(180),U(180),Q(180)
        real*4  F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14)
        real*4  AH(9000),ATAB(3300)
        real*4  aatab
        integer*4       KTHOR(3300),KTMIN(3300)
        integer*4       LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)
        integer*4       im(12),lm(14),inaux(14)
        integer*4       KTANO(3300),KTMES(3300),KTDIA(3300)

        CHARACTER*2     VETDIA (9)
        CHARACTER*2     VETHOR (9)
        CHARACTER*2     VETMIN (9)
        CHARACTER*4     VETALT (9)
        INTEGER*2       IND
        INTEGER*4       DIA_ANT
        REAL*4          AMAXI,AMINI

        INTEGER*2       IWAH(24)

        data tab_mes /' JANEIRO ','FEVEREIRO','  MARCO  ','  ABRIL  ',&
        &             '   MAIO  ','  JUNHO  ','  JULHO  ','  AGOSTO ',&
        &             'SETEMBRO ',' OUTUBRO ','NOVEMBRO ','DEZEMBRO '/




!c------------------------------------------------------------------------------
        

!c      DATA IM/31,28,31,30,31,30,31,31,30,31,30,31/

!C     Q1 FREQUENCIAS, EM GRAUS POR HORA, DAS 37 COMPONENTES ASTRONOMICAS
!C     PRINCIPAIS.

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424078,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265120,&
     &43.4761563/

      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/


        common  /impre/ impre
        common  /relatorio/ houve_registro

!C     INAUX INDICE DAS 14 COMPONENTES ASTRONOMICAS QUE ENTRAM USUALMENTE
!C     NA FORMACAO DAS COMPONENTES DE PEQUENO FUNDO
!C     DELTAT INTERVALO, EM FRACAO DECIMAL DA HORA, ENTRE DUAS ALTURAS
!C     CONSECUTIVAS PREVISTAS. HI,IDIAS,IMES HORA, DIA E MES DO INICIO
!C     DA PREVISAO. NL NUMERO DE MESES DA PREVISAO. APOS A PREVISAO,
!C     EXTREMOS SAO CALCULADOS POR INTERPOLACAO.
!C     DATA DELTAT,HI,IDIAS,IMES,NL/1.,-3.,1,12,14/
!C     IANO ANO DA PREVISAO
!C     JH NUMERO DE PORTOS


!c      Inicializar variaveis




        im (01) = 31
        im (02) = 28    
        im (03) = 31
        im (04) = 30
        im (05) = 31
        im (06) = 30
        im (07) = 31
        im (08) = 31
        im (09) = 30
        im (10) = 31
        im (11) = 30
        im (12) = 31

        DO I = 1,129
                ASTER (I:I) = '*'
        END DO

        DO I = 1,125
                ASTER2 (I:I) = '*'
        END DO


        deltat = 1.0
        hi = -3.0
        idias = 1
        imes = 12
        nl = 14

        brancos = ' '
        instituicao = ' '
        carta = ' '

!c      abertura dos arquivos de saida tanto de alturas como previsao



          if (tipo .eq. '2') then

!c              Abertura do arquivo de alturas

        open    (unit = 22, file = arq_prev_alt, status = 'NEW', iostat = ierro)

                !if (ierro .ne. 0) then
                  !type *,'Erro na abertura do arquivo de ALTURAS PARA GRAVACAO'
                  !type *,'Avisar Analista Responsavel'
                  !type *,'Erro numero - ',ierro
                  !stop
                !end if


!c              Abertura do arquivo de PREVISAO

                open    (unit = 33, file = arq_prev_maxmin, status = 'NEW', iostat = ierro)

                !if (ierro .ne. 0) then
                  !type *,'Erro na abertura do arquivo de PREVISAO PARA GRAVACAO'
                  !type *,'Avisar Analista Responsavel'
                  !type *,'Erro numero - ',ierro
                  !stop
                !end if
          else
                if (tipo .eq. '1') then 
!c                      Abertura do arquivo de ALTURAS
        
                        open    (unit = 22, file = arq_prev_alt, status = 'NEW', iostat = ierro)

                        !if (ierro .ne. 0) then
                          !type *,'Erro na abertura do arquivo de PREVISAO PARA GRAVACAO'
                          !type *,'Avisar Analista Responsavel'
                          !type *,'Erro numero - ',ierro
                          !stop
                        !end if
                else
!c                      Abertura do arquivo de PREVISAO

                        open    (unit = 33, file = arq_prev_maxmin, status = 'NEW', iostat = ierro)

                        !if (ierro .ne. 0) then
                          !type *,'Erro na abertura do arquivo de ALTURAS PARA GRAVACAO'
                          !type *,'Avisar Analista Responsavel'
                          !type *,'Erro numero - ',ierro
                          !stop
                        !end if
                end if
          end if



!C      Transformar variaveis passadas para a subrotina


!C        decode (2, '(i2)', di ) dia_ini
		READ (di,'(i2)') dia_ini
!C        decode (2, '(i2)', mi ) mes_ini
		READ (mi,'(i2)') mes_ini
!C        decode (4, '(i4)', ai ) ano_ini
		READ (ai,'(i4)') ano_ini
!C        decode (2, '(i2)', df ) dia_fim
		READ (df,'(i2)') dia_fim
!C        decode (2, '(i2)', mf ) mes_fim
		READ (mf,'(i2)') mes_fim
!C        decode (4, '(i4)', af ) ano_fim
		READ (af,'(i4)') ano_fim
!C        decode (10, '(f10.2)', nivel ) s0
		READ (nivel,'(f10.2)') s0
        SOMET=S0/100.

        iano = ano_ini

!c      Abertura do arquivo de constantes.
        open    (unit = 11, file = arq_const, status = 'old', iostat = ierro)

        !if (ierro .ne. 0) then
          !type *,'Erro na abertura do arquivo de constantes na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ierro
          !close (unit = 11)
          !stop
        !end if

!c      Inicializar jh com o valor de 1 para o loop ser de um porto de cada vez.

        jh = 1



!C     CONSTRUCAO DA TABELA DE COSSENOS C(I), PARA UM INTERVALO DE 0.2 DO
!C     GRAU.
      AR=3.1415926/180.
      AV=AR*DELTAT
      DELTAX=.2*AR
      AA=COS(DELTAX)
      AB=SIN(DELTAX)
      BB=1.
      BC=0.
      C(1)=1.
      DO 3 I=1,1800
      Z=AA*BB-AB*BC
      BC=AB*BB+AA*BC
      BB=Z
    3 C(I+1)=Z
      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)IM(2)=29
      N=(399+IM(2))*24+6
      KANO=IANO-1

!C     CALCULO DOS ARGUMENTOS ASTRONOMICOS E DOS FATORES PERINODAIS DAS
!C     37 COMPONENTES ASTRONOMICAS PRINCIPAIS.

      CALL ASTRO(1,DELTAT,HI,IDIAS,IMES,KANO,N,0,F1,U1,AS)

      DO 4 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    4 CONTINUE
      DO 1500 LI=1,JH
      KANO=IANO-1
      JV=IMES-1


!C-------------------------------------------------------------------------------
!c      Leitura do primeiro registro do arquivo de constantes com os seguintes
!c      campos para processamento
!c
!c      Numero de componentes           = M1 (i3)               = i3
!c      Nivel medio                     = nivel_medio (char*10) = s0 (f10.2)
!c      periodo inicial da analise(DMA) = data_inic char*6      = 
!c      periodo final da analise (DMA)  = data_fim char*6       =
!c      numero da estacao               = nr_estacao char*5     =
!c      nome da estacao                 = nome_estacao char*38  =
!c      grau_da_latitude                = xlatg char*2          = xlatg
!c      minuto_da_latitude              = min_lat char*2        = min_lat
!c      decimo_da_latitude              = dec_lat char*1        = dec_lat
!c      sentido_da_latitude             = hem char*1            = hem
!c      grau_da_longitude               = xlong char*3          = xlong
!c      minuto_da_longitude             = min_lat char*2        = min_lon
!c      decimo_da_longitude             = dec_lat char*1        = dec_lon
!c      sentido_da_longitude            = ori char*1            = ori
!c      fuso_horario                    = fuso_horario char*4   = fuso char*5


        read (unit = 11, fmt = 6000, iostat = ierro_le_1) m1,nivel_medio,dd1,&
        &       mm1,aa1,dd2,mm2,aa2,nr_estacao,nome_estacao,xlatg,min_lat,&
        &       dec_lat,hem,xlong,min_lon,dec_lon,ori,fuso_horario

 6000   format (i3,18a)


        FUSO = FUSO_HORARIO (1:3) // '.' // FUSO_HORARIO (4:4)

!C        decode (10, '(f10.2)', nivel_medio ) s0_anterior
		READ (nivel_medio,'(f10.2)') s0_anterior

!c------------------------------------------------------------------------------

      DO 30 I=1,M1
!C     IX=1 SE A COMPONENTE FOR ASTRONOMICA E IX=0 SE FOR DE PEQUENO FUN-
!C     DO. IX=2 PARA COMPONENTES ARBITRARIAS.
!C     Q VELOC ANG, LM COMBINACOES, H,G CTES HARM

      READ (11,2) IX,Q(I),(LM(J),J=1,14),H,G
    2 FORMAT(I1,7X,F11.7,14I2,2F8.2)
      IF(1-IX)17,15,16
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ASTRONOMICAS.
   15 DO 5 JK=1,37
      IF(ABS(Q1(JK)-Q(I)).GE..0001)GO TO 5
      F(I)=F1(JK)*H
      U(I)=U1(JK)-G
      GO TO 30
    5 CONTINUE
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES DE PEQUENO FUNDO.
   16 AA=1.
      BB=0.
      DO 6 M=1,14
      AA=AA*F2(M)**IABS(LM(M))
    6 BB=BB+U2(M)*LM(M)
      F(I)=AA*H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
      GO TO 30
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ARBITRARIAS.
   17 BB=0.
      DO 7 J=1,6
    7 BB=BB+AS(J)*LM(J)
      F(I)=H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
   30 Q(I)=Q(I)*DELTAT
      INDEX=0


!C      GRAVACAO DO PRIMEIRO REGISTRO DO ARQUIVO DE ALTURAS
!cahf
                if (tipo .ne. '0') then
                        write (22,2201) nr_estacao,di,mi,ai,df,mf,af,&
        &               nome_estacao,xlatg,min_lat,dec_lat,hem,xlong,min_lon,&
        &               dec_lon,ori,FUSO_HORARIO,brancos (1:20)
                end if
2201    format (18(a))

!C-------------------------------------------------------------------------------

!C     CALCULO DAS ALTURAS SUCESSIVAS.

        IND_MES = 0     ! VARIAVEL QUE IDENTIFICA O MES REAL QUE ESTA SENDO
!C                        PROCESSADO 

      DO 1000 LOOP=1,NL
        IND_MES = IND_MES + 1
      JV=JV+1
      IF(JV-12)32,32,9030
 9030 JV=1
      KANO=KANO+1
   32 IH=IM(JV)*24+6
      DO 22 K=1,IH
      S=S0
      DO 23 J=1,M1
      AA=U(J)
      IK=ABS(AA/.2)+1.5
      AA=AA+Q(J)
      U(J)=AA-IFIX(AA/360.)*360.
   23 S=S+C(IK)*F(J)
      AH(K)=S


   22 CONTINUE
      DO 24 I=1,M1
      U(I)=U(I)-6.*Q(I)
      MA=U(I)/360.
      U(I)=U(I)-MA*360.
      IF(U(I).LT.0.)U(I)=U(I)+360.
   24 CONTINUE

!c      relatorio das alturas horarias
!c      so imprime se tipo for diferente de 0

        if ( tipo .ne. '0') then

                if ( ( (ind_mes - 1) .ge. mes_ini ) .and.&
        &            ( (ind_mes - 1) .le. mes_fim )) then
                        HOUVE_REGISTRO = .TRUE.

                        k1 = 3
                        ind1 = im (ind_mes - 1)
                        do ind2 = 1, ind1
                                do ind3 = 1,24
                                        k1 = k1 + 1
                                        iwah (ind3) = int (ah (k1),2)
                                end do
!C                              impressao so dos dias desejados
                                if (mes_ini .eq. mes_fim) then
                                  if (ind2 .ge. dia_ini .and. ind2 .le. dia_fim) then
                                        write (22,2202) (iwah (l1),l1=1,24)
                                  end if
                                else
                                    if ( (ind_mes - 1) .eq. mes_ini) then
                                          if (ind2 .ge. dia_ini) then
                                                write (22,2202) (iwah (l1),l1=1,24)
                                          end if
                                    else
                                        if ((ind_mes - 1) .eq. mes_fim) then
                                           if (ind2 .le. dia_fim) then
                                                  write (22,2202) (iwah (l1),l1=1,24)
                                           end if
                                        else
                                                   write (22,2202) (iwah (l1),l1=1,24)
                                        end if
                                    end if
                                end if
                        end do
2202    format (24(i4))
                end if
        end if
!c--------------------------------------------------------------------
!C

        if (tipo .eq. '1') go to 1000   ! SO IMPRIME ALTURAS

!c      RELATORIO DE PREAMARES E BAIXAMARES
!C      SO PASSARA POR AQUI SE TIPO FOR DIFERENTE DE 1

!c-----------------------------------------------------------------------
!C     CALCULO POR INTERPOL DE DATAS E ALTURAS DE PREAMARES E BAIXAMARES
      IL=IH-3
      M=0
      ALT=S0
      DO 160 I=4,IL
      IF(AH(I-1).LE.AH(I).AND.AH(I).GE.AH(I+1))M=I
      IF(AH(I-1).GE.AH(I).AND.AH(I).LE.AH(I+1))M=I
      IF(I-M)160,99,160
   99 CALL TERP(AH,M,3,P)
      DO 100 J=4,18
      IF(P(J-1).LE.P(J).AND.P(J).GE.P(J+1))JJ=J
      IF(P(J-1).GE.P(J).AND.P(J).LE.P(J+1))JJ=J
  100 CONTINUE
      CALL TERP(P,JJ,2,P)
      DO 110 K=4,10
      IF(P(K-1).LE.P(K).AND.P(K).GE.P(K+1))KK=K
      IF(P(K-1).GE.P(K).AND.P(K).LE.P(K+1))KK=K
  110 CONTINUE
      HORA=M-4-1.4375+(JJ-1)*.125+(KK-1)*.03125
      IHORA=HORA
      MIN=(HORA-IHORA)*60.+.5
      IDIA=IHORA/24+1
      IHORA=MOD(IHORA,24)
      IF(ABS(ALT-P(KK)).LT.0.5.OR.IHORA.LT.0)GO TO 160
      ALT=P(KK)
      INDEX=INDEX+1
      KTANO(INDEX)=KANO
      KTMES(INDEX)=JV
      KTDIA(INDEX)=IDIA
      KTHOR(INDEX)=IHORA
      KTMIN(INDEX)=MIN
      ATAB(INDEX)=ALT
  160 CONTINUE
 1000 CONTINUE

!C      NESTA PARTE SO SERA EXECUTADO SE TIPO FOR DIFERENTE DE 1

        if (tipo .eq. '1') go to 1501   ! SO IMPRIME ALTURAS

!C      A PARTIR DAQUI JA ESTAO CALCULADOS TODAS AS PREAMEARES E BAIXAMARES

!C      Altercao feita em 17/09/90 para que ao encontrar o minuto negativo
!c      nao altere a data de janeiro para dezembro.
!c
!C     CORRECAO DE MINUTOS NEGATIVOS
!c      MADEX=INDEX
!c      DO 1100 INDEX=1,MADEX
!c      IF(KTMIN(INDEX))1010,1100,1100
!c 1010 IF(KTMES(INDEX)-1)1020,1020,1040
!c 1020 KTANO(INDEX)=KTANO(INDEX)-1
!c      KTMES(INDEX)=12
!c      KTDIA(INDEX)=31
!c      GO TO 1050
!c 1040 JV=KTMES(INDEX)-1
!c      KTMES(INDEX)=JV
!c      KTDIA(INDEX)=IM(JV)
!c 1050 KTHOR(INDEX)=23
!c      KTMIN(INDEX)=KTMIN(INDEX)+60
!c 1100 CONTINUE


!C     CORRECAO DE MINUTOS NEGATIVOS

      MADEX=INDEX

        do index = 1, madex
                if (ktmin (index) .lt. 0) then
                        if (ktmes (index) .eq. 1) then
                                ktdia (index) = 1
                                kthor (index) = 0
                                ktmin (index) = 0
                        else
                                jv = ktmes (index) - 1
                                ktmes (index) = jv
                                ktdia (index) = im (jv)
                                kthor (index) = 23
                                ktmin (index) = ktmin (index) + 60
                        end if
                end if
        end do


!C     AJUSTE DE INDICES E CONVERSAO DOS EXTREMOS EM METROS.
      DO 1120 INDEX=1,MADEX
      IF(KTANO(INDEX)-IANO)1120,1150,1150
 1120 CONTINUE
 1150 INDIN=INDEX
      DO 1170 INDEX=INDIN,MADEX
      IF(KTANO(INDEX)-IANO)1170,1170,1190
 1170 CONTINUE
 1190 INDFI=INDEX-1
      INDEX=0
      DO 1200 M=INDIN,INDFI
      INDEX=INDEX+1
      KTANO(INDEX)=KTANO(M)
      KTMES(INDEX)=KTMES(M)
      KTDIA(INDEX)=KTDIA(M)
      KTHOR(INDEX)=KTHOR(M)
      KTMIN(INDEX)=KTMIN(M)
      ATAB (INDEX)=ATAB (M)
!c------------------------------------------------------------------------------
!c       ATAB(INDEX)=ATAB(M)/100.
!c      substituido para tirar o sinal do -0.0
!c      AHF 30/04/87
!c
!c      atab (index) = aint (atab (m) / 10.) / 10.
!c------------------------------------------------------------------------------

 1200 CONTINUE

!c      MADEX=INDEX

!c      Loop para impressao das preamares e baixamares



        primeira_vez = .true.
        do i = 1, index
                if (ktmes (i) .ge. mes_ini .and. ktmes (i) .le. mes_fim) then
                        if (primeira_vez) then
                                houve_registro = .true.
                                mes_ant = ktmes (i)
                                amaxi = 0.0
                                amini = 999.99
                                ind = 0
                                dia_ant = ktdia (i)
                                primeira_vez = .false.

!C      gravar as previsoes
                                write (33,3301) nome_estacao,brancos (1:57)

                                write (33,3302) xlatg,min_lat,dec_lat,&
        &                               hem,xlong,min_lon,dec_lon,ori,&
        &                               FUSO,instituicao,somet,carta,m1,&
        &                               dd1,mm1,aa1,dd2,mm2,aa2,brancos (1:34)

                        end if
3302    format ('2',a,a,'.',a,a,a,a,'.',a, a, a,a,f5.2,a,i3,7(a))


!c                      quebra do mes e gravacao do ultimo dia do mes

                        if (ktmes (i) .ne. mes_ant) then

                                write (33,3303) kiano , mes_ant, dia_ant,&
        &                       ind, (vethor(j),vetmin(j),vetalt(j), j = 1,ind)

                                amaxii = amaxi / 100
                                aminii = amini / 100
                                mes_ant = ktmes (i)
                                amaxi = 0.0
                                amini = 999.99
                                ind = 0
                                dia_ant = ktdia (i)
                        end if

!c                      if (atab (i) .gt. amaxi) then
!c                              amaxi = atab (i)
!c                              idima = ktdia (i)
!c                              ihoma = kthor (i)
!c                              imima = ktmin (i)
!c                      end if
!c                      if (atab (i) .lt. amini) then
!c                              amini = atab (i)
!c                              idimi = ktdia (i)
!c                              ihomi = kthor (i)
!c                              imimi = ktmin (i)
!c                      end if
        


                        IF (KTDIA (I) .NE. DIA_ANT) THEN
!C                              ALTERCAO FEITA EM 25/10/91 PARA FAZER UMA
!C                              PREVISAO PARA 1831 DESTE MODO DA VALOR NEGATIVO.
!C                              kiano = ktano (i) - 1900

!c      alteracao feita em 20/10/98 para gravar o ano com 4 digitos
!c              essas linhas serao eliminadas
!c                              KIANO = KTANO (I) / 100
!c                              KIANO = KIANO * 100
!c                              KIANO = KTANO (I) - KIANO

                                kiano = ktano (i)

!c------------------------------------------------------------------------

                                write (33,3303) kiano , ktmes (i), dia_ant,&
        &                       ind, (vethor(j),vetmin(j),vetalt(j), j = 1,ind)
                        
                                DIA_ANT = KTDIA (I)
                                IND = 0
                                DO K = 1, 9
                                        VETDIA (K) = ' '
                                        VETHOR (K) = ' '
                                        VETMIN (K) = ' '
                                        VETALT (K) = ' '
                                END DO
                        END IF
                        IND = IND + 1
                        IF (IND .GT. 9) THEN
                                write (6,1225)
                                WRITE (6,1226) KTDIA(I),KTMES(I),KIANO
                                ind = 9
                        END IF
!C      MODIFICACAO FEITA POR CARLOS MAGNO ABREU EM 14/06/2020 
!C                        encode (2,'(I2)', VETDIA (IND) ) KTDIA (I)
						WRITE(VETDIA (IND) ,'(i2)') KTDIA (I)
!C                        encode (2,'(I2)', VETHOR (IND) ) KTHOR (I)
                        WRITE(VETHOR (IND),'(i2)') KTHOR (I)
!C                        encode (2,'(I2)', VETMIN (IND) ) KTMIN (I)
                        WRITE(VETMIN (IND),'(i2)') KTMIN (I)
                        AATAB = (ATAB (I) /10.) / 10.
!C                        encode (4,'(F4.1)', VETALT (IND) ) AATAB
                        WRITE(VETALT (IND),'(F4.1)') AATAB
                        IF (KTHOR (I) .EQ. 0) VETHOR (IND) = ' 0'
                        IF (KTMIN (I) .LT. 10) VETMIN (IND) (1:1) = '0'
                end if
        end do


!c      gravacao do ultimo dia do ano
!c------------------------------------

        write (33,3303) kiano , mes_ant, dia_ant,&
        &                       ind, (vethor(j),vetmin(j),vetalt(j), j = 1,ind)


        amaxii = amaxi / 100
        aminii = amini / 100


 1500 CONTINUE

1501    if (op .eq. 'S') then
                close (unit = 11, status = 'delete')
        else
                close (unit = 11)
        end if



        if (tipo .eq. '2') then
                close (unit = 22)
                close (unit = 33)
        else
                if (tipo .eq. '1') then
                        close (unit = 22)
                else
                        close (unit = 33)
                end if
        end if




111     format (t42,'PREAMARES E BAIXAMARES - MES ',a,' - ANO - ',i4,/)
112     format (t3,9('     HORA  ALT'))
113     FORMAT (T5,9('DIA           '))
114     FORMAT (T2,9('       H M   M'))
225     FORMAT (4x,9(A2,' ',A2,A2,' ',A4,'  '))
555     FORMAT (//,21X,'MAXIMA DO MES - DIA   HORA MINUTO     ALTURA')
333     FORMAT (38X,I2,4X,I2,3X,I2,5X,F8.2)
222     FORMAT (21X,'MINIMA DO MES - DIA    HORA MINUTO     ALTURA')
223     FORMAT (/,T38,'OBS: ALTURAS EM METROS EM RELACAO AO NIVEL DE REDUCAO (NR).')
224     FORMAT (/,T38,'OBS: ALTURAS EM METROS EM RELACAO AO ZERO DA REGUA.')


198     format (t19,'PREVISAO DE ALTURAS HORARIAS PARA O PERIODO DE ',A,' DE ',&
        &       A,' DE ',I4,' A ',A,' DE ',A,' DE ',I4,/)

199     FORMAT (T60,A,/)

2001    FORMAT (T3,A)

201     FORMAT (T3,'HORAS *',T131,'*')

202     FORMAT (T4,'*    *    0    1    2    3    4    5    6    7    8    9',&
        &       '   10   11   12   13   14   15   16   17   18   19   20   21',&
        &       '   22   23 *')

203     FORMAT (T5,'*   *',T131,'*')

204     FORMAT (T6,'*  *',T131,'*')

205     FORMAT (T3,'DIAS',A)

354     FORMAT (T5,I2,'  *',24(' ',I4),' *')

355     FORMAT (///,T35,'OBS: ALTURAS EM CENTIMETROS EM RELACAO AO NIVEL DE REDUCAO (NR).')

356     FORMAT (///,T40,'OBS: ALTURAS EM CENTIMETROS EM RELACAO AO ZERO DA REGUA')
1225    format (t5,'*****  ATENCAO NESTE DIA HOUVE MAIS DE NOVE VALORES MAXIMOS E MINIMOS, AVISAR AO ANALISTA RESPONSAVEL. *****')
1226    FORMAT  ('****** ',I2,'/',I2,'/',I2,' ******')
3303    format ('3',i4,i2,i2,i2,9(a2,a2,a4))
3301    format ('1',a,a)





       RETURN
       END



SUBROUTINE TABUA (arq_const,arq_porto,arq_tabua,carta,instituicao,nome_porto,ano_tabua)

  !DEC$ ATTRIBUTES DLLEXPORT::TABUA

!C------------------------------------------------------------------------------
!C      ESTA VERSAO DA SUBROTINA TABUA E' PARA GRAVAR DOIS ARQUIVOS
!C      UM CONTENDO INFORMACOES DOS PORTOS GERADOS PARA A TABUA O OUTRO COM
!C      OS DIAS, HORAS E ALTURAS
!C      O RELACIONAMENTO DESTES ARQUIVOS E' O NUMERO DA ESTACAO DE (1 PARA N)

!C      LAY-OUT DO 1 ARQUIVO

!C      NUMERO DA ESTACAO               CHAR*5
!C      NOME DO PORTO                   CHAR*76
!C      LATITUDE  (GR,MI,DE,HEM)        CHAR*7
!C      LONGITUDE (GR,MI,DE,HEM)        CHAR*8
!C      FUSO HORARIO                    CHAR*5  (F5.1)
!C      NUMERO DE COMPONENTES           CHAR*2
!C      NOME DA INSTITUICAO             CHAR*13
!C      NIVEL MEDIO                     REAL    (F4.2)
!C      NUMERO DA CARTA                 CHAR*4


!C      LAY-OUT DO SEGUNDO ARQUIVO

!C      NUMERO DA ESTACAO               CHAR*5
!C      DATA (DD/MM/AA)                 CHAR*8
!C      HORA (HHMM)                     CHAR*4
!C      ALTURA                          REAL    (F4.1)

!C----------------------------------------------------------------------------

!C     TABUA DE MARES - CALCULOS E GRAVACAO
!C     ESTA SUB-ROTINA CHAMA AS ROTINAS DE USO COMUM NO SISTEMA DE MARE
!C                      ASTRO
!C                      TERP 


!c      Variaveis passadas para a subrotina

        character*150   arq_const
        character*150  arq_porto
        character*150  arq_tabua
        character*5     carta
        character*13    instituicao
        character*76    nome_porto
        character*4     ano_tabua

!c      Variaveis do registro mestre

        integer*2       m1
        character*10    nivel_medio
        character*2     dd1,mm1,dd2,mm2
        CHARACTER*4     AA1,AA2
        character*5     nr_estacao
        character*38    nome_estacao
        character*2     xlatg,min_lat
        character*1     dec_lat,hem
        character*3     xlong
        character*2     min_lon
        character*1     dec_lon,ori
        character*4     fuso_horario

!c      Variaveis de trabalho

        character*1     nome (76)
        character*1     ano (4)
        character*1     porto1  (83)
        character*1     porto2  (83)
        !integer*2      ncart
        character*1     bk
        character*1     hifen
        character*4     xlatm
        character*4     xlonm
        character*5     fuso

        integer*4       indice


!C      VARIAVEIS PARA GRAVACAO

        CHARACTER*4     HORA_ALFA
        CHARACTER*4     MIN_ALFA
        CHARACTER*2     DIA_ALFA
        CHARACTER*2     MES_ALFA
        CHARACTER*10    DATA_ALFA
        CHARACTER*3     M1_ALFA


!c------------------------------------------------------------------------------

       character*3 MESA(12),MESB(12),MESC(12)

        character*4     wrifi (24)
        character*4     br3,br4
        character*4     hora1,minu1,alt1


        real*4  C(1801),P(21)
        real*4  F(180),U(180),Q(180)
        real*4  F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14)
        real*4  AH(9000),ATAB(3300)
        integer*4       KTHOR(3300),KTMIN(3300)
        integer*4       LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)
        integer*4       im(12),lm(14),inaux(14)
        integer*4       KTANO(3300),KTMES(3300),KTDIA(3300)
!c------------------------------------------------------------------------------
        

      DATA BK/' '/

      DATA HIFEN/'-'/

      DATA MESA/' JA','FEV','  M','  A','  M','  J','  J',&
     &' AG','SET',' OU','NOV','DEZ'/

      DATA MESB/'NEI','ERE','ARC','BRI','AIO','UNH','ULH',&
     &'OST','EMB','TUB','EMB','EMB'/

      DATA MESC/'RO ','IRO','O  ','L  ','   ','O  ','O  ',&
     &'O  ','RO ','RO ','RO ','RO '/

!c      DATA BR3,BR4/'   ','    '/

!c      DATA IM/31,28,31,30,31,30,31,31,30,31,30,31/

!C     Q1 FREQUENCIAS, EM GRAUS POR HORA, DAS 37 COMPONENTES ASTRONOMICAS
!C     PRINCIPAIS.

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424078,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265120,&
     &43.4761563/

      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/

!C     INAUX INDICE DAS 14 COMPONENTES ASTRONOMICAS QUE ENTRAM USUALMENTE
!C     NA FORMACAO DAS COMPONENTES DE PEQUENO FUNDO
!C     DELTAT INTERVALO, EM FRACAO DECIMAL DA HORA, ENTRE DUAS ALTURAS
!C     CONSECUTIVAS PREVISTAS. HI,IDIAS,IMES HORA, DIA E MES DO INICIO
!C     DA PREVISAO. NL NUMERO DE MESES DA PREVISAO. APOS A PREVISAO,
!C     EXTREMOS SAO CALCULADOS POR INTERPOLACAO.
!C     DATA DELTAT,HI,IDIAS,IMES,NL/1.,-3.,1,12,14/
!C     IANO ANO DA PREVISAO
!C     JH NUMERO DE PORTOS


!c      Inicializar variaveis

        im (01) = 31
        im (02) = 28    
        im (03) = 31
        im (04) = 30
        im (05) = 31
        im (06) = 30
        im (07) = 31
        im (08) = 31
        im (09) = 30
        im (10) = 31
        im (11) = 30
        im (12) = 31



        br3 = '    '
        br4 = '    '

        deltat = 1.0
        hi = -3.0
        idias = 1
        imes = 12
        nl = 14

!C      Transformar variaveis passadas para a subrotina

        !decode (5,'(i5)', carta) ncart

!c      Abertura do arquivo de constantes para cada porto da tabua.
!c      A variavel arquivo contem o disco, diretorio, subdiretorio e o nome
!c      do arquivo de constantes correspondente ao porto lido no cadastro de
!c      portos.

        open    (unit = 11, file = arq_const, status = 'old',   iostat = ierro)

        !if (ierro .ne. 0) then
          !type *,'Erro na abertura do arquivo de constantes na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ierro
          !close (unit = 11)
          !stop
        !end if

        open    (unit = 25, file = arq_porto, status = 'new',   iostat = ierro)
        open    (unit = 26, file = arq_tabua, status = 'new',   iostat = ierro)

!c      Inicializar jh com o valor de 1 para o loop ser de um porto de cada vez.

        jh = 1

!c      Tranformar o ano passado para a subrotina para inteiro

!C        decode (4,'(i4)', ano_tabua) iano
		READ (ano_tabua,'(i4)') iano


!C     CONSTRUCAO DA TABELA DE COSSENOS C(I), PARA UM INTERVALO DE 0.2 DO
!C     GRAU.
      AR=3.1415926/180.
      AV=AR*DELTAT
      DELTAX=.2*AR
      AA=COS(DELTAX)
      AB=SIN(DELTAX)
      BB=1.
      BC=0.
      C(1)=1.
      DO 3 I=1,1800
      Z=AA*BB-AB*BC
      BC=AB*BB+AA*BC
      BB=Z
    3 C(I+1)=Z
      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)IM(2)=29
      N=(399+IM(2))*24+6
      KANO=IANO-1

!C     CALCULO DOS ARGUMENTOS ASTRONOMICOS E DOS FATORES PERINODAIS DAS
!C     37 COMPONENTES ASTRONOMICAS PRINCIPAIS.

      CALL ASTRO(1,DELTAT,HI,IDIAS,IMES,KANO,N,0,F1,U1,AS)

      DO 4 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    4 CONTINUE
      DO 1500 LI=1,JH
      KANO=IANO-1
      JV=IMES-1


!C-------------------------------------------------------------------------------
!c      Leitura do primeiro registro do arquivo de constantes com os seguintes
!c      campos para processamento
!c
!c      Numero de componentes           = M1 (i3)               = i3
!c      Nivel medio                     = nivel_medio (char*10) = s0 (f10.2)
!c      periodo inicial da analise(DMA) = data_inic char*6      = 
!c      periodo final da analise (DMA)  = data_fim char*6       =
!c      numero da estacao               = nr_estacao char*5     =
!c      nome da estacao                 = nome_estacao char*38  =
!c      grau_da_latitude                = xlatg char*2          = xlatg
!c      minuto_da_latitude              = min_lat char*2        = min_lat
!c      decimo_da_latitude              = dec_lat char*1        = dec_lat
!c      sentido_da_latitude             = hem char*1            = hem
!c      grau_da_longitude               = xlong char*3          = xlong
!c      minuto_da_longitude             = min_lat char*2        = min_lon
!c      decimo_da_longitude             = dec_lat char*1        = dec_lon
!c      sentido_da_longitude            = ori char*1            = ori
!c      fuso_horario                    = fuso_horario char*4   = fuso char*5


        read (unit = 11, fmt = 6000, iostat = ierro_le_1) m1,nivel_medio,dd1,&
        &       mm1,aa1,dd2,mm2,aa2,nr_estacao,nome_estacao,xlatg,min_lat,&
        &       dec_lat,hem,xlong,min_lon,dec_lon,ori,fuso_horario

 6000   format (i3,18a)

!c      concatenacao de variaveis e trasformacao de variaveis

        xlatm = min_lat // '.' // dec_lat
        xlonm = min_lon // '.' // dec_lon
        fuso = fuso_horario (1:3) // '.' // fuso_horario (4:4)
!C        decode (10,'(f10.2)', nivel_medio ) s0
		READ (nivel_medio,'(f10.2)') s0
        SOMET = S0 / 100.

!c------------------------------------------------------------------------------
!C      GRAVACAO DO 1 ARQUIVO

!C        encode (3, '(I3)', M1_ALFA) M1
        WRITE (M1_ALFA,'(i3)') M1
        WRITE (25,25) NR_ESTACAO, NOME_PORTO, XLATG, XLATM, HEM,&
        &               XLONG, XLONM, ORI, FUSO, M1_ALFA, INSTITUICAO,&
        &               SOMET, CARTA

25      FORMAT (A5,A76,A2,A4,A1,A3,A4,A1,A5,A3,A13,F4.2,A5)

!c------------------------------------------------------------------------------

      S0MET=S0/100.
      DO 30 I=1,M1
!C     IX=1 SE A COMPONENTE FOR ASTRONOMICA E IX=0 SE FOR DE PEQUENO FUN-
!C     DO. IX=2 PARA COMPONENTES ARBITRARIAS.
!C     Q VELOC ANG, LM COMBINACOES, H,G CTES HARM

      READ (11,2) IX,Q(I),(LM(J),J=1,14),H,G
    2 FORMAT(I1,7X,F11.7,14I2,2F8.2)
      IF(1-IX)17,15,16
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ASTRONOMICAS.
   15 DO 5 JK=1,37
      IF(ABS(Q1(JK)-Q(I)).GE..0001)GO TO 5
      F(I)=F1(JK)*H
      U(I)=U1(JK)-G
      GO TO 30
    5 CONTINUE
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES DE PEQUENO FUNDO.
   16 AA=1.
      BB=0.
      DO 6 M=1,14
      AA=AA*F2(M)**IABS(LM(M))
    6 BB=BB+U2(M)*LM(M)
      F(I)=AA*H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
      GO TO 30
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ARBITRARIAS.
   17 BB=0.
      DO 7 J=1,6
    7 BB=BB+AS(J)*LM(J)
      F(I)=H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
   30 Q(I)=Q(I)*DELTAT
      INDEX=0
!C     CALCULO DAS ALTURAS SUCESSIVAS.
      DO 1000 LOOP=1,NL
      JV=JV+1
      IF(JV-12)32,32,9030
 9030 JV=1
      KANO=KANO+1
   32 IH=IM(JV)*24+6
      DO 22 K=1,IH
      S=S0
      DO 23 J=1,M1
      AA=U(J)
      IK=ABS(AA/.2)+1.5
      AA=AA+Q(J)
      U(J)=AA-IFIX(AA/360.)*360.
   23 S=S+C(IK)*F(J)
      AH(K)=S
   22 CONTINUE
      DO 24 I=1,M1
      U(I)=U(I)-6.*Q(I)
      MA=U(I)/360.
      U(I)=U(I)-MA*360.
      IF(U(I).LT.0.)U(I)=U(I)+360.
   24 CONTINUE
!C     CALCULO POR INTERPOL DE DATAS E ALTURAS DE PREAMARES E BAIXAMARES
      IL=IH-3
      M=0
      ALT=S0
      DO 160 I=4,IL
      IF(AH(I-1).LE.AH(I).AND.AH(I).GE.AH(I+1))M=I
      IF(AH(I-1).GE.AH(I).AND.AH(I).LE.AH(I+1))M=I
      IF(I-M)160,99,160
   99 CALL TERP(AH,M,3,P)
      DO 100 J=4,18
      IF(P(J-1).LE.P(J).AND.P(J).GE.P(J+1))JJ=J
      IF(P(J-1).GE.P(J).AND.P(J).LE.P(J+1))JJ=J
  100 CONTINUE
      CALL TERP(P,JJ,2,P)
      DO 110 K=4,10
      IF(P(K-1).LE.P(K).AND.P(K).GE.P(K+1))KK=K
      IF(P(K-1).GE.P(K).AND.P(K).LE.P(K+1))KK=K
  110 CONTINUE
      HORA=M-4-1.4375+(JJ-1)*.125+(KK-1)*.03125
      IHORA=HORA
      MIN=(HORA-IHORA)*60.+.5
      IDIA=IHORA/24+1
      IHORA=MOD(IHORA,24)
      IF(ABS(ALT-P(KK)).LT.0.5.OR.IHORA.LT.0)GO TO 160
      ALT=P(KK)
      INDEX=INDEX+1
      KTANO(INDEX)=KANO
      KTMES(INDEX)=JV
      KTDIA(INDEX)=IDIA
      KTHOR(INDEX)=IHORA
      KTMIN(INDEX)=MIN
      ATAB(INDEX)=ALT
  160 CONTINUE
 1000 CONTINUE


!C     CORRECAO DE MINUTOS NEGATIVOS
!c      MADEX=INDEX
!c      DO 1100 INDEX=1,MADEX
!c      IF(KTMIN(INDEX))1010,1100,1100
!c 1010 IF(KTMES(INDEX)-1)1020,1020,1040
!c 1020 KTANO(INDEX)=KTANO(INDEX)-1
!c      KTMES(INDEX)=12
!c      KTDIA(INDEX)=31
!c      GO TO 1050
!c 1040 JV=KTMES(INDEX)-1
!c      KTMES(INDEX)=JV
!c      KTDIA(INDEX)=IM(JV)
!c 1050 KTHOR(INDEX)=23
!c      KTMIN(INDEX)=KTMIN(INDEX)+60
!c 1100 CONTINUE

!C     CORRECAO DE MINUTOS NEGATIVOS

      MADEX=INDEX

        do index = 1, madex
                if (ktmin (index) .lt. 0) then
                        if (ktmes (index) .eq. 1) then
                                ktdia (index) = 1
                                kthor (index) = 0
                                ktmin (index) = 0
                        else
                                jv = ktmes (index) - 1
                                ktmes (index) = jv
                                ktdia (index) = im (jv)
                                kthor (index) = 23
                                ktmin (index) = ktmin (index) + 60
                        end if
                end if
        end do



!C     AJUSTE DE INDICES E CONVERSAO DOS EXTREMOS EM METROS.
      DO 1120 INDEX=1,MADEX
      IF(KTANO(INDEX)-IANO)1120,1150,1150
 1120 CONTINUE
 1150 INDIN=INDEX
      DO 1170 INDEX=INDIN,MADEX
      IF(KTANO(INDEX)-IANO)1170,1170,1190
 1170 CONTINUE
 1190 INDFI=INDEX-1
      INDEX=0
      DO 1200 M=INDIN,INDFI
      INDEX=INDEX+1
      KTANO(INDEX)=KTANO(M)
      KTMES(INDEX)=KTMES(M)
      KTDIA(INDEX)=KTDIA(M)
      KTHOR(INDEX)=KTHOR(M)+100
      KTMIN(INDEX)=KTMIN(M)+100
!c------------------------------------------------------------------------------
!c       ATAB(INDEX)=ATAB(M)/100.
!c      substituido para tirar o sinal do -0.0
!c      AHF 30/04/87
!c      atab (index) = aint (atab (m) / 10.) / 10.
!c      ahf 18/09/90
!c      Foi retirado  o AINT a pedido da MARIA HELENA

        atab (index) = (atab (m) / 10.) / 10.

!c------------------------------------------------------------------------------

 1200 CONTINUE
      MADEX=INDEX

!C      GRAVACAO DOS REGISTROS DO 2 ARQUIVO

        DO INDICE = 1, MADEX
!C                encode (4, '(I4)' , HORA_ALFA)  KTHOR (INDICE)
                WRITE (HORA_ALFA,'(i4)') KTHOR (INDICE)
!C                encode (4, '(I4)' , MIN_ALFA)   KTMIN (INDICE)
                WRITE (MIN_ALFA,'(i4)') KTMIN (INDICE)
!C                encode (2, '(I2)' , DIA_ALFA)   KTDIA (INDICE)
                WRITE (DIA_ALFA,'(i2)') KTDIA (INDICE)
!C                encode (2, '(I2)' , MES_ALFA)   KTMES (INDICE)
                WRITE (MES_ALFA,'(i2)') KTMES (INDICE)
!C                encode (4, '(F4.1)', ALT1) ATAB  (INDICE)
                WRITE (ALT1,'(f4.1)') ATAB (INDICE)
                IF (KTDIA (INDICE) .LT. 10) DIA_ALFA (1:1) = '0'
                IF (KTMES (INDICE) .LT. 10) MES_ALFA (1:1) = '0'
                DATA_ALFA= DIA_ALFA // '/' // MES_ALFA // '/' // ANO_TABUA (1:4)
                WRITE (26,26) NR_ESTACAO, DATA_ALFA, HORA_ALFA (3:4),&
        &                       MIN_ALFA (3:4), ALT1
        END DO

26      FORMAT (A5,A10,A2,A2,A4)



 1500 CONTINUE

        close (unit= 11)
        close (unit= 25)
        close (unit= 26)

       RETURN
       END


SUBROUTINE TABUA_IMP (arq_const,arq_imp,arq_temp,carta,instituicao,nome_porto,ano_tabua)

  !DEC$ ATTRIBUTES DLLEXPORT::TABUA_IMP

!C     TABUA DE MARES - CALCULOS E IMPRESSAO
!C     ESTE PROGRAMA CHAMA AS SUB-ROTINAS DE USO COMUM NO SISTEMA DE MARE
!C     ASTRO  CATALOGADA COM O NOME DE  MAR1RT05
!C     TERP   CATALOGADA COM O NOME DE  MAR1RT10


!c      Variaveis passadas para a subrotina

        character*150   arq_const
        character*150   arq_imp
        character*150   arq_temp
        character*5     carta
        character*13    instituicao
        character*76    nome_porto
        character*4     ano_tabua

!c      Variaveis do registro mestre

        integer*2       m1
        character*10    nivel_medio
        character*2     dd1,mm1,dd2,mm2
        CHARACTER*4     AA1,AA2
        character*5     nr_estacao
        character*38    nome_estacao
        character*2     xlatg,min_lat
        character*1     dec_lat,hem
        character*3     xlong
        character*2     min_lon
        character*1     dec_lon,ori
        character*4     fuso_horario

!c      Variaveis de trabalho

        character*1     nome (76)
        character*1     ano (4)
        character*1     porto1  (83)
        character*1     porto2  (83)
        !integer*2      ncart
        character*1     bk
        character*1     hifen
        character*4     xlatm
        character*4     xlonm
        character*5     fuso

        character*3     pri,seg,ter,qua,qui,sex
        character*2     dia1,dia16
        character*2     mes_semana1,mes_semana2,mes_semana3
        integer*4       indice
        character*3     tab_semana(7)

!c      Variaveis para prender o carro e concatenacao


        character*2     dia_sai1,dia_sai2,dia_sai3,dia_sai4,dia_sai5,dia_sai6
        character*2     hor_sai1,hor_sai2,hor_sai3,hor_sai4,hor_sai5,hor_sai6
        character*2     min_sai1,min_sai2,min_sai3,min_sai4,min_sai5,min_sai6
        character*4     alt_sai1,alt_sai2,alt_sai3,alt_sai4,alt_sai5,alt_sai6

        character*1     controle
        character*120   primeira_linha
        character*108   segunda_linha
        character*229   linha_grande

!c------------------------------------------------------------------------------

!c      REAL MESA(12),MESB(12),MESC(12),WRIFI(24)
       character*3 MESA(12),MESB(12),MESC(12)

        character*4     wrifi (24)
        character*4     br3,br4
        character*4     hora1,minu1,alt1


!c      DIMENSION C(1801),IM(12),P(21)
!c      DIMENSION LM(14),F(180),U(180),Q(180)
!c      DIMENSION F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14),INAUX(14)
!c      DIMENSION AH(9000),KTANO(3300),KTMES(3300),KTDIA(3300)
!c      DIMENSION KTHOR(3300),KTMIN(3300),ATAB(3300)
!c      DIMENSION LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)


        real*4  C(1801),P(21)
        real*4  F(180),U(180),Q(180)
        real*4  F1(37),U1(37),Q1(37),AS(9),F2(14),U2(14)
        real*4  AH(9000),ATAB(3300)
        integer*4       KTHOR(3300),KTMIN(3300)
        integer*4       LMEX(12),IND01(12),IND16(12),LDMEX(12,31),KSW(200)
        integer*4       im(12),lm(14),inaux(14)
        integer*4       KTANO(3300),KTMES(3300),KTDIA(3300)
!c------------------------------------------------------------------------------
        
        data    tab_semana /'DOM','SEG','TER','QUA','QUI','SEX','SAB'/

      DATA BK/' '/

      DATA HIFEN/'-'/

      DATA MESA/' JA','FEV','  M','  A','  M','  J','  J',&
     &' AG','SET',' OU','NOV','DEZ'/

      DATA MESB/'NEI','ERE','ARC','BRI','AIO','UNH','ULH',&
     &'OST','EMB','TUB','EMB','EMB'/

      DATA MESC/'RO ','IRO','O  ','L  ','   ','O  ','O  ',&
     &'O  ','RO ','RO ','RO ','RO '/

!c      DATA BR3,BR4/'   ','    '/

!c      DATA IM/31,28,31,30,31,30,31,31,30,31,30,31/

!C     Q1 FREQUENCIAS, EM GRAUS POR HORA, DAS 37 COMPONENTES ASTRONOMICAS
!C     PRINCIPAIS.

      DATA Q1/.0410686,.0821373,.5443747,1.0980331,1.6424078,12.8542862,&
     &12.9271398,13.3986609,13.4715145,13.9430356,14.0251729,14.4966939,&
     &14.5695476,14.9178647,14.9589314,15.0000000,15.0410686,15.0821353,&
     &15.1232059,15.5125897,15.5854433,16.1391017,27.4238337,27.8953548,&
     &27.9682084,28.4397295,28.5125831,28.9841042,29.4556253,29.5284789,&
     &29.9589333,30.0000000,30.0410667,30.0821373,30.5536584,30.6265120,&
     &43.4761563/

      DATA INAUX/8,10,12,15,16,17,21,26,27,28,30,31,32,34/

!C     INAUX INDICE DAS 14 COMPONENTES ASTRONOMICAS QUE ENTRAM USUALMENTE
!C     NA FORMACAO DAS COMPONENTES DE PEQUENO FUNDO
!C     DELTAT INTERVALO, EM FRACAO DECIMAL DA HORA, ENTRE DUAS ALTURAS
!C     CONSECUTIVAS PREVISTAS. HI,IDIAS,IMES HORA, DIA E MES DO INICIO
!C     DA PREVISAO. NL NUMERO DE MESES DA PREVISAO. APOS A PREVISAO,
!C     EXTREMOS SAO CALCULADOS POR INTERPOLACAO.
!C     DATA DELTAT,HI,IDIAS,IMES,NL/1.,-3.,1,12,14/
!C     IANO ANO DA PREVISAO
!C     JH NUMERO DE PORTOS


!c      Inicializar variaveis

        im (01) = 31
        im (02) = 28    
        im (03) = 31
        im (04) = 30
        im (05) = 31
        im (06) = 30
        im (07) = 31
        im (08) = 31
        im (09) = 30
        im (10) = 31
        im (11) = 30
        im (12) = 31

        controle = char (13)
        br3 = '    '
        br4 = '    '

        deltat = 1.0
        hi = -3.0
        idias = 1
        imes = 12
        nl = 14

!C      Transformar variaveis passadas para a subrotina

        !decode (5,'(i5)', carta) ncart

!c      Abertura do arquivo de constantes para cada porto da tabua.
!c      A variavel arquivo contem o disco, diretorio, subdiretorio e o nome
!c      do arquivo de constantes correspondente ao porto lido no cadastro de
!c      portos.

    open (unit = 11, file = arq_const, status = 'old', iostat = ierro)

        !if (ierro .ne. 0) then
          !type *,'Erro na abertura do arquivo de constantes na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ierro
          !close (unit = 11)
          !stop
        !end if

!c      Abertura do arquivo de trabalho da TABUA DE MARES 

        open (unit = 13, file = arq_temp, status = 'new', iostat = ios2)

        !if (ios2 .ne. 0) then
          !type *,'Erro na abertura do arquivo de trabalho na sub_rotina tabua'
          !type *,'Avisar Analista Responsavel'
          !type *,'Erro numero - ',ios2
          !close (unit = 13)
          !stop
        !end if

        open (unit = 12, file = arq_imp, status = 'new', iostat = ierro)

!c      Inicializar jh com o valor de 1 para o loop ser de um porto de cada vez.

        jh = 1

!c      Tranformar o ano passado para a subrotina para inteiro

!C        decode (4,'(i4)', ano_tabua) iano
		READ (ano_tabua,'(i4)') iano

!C     CONSTRUCAO DA TABELA DE COSSENOS C(I), PARA UM INTERVALO DE 0.2 DO
!C     GRAU.
      AR=3.1415926/180.
      AV=AR*DELTAT
      DELTAX=.2*AR
      AA=COS(DELTAX)
      AB=SIN(DELTAX)
      BB=1.
      BC=0.
      C(1)=1.
      DO 3 I=1,1800
      Z=AA*BB-AB*BC
      BC=AB*BB+AA*BC
      BB=Z
    3 C(I+1)=Z
      MB=MOD(IANO,4)
      MC=MOD(IANO,100)
      MD=MOD(IANO,400)
      IF((MB.EQ.0.AND.MC.NE.0).OR.MD.EQ.0)IM(2)=29
      N=(399+IM(2))*24+6
      KANO=IANO-1

!C     CALCULO DOS ARGUMENTOS ASTRONOMICOS E DOS FATORES PERINODAIS DAS
!C     37 COMPONENTES ASTRONOMICAS PRINCIPAIS.

      CALL ASTRO(1,DELTAT,HI,IDIAS,IMES,KANO,N,0,F1,U1,AS)

      DO 4 I=1,14
      J=INAUX(I)
      F2(I)=F1(J)
      U2(I)=U1(J)
    4 CONTINUE
      DO 1500 LI=1,JH
      KANO=IANO-1
      JV=IMES-1

!C     IDENTIFICACAO DO PORTO
!C
!C     CARREGAR O NOME DO PORTO E ANO,FAZENDO COM QUE O NOME DO PORTO FIQUE CEN-
!C     TRALIZADO COM O ANO VETOR PORTO2 DE 83 POSICOES.


!C      LIMPAR O VETOR DE SAIDA
        
      DO 1444  K=1,83
         PORTO1(K)=BK
         PORTO2(K)=BK
 1444 CONTINUE


        do ind = 1,76
           porto1 (ind) = nome_porto (ind:ind)
        end do

        do ind = 1,4
           ano (ind) = ano_tabua (ind:ind)
        end do




!c      Colocar o nome do porto com o ano num vetor centralizado

      IBK = 0
      DO  670 I=1,76
      IF (PORTO1(I).NE.BK) GO TO 650
      IBK = IBK + 1
      IF (IBK.EQ.2) N1 = I
      GO TO (670,700),IBK
  650 IBK = 0
  670 CONTINUE

  700 if (ibk .eq. 0) then
        n1 = 78
      else
        if (ibk .eq. 1) then
          n1 = 77
        end if
      end if

      PORTO1(N1) = HIFEN
      PORTO1(N1 + 1) = BK
      N2 = N1 + 1
      N3 = N1 + 4
      DO 730 I=1,4
  730 PORTO1(I + N2) = ANO (I)
      LIMITE = (83 - N3) / 2
      N4 = 83 - LIMITE
      DO 750 I=1,N4
      PORTO2(I + LIMITE) = PORTO1 (I)
  750 CONTINUE

!C-------------------------------------------------------------------------------
!c      Leitura do primeiro registro do arquivo de constantes com os seguintes
!c      campos para processamento
!c
!c      Numero de componentes           = M1 (i2)               = i2
!c      Nivel medio                     = nivel_medio (char*10) = s0 (f10.2)
!c      periodo inicial da analise(DMA) = data_inic char*6      = 
!c      periodo final da analise (DMA)  = data_fim char*6       =
!c      numero da estacao               = nr_estacao char*5     =
!c      nome da estacao                 = nome_estacao char*38  =
!c      grau_da_latitude                = xlatg char*2          = xlatg
!c      minuto_da_latitude              = min_lat char*2        = min_lat
!c      decimo_da_latitude              = dec_lat char*1        = dec_lat
!c      sentido_da_latitude             = hem char*1            = hem
!c      grau_da_longitude               = xlong char*3          = xlong
!c      minuto_da_longitude             = min_lat char*2        = min_lon
!c      decimo_da_longitude             = dec_lat char*1        = dec_lon
!c      sentido_da_longitude            = ori char*1            = ori
!c      fuso_horario                    = fuso_horario char*4   = fuso char*5


        read (unit = 11, fmt = 6000, iostat = ierro_le_1) m1,nivel_medio,dd1,&
        &       mm1,aa1,dd2,mm2,aa2,nr_estacao,nome_estacao,xlatg,min_lat,&
        &       dec_lat,hem,xlong,min_lon,dec_lon,ori,fuso_horario

 6000   format (i3,18a)

!c      concatenacao de variaveis e trasformacao de variaveis

        xlatm = min_lat // '.' // dec_lat
        xlonm = min_lon // '.' // dec_lon
        fuso = fuso_horario (1:3) // '.' // fuso_horario (4:4)
!C        decode (10,'(f10.2)', nivel_medio ) s0
		READ (nivel_medio,'(f10.2)') s0		


!c------------------------------------------------------------------------------

      S0MET=S0/100.
      DO 30 I=1,M1
!C     IX=1 SE A COMPONENTE FOR ASTRONOMICA E IX=0 SE FOR DE PEQUENO FUN-
!C     DO. IX=2 PARA COMPONENTES ARBITRARIAS.
!C     Q VELOC ANG, LM COMBINACOES, H,G CTES HARM

      READ (11,2) IX,Q(I),(LM(J),J=1,14),H,G
    2 FORMAT(I1,7X,F11.7,14I2,2F8.2)
      IF(1-IX)17,15,16
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ASTRONOMICAS.
   15 DO 5 JK=1,37
      IF(ABS(Q1(JK)-Q(I)).GE..0001)GO TO 5
      F(I)=F1(JK)*H
      U(I)=U1(JK)-G
      GO TO 30
    5 CONTINUE
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES DE PEQUENO FUNDO.
   16 AA=1.
      BB=0.
      DO 6 M=1,14
      AA=AA*F2(M)**IABS(LM(M))
    6 BB=BB+U2(M)*LM(M)
      F(I)=AA*H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
      GO TO 30
!C     CALCULO DAS AMPLITUDES E FASES INICIAIS DAS
!C     COMPONENTES ARBITRARIAS.
   17 BB=0.
      DO 7 J=1,6
    7 BB=BB+AS(J)*LM(J)
      F(I)=H
      BB=BB-G
      U(I)=BB-IFIX(BB/360.)*360.
   30 Q(I)=Q(I)*DELTAT
      INDEX=0
!C     CALCULO DAS ALTURAS SUCESSIVAS.
      DO 1000 LOOP=1,NL
      JV=JV+1
      IF(JV-12)32,32,9030
 9030 JV=1
      KANO=KANO+1
   32 IH=IM(JV)*24+6
      DO 22 K=1,IH
      S=S0
      DO 23 J=1,M1
      AA=U(J)
      IK=ABS(AA/.2)+1.5
      AA=AA+Q(J)
      U(J)=AA-IFIX(AA/360.)*360.
   23 S=S+C(IK)*F(J)
      AH(K)=S
   22 CONTINUE
      DO 24 I=1,M1
      U(I)=U(I)-6.*Q(I)
      MA=U(I)/360.
      U(I)=U(I)-MA*360.
      IF(U(I).LT.0.)U(I)=U(I)+360.
   24 CONTINUE
!C     CALCULO POR INTERPOL DE DATAS E ALTURAS DE PREAMARES E BAIXAMARES
      IL=IH-3
      M=0
      ALT=S0
      DO 160 I=4,IL
      IF(AH(I-1).LE.AH(I).AND.AH(I).GE.AH(I+1))M=I
      IF(AH(I-1).GE.AH(I).AND.AH(I).LE.AH(I+1))M=I
      IF(I-M)160,99,160
   99 CALL TERP(AH,M,3,P)
      DO 100 J=4,18
      IF(P(J-1).LE.P(J).AND.P(J).GE.P(J+1))JJ=J
      IF(P(J-1).GE.P(J).AND.P(J).LE.P(J+1))JJ=J
  100 CONTINUE
      CALL TERP(P,JJ,2,P)
      DO 110 K=4,10
      IF(P(K-1).LE.P(K).AND.P(K).GE.P(K+1))KK=K
      IF(P(K-1).GE.P(K).AND.P(K).LE.P(K+1))KK=K
  110 CONTINUE
      HORA=M-4-1.4375+(JJ-1)*.125+(KK-1)*.03125
      IHORA=HORA
      MIN=(HORA-IHORA)*60.+.5
      IDIA=IHORA/24+1
      IHORA=MOD(IHORA,24)
      IF(ABS(ALT-P(KK)).LT.0.5.OR.IHORA.LT.0)GO TO 160
      ALT=P(KK)
      INDEX=INDEX+1
      KTANO(INDEX)=KANO
      KTMES(INDEX)=JV
      KTDIA(INDEX)=IDIA
      KTHOR(INDEX)=IHORA
      KTMIN(INDEX)=MIN
      ATAB(INDEX)=ALT
  160 CONTINUE
 1000 CONTINUE


!C     CORRECAO DE MINUTOS NEGATIVOS
!c      MADEX=INDEX
!c      DO 1100 INDEX=1,MADEX
!c      IF(KTMIN(INDEX))1010,1100,1100
!c 1010 IF(KTMES(INDEX)-1)1020,1020,1040
!c 1020 KTANO(INDEX)=KTANO(INDEX)-1
!c      KTMES(INDEX)=12
!c      KTDIA(INDEX)=31
!c      GO TO 1050
!c 1040 JV=KTMES(INDEX)-1
!c      KTMES(INDEX)=JV
!c      KTDIA(INDEX)=IM(JV)
!c 1050 KTHOR(INDEX)=23
!c      KTMIN(INDEX)=KTMIN(INDEX)+60
!c 1100 CONTINUE

!C     CORRECAO DE MINUTOS NEGATIVOS

      MADEX=INDEX

        do index = 1, madex
                if (ktmin (index) .lt. 0) then
                        if (ktmes (index) .eq. 1) then
                                ktdia (index) = 1
                                kthor (index) = 0
                                ktmin (index) = 0
                        else
                                jv = ktmes (index) - 1
                                ktmes (index) = jv
                                ktdia (index) = im (jv)
                                kthor (index) = 23
                                ktmin (index) = ktmin (index) + 60
                        end if
                end if
        end do





!C     AJUSTE DE INDICES E CONVERSAO DOS EXTREMOS EM METROS.
      DO 1120 INDEX=1,MADEX
      IF(KTANO(INDEX)-IANO)1120,1150,1150
 1120 CONTINUE
 1150 INDIN=INDEX
      DO 1170 INDEX=INDIN,MADEX
      IF(KTANO(INDEX)-IANO)1170,1170,1190
 1170 CONTINUE
 1190 INDFI=INDEX-1
      INDEX=0
      DO 1200 M=INDIN,INDFI
      INDEX=INDEX+1
      KTANO(INDEX)=KTANO(M)
      KTMES(INDEX)=KTMES(M)
      KTDIA(INDEX)=KTDIA(M)
      KTHOR(INDEX)=KTHOR(M)+100
      KTMIN(INDEX)=KTMIN(M)+100
!c------------------------------------------------------------------------------
!c       ATAB(INDEX)=ATAB(M)/100.
!c      substituido para tirar o sinal do -0.0
!c      AHF 30/04/87
!c      AHF 14/09/90 RETIRADO O AINT A PEDIDO DA MARIA HELENA
!C
!C      atab (index) = aint (atab (m) / 10.) / 10.
        atab (index) = (atab (m) / 10.) / 10.
!c------------------------------------------------------------------------------

 1200 CONTINUE
      MADEX=INDEX
!C     CALCULO DO NUMERO DE EXTREMOS EM CADA MES
      DO 1205 M=1,12
 1205 LMEX(M)=0
      DO 1210 INDEX=1,MADEX
      KMEX=KTMES(INDEX)
      LMEX(KMEX)=LMEX(KMEX)+1
 1210 CONTINUE
!C     DETERMINACAO DOS INDICES DOS EXTREMOS INICIAIS DE CADA
!C     QUINZENA DE CADA MES
      ISOM=0
      IND01(1)=1
      DO 1240 M=2,12
      MANT=M-1
      ISOM=LMEX(MANT)+ISOM
      IND01(M)=ISOM+1
 1240 CONTINUE
      DO 1280 M=1,12
      INDIN=IND01(M)
      INDFI=LMEX(M)+INDIN-1
      DO 1260 INDEX=INDIN,INDFI
      IF(KTDIA(INDEX)-16)1260,1270,1270
 1260 CONTINUE
 1270 IND16(M)=INDEX
 1280 CONTINUE
!C     CALCULO DO NUMERO DE EXTREMOS EM CADA DIA
      DO 1350 M=1,12
      INDIN=IND01(M)
      INDFI=LMEX(M)+INDIN-1
      DO 1310 KMEX=1,31
 1310 LDMEX(M,KMEX)=0
      DO 1320 INDEX=INDIN,INDFI
      KMEX=KTDIA(INDEX)
      LDMEX(M,KMEX)=LDMEX(M,KMEX)+1
 1320 CONTINUE
 1350 CONTINUE
!C     IMPRIMIR A TABUA DE MARES
      M=1
      M2=2
      M3=3
      DO 1480 KTRIM=1,4
        write (12,351) (porto2 (i),i=1,83)
  351 FORMAT(20x,83A1)
      WRITE (12,5000)
 5000 FORMAT(133X)
      WRITE (12,35) XLATG,XLATM,HEM,XLONG,XLONM,ORI,FUSO
   35 FORMAT(21X,'LATITUDE',1X,A2,1X,A4,1X,A1,15X,'LONGITUDE',1X,A3,1X,&
     &A4,1X,A1,14X,'FUSO',1X,a,1X,'HORAS')
      WRITE (12,5000)
      WRITE (12,5001) INSTITUICAO,M1,S0MET,CARTA
 5001 FORMAT(5X,A,20X,I3,' COMPONENTES',19X,'NIVEL MEDIO ',F4.2,1X,'M',20X,'CARTA ',A)
      WRITE (12,5000)
      WRITE (12,5000)
      WRITE (12,36) MESA(M),MESB(M),MESC(M),MESA(M2),MESB(M2),MESC(M2),&
     &              MESA(M3),MESB(M3),MESC(M3)
   36 FORMAT(17X,3A3,32X,3a3,32x,3a3)
      WRITE (12,5000)
      WRITE (12,5002)
 5002 FORMAT(9X,3('HORA   ALT',9X,'HORA   ALT',12X))
      WRITE (12,5003)
 5003 FORMAT(5X,3('DIA',16X,'DIA',19X))
!c      WRITE (12,5000)
      WRITE (12,5004)
 5004 FORMAT(10X,3('H M    M',11X,'H M    M',14X))
      WRITE (12,5000)

!C      TRNSFORMAR OS MESES DA IMPRESSAO PARA CHARACTER

!C        encode (2,'(i2)', mes_semana1) m
                WRITE (mes_semana1,'(i2)') m
!C        encode (2,'(i2)', mes_semana2) m2
                WRITE (mes_semana2,'(i2)') m2
!C        encode (2,'(i2)', mes_semana3) m3
                WRITE (mes_semana3,'(i2)') m3

!c      Inicializar os dias dos meses

        idia1 = 0
        idia16 = 15

      INDI1=IND01(M)-1
      INDI2=IND16(M)-1
      INDI3=IND01(M2)-1
      INDI4=IND16(M2)-1
      INDI5=IND01(M3)-1
      INDI6=IND16(M3)-1
      JC1=0
      JC2=15
      REWIND 13
      LINTO=0
      DO 1460 J=1,16
      J15=J-15
      JC1=JC1+1
      JC2=JC2+1
      JC100=JC1+100
      JC200=JC2+100
      LIN=0
 1400 INDI1=INDI1+1
      INDI2=INDI2+1
      INDI3=INDI3+1
      INDI4=INDI4+1
      INDI5=INDI5+1
      INDI6=INDI6+1
      LINTO=LINTO+1
      LIN1=LIN
      LIN=LIN+1
      KSW(LINTO)=0
      IF(J15)9401,9401,1401
 9401 IF(LDMEX(M,JC1)-LIN)1401,1402,1402
 1401 INDI1=INDI1-1
      WRITE (13,300) BR3,BR3,BR3,BR4


!c  300 FORMAT(3A3,A4)

300     FORMAT(4A4)

      GO TO 1404
 1402 KSW(LINTO)=1
      IF(LIN1)9402,9402,9403
 9402 WRITE (13,303) JC100,KTHOR(INDI1),KTMIN(INDI1),ATAB(INDI1)

!c  303 FORMAT(3I3,F4.1)

303     FORMAT(3I4,F4.1)

      GO TO 1404


!c 9403 WRITE (13,302) BR3,KTHOR(INDI1),KTMIN(INDI1),ATAB(INDI1)
!C 9403    encode (4, '(i4)' , hora1) kthor (indi1)
!C        encode (4, '(i4)' , minu1) ktmin (indi1)
!C        encode (4, '(f4.1)' , alt1) atab (indi1)

9403    WRITE (hora1,'(i4)') kthor (indi1)
        WRITE (minu1,'(i4)') ktmin (indi1)
        WRITE (alt1,'(f4.1)') atab (indi1)
        write (13,302) br3,hora1,minu1,alt1

!c  302 FORMAT(A3,2I3,F4.1)

302     FORMAT(A4,2a4,a4)

 1404 IF(LDMEX(M,JC2)-LIN)1405,1406,1406
 1405 INDI2=INDI2-1
      WRITE (13,300) BR3,BR3,BR3,BR4
      GO TO 1408
 1406 KSW(LINTO)=1
      IF(LIN1)9405,9405,9406
 9405 WRITE (13,303) JC200,KTHOR(INDI2),KTMIN(INDI2),ATAB(INDI2)
      GO TO 1408
!c 9406 WRITE (13,302) BR3,KTHOR(INDI2),KTMIN(INDI2),ATAB(INDI2)
!C 9406    encode (4, '(i4)' , hora1) kthor (indi2)
!C        encode (4, '(i4)' , minu1) ktmin (indi2)
!C        encode (4, '(f4.1)' , alt1) atab (indi2)

9406    WRITE (hora1,'(i4)') kthor (indi2)
        WRITE (minu1,'(i4)') ktmin (indi2)
        WRITE (alt1,'(f4.1)') atab (indi2)
        write (13,302) br3,hora1,minu1,alt1


 1408 IF(J15)9409,9409,1409
 9409 IF(LDMEX(M2,JC1)-LIN)1409,1410,1410
 1409 INDI3=INDI3-1
      WRITE (13,300) BR3,BR3,BR3,BR4
      GO TO 1412
 1410 KSW(LINTO)=1
      IF(LIN1)9411,9411,9412
 9411 WRITE (13,303) JC100,KTHOR(INDI3),KTMIN(INDI3),ATAB(INDI3)
      GO TO 1412
!c 9412 WRITE (13,302) BR3,KTHOR(INDI3),KTMIN(INDI3),ATAB(INDI3)
!C 9412    encode (4, '(i4)' , hora1) kthor (indi3)
!C        encode (4, '(i4)' , minu1) ktmin (indi3)
!C        encode (4, '(f4.1)' , alt1) atab (indi3)
		
9412    WRITE (hora1,'(i4)') kthor (indi3)
        WRITE (minu1,'(i4)') ktmin (indi3)
        WRITE (alt1,'(f4.1)') atab (indi3)
        write (13,302) br3,hora1,minu1,alt1


 1412 IF(LDMEX(M2,JC2)-LIN)1413,1414,1414
 1413 INDI4=INDI4-1
      WRITE (13,300) BR3,BR3,BR3,BR4
      GO TO 1416
 1414 KSW(LINTO)=1
      IF(LIN1)9414,9414,9415
 9414 WRITE (13,303) JC200,KTHOR(INDI4),KTMIN(INDI4),ATAB(INDI4)
      GO TO 1416
!c 9415 WRITE (13,302) BR3,KTHOR(INDI4),KTMIN(INDI4),ATAB(INDI4)
!C 9415    encode (4, '(i4)' , hora1) kthor (indi4)
!C        encode (4, '(i4)' , minu1) ktmin (indi4)
!C        encode (4, '(f4.1)' , alt1) atab (indi4)
		
9415    WRITE (hora1,'(i4)') kthor (indi4)
        WRITE (minu1,'(i4)') ktmin (indi4)
        WRITE (alt1,'(f4.1)') atab (indi4)
        write (13,302) br3,hora1,minu1,alt1


 1416 IF(J15)9417,9417,1417
 9417 IF(LDMEX(M3,JC1)-LIN)1417,1418,1418
 1417 INDI5=INDI5-1
      WRITE (13,300) BR3,BR3,BR3,BR4
      GO TO 1420
 1418 KSW(LINTO)=1
      IF(LIN1)9421,9421,9422
 9421 WRITE (13,303) JC100,KTHOR(INDI5),KTMIN(INDI5),ATAB(INDI5)
      GO TO 1420
!c 9422 WRITE (13,302) BR3,KTHOR(INDI5),KTMIN(INDI5),ATAB(INDI5)
!C 9422    encode (4, '(i4)' , hora1) kthor (indi5)
!C        encode (4, '(i4)' , minu1) ktmin (indi5)
!C        encode (4, '(f4.1)' , alt1) atab (indi5)

9422    WRITE (hora1,'(i4)') kthor (indi5)
        WRITE (minu1,'(i4)') ktmin (indi5)
        WRITE (alt1,'(f4.1)') atab (indi5)
        write (13,302) br3,hora1,minu1,alt1


 1420 IF(LDMEX(M3,JC2)-LIN)1421,1422,1422
 1421 INDI6=INDI6-1
      WRITE (13,300) BR3,BR3,BR3,BR4
      GO TO 1424
 1422 KSW(LINTO)=1
      IF(LIN1)9425,9425,9426
 9425 WRITE (13,303) JC200,KTHOR(INDI6),KTMIN(INDI6),ATAB(INDI6)
      GO TO 1424
!c 9426 WRITE (13,302) BR3,KTHOR(INDI6),KTMIN(INDI6),ATAB(INDI6)
!C 9426   encode (4, '(i4)'  , hora1) kthor (indi6)
!C        encode (4, '(i4)'  , minu1) ktmin (indi6)
!C        encode (4, '(f4.1)' , alt1) atab (indi6)
		
		
9426    WRITE (hora1,'(i4)') kthor (indi6)
        WRITE (minu1,'(i4)') ktmin (indi6)
        WRITE (alt1,'(f4.1)') atab (indi6)
        write (13,302) br3,hora1,minu1,alt1


 1424 IF(KSW(LINTO))1400,1460,1400
 1460 CONTINUE

      REWIND 13

      DO 1470 LIN=1,LINTO

!c      READ (13,330) (WRIFI(JWR),JWR=1,24)
!c  330 FORMAT(1X,A2,1X,A2,1X,A2,A4)

        read (13,330) (wrifi (jwr), jwr = 1,24)
330     format (a4,a4,a4,a4)

                dia_sai1 = wrifi (1) (3:4)
                hor_sai1 = wrifi (2) (3:4)
                min_sai1 = wrifi (3) (3:4)
                alt_sai1 = wrifi (4) (1:4)

                dia_sai2 = wrifi (5) (3:4)
                hor_sai2 = wrifi (6) (3:4)
                min_sai2 = wrifi (7) (3:4)
                alt_sai2 = wrifi (8) (1:4)

                dia_sai3 = wrifi (9)  (3:4)
                hor_sai3 = wrifi (10) (3:4)
                min_sai3 = wrifi (11) (3:4)
                alt_sai3 = wrifi (12) (1:4)

                dia_sai4 = wrifi (13) (3:4)
                hor_sai4 = wrifi (14) (3:4)
                min_sai4 = wrifi (15) (3:4)
                alt_sai4 = wrifi (16) (1:4)

                dia_sai5 = wrifi (17) (3:4)
                hor_sai5 = wrifi (18) (3:4)
                min_sai5 = wrifi (19) (3:4)
                alt_sai5 = wrifi (20) (1:4)

                dia_sai6 = wrifi (21) (3:4)
                hor_sai6 = wrifi (22) (3:4)
                min_sai6 = wrifi (23) (3:4)
                alt_sai6 = wrifi (24) (1:4)



      IF(KSW(LIN))1465,1470,1465

 1465 if       ((wrifi (1)  .ne. '  ')   .or.&
        &       (wrifi (5)  .ne. '  ')   .or.&
        &       (wrifi (9)  .ne. '  ')   .or.&
        &       (wrifi (13) .ne. '  ')   .or.&
        &       (wrifi (17) .ne. '  ')   .or.&
        &       (wrifi (21) .ne. '  ') ) then

!c      calculo dos dias da linha

        idia1 = idia1 + 1
        idia16 = idia16 + 1

!c        encode (2,'(i2)', dia1) idia1
        WRITE (dia1,'(i2)') idia1
!C        encode (2,'(i2)', dia16) idia16
        WRITE (dia16,'(i2)') idia16

        call semana (dia1, mes_semana1, ano_tabua, indice)
        pri = tab_semana (indice)
        call semana (dia16, mes_semana1, ano_tabua, indice)
        seg = tab_semana (indice)
        call semana (dia1, mes_semana2, ano_tabua, indice)
        ter = tab_semana (indice)
        call semana (dia16, mes_semana2, ano_tabua, indice)
        qua = tab_semana (indice)
        call semana (dia1, mes_semana3, ano_tabua, indice)
        qui = tab_semana (indice)
        call semana (dia16, mes_semana3, ano_tabua, indice)
        sex = tab_semana (indice)

        if (wrifi (1)  .eq. '  ') pri = '   '
        if (wrifi (5)  .eq. '  ') seg = '   '
        if (wrifi (9)  .eq. '  ') ter = '   '
        if (wrifi (13) .eq. '  ') qua = '   '
        if (wrifi (17) .eq. '  ') qui = '   '
        if (wrifi (21) .eq. '  ') sex = '   '

        write (12,5000)

!c      write (12,55) (wrifi(jwr),jwr=1,24)
        write (12,55)   dia_sai1,hor_sai1,min_sai1,alt_sai1,&
        &               dia_sai2,hor_sai2,min_sai2,alt_sai2,&
        &               dia_sai3,hor_sai3,min_sai3,alt_sai3,&
        &               dia_sai4,hor_sai4,min_sai4,alt_sai4,&
        &               dia_sai5,hor_sai5,min_sai5,alt_sai5,&
        &               dia_sai6,hor_sai6,min_sai6,alt_sai6



        ichave = 1

      else
        if (ichave .eq. 1 ) then
                ichave = 0

                primeira_linha = '     ' // dia_sai1 // '  ' // hor_sai1 //&
        &       min_sai1 // '  ' // alt_sai1 // '     ' // dia_sai2 //&
        &       '  ' // hor_sai2 // min_sai2 // '  ' // alt_sai2 //&
        &       '        ' // dia_sai3 // '  ' // hor_sai3 // min_sai3 //&
        &       '  ' // alt_sai3 // '     ' // dia_sai4 // '  ' //&
        &       hor_sai4 // min_sai4 // '  ' // alt_sai4 // '        ' //&
        &       dia_sai5 // '  ' // hor_sai5 // min_sai5 // '  '  //&
        &       alt_sai5 // '     ' // dia_sai6 // '  ' // hor_sai6 //&
        &       min_sai6 // '  ' // alt_sai6


                segunda_linha = '    ' // pri // '                ' //&
        &       seg // '                   ' // ter // '                ' //&
        &       qua // '                   ' // qui // '                ' //&
        &       sex

                linha_grande = primeira_linha // controle // segunda_linha

                write (12,56) linha_grande
!c              write (12,56) linha_certa

        else
!c              write (12,55) (wrifi(jwr),jwr=1,24)
        write (12,55)   dia_sai1,hor_sai1,min_sai1,alt_sai1,&
        &               dia_sai2,hor_sai2,min_sai2,alt_sai2,&
        &               dia_sai3,hor_sai3,min_sai3,alt_sai3,&
        &               dia_sai4,hor_sai4,min_sai4,alt_sai4,&
        &               dia_sai5,hor_sai5,min_sai5,alt_sai5,&
        &               dia_sai6,hor_sai6,min_sai6,alt_sai6

        end if

      end if

55      FORMAT(5X,3(A2,2X,2A2,2X,A4,5X,A2,2X,2A2,2X,A4,8X))

!c  56 format (a,4x,a,16x,a,19x,a,16x,a,19x,a,16x,a)

56      format (a)

 1470 CONTINUE
      M=M+3
      M2=M2+3
      M3=M3+3

        call saltafolha_tabua

 1480 CONTINUE

 1500 CONTINUE

        close (unit= 11)
        close (unit= 12)
        close (unit= 13,status='delete')

       RETURN
       END



SUBROUTINE semana (dia,mes,ano,indice)

!c      Esta subroutina calcula o dia da semana a partir de uma data enviada.
!c      O valor retornado ao programa principal e' o indice de uma tabela da
!c      semana. Cada programa usara as letras necessarias.

        character*2     dia
        character*2     mes
        character*4     ano

        real*4          d1,m1,a1,x
        integer*4       jd,indice

!C        decode (2,'(f2.0)', dia) d1
		READ (dia,'(f2.0)') dl
!C        decode (2,'(f2.0)', mes) m1
		READ (mes,'(f2.0)') ml
!C        decode (4,'(f4.0)', ano) a1
		READ (ano,'(f4.0)') al
        
        if (m1 .eq. 1  .or.   m1 .eq. 2) then
          a1 = a1 - 1.
          m1 = m1 + 13.
        else
          m1 = m1 + 1.
        end if

        jd = jint (a1 * 365.25) - jint (a1 / 100.) + jint (a1 /400.) +&
        &       jint (30.6001 * m1) + d1 - 478164.

        x = floatj (jd)

        indice = (x - 7. * jint (x / 7.)) + 1

        return
end


SUBROUTINE SaltaFolha_Tabua

        character*1     ff

        ff =  char(12)
        Write(12,1) ff
1       format (a)

  Return
End


