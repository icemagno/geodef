--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

-- Started on 2019-03-21 17:41:40 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16385)
-- Name: access_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_log (
    log_id bigint NOT NULL,
    date timestamp without time zone,
    header text,
    method character varying(20),
    querystring character varying(255),
    remoteaddr character varying(50),
    remotehost character varying(50),
    remoteuser character varying(100),
    remoteuserid bigint,
    remoteusername character varying(255),
    requesturl character varying(255),
    accesstype character varying(255),
    profileimage character varying(100),
    access_type character varying(255)
);


ALTER TABLE public.access_log OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16391)
-- Name: access_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.access_log_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_log_log_id_seq OWNER TO postgres;

--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 197
-- Name: access_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.access_log_log_id_seq OWNED BY public.access_log.log_id;


--
-- TOC entry 198 (class 1259 OID 16393)
-- Name: clientdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientdetails (
    client_id character varying(255) NOT NULL,
    access_token_validity integer,
    additional_information text,
    app_id character varying(255),
    app_secret character varying(255),
    authorities character varying(255),
    auto_approve_scopes character varying(255),
    grant_types character varying(255),
    redirect_url character varying(255),
    refresh_token_validity integer,
    resource_ids character varying(255),
    scope character varying(255)
);


ALTER TABLE public.clientdetails OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16399)
-- Name: oauth_access_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_access_token (
    authentication_id character varying(255) NOT NULL,
    authentication bytea,
    client_id character varying(255),
    refresh_token character varying(255),
    token bytea,
    token_id character varying(255),
    user_name character varying(255)
);


ALTER TABLE public.oauth_access_token OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16405)
-- Name: oauth_approvals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_approvals (
    pk_id bigint NOT NULL,
    clientid character varying(255),
    expiresat date,
    lastmodifiedat date,
    scope character varying(255),
    status character varying(10),
    userid character varying(255),
    client_id character varying(255),
    expires_at date,
    last_modified_at date,
    user_id character varying(255)
);


ALTER TABLE public.oauth_approvals OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16411)
-- Name: oauth_approvals_pk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_approvals_pk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_approvals_pk_id_seq OWNER TO postgres;

--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 201
-- Name: oauth_approvals_pk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_approvals_pk_id_seq OWNED BY public.oauth_approvals.pk_id;


--
-- TOC entry 202 (class 1259 OID 16413)
-- Name: oauth_client_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_client_details (
    client_id character varying(255) NOT NULL,
    access_token_validity integer,
    additional_information text,
    authorities character varying(255),
    authorized_grant_types character varying(255),
    autoapprove character varying(50),
    client_secret character varying(255),
    refresh_token_validity integer,
    resource_ids character varying(255),
    scope character varying(255),
    web_server_redirect_uri character varying(255)
);


ALTER TABLE public.oauth_client_details OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16419)
-- Name: oauth_client_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_client_token (
    authentication_id character varying(255) NOT NULL,
    client_id character varying(255),
    token bytea,
    token_id character varying(255),
    user_name character varying(255)
);


ALTER TABLE public.oauth_client_token OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16425)
-- Name: oauth_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_code (
    pk_id bigint NOT NULL,
    authentication bytea,
    code character varying(255)
);


ALTER TABLE public.oauth_code OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16431)
-- Name: oauth_code_pk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_code_pk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_code_pk_id_seq OWNER TO postgres;

--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 205
-- Name: oauth_code_pk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_code_pk_id_seq OWNED BY public.oauth_code.pk_id;


--
-- TOC entry 206 (class 1259 OID 16433)
-- Name: oauth_refresh_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_refresh_token (
    pk_id bigint NOT NULL,
    authentication bytea,
    token bytea,
    token_id character varying(255)
);


ALTER TABLE public.oauth_refresh_token OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16439)
-- Name: oauth_refresh_token_pk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oauth_refresh_token_pk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth_refresh_token_pk_id_seq OWNER TO postgres;

--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 207
-- Name: oauth_refresh_token_pk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oauth_refresh_token_pk_id_seq OWNED BY public.oauth_refresh_token.pk_id;


--
-- TOC entry 208 (class 1259 OID 16441)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    enabled boolean NOT NULL,
    full_name character varying(200) NOT NULL,
    funcao character varying(100),
    user_name character varying(100) NOT NULL,
    origem character varying(200),
    password character varying(100) NOT NULL,
    profile_image character varying(255) NOT NULL,
    setor character varying(100),
    telefone character varying(20),
    cpf character varying(14),
    email character varying(100)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16447)
-- Name: users_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_clients (
    client_client_id character varying(255) NOT NULL,
    user_user_id bigint NOT NULL,
    dt_final timestamp without time zone,
    dt_inicial timestamp without time zone,
    sysadmin boolean,
    dt_alteracao timestamp without time zone,
    respalteracao character varying(255),
    tipoalteracao character varying(255)
);


ALTER TABLE public.users_clients OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16453)
-- Name: users_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_roles (
    user_role_id bigint NOT NULL,
    role_name character varying(255) NOT NULL,
    user_id bigint
);


ALTER TABLE public.users_roles OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16456)
-- Name: users_roles_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_roles_user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_roles_user_role_id_seq OWNER TO postgres;

--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_roles_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_roles_user_role_id_seq OWNED BY public.users_roles.user_role_id;


--
-- TOC entry 212 (class 1259 OID 16458)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 212
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 2800 (class 2604 OID 16460)
-- Name: access_log log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_log ALTER COLUMN log_id SET DEFAULT nextval('public.access_log_log_id_seq'::regclass);


--
-- TOC entry 2801 (class 2604 OID 16461)
-- Name: oauth_approvals pk_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_approvals ALTER COLUMN pk_id SET DEFAULT nextval('public.oauth_approvals_pk_id_seq'::regclass);


--
-- TOC entry 2802 (class 2604 OID 16462)
-- Name: oauth_code pk_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_code ALTER COLUMN pk_id SET DEFAULT nextval('public.oauth_code_pk_id_seq'::regclass);


--
-- TOC entry 2803 (class 2604 OID 16463)
-- Name: oauth_refresh_token pk_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_refresh_token ALTER COLUMN pk_id SET DEFAULT nextval('public.oauth_refresh_token_pk_id_seq'::regclass);


--
-- TOC entry 2804 (class 2604 OID 16464)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 2805 (class 2604 OID 16465)
-- Name: users_roles user_role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles ALTER COLUMN user_role_id SET DEFAULT nextval('public.users_roles_user_role_id_seq'::regclass);


