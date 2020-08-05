Download e consumo de arquivos do BDGEx pelo SisGeoDef

- Interagindo com o servidor de catálogo:

Abra um request POST para o nosso servidor (http://bdgex.eb.mil.br/csw) e envie como conteúdo o xml do da busca. Por exemplo, para listas os arquivos vetoriais 1:25000 pode-se usar o arquivo pesquisar_vetoriais_25000.xml. Estes arquivos XML são apenas exemplos. O SisGeoDef terá liberdade de consumir qualquer arquivo listado no CSW.
Dentro de <csw:SearchResults> estarão listados vários <gmd:MD_Metadata>. Cada um corresponde a um arquivo encontrado na região.
Para obter o link de download acesse a tag: <gmd:onLine><gmd:CI_OnlineResource><gmd:linkage><gco:CharacterString>
Um exemplo de resposta se encontra em pesquisar_vetoriais_25000_resposta.xml

Os demais arquivos XML representam outros exemplos de pesquisas (consulta de MDS, Ortoimagens, etc). Note que todos os exemplos tem um retângulo envolvente que restringe a área de pesquisa (em <ogc:BBOX><ogc:PropertyName>ows:BoundingBox</ogc:PropertyName><gml:Envelope>). Este retângulo pode ser alterado para criar o efeito de baixar os produtos de determinada região.

Exemplo:
    curl -X POST -d @pesquisar_ortoimagem.xml http://bdgex.eb.mil.br/csw


- URL de download

Para baixar os arquivos propriamente ditos, o sistema deverá fazer login antes. Exemplo:


    curl -k -d "email=sisgeodef@sisgeodef.mil.br&senha=sisgeodef2019" -X POST 'https://bdgex.eb.mil.br/mediador/index.php?modulo=login&acao=verificar'     --cookie "cookies.txt" --cookie-jar "cookies.txt"

Para efetuar o download utiliza-se o endereço fornecido no csw (caso esteja www.geoportal.eb.mil.br, trocar para bdgex.eb.mil.br): 
    
    curl -k "https://bdgex.eb.mil.br/mediador/index.php?modulo=download&acao=baixar&identificador=28e325a6-c7e8-11df-adb5-00270e07db9f" --cookie "cookies.txt" --cookie-jar "cookies.txt" --output teste.tif
    
- Importação
    O arquivo "cg_arquivocampo.txt" apresenta a conversão de atributos. Os atributos que nossos Shapefiles trazem tem limitações de caracteres. Para utilizar os nomes de atributos completos, conforme a EDGV, deve-se trocar o nome das colunas no ETL. Recomendamos remover do nome da classe a categoria (Representada nos quatro primeiros dígitos. Ex.: HID_) para facilitar a etapa a seguir. Também é recomendado colocar os nomes das classes em letras minúsculas.
    
- Simbolização
    Os arquivos SLD encontram-se no arquivo sld.zip. Existe um para cada camada. Naturalmente, nem todos serão usados, pois nem todos produtos possuem todas camadas. Os nomes dos arquivos são os nomes das classes especificadas em cg_arquivocampo, cortando a categoria (Ex.: HID_Trecho_Drenagem_L será trecho_drenagem_l.sld ). Estes estilos são os atuais do BDGEx. Não são muito similares às cartas topográficas. Foram projetados para a visualização em tela, comumente sobrepondo imagens de satélite.
    
- Opção 2: Utilizar apenas as camadas do WFS multiescala
    Acessar os dados vetoriais via WFS em http://bdgex.eb.mil.br/wfs
    Utilizar os SLDs para representá-los.
    
    
-CAMADAS

Recomendamos a utilização das seguintes camadas, preferêncialmente agrupadas:

Transportes:
    Trecho_Rodoviario_L,Trecho_Ferroviario_L,Arruamento_L,Travessia_L,Passag_elevada_viaduto_L,Ponte_L,Tunel_L,Identificador_Trecho_Rodoviario_P

Localidades:
    Capital_P,Cidade_P,Vila_P,Aglomerado_Rural_Isolado_P,Unidade_Federacao_A,Municipio_A

Relevo:
    Curva_Nivel_L,Curva_Forma_L,Ponto_Cotado_Altimetrico_P

Hidrografia:
    Trecho_Drenagem_L,Trecho_Massa_Dagua_A,Massa_Dagua_A,Barragem_A,Barragem_L


    
