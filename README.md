## Lembretes App (Flutter)
Este é o README.md para o aplicativo "Lembretes App", desenvolvido em Flutter. O aplicativo permite criar e visualizar lembretes com datas associadas. Ele utiliza o Firebase para armazenar os lembretes e sincronizar os dados em tempo real.

###  Instalação
Antes de executar o aplicativo, é necessário ter o ambiente de desenvolvimento do Flutter configurado em sua máquina. Caso ainda não tenha feito isso, siga as instruções para configurar o ambiente.

Flutter: 3.10.6 => https://docs.flutter.dev/get-started/install

JDK: 11 => https://www.oracle.com/br/java/technologies/javase/jdk11-archive-downloads.html

Gradle: 7.4.2

Após configurar o ambiente, siga os passos abaixo para executar o aplicativo:

#### Clone este repositório:

git clone git@github.com:leticiatakenaka/reminder-app.git

cd reminder-app

####  Instale as dependências do projeto:

flutter pub get

Certifique-se de que o emulador ou um dispositivo físico esteja conectado ao computador.

#### Execute o aplicativo:

flutter run

### Funcionalidades

Adicionar e visualizar lembretes com títulos e datas associadas.
Atualizar lembretes existentes.
Excluir lembretes da lista.
Os lembretes são agrupados por data e são exibidos em ordem crescente de data.
#### Arquivos Principais

main.dart: Contém a função main() para inicialização do aplicativo e a classe Main, que é a classe principal do aplicativo, responsável por configurar temas e localizações.

home.dart: Contém a classe Home, que é a tela inicial do aplicativo e exibe a lista de lembretes.

formulario.dart: Contém a classe FormularioDialog, que é um formulário em forma de diálogo utilizado para adicionar ou atualizar os lembretes.

#### Dependências Externas

flutter_localizations: Pacote que fornece localizações para a internacionalização do aplicativo.

intl: Pacote para formatação de datas e horas.

firebase_core: Pacote do Firebase para inicializar o Firebase no aplicativo.

cloud_firestore: Pacote do Firebase para interação com o Firestore, o banco de dados em tempo real.