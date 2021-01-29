CREATE SEQUENCE usuario_codigo_usu_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE database_codigo_dat_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*
CREATE SEQUENCE pais_codigo_pai_seq 
    INCREMENT 1 
    START 1 
    MINVALUE 1 
    MAXVALUE 2147483647 
    CACHE 1;


CREATE SEQUENCE uf_codigo_uf_seq 
    INCREMENT 1 
    START 1 
    MINVALUE 1 
    MAXVALUE 2147483647 
    CACHE 1;

CREATE SEQUENCE municipio_codigo_mun_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
*/

CREATE SEQUENCE empbolsa_codigo_emb_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE SEQUENCE tickerb3_codigo_tb3_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

CREATE TABLE database
(
    codigo_dat integer NOT NULL DEFAULT nextval('database_codigo_dat_seq'::regclass),
    host_dat character(250) COLLATE pg_catalog."default" NOT NULL,
    porta_dat character(5) COLLATE pg_catalog."default" NOT NULL DEFAULT 5432,
    login_dat character(250) COLLATE pg_catalog."default" NOT NULL,
    senha_dat character(250) COLLATE pg_catalog."default" NOT NULL,
    obs_dat text COLLATE pg_catalog."default",
    CONSTRAINT database_pkey PRIMARY KEY (codigo_dat)
);

COMMENT ON COLUMN database.codigo_dat
    IS 'Codigo do database';

COMMENT ON COLUMN database.host_dat
    IS 'endereco database';

COMMENT ON COLUMN database.porta_dat
    IS 'porta database';

COMMENT ON COLUMN database.login_dat
    IS 'usuário para o database';

COMMENT ON COLUMN database.senha_dat
    IS 'senha para conexão';

COMMENT ON COLUMN database.obs_dat
    IS 'observações sobre esta conexão';

CREATE TABLE usuario
(
    codigo_usu integer NOT NULL DEFAULT nextval('usuario_codigo_usu_seq'::regclass),
    login_usu character(250) COLLATE pg_catalog."default" NOT NULL,
    passwd_usu character(250) COLLATE pg_catalog."default" NOT NULL,
    ativo_usu boolean NOT NULL DEFAULT true,
    isconf_usu boolean NOT NULL DEFAULT false,
    nome_usu character(250) COLLATE pg_catalog."default",
    telcom_usu character(250) COLLATE pg_catalog."default",
    datins_usu timestamp without time zone NOT NULL,
    coddat_usu integer,
    CONSTRAINT usuario_pkey PRIMARY KEY (codigo_usu),
    CONSTRAINT unique_login_usu UNIQUE (login_usu),
    CONSTRAINT fk_database_usuario FOREIGN KEY (coddat_usu)
        REFERENCES database (codigo_dat) MATCH SIMPLE
 );

COMMENT ON COLUMN usuario.codigo_usu
    IS 'Código';

COMMENT ON COLUMN usuario.login_usu
    IS 'Login(e-mail) usuário';

COMMENT ON COLUMN usuario.passwd_usu
    IS 'Password';

COMMENT ON COLUMN usuario.ativo_usu
    IS 'Usuário ativo?';

COMMENT ON COLUMN usuario.isconf_usu
    IS 'Usuário realizou a confirmação de e-mail?';

COMMENT ON COLUMN usuario.nome_usu
    IS 'Nome do usuário';

COMMENT ON COLUMN usuario.telcom_usu
    IS 'Telefone do usuário';

CREATE TABLE pais

(
    codigo_pai integer NOT NULL, -- DEFAULT nextval('pais_codigo_pai_seq'::regclass),
    descri_pai character(250) COLLATE pg_catalog."default" NOT NULL,
    codibg_pai integer,
    codscx_pai integer,
    codbac_pai integer,
    codddi_pai integer,
    codirr_pai integer,
    CONSTRAINT codigo_pai PRIMARY KEY (codigo_pai),
    CONSTRAINT descri_pai UNIQUE (descri_pai)
);

COMMENT ON TABLE pais
    IS 'Cadastros de Paises';

COMMENT ON COLUMN pais.codigo_pai
    IS 'Codigo do pais';

COMMENT ON COLUMN pais.descri_pai
    IS 'Descricao do pais';

COMMENT ON COLUMN pais.codibg_pai
    IS 'Codigo do pais IBGE';

COMMENT ON COLUMN pais.codscx_pai
    IS 'Codigo do pais SisComex';

COMMENT ON COLUMN pais.codbac_pai
    IS 'Codigo do pais Bacen';

COMMENT ON COLUMN pais.codddi_pai
    IS 'Codigo DDI do pais';

COMMENT ON COLUMN pais.codirr_pai
    IS 'Codigo Programa IRRF';