--
-- TOC entry 2954 (class 0 OID 16385)
-- Dependencies: 196
-- Data for Name: access_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.access_log (log_id, date, header, method, querystring, remoteaddr, remotehost, remoteuser, remoteuserid, remoteusername, requesturl, accesstype, profileimage, access_type) FROM stdin;
67	2019-01-11 17:05:40.716	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 98257</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>dnt : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundary31ARI2ypKYRAyLQU</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/user/1</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : remember-me=YWRtaW4lNDBhZG1pbjoxNTQ4NDI4NzMzNzk5OmE2NTNlM2IxMDk2NGQ5ZTgyY2U0MjhkMGU5MDEzMGIz; JSESSIONID=048C2AFB57ED3AA56E48F277E293DD98</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário admin@admin (Administrador do Sistema)	\N	cecd53a295b646dc974800b3e2b80764.png	USER
68	2019-01-14 15:13:12.573	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 1542</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>dnt : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundary6EBBJCY5RIYPa0L9</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/user/553</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : remember-me=YWRtaW4lNDBhZG1pbjoxNTQ4NDI4NzMzNzk5OmE2NTNlM2IxMDk2NGQ5ZTgyY2U0MjhkMGU5MDEzMGIz; JSESSIONID=6DC1AFE5F81B76B3D402A5A5E2B66451</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário user@user (Usuário Comum)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
69	2019-01-14 16:56:55.205	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 8440</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundary6SvwB4txlYuHAE2e</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/newUser</br>accept-encoding : gzip, deflate</br>accept-language : en-US,en;q=0.9</br>cookie : JSESSIONID=516A9B8F5C4EE8748B157F76B98ECD92</br>	POST	\N	10.5.115.110	10.5.115.110	admin@admin	1	Administrador do Sistema	Criação do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
70	2019-01-14 16:57:37.903	host : 10.5.115.180:36201</br>connection : keep-alive</br>content-length : 233201</br>cache-control : max-age=0</br>origin : http://10.5.115.180:36201</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundaryduQxGVw6OAXMddDi</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://10.5.115.180:36201/newUser</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=50F19ED4988E9744D6D663481B356970</br>	POST	\N	10.5.115.118	10.5.115.118	admin@admin	1	Administrador do Sistema	Criação do usuário primoreno (Priscilla Moreno)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
71	2019-01-14 17:01:14.026	host : 10.5.115.180:36201</br>connection : keep-alive</br>content-length : 526359</br>cache-control : max-age=0</br>origin : http://10.5.115.180:36201</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundarywGLwIwlnspBNKP14</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://10.5.115.180:36201/user/555</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=50F19ED4988E9744D6D663481B356970</br>	POST	\N	10.5.115.118	10.5.115.118	admin@admin	1	Administrador do Sistema	Atualização do usuário primoreno (Priscilla Moreno)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
72	2019-01-14 17:03:28.594	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 1642</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>dnt : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundary1itPpZE2vbneP3ep</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/user/555</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : remember-me=YWRtaW4lNDBhZG1pbjoxNTQ4NDI4NzMzNzk5OmE2NTNlM2IxMDk2NGQ5ZTgyY2U0MjhkMGU5MDEzMGIz; JSESSIONID=89AA898F786ED87A825AA22F723980B2</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário primoreno (Priscilla Moreno)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
73	2019-01-14 18:09:16.405	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 1561</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>dnt : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundaryfdWWyRzAuInZBd0h</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : remember-me=YWRtaW4lNDBhZG1pbjoxNTQ4NDI4NzMzNzk5OmE2NTNlM2IxMDk2NGQ5ZTgyY2U0MjhkMGU5MDEzMGIz; JSESSIONID=1C5C83DCD00820CC035C723DEA7FCE6D</br>	POST	\N	10.5.114.110	10.5.114.110	primoreno	555	Priscilla Moreno	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	13c6d95a361e4336906636e074e93490.jpg	USER
74	2019-01-16 13:20:40.278	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/163</br>cookie : JSESSIONID=72B76727846CCF006B5CCADB49C9FCBB</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------462580723633</br>content-length : 22125</br>	POST	\N	10.5.114.119	10.5.114.119	admin@admin	1	Administrador do Sistema	Atualização do usuário 34747591753 (Edgard Candido de Oliveira Neto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
75	2019-01-16 13:21:27.202	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/163</br>cookie : JSESSIONID=72B76727846CCF006B5CCADB49C9FCBB</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------83951474717574</br>content-length : 1832</br>	POST	\N	10.5.114.119	10.5.114.119	admin@admin	1	Administrador do Sistema	Atualização do usuário 34747591753 (Edgard Candido de Oliveira Neto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
76	2019-01-16 17:49:29.786	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/163</br>cookie : JSESSIONID=F0D983501CE16A469AF36C33664AA1E7</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------224642560119904</br>content-length : 1849</br>	POST	\N	10.5.114.119	10.5.114.119	admin@admin	1	Administrador do Sistema	Atualização do usuário 34747591753 (Edgard Candido de Oliveira Neto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
77	2019-01-16 17:56:15.398	host : 10.5.115.180:36201</br>connection : keep-alive</br>content-length : 254283</br>cache-control : max-age=0</br>origin : http://10.5.115.180:36201</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundarymnOEvXoFmZZLt4kn</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://10.5.115.180:36201/user/163</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=63B11AF040A2823E859E0D1E212B7095</br>	POST	\N	10.5.115.118	10.5.115.118	admin@admin	1	Administrador do Sistema	Atualização do usuário 34747591753 (Edgard Candido de Oliveira Neto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
78	2019-01-18 17:10:26.783	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 1763</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>dnt : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundaryuIrb6rBzkK7SPkJI</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/user/163</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : remember-me=YWRtaW4lNDBhZG1pbjoxNTQ4NDI4NzMzNzk5OmE2NTNlM2IxMDk2NGQ5ZTgyY2U0MjhkMGU5MDEzMGIz; JSESSIONID=9AE7563E65CA13593E7FDBB476F338B4</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário 34747591753 (Edgard Candido de Oliveira Neto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
79	2019-02-11 14:32:08.428	host : localhost:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>referer : http://localhost:36201/user/554</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=18751DA663993614DB7D825448790BF3</br>	GET	start=17/02/2019&end=28/02/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificou o período de acesso do usuário Diego Victor de Jesus ao sistema apolo para 17/02/2019 até 28/02/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
80	2019-02-11 16:43:30.772	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=5EA286BD19F75E4A58402C13F785AA38</br>	GET	start=17/02/2019&end=28/03/2019	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema apolo para 17/02/2019 até 28/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
81	2019-02-11 16:26:14.24	host : localhost:36201</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>upgrade-insecure-requests : 1</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>dnt : 1</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=7CABCE967C1A1D67C71A160C07969E8F</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
82	2019-02-11 16:32:30.015	host : localhost:36201</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>dnt : 1</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=C019095F95D67A79FAE501C8825DE0D2</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
83	2019-02-11 16:32:48.611	host : localhost:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>referer : http://localhost:36201/user/554</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=C019095F95D67A79FAE501C8825DE0D2</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
84	2019-02-12 07:56:18.215	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>cookie : JSESSIONID=4DC3DA718A348A95D1EC7004A88C2897</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------18195278026702</br>content-length : 1700</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
85	2019-02-12 07:56:46.146	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user</br>cookie : JSESSIONID=4DC3DA718A348A95D1EC7004A88C2897</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------3165995823856</br>content-length : 1684</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
86	2019-02-12 07:57:09.552	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>cookie : JSESSIONID=4DC3DA718A348A95D1EC7004A88C2897</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------173912118714108</br>content-length : 1727</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
87	2019-02-12 12:30:12.416	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>cookie : JSESSIONID=96A46F120E85AA20EC549A51D33152D1</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------14221636396</br>content-length : 1657</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
88	2019-02-12 12:30:56.595	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>cookie : JSESSIONID=96A46F120E85AA20EC549A51D33152D1</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
89	2019-02-12 11:25:46.229	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>cookie : JSESSIONID=0E110D323DFF5AE0BA6B4FCABB58F1C1</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------1798276421956</br>content-length : 1705</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
90	2019-02-13 12:16:28.437	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>content-length : 1673</br>cache-control : max-age=0</br>origin : http://sisgeodef.defesa.mil.br:36201</br>upgrade-insecure-requests : 1</br>dnt : 1</br>content-type : multipart/form-data; boundary=----WebKitFormBoundary2NDfeIHtXiHCSDCj</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=B43E1BF438844C4E0EF5403DEDD0585E</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
91	2019-02-13 11:01:59.02	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=D9F888110A058C1EA7618B8BD52F55AA</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema atlas	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
92	2019-02-13 11:02:06.762	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=D9F888110A058C1EA7618B8BD52F55AA</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema atlas	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
93	2019-02-13 11:03:12.703	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema cerberus	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
94	2019-02-13 11:03:25.209	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	start=13/02/2019&end=26/03/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema cerberus para 13/02/2019 até 26/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
95	2019-02-13 11:03:35.828	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema cerberus	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
96	2019-02-13 11:03:46.131	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
97	2019-02-13 11:04:22.78	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
98	2019-02-13 11:04:27.587	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
99	2019-02-13 11:04:51.915	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
100	2019-02-13 11:04:57.532	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	start=13/02/2019&end=26/03/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema apolo para 13/02/2019 até 26/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
101	2019-02-13 11:05:01.236	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
102	2019-02-13 11:05:18.45	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
103	2019-02-13 11:05:25.362	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1DB55C9A5F7811851C0F552D63C3E3DD</br>connection : keep-alive</br>	GET	start=13/02/2019&end=29/03/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema apolo para 13/02/2019 até 29/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
104	2019-02-13 13:15:03.974	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=4502EF62EDF185C01744E2D4BB60C478</br>connection : keep-alive</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema cerberus	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
142	2019-02-14 08:25:37.852	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE452814E147DBF60ACF7A4277678CAF</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
105	2019-02-13 13:16:40.553	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=4502EF62EDF185C01744E2D4BB60C478</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema sisclaten	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
106	2019-02-13 13:16:52.968	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=4502EF62EDF185C01744E2D4BB60C478</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema sisclaten	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
107	2019-02-13 13:17:06.756	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=4502EF62EDF185C01744E2D4BB60C478</br>connection : keep-alive</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema sisclaten	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
108	2019-02-13 13:17:09.812	host : sisgeodef.defesa.mil.br:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://sisgeodef.defesa.mil.br:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=4502EF62EDF185C01744E2D4BB60C478</br>connection : keep-alive</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Diego Victor de Jesus ao sistema cerberus	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
109	2019-02-14 07:58:38.97	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=DF4E71E57B67F7F01E5487DF250FB2CF</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
110	2019-02-14 07:58:49.084	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=DF4E71E57B67F7F01E5487DF250FB2CF</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
111	2019-02-14 07:59:01.733	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=DF4E71E57B67F7F01E5487DF250FB2CF</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
112	2019-02-14 08:07:48.886	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FCA2D5F9C62FD7773F8E48D792066835</br>connection : keep-alive</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
113	2019-02-14 08:09:22.111	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=AB0A258057E241F4D8CA1163BD1ADDD4</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
114	2019-02-14 08:09:34.934	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=AB0A258057E241F4D8CA1163BD1ADDD4</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
115	2019-02-14 08:09:44.435	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=AB0A258057E241F4D8CA1163BD1ADDD4</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
116	2019-02-14 08:13:40.969	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
117	2019-02-14 08:13:44.997	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
118	2019-02-14 08:13:49.205	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
119	2019-02-14 08:13:50.983	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
120	2019-02-14 08:14:02.034	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
121	2019-02-14 08:14:06.13	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
122	2019-02-14 08:14:07.854	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
123	2019-02-14 08:14:20.642	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
124	2019-02-14 08:14:34.265	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
125	2019-02-14 08:15:03.835	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
126	2019-02-14 08:15:08.817	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
127	2019-02-14 08:15:12.448	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
128	2019-02-14 08:15:43.516	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
129	2019-02-14 08:15:56.082	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
131	2019-02-14 08:16:15.096	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
130	2019-02-14 08:16:02.769	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F3952BDFD88B1B6047A624F143102249</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
132	2019-02-14 08:21:46.769	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=6EAED28D7A32F1FA6EB5AF1BEC941809</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
133	2019-02-14 08:21:50.939	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=6EAED28D7A32F1FA6EB5AF1BEC941809</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
134	2019-02-14 08:22:23.975	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=6EAED28D7A32F1FA6EB5AF1BEC941809</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
135	2019-02-14 08:22:27.724	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=6EAED28D7A32F1FA6EB5AF1BEC941809</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
136	2019-02-14 08:22:34.717	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=6EAED28D7A32F1FA6EB5AF1BEC941809</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
137	2019-02-14 08:25:20.336	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE452814E147DBF60ACF7A4277678CAF</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
138	2019-02-14 08:25:21.773	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE452814E147DBF60ACF7A4277678CAF</br>connection : keep-alive</br>pragma : no-cache</br>cache-control : no-cache</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
139	2019-02-14 08:25:30.573	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE452814E147DBF60ACF7A4277678CAF</br>connection : keep-alive</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
140	2019-02-14 08:25:31.74	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE452814E147DBF60ACF7A4277678CAF</br>connection : keep-alive</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
141	2019-02-14 08:25:36.621	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE452814E147DBF60ACF7A4277678CAF</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
143	2019-02-14 09:50:38.608	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=199E9E46AA5B45BF1859002860E486A1</br>connection : keep-alive</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
144	2019-02-14 11:58:41.995	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	value=off	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
145	2019-02-14 11:58:44.533	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	value=off	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
146	2019-02-14 11:58:45.785	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	value=on	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
147	2019-02-14 11:58:50.495	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	value=on	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
148	2019-02-14 11:58:53.843	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	value=off	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
149	2019-02-14 12:00:40.669	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
150	2019-02-14 12:00:46.09	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	value=on	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Administrador do Sistema ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
151	2019-02-14 12:00:54.064	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>	GET	start=14/02/2019&end=29/03/2019	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Administrador do Sistema ao sistema apolo para 14/02/2019 até 29/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
152	2019-02-14 12:01:17.883	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/1</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_images=50; portainer.pagination_containers=50; _gid=GA1.1.1995126853.1550063501; _gitlab_session=2720e087b724bb049f2af7e5c29e36b8; event_filter=all; JSESSIONID=24261A2060F8E06232C757C51DA5B751</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------27996263520922</br>content-length : 1734</br>	POST	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Atualização do usuário admin@admin (Administrador do Sistema)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
153	2019-02-14 10:18:17.575	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/newUser</br>cookie : JSESSIONID=1B1BE250A2D22FEAB8A0258ADB62DE12</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------175661282123258</br>content-length : 27568</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Criação do usuário teste (teste)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
154	2019-02-14 13:58:38.631	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=63F63F34EF362F24AF017BD5F03DE614</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
155	2019-02-14 13:58:51.587	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=63F63F34EF362F24AF017BD5F03DE614</br>connection : keep-alive</br>	GET	start=14/02/2019&end=21/03/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema apolo para 14/02/2019 até 21/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
156	2019-02-14 14:00:33.865	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=63F63F34EF362F24AF017BD5F03DE614</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
157	2019-02-14 14:00:42.765	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=63F63F34EF362F24AF017BD5F03DE614</br>connection : keep-alive</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
158	2019-02-14 15:37:04.509	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=84DB5A4C9BC5E3713CC6EFCECB89001C</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema sisclaten	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
159	2019-02-14 16:22:11.053	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/156</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=7B37FCAAD44A0F29FD33029BA042E2C5</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário 00200328115 SISEIDN ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
160	2019-02-19 10:34:00.532	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/newUser</br>cookie : JSESSIONID=99FE7F14C6A0B0EA305269DC1C70A144</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------143772697813422</br>content-length : 124030</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Criação do usuário teste1234 (teste1234)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
161	2019-02-19 10:34:28.447	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/users</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=99FE7F14C6A0B0EA305269DC1C70A144</br>connection : keep-alive</br>	DELETE	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Apagou o usuário teste1234 (teste1234) do banco de dados.	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
172	2019-02-25 08:16:51.712	host : localhost:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36</br>referer : http://localhost:36201/user/561</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=DB7FE07A9EFB63524CC2620FB1DB32A5</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário ffff ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
162	2019-02-19 10:36:26.37	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/newUser</br>cookie : JSESSIONID=AA7E86BEA61E84693AF72DD6B404F353</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------20250277885141</br>content-length : 27549</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Criação do usuário udto (udto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
163	2019-02-19 10:42:46.346	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/users</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=6626670E7D5026F93FE3A481CED81544</br>connection : keep-alive</br>	DELETE	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Apagou o usuário udto (udto) do banco de dados.	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
164	2019-02-19 10:43:12.666	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/newUser</br>cookie : JSESSIONID=6626670E7D5026F93FE3A481CED81544</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------6557163816787</br>content-length : 27537</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Criação do usuário udto (udto)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
165	2019-02-19 10:59:04.579	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>cookie : JSESSIONID=AB7DC104F3063C78164C02CB83E1E48A</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------16871111023861</br>content-length : 1705</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
166	2019-02-19 11:04:10.239	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>cookie : JSESSIONID=1CE2E6B250B4E5020E32883BFDE8E9F3</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------216872070726994</br>content-length : 1721</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
167	2019-02-19 11:04:19.756	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554?midasLocation=http%3A%2F%2F10.5.115.180%3A36205</br>cookie : JSESSIONID=1CE2E6B250B4E5020E32883BFDE8E9F3</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------20704914527983</br>content-length : 1707</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
168	2019-02-19 11:04:26.867	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554?midasLocation=http%3A%2F%2F10.5.115.180%3A36205</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1CE2E6B250B4E5020E32883BFDE8E9F3</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
169	2019-02-19 11:04:29.758	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554?midasLocation=http%3A%2F%2F10.5.115.180%3A36205</br>cookie : JSESSIONID=1CE2E6B250B4E5020E32883BFDE8E9F3</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------28584320099932</br>content-length : 1707</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
170	2019-02-19 11:04:43.193	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554?midasLocation=http%3A%2F%2F10.5.115.180%3A36205</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1CE2E6B250B4E5020E32883BFDE8E9F3</br>connection : keep-alive</br>	GET	start=14/02/2019&end=26/03/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema sisclaten para 14/02/2019 até 26/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
171	2019-02-19 11:04:47.163	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554?midasLocation=http%3A%2F%2F10.5.115.180%3A36205</br>cookie : JSESSIONID=1CE2E6B250B4E5020E32883BFDE8E9F3</br>connection : keep-alive</br>upgrade-insecure-requests : 1</br>content-type : multipart/form-data; boundary=---------------------------172782632015613</br>content-length : 1723</br>	POST	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Atualização do usuário diegovictorbr (Diego Victor de Jesus)	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
173	2019-02-25 08:27:46.069	host : localhost:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36</br>referer : http://localhost:36201/user/156</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=354F455C3A4C71C5C39C3B7D2AEF8172</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário 00200328115 SISEIDN ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
174	2019-02-25 08:28:47.057	host : localhost:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36</br>referer : http://localhost:36201/user/156</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : JSESSIONID=354F455C3A4C71C5C39C3B7D2AEF8172</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário 00200328115 SISEIDN ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
175	2019-02-25 10:22:01.008	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1EECEB42F4A9D4B1A3CBD38CC4801D91</br>connection : keep-alive</br>	GET	start=15/02/2019&end=27/03/2019	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação do período de acesso do usuário Diego Victor de Jesus ao sistema apolo para 15/02/2019 até 27/03/2019	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
176	2019-02-25 10:22:43.715	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1EECEB42F4A9D4B1A3CBD38CC4801D91</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
177	2019-02-25 10:22:46.996	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=1EECEB42F4A9D4B1A3CBD38CC4801D91</br>connection : keep-alive</br>	GET	value=off	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Usuário'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
178	2019-02-25 11:35:55.02	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F2A5BCEE56739341D78FE4393957BCA6</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema apolo	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
179	2019-02-25 11:35:59.339	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F2A5BCEE56739341D78FE4393957BCA6</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema sisclaten	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
180	2019-02-25 11:36:02.901	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=F2A5BCEE56739341D78FE4393957BCA6</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Administrador do Sistema ao sistema sisclaten para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
181	2019-02-26 08:15:14.927	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : JSESSIONID=FE29BC970324AB8A0325A576CF52ED82</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema hydra	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
182	2019-02-27 09:12:01.519	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : HADESSSESSION=5FE3D69C2332CE47313104CB47BFFAD8</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema apolo para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
183	2019-02-27 09:12:14.771	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : HADESSSESSION=5FE3D69C2332CE47313104CB47BFFAD8</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Diego Victor de Jesus ao sistema hades	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
184	2019-02-27 09:12:40.696	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/554</br>x-requested-with : XMLHttpRequest</br>cookie : HADESSSESSION=5FE3D69C2332CE47313104CB47BFFAD8</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Diego Victor de Jesus ao sistema hades para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
185	2019-02-27 09:13:07.452	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : HADESSSESSION=5FE3D69C2332CE47313104CB47BFFAD8</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema hades	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
186	2019-02-27 09:13:10.143	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : HADESSSESSION=5FE3D69C2332CE47313104CB47BFFAD8</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Administrador do Sistema ao sistema hades para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
187	2019-02-28 14:36:27.824	host : 10.5.115.180:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://10.5.115.180:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : _ga=GA1.1.1126351319.1545049152; sidebar_collapsed=false; portainer.pagination_containers=100; _gid=GA1.1.211825262.1551093127; JSESSIONID=5A024C6966E8F81B571066BD5DCC71E1</br>connection : keep-alive</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema atlas	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
188	2019-02-28 11:37:29.577	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : HYDRASSESSION=76BE9358A9507C22B66B5D02C4CB94D9; JSESSIONID=381CE59D1DF0CF4BE70CEAD4E85B8724</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema cliente01	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
189	2019-02-28 11:48:59.399	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : HYDRASSESSION=F5AFBC29B64CD3ACC83B1D6D284FF368; JSESSIONID=381CE59D1DF0CF4BE70CEAD4E85B8724</br>connection : keep-alive</br>	GET	value=on	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Administrador do Sistema ao sistema cliente01 para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
190	2019-02-28 11:49:26.207	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : HYDRASSESSION=F5AFBC29B64CD3ACC83B1D6D284FF368; JSESSIONID=9D5A6C80A9FC22C82F8084D60757B718</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Administrador do Sistema ao sistema cliente01	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
191	2019-02-28 11:49:30.447	host : localhost:36201</br>user-agent : Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0</br>accept : */*</br>accept-language : pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3</br>accept-encoding : gzip, deflate</br>referer : http://localhost:36201/user/1</br>x-requested-with : XMLHttpRequest</br>cookie : HYDRASSESSION=F5AFBC29B64CD3ACC83B1D6D284FF368; JSESSIONID=9D5A6C80A9FC22C82F8084D60757B718</br>connection : keep-alive</br>	GET	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Retirada do acesso do usuário Administrador do Sistema ao sistema atlas	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
192	2019-03-11 11:45:00.673	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36</br>referer : http://sisgeodef.defesa.mil.br:36201/user/1</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : HYDRASSESSION=8992B127E92E401D1558456FA872E456; JSESSIONID=F5D4CC1C9AEEA2F269C6707844CD7EDC</br>	GET	\N	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Adicionou usuário Administrador do Sistema ao sistema cliente01	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
193	2019-03-11 12:43:58.937	host : sisgeodef.defesa.mil.br:36201</br>connection : keep-alive</br>accept : */*</br>dnt : 1</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36</br>referer : http://sisgeodef.defesa.mil.br:36201/user/1</br>accept-encoding : gzip, deflate</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : HYDRASSESSION=204DCC0A39CDE66BB1A143D143A4A51A; CLIENTE01SSESSION=764A27E0F47F17886DFF45948FA61564; JSESSIONID=55BF8708D805E1A8C3A47C3C7CD6EFF9</br>	GET	value=on	10.5.114.110	10.5.114.110	admin@admin	1	Administrador do Sistema	Modificação da permissão de acesso do usuário Administrador do Sistema ao sistema cliente01 para 'Administrador'	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
194	2019-03-18 10:03:19.548	host : localhost:36201</br>connection : keep-alive</br>accept : */*</br>origin : http://localhost:36201</br>x-requested-with : XMLHttpRequest</br>user-agent : Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36</br>dnt : 1</br>referer : http://localhost:36201/clients</br>accept-encoding : gzip, deflate, br</br>accept-language : pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7</br>cookie : CLIENTE01SSESSION=CF373367A3AEB4A49E31E29A72C91AAA; JSESSIONID=E5A9F8ABED483648711750929F55CB41</br>	DELETE	\N	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	admin@admin	1	Administrador do Sistema	Apagou o sistema cliente hydra do banco de dados.	\N	601aeab282f94aaeb4f706042d6427fe.png	USER
\.


--
-- TOC entry 2956 (class 0 OID 16393)
-- Dependencies: 198
-- Data for Name: clientdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientdetails (client_id, access_token_validity, additional_information, app_id, app_secret, authorities, auto_approve_scopes, grant_types, redirect_url, refresh_token_validity, resource_ids, scope) FROM stdin;
\.


--
-- TOC entry 2957 (class 0 OID 16399)
-- Dependencies: 199
-- Data for Name: oauth_access_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_access_token (authentication_id, authentication, client_id, refresh_token, token, token_id, user_name) FROM stdin;
ff8abf90b6f6e1f4826e0c5c6a5728dd	\\xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f417574683241757468656e7469636174696f6ebd400b02166252130200024c000d73746f7265645265717565737474003c4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f4f4175746832526571756573743b4c00127573657241757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c737400124c6a6176612f6c616e672f4f626a6563743b787000737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00047870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000001fe0200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b787074000a524f4c455f41444d494e7871007e000c707372003a6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f41757468325265717565737400000000000000010200075a0008617070726f7665644c000b617574686f72697469657371007e00044c000a657874656e73696f6e7374000f4c6a6176612f7574696c2f4d61703b4c000b726564697265637455726971007e000e4c00077265667265736874003b4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f546f6b656e526571756573743b4c000b7265736f7572636549647374000f4c6a6176612f7574696c2f5365743b4c000d726573706f6e7365547970657371007e0014787200386f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e426173655265717565737436287a3ea37169bd0200034c0008636c69656e74496471007e000e4c001172657175657374506172616d657465727371007e00124c000573636f706571007e0014787074000561746c6173737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654d6170f1a5a8fe74f507420200014c00016d71007e00127870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000037708000000040000000274000a6772616e745f7479706574000870617373776f7264740008757365726e616d6574000b61646d696e4061646d696e78737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e0009737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f78017371007e0023770c000000103f400000000000027371007e000d74000b524f4c455f434c49454e547371007e000d740013524f4c455f545255535445445f434c49454e54787371007e001a3f40000000000000770800000010000000007870737200396f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e546f6b656e52657175657374d62a84b8cf38f8010200014c00096772616e745479706571007e000e7871007e001574000561746c61737371007e00187371007e001a3f400000000000067708000000080000000374000d726566726573685f746f6b656e74002462333666316534622d366232392d343463372d623065622d34393933386539616632636674000a6772616e745f7479706574000d726566726573685f746f6b656e740009636c69656e745f696471007e0031787371007e00207371007e0022770c000000103f400000000000007871007e00377371007e0023770c000000103f40000000000000787371007e0023770c000000103f40000000000000787372005b6f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e707265617574682e50726541757468656e7469636174656441757468656e7469636174696f6e546f6b656e00000000000001fe0200024c000b63726564656e7469616c7371007e00054c00097072696e636970616c71007e00057871007e0003017371007e00077371007e000b0000000177040000000171007e000f7871007e004070740000737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000001fe0200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657371007e00144c000870617373776f726471007e000e4c0008757365726e616d6571007e000e7870010101017371007e0020737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f7200000000000001fe020000787077040000000171007e000f787074000b61646d696e4061646d696e	atlas	f233ef4e6af719c99dd45be50a17702a	\\xaced0005737200436f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f4175746832416363657373546f6b656e0cb29e361b24face0200064c00156164646974696f6e616c496e666f726d6174696f6e74000f4c6a6176612f7574696c2f4d61703b4c000a65787069726174696f6e7400104c6a6176612f7574696c2f446174653b4c000c72656672657368546f6b656e74003f4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f636f6d6d6f6e2f4f417574683252656672657368546f6b656e3b4c000573636f706574000f4c6a6176612f7574696c2f5365743b4c0009746f6b656e547970657400124c6a6176612f6c616e672f537472696e673b4c000576616c756571007e000578707372001e6a6176612e7574696c2e436f6c6c656374696f6e7324456d7074794d6170593614855adce7d002000078707372000e6a6176612e7574696c2e44617465686a81014b59741903000078707708000001696d2dabb9787372004c6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744578706972696e674f417574683252656672657368546f6b656e2fdf47639dd0c9b70200014c000a65787069726174696f6e71007e0002787200446f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f417574683252656672657368546f6b656e73e10e0a6354d45e0200014c000576616c756571007e0005787074002462333666316534622d366232392d343463372d623065622d3439393338653961663263667371007e00097708000001696cffaa3078737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c0001637400164c6a6176612f7574696c2f436f6c6c656374696f6e3b7870737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f7874000662656172657274002464666135303231622d633736652d343934622d383234392d386365363964363534363836	0b18e4e193bfe1b5f32ca0d7ddaac847	admin@admin
082c69315d0ff6a9af5d05b261b601d6	\\xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f417574683241757468656e7469636174696f6ebd400b02166252130200024c000d73746f7265645265717565737474003c4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f4f4175746832526571756573743b4c00127573657241757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c737400124c6a6176612f6c616e672f4f626a6563743b787000737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00047870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000001fe0200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b787074000a524f4c455f41444d494e7871007e000c707372003a6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f41757468325265717565737400000000000000010200075a0008617070726f7665644c000b617574686f72697469657371007e00044c000a657874656e73696f6e7374000f4c6a6176612f7574696c2f4d61703b4c000b726564697265637455726971007e000e4c00077265667265736874003b4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f546f6b656e526571756573743b4c000b7265736f7572636549647374000f4c6a6176612f7574696c2f5365743b4c000d726573706f6e7365547970657371007e0014787200386f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e426173655265717565737436287a3ea37169bd0200034c0008636c69656e74496471007e000e4c001172657175657374506172616d657465727371007e00124c000573636f706571007e00147870740009636c69656e74653032737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654d6170f1a5a8fe74f507420200014c00016d71007e00127870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000006740004636f646574000668694d484c6374000a6772616e745f74797065740012617574686f72697a6174696f6e5f636f646574000d726573706f6e73655f74797065740004636f646574000c72656469726563745f75726974001c687474703a2f2f6c6f63616c686f73743a33363231362f6c6f67696e7400057374617465740006783264563975740009636c69656e745f696471007e001778737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e0009737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f78017371007e002a770c000000103f400000000000027371007e000d74000b524f4c455f434c49454e547371007e000d740013524f4c455f545255535445445f434c49454e54787371007e001a3f40000000000000770800000010000000007874001c687474703a2f2f6c6f63616c686f73743a33363231362f6c6f67696e707371007e002a770c000000103f40000000000000787371007e002a770c000000103f4000000000000171007e0021787372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000001fe0200024c000b63726564656e7469616c7371007e00054c00097072696e636970616c71007e00057871007e0003017371007e00077371007e000b0000000177040000000171007e000f7871007e003c737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c7300000000000001fe0200024c000d72656d6f74654164647265737371007e000e4c000973657373696f6e496471007e000e787074000c31302e352e3131342e313130740020343731453633344134443038443046413244324239364246364145373730333070737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000001fe0200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657371007e00144c000870617373776f726471007e000e4c0008757365726e616d6571007e000e7870010101017371007e0027737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f7200000000000001fe020000787077040000000171007e000f787074000b61646d696e4061646d696e	cliente02	73dba8c0c446dded189d0b5b48f9723c	\\xaced0005737200436f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f4175746832416363657373546f6b656e0cb29e361b24face0200064c00156164646974696f6e616c496e666f726d6174696f6e74000f4c6a6176612f7574696c2f4d61703b4c000a65787069726174696f6e7400104c6a6176612f7574696c2f446174653b4c000c72656672657368546f6b656e74003f4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f636f6d6d6f6e2f4f417574683252656672657368546f6b656e3b4c000573636f706574000f4c6a6176612f7574696c2f5365743b4c0009746f6b656e547970657400124c6a6176612f6c616e672f537472696e673b4c000576616c756571007e000578707372001e6a6176612e7574696c2e436f6c6c656374696f6e7324456d7074794d6170593614855adce7d002000078707372000e6a6176612e7574696c2e44617465686a81014b5974190300007870770800000169737954c6787372004c6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744578706972696e674f417574683252656672657368546f6b656e2fdf47639dd0c9b70200014c000a65787069726174696f6e71007e0002787200446f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f417574683252656672657368546f6b656e73e10e0a6354d45e0200014c000576616c756571007e0005787074002437323538353730372d653935622d343961352d623737362d3662346164356436666337667371007e0009770800000169a91e3dc378737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c0001637400164c6a6176612f7574696c2f436f6c6c656374696f6e3b7870737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000083f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f7874000662656172657274002431616134373730312d316331322d343638622d386535392d646535383763656333396136	9805eac78b9bb38e0fbd06844901513d	admin@admin
8c8b2b274c3f36d0ee552e537b0e41d1	\\xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f417574683241757468656e7469636174696f6ebd400b02166252130200024c000d73746f7265645265717565737474003c4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f4f4175746832526571756573743b4c00127573657241757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c737400124c6a6176612f6c616e672f4f626a6563743b787000737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00047870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000001fe0200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b787074000a524f4c455f41444d494e7871007e000c707372003a6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f41757468325265717565737400000000000000010200075a0008617070726f7665644c000b617574686f72697469657371007e00044c000a657874656e73696f6e7374000f4c6a6176612f7574696c2f4d61703b4c000b726564697265637455726971007e000e4c00077265667265736874003b4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f546f6b656e526571756573743b4c000b7265736f7572636549647374000f4c6a6176612f7574696c2f5365743b4c000d726573706f6e7365547970657371007e0014787200386f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e426173655265717565737436287a3ea37169bd0200034c0008636c69656e74496471007e000e4c001172657175657374506172616d657465727371007e00124c000573636f706571007e00147870740009636c69656e74653031737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654d6170f1a5a8fe74f507420200014c00016d71007e00127870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000006740004636f64657400063751686e494874000a6772616e745f74797065740012617574686f72697a6174696f6e5f636f646574000d726573706f6e73655f74797065740004636f646574000c72656469726563745f75726974001c687474703a2f2f6c6f63616c686f73743a33363231352f6c6f67696e74000573746174657400063568394d366a740009636c69656e745f696471007e001778737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e0009737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f78017371007e002a770c000000103f400000000000027371007e000d74000b524f4c455f434c49454e547371007e000d740013524f4c455f545255535445445f434c49454e54787371007e001a3f40000000000000770800000010000000007874001c687474703a2f2f6c6f63616c686f73743a33363231352f6c6f67696e707371007e002a770c000000103f40000000000000787371007e002a770c000000103f4000000000000171007e0021787372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000001fe0200024c000b63726564656e7469616c7371007e00054c00097072696e636970616c71007e00057871007e0003017371007e00077371007e000b0000000177040000000171007e000f7871007e003c737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c7300000000000001fe0200024c000d72656d6f74654164647265737371007e000e4c000973657373696f6e496471007e000e787074000c31302e352e3131342e313130740020313146353438304535413335453141373931373745384134394131303139424170737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000001fe0200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657371007e00144c000870617373776f726471007e000e4c0008757365726e616d6571007e000e7870010101017371007e0027737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f7200000000000001fe020000787077040000000171007e000f787074000b61646d696e4061646d696e	cliente01	513bf37e8d1d409fc25118c902ae0e4b	\\xaced0005737200436f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f4175746832416363657373546f6b656e0cb29e361b24face0200064c00156164646974696f6e616c496e666f726d6174696f6e74000f4c6a6176612f7574696c2f4d61703b4c000a65787069726174696f6e7400104c6a6176612f7574696c2f446174653b4c000c72656672657368546f6b656e74003f4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f636f6d6d6f6e2f4f417574683252656672657368546f6b656e3b4c000573636f706574000f4c6a6176612f7574696c2f5365743b4c0009746f6b656e547970657400124c6a6176612f6c616e672f537472696e673b4c000576616c756571007e000578707372001e6a6176612e7574696c2e436f6c6c656374696f6e7324456d7074794d6170593614855adce7d002000078707372000e6a6176612e7574696c2e44617465686a81014b597419030000787077080000016996a9da10787372004c6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744578706972696e674f417574683252656672657368546f6b656e2fdf47639dd0c9b70200014c000a65787069726174696f6e71007e0002787200446f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f417574683252656672657368546f6b656e73e10e0a6354d45e0200014c000576616c756571007e0005787074002436353930636334652d623835322d343936382d613064392d6639643435356564323439387371007e0009770800000169914c8f8f78737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c0001637400164c6a6176612f7574696c2f436f6c6c656374696f6e3b7870737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000083f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f7874000662656172657274002466373932666165382d336364652d343837642d613534312d666336346664303033383565	5a7a5d281725da7b9779a258a3932cf3	admin@admin
\.


--
-- TOC entry 2958 (class 0 OID 16405)
-- Dependencies: 200
-- Data for Name: oauth_approvals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_approvals (pk_id, clientid, expiresat, lastmodifiedat, scope, status, userid, client_id, expires_at, last_modified_at, user_id) FROM stdin;
\.


--
-- TOC entry 2960 (class 0 OID 16413)
-- Dependencies: 202
-- Data for Name: oauth_client_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_client_details (client_id, access_token_validity, additional_information, authorities, authorized_grant_types, autoapprove, client_secret, refresh_token_validity, resource_ids, scope, web_server_redirect_uri) FROM stdin;
atlas	3600	{"nome":"Sistema Atlas", "logotipo":"/resources/img/sisclaten-symbol.png","descricao":"descricao", "homePath":"homePath"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	600	\N	read,write,trust,user_info	http://apolo.defesa.mil.br/
cerberus	120	{"nome":"Sistema Cerberus","logotipo":"/resources/img/sisclaten-symbol.png", "descricao":"descricao", "homePath":"homePath"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	600	\N	read,write,trust,user_info	http://localhost:19889/atlas/login
sisclaten	999999	{"nome":"Sisclaten", "logotipo":"/resources/img/sisclaten-symbol.png", "descricao":"Sistema de Cadastro de Levantamentos Aeroespaciais do Território Nacional ", "homePath":"http://sisclaten.defesa.gov.br/"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	9999999	\N	read,write,trust,user_info	http://localhost:36220/hydra/login
cliente02	99999	{"nome":"Módulo Hydra", "descricao":"descricao", "logotipo":"/resources/img/sisclaten-symbol.png","homePath":"homePath"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	999999	\N	read,write,trust,user_info	http://localhost:36216/login
apolo	999999999	{"nome":"Sistema Apolo", "logotipo":"/resources/img/apolo-symbol.png", "descricao":"descricao", "homePath":"homePath"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	999999999	\N	read,write,trust,user_info	http://apolo.defesa.mil.br/
hades	99999999	{"nome":"Gerenciador Hades", "logotipo":"/resources/img/sisclaten-symbol.png", "descricao":"descricao", "homePath":"homePath"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	9999999	\N	read,write,trust,user_info	http://localhost:36201/login
cliente01	99999	{"nome":"Cliente de Teste", "descricao":"descricao","logotipo":"/resources/img/sisclaten-symbol.png", "homePath":"homePath"}	ROLE_CLIENT,ROLE_TRUSTED_CLIENT	password,authorization_code,refresh_token,implicit	true	$2a$09$lILtQ14UWv.OfGJ6AZtOEeGwmG/MOwa/sXz1Bjul4cjI.6J2JEkiS	9999	\N	read,write,trust,user_info	http://localhost:36215/login
\.


--
-- TOC entry 2961 (class 0 OID 16419)
-- Dependencies: 203
-- Data for Name: oauth_client_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_client_token (authentication_id, client_id, token, token_id, user_name) FROM stdin;
\.


--
-- TOC entry 2962 (class 0 OID 16425)
-- Dependencies: 204
-- Data for Name: oauth_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_code (pk_id, authentication, code) FROM stdin;
\.


--
-- TOC entry 2964 (class 0 OID 16433)
-- Dependencies: 206
-- Data for Name: oauth_refresh_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_refresh_token (pk_id, authentication, token, token_id) FROM stdin;
112	\\xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f417574683241757468656e7469636174696f6ebd400b02166252130200024c000d73746f7265645265717565737474003c4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f4f4175746832526571756573743b4c00127573657241757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c737400124c6a6176612f6c616e672f4f626a6563743b787000737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00047870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000001fe0200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b787074000a524f4c455f41444d494e7871007e000c707372003a6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f41757468325265717565737400000000000000010200075a0008617070726f7665644c000b617574686f72697469657371007e00044c000a657874656e73696f6e7374000f4c6a6176612f7574696c2f4d61703b4c000b726564697265637455726971007e000e4c00077265667265736874003b4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f546f6b656e526571756573743b4c000b7265736f7572636549647374000f4c6a6176612f7574696c2f5365743b4c000d726573706f6e7365547970657371007e0014787200386f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e426173655265717565737436287a3ea37169bd0200034c0008636c69656e74496471007e000e4c001172657175657374506172616d657465727371007e00124c000573636f706571007e0014787074000561746c6173737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654d6170f1a5a8fe74f507420200014c00016d71007e00127870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f400000000000037708000000040000000274000a6772616e745f7479706574000870617373776f7264740008757365726e616d6574000b61646d696e4061646d696e78737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e0009737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f78017371007e0023770c000000103f400000000000027371007e000d74000b524f4c455f434c49454e547371007e000d740013524f4c455f545255535445445f434c49454e54787371007e001a3f40000000000000770800000010000000007870707371007e0023770c000000103f40000000000000787371007e0023770c000000103f40000000000000787372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000001fe0200024c000b63726564656e7469616c7371007e00054c00097072696e636970616c71007e00057871007e0003017371007e00077371007e000b0000000177040000000171007e000f7871007e0034737200176a6176612e7574696c2e4c696e6b6564486173684d617034c04e5c106cc0fb0200015a000b6163636573734f726465727871007e001a3f400000000000067708000000080000000271007e001c71007e001d71007e001e71007e001f780070737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000001fe0200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657371007e00144c000870617373776f726471007e000e4c0008757365726e616d6571007e000e7870010101017371007e0020737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f7200000000000001fe020000787077040000000171007e000f787074000b61646d696e4061646d696e	\\xaced00057372004c6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744578706972696e674f417574683252656672657368546f6b656e2fdf47639dd0c9b70200014c000a65787069726174696f6e7400104c6a6176612f7574696c2f446174653b787200446f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f417574683252656672657368546f6b656e73e10e0a6354d45e0200014c000576616c75657400124c6a6176612f6c616e672f537472696e673b787074002462333666316534622d366232392d343463372d623065622d3439393338653961663263667372000e6a6176612e7574696c2e44617465686a81014b59741903000078707708000001696cffaa3078	f233ef4e6af719c99dd45be50a17702a
113	\\xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f417574683241757468656e7469636174696f6ebd400b02166252130200024c000d73746f7265645265717565737474003c4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f4f4175746832526571756573743b4c00127573657241757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c737400124c6a6176612f6c616e672f4f626a6563743b787000737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00047870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000001fe0200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b787074000a524f4c455f41444d494e7871007e000c707372003a6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f41757468325265717565737400000000000000010200075a0008617070726f7665644c000b617574686f72697469657371007e00044c000a657874656e73696f6e7374000f4c6a6176612f7574696c2f4d61703b4c000b726564697265637455726971007e000e4c00077265667265736874003b4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f546f6b656e526571756573743b4c000b7265736f7572636549647374000f4c6a6176612f7574696c2f5365743b4c000d726573706f6e7365547970657371007e0014787200386f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e426173655265717565737436287a3ea37169bd0200034c0008636c69656e74496471007e000e4c001172657175657374506172616d657465727371007e00124c000573636f706571007e00147870740009636c69656e74653032737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654d6170f1a5a8fe74f507420200014c00016d71007e00127870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000006740004636f646574000634744630324b74000a6772616e745f74797065740012617574686f72697a6174696f6e5f636f646574000d726573706f6e73655f74797065740004636f646574000c72656469726563745f75726974001c687474703a2f2f6c6f63616c686f73743a33363231362f6c6f67696e7400057374617465740006667534344e76740009636c69656e745f696471007e001778737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e0009737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f78017371007e002a770c000000103f400000000000027371007e000d74000b524f4c455f434c49454e547371007e000d740013524f4c455f545255535445445f434c49454e54787371007e001a3f40000000000000770800000010000000007874001c687474703a2f2f6c6f63616c686f73743a33363231362f6c6f67696e707371007e002a770c000000103f40000000000000787371007e002a770c000000103f4000000000000171007e0021787372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000001fe0200024c000b63726564656e7469616c7371007e00054c00097072696e636970616c71007e00057871007e0003017371007e00077371007e000b0000000177040000000171007e000f7871007e003c737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c7300000000000001fe0200024c000d72656d6f74654164647265737371007e000e4c000973657373696f6e496471007e000e787074000c31302e352e3131342e313130740020454144434245374146333943423344333537393645384439413136323236443670737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000001fe0200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657371007e00144c000870617373776f726471007e000e4c0008757365726e616d6571007e000e7870010101017371007e0027737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f7200000000000001fe020000787077040000000171007e000f787074000b61646d696e4061646d696e	\\xaced00057372004c6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744578706972696e674f417574683252656672657368546f6b656e2fdf47639dd0c9b70200014c000a65787069726174696f6e7400104c6a6176612f7574696c2f446174653b787200446f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f417574683252656672657368546f6b656e73e10e0a6354d45e0200014c000576616c75657400124c6a6176612f6c616e672f537472696e673b787074002437323538353730372d653935622d343961352d623737362d3662346164356436666337667372000e6a6176612e7574696c2e44617465686a81014b5974190300007870770800000169a91e3dc378	73dba8c0c446dded189d0b5b48f9723c
116	\\xaced0005737200416f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f417574683241757468656e7469636174696f6ebd400b02166252130200024c000d73746f7265645265717565737474003c4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f4f4175746832526571756573743b4c00127573657241757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c737400124c6a6176612f6c616e672f4f626a6563743b787000737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00047870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000001fe0200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b787074000a524f4c455f41444d494e7871007e000c707372003a6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e4f41757468325265717565737400000000000000010200075a0008617070726f7665644c000b617574686f72697469657371007e00044c000a657874656e73696f6e7374000f4c6a6176612f7574696c2f4d61703b4c000b726564697265637455726971007e000e4c00077265667265736874003b4c6f72672f737072696e676672616d65776f726b2f73656375726974792f6f61757468322f70726f76696465722f546f6b656e526571756573743b4c000b7265736f7572636549647374000f4c6a6176612f7574696c2f5365743b4c000d726573706f6e7365547970657371007e0014787200386f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e70726f76696465722e426173655265717565737436287a3ea37169bd0200034c0008636c69656e74496471007e000e4c001172657175657374506172616d657465727371007e00124c000573636f706571007e00147870740009636c69656e74653031737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654d6170f1a5a8fe74f507420200014c00016d71007e00127870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000006740004636f64657400065050636d593874000a6772616e745f74797065740012617574686f72697a6174696f6e5f636f646574000d726573706f6e73655f74797065740004636f646574000c72656469726563745f75726974001c687474703a2f2f6c6f63616c686f73743a33363231352f6c6f67696e74000573746174657400066a304c6c5247740009636c69656e745f696471007e001778737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e0009737200176a6176612e7574696c2e4c696e6b656448617368536574d86cd75a95dd2a1e020000787200116a6176612e7574696c2e48617368536574ba44859596b8b7340300007870770c000000103f400000000000047400047265616474000577726974657400057472757374740009757365725f696e666f78017371007e002a770c000000103f400000000000027371007e000d74000b524f4c455f434c49454e547371007e000d740013524f4c455f545255535445445f434c49454e54787371007e001a3f40000000000000770800000010000000007874001c687474703a2f2f6c6f63616c686f73743a33363231352f6c6f67696e707371007e002a770c000000103f40000000000000787371007e002a770c000000103f4000000000000171007e0021787372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000001fe0200024c000b63726564656e7469616c7371007e00054c00097072696e636970616c71007e00057871007e0003017371007e00077371007e000b0000000177040000000171007e000f7871007e003c737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c7300000000000001fe0200024c000d72656d6f74654164647265737371007e000e4c000973657373696f6e496471007e000e787074000c31302e352e3131342e313130740020363638344133443933353744463042393238333144334142303833453945323670737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000001fe0200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657371007e00144c000870617373776f726471007e000e4c0008757365726e616d6571007e000e7870010101017371007e0027737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f7200000000000001fe020000787077040000000171007e000f787074000b61646d696e4061646d696e	\\xaced00057372004c6f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744578706972696e674f417574683252656672657368546f6b656e2fdf47639dd0c9b70200014c000a65787069726174696f6e7400104c6a6176612f7574696c2f446174653b787200446f72672e737072696e676672616d65776f726b2e73656375726974792e6f61757468322e636f6d6d6f6e2e44656661756c744f417574683252656672657368546f6b656e73e10e0a6354d45e0200014c000576616c75657400124c6a6176612f6c616e672f537472696e673b787074002436353930636334652d623835322d343936382d613064392d6639643435356564323439387372000e6a6176612e7574696c2e44617465686a81014b5974190300007870770800000169914c8f8f78	513bf37e8d1d409fc25118c902ae0e4b
\.


--
-- TOC entry 2966 (class 0 OID 16441)
-- Dependencies: 208
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, enabled, full_name, funcao, user_name, origem, password, profile_image, setor, telefone, cpf, email) FROM stdin;
156	t	00200328115 SISEIDN	\N	00200328115	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
3	t	ertert	ertret	tertert	ertert	$2a$08$9vYjNx/HABQAdLnBiHzHAumB8w4Wwn.N1lHoFdXdJ.7MzVF81jYkC	4867ae69eda9420ab483b59dff01df2f.jpg	ertrete	rertret	\N	\N
157	t	Aldecir Vieira Simonaci	\N	51984881787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
175	t	Usuário N2-MB	\N	02225307741	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
176	t	Rafael Abílio de Almeida Dias Gonçalves	\N	05134011648	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
177	t	Mauro Ferreira Nascimento	\N	08714066750	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
178	t	Mário Cesar da Silva	\N	09305667775	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
179	t	09752829805 SISEIDN	\N	09752829805	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
180	t	09912466756 SISEIDN	\N	09912466756	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
181	t	Heider Guilherme de Azevedo	\N	10652846750	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
182	t	Carlos Antônio Correa Loio Rodrigues	\N	13216188752	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
183	t	Thaiane Silva Abreu	\N	14330247720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
184	t	Luciano Antonio Araújo dos Santos	\N	07647428764	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
185	t	Natália de Brito Oliveira	\N	10323032710	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
186	t	Ariane Ferreira Leonardelli Teixeira	\N	14803331740	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
187	t	Andre Luis Regly Ferreira	\N	01200059727	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
188	t	Rothday Zany Marques Junior	\N	08195174701	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
189	t	Rubem Teixeira	\N	53094557600	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
190	t	Wilson do Couto Filho	\N	92940722820	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
191	t	Gilmar de França Vieira	\N	00889381747	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
192	t	Marciley Thadeu Cartaxo da Costa	\N	65439694749	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
193	t	Aldo Balbi	\N	05579806744	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
194	t	Mauro André Gonçalves	\N	00761444700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
195	t	Rivelino Barata de Sousa	\N	74222953334	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
196	t	Anderson dos Santos Kümmel	\N	16861945870	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
197	t	Daniel Muniz Gonçalves	\N	46139958334	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
198	t	Geraldo Pedroso Alves	\N	38195925715	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
155	t	Cleber de Araujo	yhfghfgh	86890220749	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	fhfghfghfg	\N	\N
199	t	Raquel Araujo Serpa Farias	\N	00195629183	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
200	t	Moises Shalon Gonçalves de Almeida	\N	69676186015	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
201	t	Hudson Peçanha Murad	\N	12343221880	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
202	t	Arthur Alexandre Gentil Toneli	\N	15410947860	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
203	t	Wagner Alves da Cruz	\N	00509555780	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
204	t	Adriano Ferreira Lima	\N	55524923668	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
205	t	Roberto Carlos Belarmino	\N	10507293746	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
206	t	Virgínia Cruz de Aragão	\N	39918220406	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
207	t	Alexandre Vizeu Dias	\N	03001179732	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
208	t	Edilson Melgaço da Silva	\N	98871803191	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
209	t	Vinicius da Silva Costa	\N	12333440724	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
210	t	José Fernando Reis Costa	\N	37401971704	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
211	t	00761506748 SISEIDN	\N	00761506748	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
212	t	Mauricio Figueiredo Cordeiro	\N	97454915787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
213	t	Alessandro Carlos da Silva Gonçalves	\N	00080449700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
214	t	Joaquim Testando	\N	77304571136	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
215	t	Daniel Abreu Da Silva Velho	\N	27567939819	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
556	f	teste	teste	teste	teste	$2a$16$mZA4znDtu8gnI/saenz2KeqFZXVm1flxL/cmvdcnUTImUJjGsFzBC	a43c7c38e8764c43bb52ff6570f76bc3.png	teste	teste	575.765.757-57	teste
216	t	Claudio Antonio Paula	\N	02558102702	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
217	t	Isabel Cristina da Frota Braga Sotomayor	\N	77418123787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
218	t	Celio Magno Heredia Meirelles	\N	51072203715	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
219	t	Rafael de Mendonça Rodrigues	\N	08572000704	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
220	t	Andreia de Souza da Silva	\N	01095092774	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
221	t	Fabio Costa Barreira	\N	05252614784	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
222	t	Márcia Cortez de Sousa	\N	02846574766	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
223	t	Paulo Sergio Andrade Barreto	\N	57463921549	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
224	t	João Carlos Barbosa da Motta	\N	85531413734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
225	t	USUÁRIO CCLM	\N	37486626888	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
226	t	Viviane Alves Jones	\N	03748388799	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
227	t	Daniel Pisani Bernardes	\N	08209572830	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
228	t	Alan Matias Avelar	\N	11387850750	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
229	t	Paula Cristina Rocha Santos	\N	12387818709	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
230	t	Jonathas Teste 2	\N	11111111111	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
231	t	Gleiton Farias de Souza	\N	16862043889	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
232	t	Usuário Teste JMX 00000000004	\N	00000000004	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
233	t	00761973796 SISEIDN	\N	00761973796	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
234	t	Nilson Marcelo Silva de Paula	\N	02401769790	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
235	t	Lauro Ângelo Muniz Brandão	\N	22829140826	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
236	t	Raimundo Paulo Negrão da Silva Junior	\N	73271411204	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
237	t	Umberto Rodrigues JUnqueira Franco	\N	09539671744	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
238	t	Eduardo Freitas de Souza	\N	02737731780	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
239	t	Monica Garcia Takahashi	\N	04672481921	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
240	t	Thiago Pires Ferreira Scalercio	\N	10547197721	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
241	t	Renato Gonçalves dos Santos	\N	09430861751	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
242	t	Elander Mendes da Rosa	\N	75384299720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
243	t	Michelle Monteiro Pontes	\N	84471395149	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
244	t	Jair Milagres de Andrade	\N	00766863700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
245	t	Ademir Raimundo da Silva	\N	01035515733	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
246	t	Marcelo dos Santos	\N	01067663762	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
247	t	Silvano José Santana de Souza	\N	03537564740	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
248	t	Júlio César Canavarro de Oliveira	\N	89822064772	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
249	t	Usuário N3-eb cad	\N	36663821180	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
250	t	Sérgio de Montmorency Evaristo Pestana	\N	93311338715	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
251	t	Luiz Carlos do Couto Lopes	\N	55251293887	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
252	t	00789870754 SISEIDN	\N	00789870754	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
253	t	Usuário Teste JMX 00000000006	\N	00000000006	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
254	t	Usuário Teste JMX 00000000007	\N	00000000007	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
255	t	Usuário Teste JMX 00000000011	\N	00000000011	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
256	t	Usuário Teste JMX 00000000012	\N	00000000012	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
257	t	Usuário Teste JMX 00000000013	\N	00000000013	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
258	t	Usuário Teste JMX 00000000010	\N	00000000010	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
259	t	Usuário Teste JMX 00000000014	\N	00000000014	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
260	t	Usuário Teste JMX 00000000015	\N	00000000015	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
261	t	Usuário Teste JMX 00000000016	\N	00000000016	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
262	t	Usuário Teste JMX 00000000017	\N	00000000017	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
263	t	Usuário Teste JMX 00000000018	\N	00000000018	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
264	t	Usuário Teste JMX 00000000019	\N	00000000019	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
265	t	Usuário Teste JMX 00000000020	\N	00000000020	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
266	t	Usuário Teste JMX 00000000021	\N	00000000021	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
267	t	Usuário Teste JMX 00000000023	\N	00000000023	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
268	t	Usuário Teste JMX 00000000024	\N	00000000024	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
269	t	Usuário Teste JMX 00000000025	\N	00000000025	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
270	t	Usuário Teste JMX 00000000026	\N	00000000026	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
271	t	Usuário Teste JMX 00000000027	\N	00000000027	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
272	t	Usuário Teste JMX 00000000028	\N	00000000028	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
273	t	Usuário Teste JMX 00000000029	\N	00000000029	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
274	t	Usuário Teste JMX 00000000030	\N	00000000030	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
275	t	Usuário Teste JMX 00000000031	\N	00000000031	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
276	t	Usuário Teste JMX 00000000032	\N	00000000032	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
277	t	Usuário Teste JMX 00000000022	\N	00000000022	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
278	t	Usuário Teste JMX 00000000009	\N	00000000009	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
279	t	Usuário Teste JMX 00000000036	\N	00000000036	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
280	t	Usuário Teste JMX 00000000041	\N	00000000041	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
281	t	Usuário Teste JMX 00000000037	\N	00000000037	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
282	t	Usuário Teste JMX 00000000038	\N	00000000038	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
283	t	Usuário Teste JMX 00000000039	\N	00000000039	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
284	t	Usuário Teste JMX 00000000042	\N	00000000042	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
285	t	Usuário Teste JMX 00000000043	\N	00000000043	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
286	t	Usuário Teste JMX 00000000044	\N	00000000044	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
287	t	Usuário Teste JMX 00000000045	\N	00000000045	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
288	t	Usuário Teste JMX 00000000046	\N	00000000046	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
289	t	Usuário Teste JMX 00000000047	\N	00000000047	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
290	t	Usuário Teste JMX 00000000048	\N	00000000048	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
292	t	Usuário Teste JMX 00000000003	\N	00000000003	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
293	t	Usuário Teste JMX 00000000033	\N	00000000033	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
294	t	Usuário Teste JMX 00000000034	\N	00000000034	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
295	t	Usuário Teste JMX 00000000035	\N	00000000035	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
296	t	Usuário Teste JMX 00000000040	\N	00000000040	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
297	t	Teste Servlog MB	\N	45626385320	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
298	t	Usuário mb	\N	03459346108	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
299	t	Priscilla Moreno 	\N	12021963730	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
300	t	teste peril	\N	30000000035	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
301	t	Gustavo Ribeiro	\N	06902331758	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
302	t	Ana Beatriz Snoeck Martins	\N	08876341765	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
303	t	Serviços REST DAdM	\N	00000000000	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
305	t	usuario n3 mb	\N	28071884863	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
306	t	Usuário Teste JMX 00000000005	\N	00000000005	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
307	t	00922160724 SISEIDN	\N	00922160724	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
308	t	01173866698 SISEIDN	\N	01173866698	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
309	t	01390889629 SISEIDN	\N	01390889629	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
291	t	Usuário Teste JMX 00000000049	\N	00000000049	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
310	t	01431685682 SISEIDN	\N	01431685682	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
311	t	Usuário N41-EB	\N	59171412239	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
312	t	01439268703 SISEIDN	\N	01439268703	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
313	t	02204196045 SISEIDN	\N	02204196045	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
314	t	02783832119 SISEIDN	\N	02783832119	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
315	t	02840912783 SISEIDN	\N	02840912783	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
316	t	04165879762 SISEIDN	\N	04165879762	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
317	t	04555316681 SISEIDN	\N	04555316681	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
318	t	04716048799 SISEIDN	\N	04716048799	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
319	t	05162892769 SISEIDN	\N	05162892769	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
320	t	05780081735 SISEIDN	\N	05780081735	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
321	t	05792671800 SISEIDN	\N	05792671800	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
322	t	05946796640 SISEIDN	\N	05946796640	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
323	t	05963409667 SISEIDN	\N	05963409667	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
324	t	07095788499 SISEIDN	\N	07095788499	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
325	t	07336159702 SISEIDN	\N	07336159702	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
326	t	07543635895 SISEIDN	\N	07543635895	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
327	t	07823593700 SISEIDN	\N	07823593700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
328	t	08788264408 SISEIDN	\N	08788264408	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
329	t	08960967424 SISEIDN	\N	08960967424	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
330	t	09241556714 SISEIDN	\N	09241556714	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
331	t	09289191880 SISEIDN	\N	09289191880	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
332	t	09880664752 SISEIDN	\N	09880664752	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
333	t	10533887720 SISEIDN	\N	10533887720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
334	t	11448079721 SISEIDN	\N	11448079721	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
335	t	12068175851 SISEIDN	\N	12068175851	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
336	t	12158061758 SISEIDN	\N	12158061758	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
337	t	13970975743 SISEIDN	\N	13970975743	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
338	t	15325555200 SISEIDN	\N	15325555200	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
339	t	17195513831 SISEIDN	\N	17195513831	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
340	t	17466132898 SISEIDN	\N	17466132898	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
341	t	22444785720 SISEIDN	\N	22444785720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
342	t	22649298049 SISEIDN	\N	22649298049	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
343	t	24591392848 SISEIDN	\N	24591392848	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
344	t	25705673884 SISEIDN	\N	25705673884	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
345	t	27988252372 SISEIDN	\N	27988252372	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
346	t	27999826898 SISEIDN	\N	27999826898	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
347	t	30793882168 SISEIDN	\N	30793882168	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
348	t	32132190372 SISEIDN	\N	32132190372	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
349	t	32179740778 SISEIDN	\N	32179740778	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
350	t	32457596300 SISEIDN	\N	32457596300	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
351	t	33285305843 SISEIDN	\N	33285305843	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
352	t	33341028315 SISEIDN	\N	33341028315	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
353	t	33902020210 SISEIDN	\N	33902020210	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
354	t	35684429149 SISEIDN	\N	35684429149	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
355	t	35735177818 SISEIDN	\N	35735177818	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
356	t	36001537810 SISEIDN	\N	36001537810	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
553	t	Usuário Comum	Usuário	user@user	CASNAV	$2a$16$QRYhTRYzdu40nJbdjUAf6OADrns63eKenTI8E/JV6VssJ/mLPaaWK	601aeab282f94aaeb4f706042d6427fe.png	APOLO	(21) 3456-7654	013.014.597-12	magno@apolo-correio.com.br
357	t	38542625072 SISEIDN	\N	38542625072	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
358	t	38651459149 SISEIDN	\N	38651459149	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
359	t	42406730034 SISEIDN	\N	42406730034	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
360	t	43309593487 SISEIDN	\N	43309593487	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
361	t	44136021020 SISEIDN	\N	44136021020	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
362	t	45481962691 SISEIDN	\N	45481962691	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
363	t	50077961072 SISEIDN	\N	50077961072	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
364	t	55843077004 SISEIDN	\N	55843077004	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
365	t	56221550025 SISEIDN	\N	56221550025	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
366	t	56746075320 SISEIDN	\N	56746075320	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
367	t	57651361253 SISEIDN	\N	57651361253	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
368	t	60109700759 SISEIDN	\N	60109700759	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
369	t	61244503649 SISEIDN	\N	61244503649	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
370	t	61440531315 SISEIDN	\N	61440531315	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
371	t	61441414304 SISEIDN	\N	61441414304	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
372	t	63992795004 SISEIDN	\N	63992795004	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
373	t	65336143472 SISEIDN	\N	65336143472	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
374	t	66540500700 SISEIDN	\N	66540500700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
375	t	70227500253 SISEIDN	\N	70227500253	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
376	t	70643296700 SISEIDN	\N	70643296700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
377	t	71139303015 SISEIDN	\N	71139303015	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
378	t	72944587315 SISEIDN	\N	72944587315	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
379	t	74970801720 SISEIDN	\N	74970801720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
380	t	76823202653 SISEIDN	\N	76823202653	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
381	t	77880242449 SISEIDN	\N	77880242449	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
382	t	79145949549 SISEIDN	\N	79145949549	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
383	t	79157831653 SISEIDN	\N	79157831653	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
384	t	79673279772 SISEIDN	\N	79673279772	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
385	t	79979661704 SISEIDN	\N	79979661704	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
386	t	81543832415 SISEIDN	\N	81543832415	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
387	t	83009892004 SISEIDN	\N	83009892004	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
388	t	86023500749 SISEIDN	\N	86023500749	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
389	t	86090895687 SISEIDN	\N	86090895687	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
390	t	86635069704 SISEIDN	\N	86635069704	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
391	t	90521595720 SISEIDN	\N	90521595720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
392	t	93404565720 SISEIDN	\N	93404565720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
393	t	93617186068 SISEIDN	\N	93617186068	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
394	t	94489076568 SISEIDN	\N	94489076568	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
396	t	Usuário N3-EB	\N	55551757102	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
397	t	Serviços DATASUS	\N	00000000200	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
398	t	SISEIDN - Registros sem usuário conhecido	\N	00000000100	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
399	t	VANDO Azevedo Silva	\N	92587925568	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
400	t	Halley da Silva Máximo	\N	69752699120	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
401	t	MARCUS VINICIUS SILVA MENEZES	\N	05155198712	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
402	t	Sebastião Alves da Silva	\N	07946532865	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
403	t	João Vicente Bacellar da Silva	\N	88042170734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
404	t	RONALDO LUCAS DOS SANTOS	\N	92102522768	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
405	t	RICARDO Dias Paz	\N	75190770630	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
406	t	UBIRAJARA PEREIRA DE ANDRADE	\N	95813063749	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
407	t	OLAVO MIGUEL KAYSER	\N	78751217872	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
408	t	Alexandre Cunha Pinto  Cel Av COMAR 1	\N	61241814600	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
409	t	ALLAN DOS SANTOS DA SILVA S1 SAD COMAR 4	\N	38185833826	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
410	t	RHENAN Roulin Rosa	\N	84399341734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
411	t	ROGÉRIO NOGUEIRA DE SOUSA	\N	48423408353	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
412	t	HELIO Carvalho Martins	\N	59655836991	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
413	t	JOSIMAR ALVES DOS SANTOS	\N	66197198134	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
414	t	HYLTON NEVES JUNIOR	\N	96096616704	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
415	t	Caroline Christiane Diehl	\N	08797018708	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
416	t	CAROLINA LUIZA DOS SANTOS VALIATTI	\N	09676994790	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
417	t	Thaline Oliveira da Silva 3S SAD COMAR 7	\N	53083091249	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
418	t	John WILFRIED Lipinski	\N	09698661867	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
419	t	Carlos Augusto Filgueira Magioli	\N	93736169787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
420	t	Lydio  Atico de Campos	\N	01046750712	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
421	t	Alberto PETERS Júnior	\N	05245111799	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
422	t	Sidnei Barcelos Cardoso	\N	62188119720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
423	t	RICARDO SILVA PATRÍCIO	\N	56623240268	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
424	t	Olegário Valverde de LACERDA Junior	\N	52388859620	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
425	t	Ubiracy Batista da Costa - SDAB	\N	01964479762	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
426	t	Leonardo Mainel 1S BMB COMAR IV	\N	05501620707	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
427	t	Celso Gomes de Sousa	\N	28702328291	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
428	t	Claudionor Souza Gomes	\N	77644026487	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
429	t	Eduardo Pereira da Silva - SRPVSP	\N	27114510896	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
430	t	Fábio Lourenço da Silva - AFA	\N	01240140703	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
431	t	Tiago de Souza Barbosa - CCA-SJ	\N	01786697505	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
432	t	Rubens Mascio Junior - ICEA	\N	15018382880	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
433	t	RODRIGO DA SILVA GOMES	\N	11656378710	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
434	t	Giovani Ferreira de Oliveira - BACG	\N	07073249714	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
435	t	Nildener Valmiraldo Santos - BACG	\N	98515756153	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
436	t	Natália Cristina Amaro da Silva	\N	40721414885	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
437	t	Glauber Barcelos Rocha - DCTA	\N	00882265733	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
438	t	Jose Carlos BERNARDO	\N	67445128468	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
439	t	TIAGO Francisco Soares	\N	11164828789	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
440	t	Adauto Teixeira da Silva	\N	66492459768	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
441	t	Guilherme Pollitano Costa	\N	08866624780	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
442	t	JARY José de Souza Filho	\N	98095188700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
443	t	LAURO JOSÉ MELLO DOMINGOS	\N	88359778787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
444	t	DELMIRO JOSÉ APARECIDO NETO	\N	05486217722	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
445	t	JOAO ROBERTO CAMPOS ELIA TCEL A-4 COMAR 3	\N	94034249749	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
446	t	LUCAS MARÇAL DOS PASSOS	\N	14268494782	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
447	t	WALBER TINOCO DE SANTANA	\N	01359017747	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
448	t	Alan Knoll	\N	24865350802	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
449	t	Everaldo Mariano da Silva	\N	81013604920	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
450	t	LUCIANO MALAQUIAS DA SILVA	\N	82974187668	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
451	t	Roque Cerqueira Pires Junior	\N	66842263549	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
452	t	FRANCISCO SANTOS DE JESUS	\N	53099230553	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
453	t	JÚLIO GABRIEL de Oliveira Ramos	\N	79771947753	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
454	t	Alex Ferreira Pereira	\N	93407084587	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
455	t	Anderson Andrade da Cruz	\N	85479217534	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
456	t	TERCIO MARTINS DO CARMO BATISTA	\N	07679748756	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
457	t	Érico Almeida Lisboa	\N	02270505506	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
458	t	Ricardo Otavio Samça Pelegrini	\N	02817359801	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
459	t	Fabio luiz marão pinheiro	\N	86972324734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
460	t	PEDRO HENRIQUE DOS SANTOS BATISTA	\N	55775179072	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
461	t	Herval Luis de Oliveira Bispo	\N	90673263568	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
462	t	JULIO CESAR SOUZA NOGUEIRA	\N	84420596791	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
463	t	JORGE LUIS COSTA SOUZA	\N	30636299368	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
464	t	CLEITON MARTINS DE SOUZA	\N	00996872671	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
465	t	LUCAS ABNER DA SILVA	\N	07791510626	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
466	t	ERIKA MARTINS BAIENSE	\N	05792566771	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
467	t	CLARISSA DE FONSECA FEITOSA	\N	01777577101	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
468	t	MARCUS VALERIUS ARARUNA DE SABOYA	\N	76002594787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
469	t	Lon Guaranay Cardoso Lopes	\N	87559889387	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
470	t	JOSÉ ADALBERTO VARGAS GOMES	\N	74068814872	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
471	t	PEDRO LUIZ BOUÇAS AZAMBUJA	\N	52101983915	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
472	t	FABRICIO FROES TEIXEIRA	\N	05183988706	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
473	t	Hildon Freitas da Costa	\N	02323300423	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
474	t	Flavio Francisco das Chagas	\N	67040705753	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
475	t	Waldo Belizário dos Santos	\N	84340371734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
476	t	RUBEM DUARTE DE SOUZA	\N	04745297700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
477	t	ROBERTO ALVES CARRIJO	\N	84987995115	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
478	t	Ronaldo Leiria Gomes	\N	51983087734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
479	t	Alex Leal Barreto	\N	96775629087	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
480	t	RENATO ALVES DE OLIVEIRA	\N	00577949608	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
481	t	TAMARA DE CASTRO RIBEIRO	\N	11542983703	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
482	t	GEDAIAS ANGELO LIMA	\N	78075874404	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
483	t	JOSÉ ALEXANDRE MARQUES DA SILVA	\N	39690598287	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
484	t	AIRTON GOMES ALEXANDRE	\N	47597984391	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
485	t	RODRIGO DA ROSA IOP	\N	75771870030	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
486	t	MARCOS DE ARAÚJO PEREIRA - Ten Cel Av COMAR II	\N	00857468782	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
487	t	Ivan Paulo Santos CORREIA	\N	02781356506	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
488	t	Osmar Ferreira da COSTA	\N	28243820078	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
489	t	ALEXANDRE HENRIQUE CARDOSO FERREIRA	\N	08058299707	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
490	t	MARCELO VICTOR CARDOSO CÂMARA	\N	70277982200	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
491	t	Gilson Alexandrino dos Santos Filho	\N	08883567730	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
492	t	LUCIANO STEFANI RUBINI	\N	17776875864	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
493	t	RAFAEL DA COSTA DE AGUIAR	\N	08918371756	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
494	t	CLAUDIO BARRETO TORRES	\N	90270878734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
495	t	JURANDYR BIZZO GONÇALVES JÚNIOR	\N	10691356742	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
496	t	JAIR DE FARIA	\N	82169160787	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
498	t	Maria de Fátima Marques	\N	91254523715	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
499	t	Daniel de Albuquerque Velozo	\N	72514051720	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
500	t	EDUARDO COELHO MEDEIROS	\N	87468131791	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
497	t	Gerson PRADE	\N	56929463000	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
501	t	Andrews Junior Vitoriano Moraes	\N	96701323200	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
502	t	Marivaldo Francisco Gaspar	\N	01256695777	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
503	t	ROBSON SANTOS DA COSTA	\N	04396139306	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
504	t	ALISSON ALLAN RODRIGUES CLEMENTINO DA SILVA	\N	07270827443	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
505	t	JOILSON BERNARD CAVALCANTE	\N	35649313334	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
508	t	Everardo Gomes de Araujo	\N	44007620334	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
509	t	Jorge Luiz Santos da VEIGA	\N	81550065734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
510	t	PEDRO José dos Santos	\N	02596888432	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
511	t	JOSUE BASTOS TAVARES	\N	26505878491	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
512	t	WANDERSON Luiz da Silva	\N	00044221711	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
513	t	ALDIMAR Bezerra de Lima	\N	90002180472	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
514	t	Marco Aurélio Brito de SAMPAIO	\N	54442800600	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
515	t	BRAULIO Lopes Reis	\N	03056284619	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
516	t	GUILHERME DUARTE DOS SANTOS	\N	05639958740	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
517	t	EDMILSON DAS MERCÊS GONÇALVES	\N	57951950653	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
518	t	SANCLEY PEREIRA FERNANDES	\N	00743248457	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
519	t	CLAUDEMIR GIRÃO RODRIGUES	\N	58052038391	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
520	t	RODOLFO Leonardo Borges Carneiro Amorim	\N	80450857549	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
521	t	RENATO SOUSA RAMOS	\N	49427822368	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
522	t	Fabio Saldanha Dias	\N	02379227039	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
523	t	Marcio dos Santos Ribeiro	\N	11638666792	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
524	t	FRANCINILSON DOMINGOS DE ARAUJO	\N	91649170459	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
525	t	IDELITA DO CARMO DE ARAÚJO RIBEIRO	\N	70036942200	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
526	t	ERICO FERNANDO MAGALHÃES DE ARAÚJO	\N	02280152436	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
527	t	JOÃO PAULO DA COSTA ARAÚJO ALVES	\N	64042278353	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
528	t	Sergio Luiz MENDES de Oliveira	\N	31888828900	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
532	t	CLÁUDIO CAVALCANTE FERREIRA - 1S BSP BANT	\N	69826439487	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
533	t	IGO TIMBÓ PAIVA MORORÓ - 3S SAD BASV	\N	91269539353	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
534	t	Luciana INGRID Feitosa Santana Moura	\N	66092515253	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
535	t	JOÃO LUIZ DE MENEZES FILHO - SO BEI CINDACTA 3	\N	85849383700	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
536	t	Ravel Silva Carvalho	\N	45408807304	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
537	t	CLODOALDO PEDRO BIASOTTO	\N	01612719953	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
538	t	RUDINEI AREND DA SILVA	\N	53698860082	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
539	t	OTACÍLIO ESTEVAM SANTIAGO FILHO - Maj Esp Av BARF	\N	52948170478	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
540	t	usuario n4 mb	\N	48767842801	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
541	t	usuário teste n3	\N	50561752770	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
542	t	Arthur Azevedo de Andrade	\N	12386616703	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
543	t	Serviços REST SigPes FAB	\N	00000000001	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
544	t	Serviços REST Cad. OM EB	\N	00000000002	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
545	t	usuário teste 1	\N	57212008800	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
546	t	usuário teste 3	\N	83094583474	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
547	t	usuário teste 2	\N	79682344760	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
548	t	Jonathas Pacífico de Souza	\N	08097752719	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
549	t	Testador	\N	10515354848	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
550	t	meu clone	\N	83623005827	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
529	t	ROBERTO CARVALHO BARRELLA - SO BEV BARF	\N	00279329741	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
158	t	Pedro Oliveira de Sá	\N	01197433708	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
159	t	Usuário Teste JMX 00000000008	\N	00000000008	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
160	t	Silas Ferreira Paz	\N	28248058387	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
161	t	José Martins Teste	\N	93985018219	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
162	t	Usuário N2-EB	\N	10000000019	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
164	t	Wilson Luiz de Lima Neves	\N	31702899772	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
165	t	Antonio Roberto de Oliveira	\N	34746420734	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
166	t	Alexandre Paulino Gonçalves	\N	01395935785	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
167	t	Marcos Paulo Gomes Serafim	\N	00064523616	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
168	t	Ernesto Pinto Junior	\N	02801803731	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
169	t	Usuário N4-MB	\N	03459347171	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
170	t	Cristiane Pinheiro de Araujo	\N	09530267797	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
171	t	00335855717 SISEIDN	\N	00335855717	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
172	t	Nacélio Alves Pessoa	\N	02331751722	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
173	t	Usuário Teste Servlog	\N	62966128690	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
174	t	José Fernando Reis Costa	\N	22222222222	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
530	t	ARNAUD GOMES DE QUEIROZ - Cap Esp Av BAFZ	\N	35755873372	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
531	t	FABIO Oliveira da SILVA	\N	09045675757	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
551	t	Usuário N1-MD	\N	44444444444	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
552	t	Usuário Teste JMX 00000000050	\N	00000000050	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
304	t	Jonathas Pacífico de Souza	\N	33333333333	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
1	t	Administrador do Sistema	Administrador do Guardião	admin@admin	CASNAV	$2a$08$9vYjNx/HABQAdLnBiHzHAumB8w4Wwn.N1lHoFdXdJ.7MzVF81jYkC	601aeab282f94aaeb4f706042d6427fe.png	APOLO	(21) 3456-7654	022.212.247-10	magno@apolo-correio.com.br
555	t	Priscilla Moreno		primoreno	Casnav	$2a$16$XY.5xcpD0o9sj/ZpisDaRePd34iJWlHxDmIen2.zNNWzReN/HoTyO	13c6d95a361e4336906636e074e93490.jpg			\N	\N
554	t	Diego Victor de Jesus	Desenvolvedor	diegovictorbr	CASNAV	$2a$16$95vmLQ6fADkw0Gr3tJmiHeQ6RTIQ.ECazY4/uT6EdTbpKq8Oi09h2	f3a83e95730d47e08f12f75e49fc5764.jpg	APOLO	(21)96821-2960	022.212.247-10	fhhhhhhhhhhh
163	t	Edgard Candido de Oliveira Neto	Gerente do Projeto Apolo	34747591753	CASNAV	$2a$16$Q0hGbs1D6.0SBehjtjqoyOFaybWrQrUQPMZm3qE.hkvlWlgvsNgue	c62c68ac76294d1f9db69e9457c47ebd.jpg	Projeto Apolo	21988110786	\N	\N
559	f	udto	admin@admin	udto	udto	$2a$16$x3gNNnNhbYT8vsiCcHFzXeuCGFkW7CXWaACETkiodfMkdANZ0knD2	3d2afff123ae4509a401ee1611c2c198.png	udto	udto	000.000.000-00	udto
560	f	uuuu	admin@admin	uuuu	uuuu	$2a$16$Hpq8AcPTBmWpM6P2ZNAIL.kKC3LIhyT9ITQA9XHzmU0A5kesUkHUS	e3c4b219de394fe093eba82076c02b9c.png	uuuu	uuuu	000.000.000-00	uuuu
561	t	ffff	ffff	ffff	ffff	$2a$08$9vYjNx/HABQAdLnBiHzHAumB8w4Wwn.N1lHoFdXdJ.7MzVF81jYkC	9d349cf37a174fab9d4c331881691f5a.png	ffff	ffff	999.999.999-99	ffff
395	t	tst222	\N	69122662669	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
506	t	Márcio Pereira de Noronha	\N	06871405879	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
507	t	MÁRIO PEREIRA MACHADO FILHO	\N	89689623753	Apolo	$2a$08$ElYpFSq2cyb/cunW3zWEEOozbIoODs1yd7rdprWKltNrhLtoxl9de	no_photo.png	Apolo	\N	\N	\N
\.


--
-- TOC entry 2967 (class 0 OID 16447)
-- Dependencies: 209
-- Data for Name: users_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_clients (client_client_id, user_user_id, dt_final, dt_inicial, sysadmin, dt_alteracao, respalteracao, tipoalteracao) FROM stdin;
sisclaten	554	2019-03-26 00:00:00	2019-02-14 00:00:00	t	2019-02-19 11:04:43.19	Administrador do Sistema	Alterou validade de acesso iniciando em 14/02/2019 até 26/03/2019
apolo	561	2019-02-25 08:16:51.697	2019-02-25 08:16:51.697	f	2019-02-25 08:16:51.697	Administrador do Sistema	Adicionou Permissão para Uso.
apolo	156	2019-02-25 08:28:47.052	2019-02-25 08:28:47.052	f	2019-02-25 08:28:47.052	Administrador do Sistema	Adicionou Permissão para Uso.
apolo	1	2019-02-25 11:35:54.996	2019-02-25 11:35:54.996	f	2019-02-25 11:35:54.996	Administrador do Sistema	Adicionou Permissão para Uso.
sisclaten	1	2019-02-25 11:35:59.33	2019-02-25 11:35:59.33	t	2019-02-25 11:36:02.895	Administrador do Sistema	Alterou permissão para 'Administrador'
apolo	554	2019-03-27 00:00:00	2019-02-15 00:00:00	t	2019-02-27 09:12:01.498	Administrador do Sistema	Alterou permissão para 'Administrador'
hades	554	2019-02-27 09:12:14.757	2019-02-27 09:12:14.757	t	2019-02-27 09:12:40.694	Administrador do Sistema	Alterou permissão para 'Administrador'
hades	1	2019-02-27 09:13:07.442	2019-02-27 09:13:07.442	t	2019-02-27 09:13:10.14	Administrador do Sistema	Alterou permissão para 'Administrador'
cliente01	1	2019-03-11 11:45:00.659	2019-03-11 11:45:00.659	t	2019-03-11 12:43:58.93	Administrador do Sistema	Alterou permissão para 'Administrador'
\.


--
-- TOC entry 2968 (class 0 OID 16453)
-- Dependencies: 210
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_roles (user_role_id, role_name, user_id) FROM stdin;
442	ROLE_ADMIN	1
151	ROLE_USER	285
152	ROLE_USER	286
153	ROLE_USER	287
154	ROLE_USER	288
155	ROLE_USER	289
156	ROLE_USER	290
157	ROLE_USER	291
158	ROLE_USER	292
159	ROLE_USER	293
160	ROLE_USER	294
161	ROLE_USER	295
162	ROLE_USER	296
163	ROLE_USER	297
164	ROLE_USER	298
165	ROLE_USER	299
166	ROLE_USER	300
167	ROLE_USER	301
168	ROLE_USER	302
169	ROLE_USER	303
170	ROLE_USER	304
171	ROLE_USER	305
172	ROLE_USER	306
173	ROLE_USER	307
174	ROLE_USER	308
175	ROLE_USER	309
176	ROLE_USER	310
177	ROLE_USER	311
178	ROLE_USER	312
179	ROLE_USER	313
180	ROLE_USER	314
181	ROLE_USER	315
182	ROLE_USER	316
183	ROLE_USER	317
184	ROLE_USER	318
185	ROLE_USER	319
186	ROLE_USER	320
187	ROLE_USER	321
188	ROLE_USER	322
189	ROLE_USER	323
190	ROLE_USER	324
191	ROLE_USER	325
192	ROLE_USER	326
193	ROLE_USER	327
194	ROLE_USER	328
195	ROLE_USER	329
196	ROLE_USER	330
197	ROLE_USER	331
198	ROLE_USER	332
199	ROLE_USER	333
200	ROLE_USER	334
201	ROLE_USER	335
202	ROLE_USER	336
203	ROLE_USER	337
204	ROLE_USER	338
205	ROLE_USER	339
206	ROLE_USER	340
207	ROLE_USER	341
208	ROLE_USER	342
209	ROLE_USER	343
210	ROLE_USER	344
211	ROLE_USER	345
212	ROLE_USER	346
213	ROLE_USER	347
214	ROLE_USER	348
215	ROLE_USER	349
216	ROLE_USER	350
217	ROLE_USER	351
218	ROLE_USER	352
219	ROLE_USER	353
220	ROLE_USER	354
221	ROLE_USER	355
222	ROLE_USER	356
223	ROLE_USER	357
224	ROLE_USER	358
225	ROLE_USER	359
226	ROLE_USER	360
227	ROLE_USER	361
228	ROLE_USER	362
229	ROLE_USER	363
230	ROLE_USER	364
231	ROLE_USER	365
232	ROLE_USER	366
233	ROLE_USER	367
234	ROLE_USER	368
235	ROLE_USER	369
236	ROLE_USER	370
237	ROLE_USER	371
238	ROLE_USER	372
239	ROLE_USER	373
240	ROLE_USER	374
241	ROLE_USER	375
242	ROLE_USER	376
243	ROLE_USER	377
244	ROLE_USER	378
245	ROLE_USER	379
246	ROLE_USER	380
247	ROLE_USER	381
248	ROLE_USER	382
249	ROLE_USER	383
250	ROLE_USER	384
251	ROLE_USER	385
252	ROLE_USER	386
253	ROLE_USER	387
254	ROLE_USER	388
255	ROLE_USER	389
256	ROLE_USER	390
257	ROLE_USER	391
258	ROLE_USER	392
259	ROLE_USER	393
260	ROLE_USER	394
261	ROLE_USER	395
443	ROLE_USER	556
262	ROLE_USER	396
263	ROLE_USER	397
264	ROLE_USER	398
265	ROLE_USER	399
266	ROLE_USER	400
267	ROLE_USER	401
268	ROLE_USER	402
269	ROLE_USER	403
270	ROLE_USER	404
271	ROLE_USER	405
272	ROLE_USER	406
273	ROLE_USER	407
274	ROLE_USER	408
275	ROLE_USER	409
276	ROLE_USER	410
277	ROLE_USER	411
278	ROLE_USER	412
279	ROLE_USER	413
280	ROLE_USER	414
281	ROLE_USER	415
282	ROLE_USER	416
283	ROLE_USER	417
284	ROLE_USER	418
285	ROLE_USER	419
286	ROLE_USER	420
287	ROLE_USER	421
288	ROLE_USER	422
289	ROLE_USER	423
290	ROLE_USER	424
291	ROLE_USER	425
292	ROLE_USER	426
293	ROLE_USER	427
294	ROLE_USER	428
295	ROLE_USER	429
296	ROLE_USER	430
297	ROLE_USER	431
298	ROLE_USER	432
299	ROLE_USER	433
300	ROLE_USER	434
301	ROLE_USER	435
302	ROLE_USER	436
303	ROLE_USER	437
304	ROLE_USER	438
305	ROLE_USER	439
306	ROLE_USER	440
307	ROLE_USER	441
308	ROLE_USER	442
309	ROLE_USER	443
310	ROLE_USER	444
311	ROLE_USER	445
312	ROLE_USER	446
313	ROLE_USER	447
314	ROLE_USER	448
315	ROLE_USER	449
316	ROLE_USER	450
317	ROLE_USER	451
318	ROLE_USER	452
319	ROLE_USER	453
320	ROLE_USER	454
321	ROLE_USER	455
322	ROLE_USER	456
323	ROLE_USER	457
324	ROLE_USER	458
325	ROLE_USER	459
326	ROLE_USER	460
327	ROLE_USER	461
328	ROLE_USER	462
329	ROLE_USER	463
330	ROLE_USER	464
331	ROLE_USER	465
332	ROLE_USER	466
333	ROLE_USER	467
334	ROLE_USER	468
335	ROLE_USER	469
336	ROLE_USER	470
337	ROLE_USER	471
338	ROLE_USER	472
339	ROLE_USER	473
340	ROLE_USER	474
341	ROLE_USER	475
342	ROLE_USER	476
343	ROLE_USER	477
344	ROLE_USER	478
345	ROLE_USER	479
346	ROLE_USER	480
347	ROLE_USER	481
348	ROLE_USER	482
349	ROLE_USER	483
350	ROLE_USER	484
351	ROLE_USER	485
352	ROLE_USER	486
353	ROLE_USER	487
354	ROLE_USER	488
355	ROLE_USER	489
356	ROLE_USER	490
357	ROLE_USER	491
358	ROLE_USER	492
359	ROLE_USER	493
360	ROLE_USER	494
361	ROLE_USER	495
362	ROLE_USER	496
363	ROLE_USER	497
364	ROLE_USER	498
365	ROLE_USER	499
366	ROLE_USER	500
367	ROLE_USER	501
368	ROLE_USER	502
369	ROLE_USER	503
370	ROLE_USER	504
371	ROLE_USER	505
372	ROLE_USER	506
373	ROLE_USER	507
374	ROLE_USER	508
375	ROLE_USER	509
376	ROLE_USER	510
377	ROLE_USER	511
378	ROLE_USER	512
379	ROLE_USER	513
380	ROLE_USER	514
381	ROLE_USER	515
382	ROLE_USER	516
383	ROLE_USER	517
384	ROLE_USER	518
385	ROLE_USER	519
446	ROLE_USER	559
422	ROLE_USER	401
427	ROLE_USER	555
17	ROLE_USER	3
21	ROLE_USER	155
22	ROLE_USER	156
23	ROLE_USER	157
24	ROLE_USER	158
25	ROLE_USER	159
26	ROLE_USER	160
28	ROLE_USER	162
30	ROLE_USER	164
31	ROLE_USER	165
32	ROLE_USER	166
33	ROLE_USER	167
34	ROLE_USER	168
35	ROLE_USER	169
36	ROLE_USER	170
37	ROLE_USER	171
38	ROLE_USER	172
39	ROLE_USER	173
40	ROLE_USER	174
41	ROLE_USER	175
42	ROLE_USER	176
43	ROLE_USER	177
44	ROLE_USER	178
45	ROLE_USER	179
46	ROLE_USER	180
47	ROLE_USER	181
48	ROLE_USER	182
49	ROLE_USER	183
50	ROLE_USER	184
51	ROLE_USER	185
52	ROLE_USER	186
53	ROLE_USER	187
54	ROLE_USER	188
55	ROLE_USER	189
56	ROLE_USER	190
57	ROLE_USER	191
58	ROLE_USER	192
59	ROLE_USER	193
60	ROLE_USER	194
61	ROLE_USER	195
62	ROLE_USER	196
63	ROLE_USER	197
64	ROLE_USER	198
65	ROLE_USER	199
66	ROLE_USER	200
67	ROLE_USER	201
68	ROLE_USER	202
69	ROLE_USER	203
70	ROLE_USER	204
71	ROLE_USER	205
72	ROLE_USER	206
73	ROLE_USER	207
74	ROLE_USER	208
75	ROLE_USER	209
76	ROLE_USER	210
77	ROLE_USER	211
78	ROLE_USER	212
79	ROLE_USER	213
80	ROLE_USER	214
81	ROLE_USER	215
82	ROLE_USER	216
83	ROLE_USER	217
84	ROLE_USER	218
85	ROLE_USER	219
86	ROLE_USER	220
87	ROLE_USER	221
88	ROLE_USER	222
89	ROLE_USER	223
90	ROLE_USER	224
91	ROLE_USER	225
92	ROLE_USER	226
93	ROLE_USER	227
94	ROLE_USER	228
95	ROLE_USER	229
96	ROLE_USER	230
97	ROLE_USER	231
98	ROLE_USER	232
99	ROLE_USER	233
100	ROLE_USER	234
101	ROLE_USER	235
102	ROLE_USER	236
103	ROLE_USER	237
104	ROLE_USER	238
105	ROLE_USER	239
106	ROLE_USER	240
107	ROLE_USER	241
108	ROLE_USER	242
109	ROLE_USER	243
110	ROLE_USER	244
111	ROLE_USER	245
112	ROLE_USER	246
113	ROLE_USER	247
114	ROLE_USER	248
115	ROLE_USER	249
116	ROLE_USER	250
117	ROLE_USER	251
118	ROLE_USER	252
119	ROLE_USER	253
120	ROLE_USER	254
121	ROLE_USER	255
122	ROLE_USER	256
123	ROLE_USER	257
124	ROLE_USER	258
125	ROLE_USER	259
126	ROLE_USER	260
127	ROLE_USER	261
128	ROLE_USER	262
129	ROLE_USER	263
130	ROLE_USER	264
131	ROLE_USER	265
132	ROLE_USER	266
133	ROLE_USER	267
134	ROLE_USER	268
135	ROLE_USER	269
136	ROLE_USER	270
137	ROLE_USER	271
138	ROLE_USER	272
27	ROLE_USER	161
451	ROLE_USER	554
452	ROLE_USER	560
139	ROLE_USER	273
140	ROLE_USER	274
141	ROLE_USER	275
142	ROLE_USER	276
143	ROLE_USER	277
144	ROLE_USER	278
145	ROLE_USER	279
146	ROLE_USER	280
147	ROLE_USER	281
148	ROLE_USER	282
149	ROLE_USER	283
150	ROLE_USER	284
386	ROLE_USER	520
387	ROLE_USER	521
388	ROLE_USER	522
389	ROLE_USER	523
390	ROLE_USER	524
391	ROLE_USER	525
392	ROLE_USER	526
393	ROLE_USER	527
394	ROLE_USER	528
395	ROLE_USER	529
396	ROLE_USER	530
397	ROLE_USER	531
398	ROLE_USER	532
399	ROLE_USER	533
400	ROLE_USER	534
401	ROLE_USER	535
402	ROLE_USER	536
403	ROLE_USER	537
404	ROLE_USER	538
405	ROLE_USER	539
406	ROLE_USER	540
407	ROLE_USER	541
408	ROLE_USER	542
409	ROLE_USER	543
410	ROLE_USER	544
411	ROLE_USER	545
412	ROLE_USER	546
413	ROLE_USER	547
414	ROLE_USER	548
415	ROLE_USER	549
416	ROLE_USER	550
417	ROLE_USER	551
418	ROLE_USER	552
423	ROLE_USER	553
434	ROLE_USER	163
453	ROLE_USER	561
\.


--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 197
-- Name: access_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.access_log_log_id_seq', 194, true);


--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 201
-- Name: oauth_approvals_pk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_approvals_pk_id_seq', 1, false);


--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 205
-- Name: oauth_code_pk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_code_pk_id_seq', 1, false);


--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 207
-- Name: oauth_refresh_token_pk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oauth_refresh_token_pk_id_seq', 116, true);


--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 211
-- Name: users_roles_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_roles_user_role_id_seq', 453, true);


--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 212
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 561, true);


--
-- TOC entry 2807 (class 2606 OID 16470)
-- Name: access_log access_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_log
    ADD CONSTRAINT access_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 2809 (class 2606 OID 16472)
-- Name: clientdetails clientdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientdetails
    ADD CONSTRAINT clientdetails_pkey PRIMARY KEY (client_id);


--
-- TOC entry 2811 (class 2606 OID 16474)
-- Name: oauth_access_token oauth_access_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_token
    ADD CONSTRAINT oauth_access_token_pkey PRIMARY KEY (authentication_id);


--
-- TOC entry 2813 (class 2606 OID 16476)
-- Name: oauth_approvals oauth_approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_approvals
    ADD CONSTRAINT oauth_approvals_pkey PRIMARY KEY (pk_id);


--
-- TOC entry 2815 (class 2606 OID 16478)
-- Name: oauth_client_details oauth_client_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_client_details
    ADD CONSTRAINT oauth_client_details_pkey PRIMARY KEY (client_id);


--
-- TOC entry 2817 (class 2606 OID 16480)
-- Name: oauth_client_token oauth_client_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_client_token
    ADD CONSTRAINT oauth_client_token_pkey PRIMARY KEY (authentication_id);


--
-- TOC entry 2819 (class 2606 OID 16482)
-- Name: oauth_code oauth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_code
    ADD CONSTRAINT oauth_code_pkey PRIMARY KEY (pk_id);


--
-- TOC entry 2821 (class 2606 OID 16484)
-- Name: oauth_refresh_token oauth_refresh_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_refresh_token
    ADD CONSTRAINT oauth_refresh_token_pkey PRIMARY KEY (pk_id);


--
-- TOC entry 2823 (class 2606 OID 16486)
-- Name: users uk_k8d0f2n7n88w1a16yhua64onx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_k8d0f2n7n88w1a16yhua64onx UNIQUE (user_name);


--
-- TOC entry 2827 (class 2606 OID 16488)
-- Name: users_clients users_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_clients
    ADD CONSTRAINT users_clients_pkey PRIMARY KEY (client_client_id, user_user_id);


--
-- TOC entry 2825 (class 2606 OID 16490)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2829 (class 2606 OID 16492)
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (user_role_id);


--
-- TOC entry 2830 (class 2606 OID 16493)
-- Name: users_clients fk24srl1mfr8r3qvdqj94d9k9d5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_clients
    ADD CONSTRAINT fk24srl1mfr8r3qvdqj94d9k9d5 FOREIGN KEY (user_user_id) REFERENCES public.users(user_id);


--
-- TOC entry 2832 (class 2606 OID 16498)
-- Name: users_roles fk_datalayer_server; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk_datalayer_server FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 2831 (class 2606 OID 16503)
-- Name: users_clients fkkvrf67oq0dsiwmt3uylmh3efy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_clients
    ADD CONSTRAINT fkkvrf67oq0dsiwmt3uylmh3efy FOREIGN KEY (client_client_id) REFERENCES public.oauth_client_details(client_id);


-- Completed on 2019-03-21 17:41:41 UTC

--
-- PostgreSQL database dump complete
--

