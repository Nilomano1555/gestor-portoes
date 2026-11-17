# Gestor Portões — MVP 0.1 (configurado para seu Supabase)

Aplicação web responsiva instalável (PWA), preparada para Android e computador. A sincronização entre dispositivos usa Supabase (Postgres + Auth + Row Level Security).

## Conexão preparada
O arquivo `.env.local` já contém a URL do seu projeto e a chave pública (publishable) informadas na conversa. A URL foi normalizada para a raiz do projeto — não use o sufixo `/rest/v1/` no `VITE_SUPABASE_URL`.

## Passos obrigatórios no painel Supabase
1. Abra seu projeto `vrmrhceydtowhjxgaupj` em https://supabase.com/dashboard.
2. Entre em **SQL Editor → New query**.
3. Abra o arquivo `supabase/schema.sql`, copie todo o conteúdo e execute no SQL Editor. Isso cria as tabelas e as políticas RLS que isolam os dados por usuário.
4. Entre em **Authentication → Users → Add user** e crie seu usuário com e-mail e senha. Não compartilhe a senha aqui.
5. Em **Authentication → Providers**, confirme que **Email** está habilitado. Se a confirmação de e-mail estiver ligada, confirme o endereço antes de entrar.

## Executar no computador
Requer Node.js 20 ou superior.

```bash
npm install
npm run dev
```

Abra o endereço local mostrado pelo Vite e entre com o e-mail e senha criados no Supabase.

## Gerar e publicar

```bash
npm run build
```

Publique o conteúdo da pasta `dist/` em um serviço de hospedagem HTTPS (por exemplo, Vercel ou Netlify). Configure no painel da hospedagem as mesmas variáveis de ambiente:

- `VITE_SUPABASE_URL=https://vrmrhceydtowhjxgaupj.supabase.co`
- `VITE_SUPABASE_ANON_KEY` = a chave `sb_publishable_...` do projeto.

Depois de publicar, abra o mesmo endereço no Android e no computador. Entre com a mesma conta para consultar os dados sincronizados.

## Segurança
- A chave `sb_publishable_...` é uma chave pública própria para uso no cliente. Ela não substitui as políticas RLS.
- Nunca coloque `service_role`, `secret key`, senha de banco ou senha de usuário no aplicativo ou em mensagens.
- Execute o `schema.sql` antes do primeiro login. As tabelas `clients`, `jobs` e `service_catalog` usam RLS e vinculam cada registro ao usuário autenticado.
- Mantenha a confirmação de e-mail e uma senha forte na conta.

## O que esta versão implementa
- Painel com indicadores básicos.
- Cadastro e pesquisa de clientes.
- Agenda/listagem de atendimentos.
- Ordens de serviço com etapas editáveis e status de pagamento.
- Catálogo de serviços e preços editáveis.
- Resumo financeiro simples.
- Interface responsiva e PWA.

## Limitações atuais do MVP
- Notificação no código atual apenas solicita permissão e faz um teste local; lembretes automáticos antecipados com aplicativo fechado ainda precisam ser desenvolvidos.
- Upload de fotos, checklist persistente, ficha técnica completa, orçamento PDF e estoque ainda não estão implementados.
- A sincronização só estará ativa depois de executar o SQL, criar o usuário de autenticação e publicar/executar a aplicação com as variáveis de ambiente configuradas.