CREATE TABLE uf
(
    -- codibg_uf integer,
    codigo_uf integer NOT NULL, -- DEFAULT nextval('uf_codigo_uf_seq'::regclass),
    codpai_uf integer NOT NULL,
    sigla_uf character(2) COLLATE pg_catalog."default" NOT NULL,
    descri_uf character(250) COLLATE pg_catalog."default" NOT NULL,
    cnpj_uf character(20) COLLATE pg_catalog."default" NOT NULL,
    utcinv_uf integer,
    utcver_uf integer,
    CONSTRAINT codigo_uf PRIMARY KEY (codigo_uf),
    CONSTRAINT unique_cnpj_uf UNIQUE (cnpj_uf)
        INCLUDE(cnpj_uf),
   --  CONSTRAINT unique_codibg_uf UNIQUE (codibg_uf),
    CONSTRAINT codpai_uf FOREIGN KEY (codpai_uf)
        REFERENCES pais (codigo_pai) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON COLUMN uf.codigo_uf
    IS 'codigo da uf';

COMMENT ON COLUMN uf.sigla_uf
    IS 'Sigla da uf';

COMMENT ON COLUMN uf.descri_uf
    IS 'descricao da uf';

COMMENT ON COLUMN uf.cnpj_uf
    IS 'CNPJ da uf';

COMMENT ON COLUMN uf.utcinv_uf
    IS 'UTC horario de inverno';

COMMENT ON COLUMN uf.utcver_uf
    IS 'UTC horario de verao';
	
/*
COMMENT ON COLUMN uf.codibg_uf
    IS 'Codigo da uf do IBGE';
*/
CREATE TABLE municipio
(
    codigo_mun integer NOT NULL, -- DEFAULT nextval('municipio_codigo_mun_seq'::regclass),
    -- codibg_mun integer NOT NULL,
    descri_mun character(250) COLLATE pg_catalog."default" NOT NULL,
    coduf_mun integer,
    CONSTRAINT municipio_pkey PRIMARY KEY (codigo_mun),
   -- CONSTRAINT unique_codibg_mun UNIQUE (codibg_mun),
    CONSTRAINT fk_municipio_uf FOREIGN KEY (coduf_mun)
        REFERENCES public.uf (codigo_uf) MATCH SIMPLE
);

COMMENT ON TABLE municipio
    IS 'Lista de municípios';

COMMENT ON COLUMN municipio.codigo_mun
    IS 'Código';
/*
COMMENT ON COLUMN municipio.codibg_mun
    IS 'Código municipios do IBGE';
*/
COMMENT ON COLUMN municipio.descri_mun
    IS 'Descrição municipios';
	
COMMENT ON COLUMN municipio.coduf_mun
    IS 'Código da UF';

CREATE TABLE empbolsa
(
	codigo_emb integer NOT NULL DEFAULT nextval('empbolsa_codigo_emb_seq'::regclass),
    cnpj_emb character(20) NOT NULL,
    descri_emb character(250) NOT NULL,
    apelid_emb character(250) NOT NULL,
    codcvm_emb integer NOT NULL,
    coduf_emb integer NOT NULL,
    codpai_emb integer NOT NULL,
    ativo_emb boolean NOT NULL DEFAULT true,
    datins_emb timestamp without time zone NOT NULL,
    CONSTRAINT codigo_emb PRIMARY KEY (codigo_emb),
    CONSTRAINT cnpj_emb UNIQUE (cnpj_emb)
        INCLUDE(cnpj_emb),
    CONSTRAINT codcvm_emb UNIQUE (codcvm_emb)
        INCLUDE(codcvm_emb),
    CONSTRAINT coduf_emb FOREIGN KEY (coduf_emb)
        REFERENCES uf (codigo_uf) MATCH SIMPLE,
    CONSTRAINT codpai_emb FOREIGN KEY (codpai_emb)
        REFERENCES pais (codigo_pai) MATCH SIMPLE
);

COMMENT ON TABLE empbolsa
    IS 'Empresas listadas na b3'; 

COMMENT ON COLUMN empbolsa.codigo_emb 
    IS 'Codigo da empresa'; 

COMMENT ON COLUMN empbolsa.descri_emb 
    IS 'Descricao da empresa'; 

COMMENT ON COLUMN empbolsa.apelid_emb 
    IS 'Apelido da empresa'; 

COMMENT ON COLUMN empbolsa.codcvm_emb 
    IS 'Codigo CVM da empresa'; 

COMMENT ON COLUMN empbolsa.ativo_emb 
    IS 'Empresa ativa?'; 

COMMENT ON COLUMN empbolsa.datins_emb 
    IS 'data e hora de insercao do registro';

CREATE TABLE tickerb3
(
    codigo_tb3 integer NOT NULL DEFAULT nextval('tickerb3_codigo_tb3_seq'::regclass),
    codatv_tb3 character(6) COLLATE pg_catalog."default" NOT NULL,
    codemb_tb3 integer NOT NULL,
    ativo_tb3 boolean NOT NULL DEFAULT true,
    CONSTRAINT tickerb3_pkey PRIMARY KEY (codigo_tb3),
    CONSTRAINT unique_codatv_tb3 UNIQUE (codatv_tb3),
    CONSTRAINT fk_codemb_tb3 FOREIGN KEY (codemb_tb3)
        REFERENCES empbolsa (codigo_emb) MATCH SIMPLE
        
);

COMMENT ON TABLE tickerb3
    IS 'lista de ativos da b3';

COMMENT ON COLUMN tickerb3.codigo_tb3
    IS 'codigo';

COMMENT ON COLUMN tickerb3.codatv_tb3
    IS 'código do ativo negociável';
	
COMMENT ON COLUMN tickerb3.codemb_tb3
    IS 'código da empresa';
	
COMMENT ON COLUMN tickerb3.ativo_tb3
    IS 'ticker ativo';