<a name="readme-top"></a>

# teste_caique_marvel_app

<details>
  <summary>Sumário</summary>
  <ol>
    <li><a href="#sobre-projeto">Sobre o projeto</a></li>
    <li><a href="#bibliotecas-utilizadas">Bibliotecas utilizadas</a></li>     
    <li><a href="#arquitetura-escolhida">Arquitetura escolhida</a></li>
    <li><a href="#espiracao-design">Espiração de design</a></li>
  </ol>
</details>

<!-- Sobre Projeto -->
## <div id="sobre-projeto">Sobre o projeto</div>

Este projeto têm como interesse a realização de um teste de proficiência técnica,
no framework Flutter para a empresa SoftDesign.

<!-- Bibliotecas utilizadas -->
## <div id="bibliotecas-utilizadas">Bibliotecas utilizadas</div>

Este projeto fez uso das seguintes bibliotecas, afim de trazer melhor produtividade
ao desenvolvimento do teste:

<li><strong>json_annotation</strong> - Utilizado para mapear os <strong>models</strong> com maior simplicidade, auxiliando no seu entendimento e manuseio.</li>
<li><strong>dartz</strong> - Utilizado para o <strong>error handling</strong> com failures.</li>
<li><strong>dio</strong> - Utilizado para a realização das requisições http.</li>
<li><strong>flutter_secure_storage</strong> - Utilizado para armazenar de forma segura as credenciais.</li>
<li><strong>mobx</strong> - Utilizado para gerenciamento de estado.</li>
<li><strong>flutter_mobx</strong> - Utilizado para gerenciamento de estado.</li>
<li><strong>skeleton_text</strong> - Utilizado para o design dos loadings.</li>
<li><strong>crypto</strong> - Utilizado para a criptografia md5 necessária para a autorização na api da marvel.</li>
<li><strong>flutter_lints</strong> - Utilizado para qualidade de código.</li>
<li><strong>build_runner</strong> - Utilizado para a geração de código.</li>
<li><strong>json_serializable</strong> - Utilizado para mapear os <strong>models</strong> com maior simplicidade, auxiliando no seu entendimento e manuseio.</li>
<li><strong>logger</strong> - Utilizado para monitorar os logs das requisições http.</li>
<li><strong>mobx_codegen</strong> - Utilizado como suporte ao mobx.</li>
<li><strong>mockito</strong> - Utilizado para criação de mocks.</li>

<!-- Bibliotecas utilizadas -->
## <div id="arquitetura-escolhida">Arquitetura escolhida</div>

### Estrutura dividida por escopo

    .                  
    ├── features                              # Todas as Features
    │   ├─ character_detail                       
    │   │  ├── controllers                    # Controlles utilizados
    │   │  ├── entity                         # Classes utilizadas na camada View
    │   │  ├── models                         # Classes utilizadas na camada Model
    │   │  ├── pages                          
    |   |  |   └── widgets                    # Designs utilizadas na feature
    │   │  ├── repositories                   # Repositórios utilizados na feature
    │   │  └── usecases                       # Casos de uso da feature           
    |   |
    │   └── home                                   
    │      ├── controllers                      
    │      ├── entity                           
    │      ├── models                           
    │      ├── pages                            
    |      |   └── widgets                      
    │      ├── repositories                     
    │      └── usecases                                                              
    ├── core                                  # Utilitários globais                
    │   ├── design                            # Designs utilizadas globalmente
    │   ├── extensions                        # Extensões de funcionalidades de classes nativas
    │   ├── failures                          # Classe de Failures para controle de erro
    │   ├── infraestruture                            
    |   |   ├── config                        # Constantes de configuração
    |   |   ├── local_storage                 # Armazenamento de informação
    |   |   ├── log                           # Monitoramento das chamadas da api
    |   |   └── datasource    
    |   |       └── http_client               # Estrutura para as requisições de http                       
    |   |
    │   └── presentantion                     # Constante
    └── main.dart                             # runApp 

<!-- Bibliotecas utilizadas -->
## <div id="espiracao-design">Espiração de design</div>
Para a criação deste projeto utilizei dois layouts como inspiração:

<li><a href="https://dribbble.com/shots/17897098-Comic-Subscription-App/attachments/13074433?mode=media">Desing app marvel - Dribbble</a></li>
<li><a href="https://dribbble.com/shots/15445373-Comic-App/attachments/7215588?mode=media">Desing app quadrinhos - Dribbble</a></li>
<li><a href="https://www.figma.com/community/file/1227220980074899885">Desing app música - figma</a></li>


<p align="right">(<a href="#readme-top">back to top</a>)</p>