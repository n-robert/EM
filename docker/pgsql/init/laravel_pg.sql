--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

DO $$
BEGIN
  CREATE ROLE robert WITH LOGIN SUPERUSER PASSWORD '1convi5t';
  EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'not creating role robert -- it already exists';
END
$$;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    name_ru character varying(512) NOT NULL,
    user_ids integer[] NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    description character varying(512),
    history text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.addresses OWNER TO robert;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO robert;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    name_ru character varying(512) NOT NULL,
    name_en character varying(512) NOT NULL,
    user_ids integer[] NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    iso_alpha2 character(2),
    iso_alpha3 character(3),
    iso_num bigint,
    phone_code bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.countries OWNER TO robert;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO robert;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    passport_number character varying(32) NOT NULL,
    last_name_ru character varying(64) NOT NULL,
    first_name_ru character varying(64) NOT NULL,
    citizenship_id bigint NOT NULL,
    status_id bigint NOT NULL,
    user_ids integer[] NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    gender character varying(32),
    passport_serie character varying(32),
    passport_issuer_code character varying(32),
    resident_document_serie character varying(32),
    resident_document_number character varying(32),
    phone character varying(32),
    work_permit_serie character varying(32),
    work_permit_number character varying(32),
    contract_number character varying(32),
    invitation_number character varying(32),
    cert_number character varying(32),
    visa_multiplicity character varying(32),
    visa_category character varying(32),
    visa_serie character varying(32),
    visa_number character varying(32),
    migr_card_serie character varying(32),
    migr_card_number character varying(32),
    middle_name_ru character varying(64),
    last_name_en character varying(64),
    first_name_en character varying(64),
    middle_name_en character varying(64),
    entry_checkpoint character varying(64),
    passport_issuer character varying(128),
    resident_document character varying(128),
    cert_issuer character varying(128),
    birth_place text,
    address text,
    history text,
    birth_date date,
    passport_issued_date date,
    passport_expired_date date,
    resident_document_issued_date date,
    resident_document_expired_date date,
    work_permit_issued_date date,
    work_permit_started_date date,
    work_permit_expired_date date,
    work_permit_paid_till_date date,
    hired_date date,
    fired_date date,
    taxpayer_id_issued_date date,
    cert_issued_date date,
    visa_issued_date date,
    visa_started_date date,
    visa_expired_date date,
    entry_date date,
    migr_card_issued_date date,
    reg_date date,
    departure_date date,
    whence_id bigint,
    employer_id bigint,
    employ_permit_id bigint,
    occupation_id bigint,
    work_address_id bigint,
    taxpayer_id bigint,
    host_id bigint,
    reg_address_id bigint,
    real_address_id bigint,
    resident_document_issuer_id bigint,
    work_permit_issuer_id bigint,
    visa_issuer_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.employees OWNER TO robert;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_id_seq OWNER TO robert;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: employers; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.employers (
    id bigint NOT NULL,
    name_ru character varying(512) NOT NULL,
    full_name_ru character varying(512) NOT NULL,
    director_id bigint NOT NULL,
    type_id bigint NOT NULL,
    user_ids integer[] NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    taxpayer_code character varying(32),
    active_business_type character varying(32),
    rcoad character varying(32),
    bcc character varying(32),
    acc_book_number character varying(32),
    account_number character varying(32),
    bank character varying(64),
    ca character varying(32),
    bic character varying(32),
    acc_reg_number character varying(32),
    uni_reg_number character varying(32),
    phone character varying(32),
    email character varying(32),
    prime_reg_number character varying(32),
    history text,
    acc_reg_date date,
    prime_reg_date date,
    uni_reg_date date,
    booker_id bigint,
    taxpayer_id bigint,
    address_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.employers OWNER TO robert;

--
-- Name: employers_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.employers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employers_id_seq OWNER TO robert;

--
-- Name: employers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.employers_id_seq OWNED BY public.employers.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO robert;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO robert;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO robert;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO robert;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: occupations; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.occupations (
    id bigint NOT NULL,
    user_ids integer[] NOT NULL,
    code character varying(32) NOT NULL,
    name_ru character varying(128) NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    description character varying(512),
    history text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.occupations OWNER TO robert;

--
-- Name: occupations_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.occupations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.occupations_id_seq OWNER TO robert;

--
-- Name: occupations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.occupations_id_seq OWNED BY public.occupations.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO robert;

--
-- Name: permits; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.permits (
    id bigint NOT NULL,
    employer_id bigint NOT NULL,
    user_ids integer[] NOT NULL,
    number character varying(64) NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    total integer,
    issued_date date,
    expired_date date,
    history text,
    details text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permits OWNER TO robert;

--
-- Name: permits_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.permits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permits_id_seq OWNER TO robert;

--
-- Name: permits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.permits_id_seq OWNED BY public.permits.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO robert;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO robert;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: quotas; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.quotas (
    id bigint NOT NULL,
    year character varying(32) NOT NULL,
    employer_id bigint NOT NULL,
    user_ids integer[] NOT NULL,
    published smallint DEFAULT '1'::smallint NOT NULL,
    total integer,
    history text,
    details text,
    issued_date date,
    expired_date date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.quotas OWNER TO robert;

--
-- Name: quotas_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.quotas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotas_id_seq OWNER TO robert;

--
-- Name: quotas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.quotas_id_seq OWNED BY public.quotas.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO robert;

--
-- Name: statuses; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.statuses (
    id bigint NOT NULL,
    name_ru character varying(32) NOT NULL,
    user_ids integer[] NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    name_en character varying(32)
);


ALTER TABLE public.statuses OWNER TO robert;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statuses_id_seq OWNER TO robert;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: telescope_entries; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.telescope_entries (
    sequence bigint NOT NULL,
    uuid uuid NOT NULL,
    batch_id uuid NOT NULL,
    family_hash character varying(255),
    should_display_on_index boolean DEFAULT true NOT NULL,
    type character varying(20) NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.telescope_entries OWNER TO robert;

--
-- Name: telescope_entries_sequence_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.telescope_entries_sequence_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.telescope_entries_sequence_seq OWNER TO robert;

--
-- Name: telescope_entries_sequence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.telescope_entries_sequence_seq OWNED BY public.telescope_entries.sequence;


--
-- Name: telescope_entries_tags; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.telescope_entries_tags (
    entry_uuid uuid NOT NULL,
    tag character varying(255) NOT NULL
);


ALTER TABLE public.telescope_entries_tags OWNER TO robert;

--
-- Name: telescope_monitoring; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.telescope_monitoring (
    tag character varying(255) NOT NULL
);


ALTER TABLE public.telescope_monitoring OWNER TO robert;

--
-- Name: types; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.types (
    id bigint NOT NULL,
    user_ids integer[] NOT NULL,
    code character varying(32) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.types OWNER TO robert;

--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_id_seq OWNER TO robert;

--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;


--
-- Name: usage_permits; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.usage_permits (
    id bigint NOT NULL,
    name_ru character varying(64) NOT NULL,
    user_ids integer[] NOT NULL,
    signing_date date,
    history text,
    address_id bigint,
    employer_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.usage_permits OWNER TO robert;

--
-- Name: usage_permits_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.usage_permits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usage_permits_id_seq OWNER TO robert;

--
-- Name: usage_permits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.usage_permits_id_seq OWNED BY public.usage_permits.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    current_team_id bigint,
    profile_photo_path text,
    is_admin boolean DEFAULT FALSE NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO robert;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO robert;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: employers id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.employers ALTER COLUMN id SET DEFAULT nextval('public.employers_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: occupations id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.occupations ALTER COLUMN id SET DEFAULT nextval('public.occupations_id_seq'::regclass);


--
-- Name: permits id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.permits ALTER COLUMN id SET DEFAULT nextval('public.permits_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: quotas id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.quotas ALTER COLUMN id SET DEFAULT nextval('public.quotas_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: telescope_entries sequence; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.telescope_entries ALTER COLUMN sequence SET DEFAULT nextval('public.telescope_entries_sequence_seq'::regclass);


--
-- Name: types id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);


--
-- Name: usage_permits id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.usage_permits ALTER COLUMN id SET DEFAULT nextval('public.usage_permits_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.addresses (id, name_ru, user_ids, published, description, history, created_at, updated_at) FROM stdin;
1	Тверская обл., г. Кимры, ул. Ленина, д. 66	{2,3}	1		{"prev_value":["name: \\u0433. \\u041a\\u0438\\u043c\\u0440\\u044b, \\u0443\\u043b. \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430, \\u0434. 66","name: 171506, \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u0433. \\u041a\\u0438\\u043c\\u0440\\u044b, \\u0443\\u043b. \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430, \\u0434. 66","name: 171506, \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u044c,\\u0433\\u043e\\u0440\\u043e\\u0434 \\u041a\\u0438\\u043c\\u0440\\u044b,\\u0443\\u043b\\u0438\\u0446\\u0430 \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430,\\u0434\\u043e\\u043c 66","name: 171506, \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.,\\u0433\\u043e\\u0440\\u043e\\u0434 \\u041a\\u0438\\u043c\\u0440\\u044b,\\u0443\\u043b\\u0438\\u0446\\u0430 \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430,\\u0434\\u043e\\u043c 66","name: 171506, \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.,\\u0433. \\u041a\\u0438\\u043c\\u0440\\u044b,\\u0443\\u043b. \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430,\\u0434. 66","user_ids: 209,208\\nname:  \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.,\\u0433. \\u041a\\u0438\\u043c\\u0440\\u044b,\\u0443\\u043b. \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430,\\u0434. 66"],"date":["11.05.2018 13:31:17","07.10.2019 13:56:16","07.10.2019 14:22:55","11.10.2019 11:46:19","14.10.2019 13:49:08","01.11.2019 13:33:26"],"user":["#208 \\u0420\\u043e\\u0431\\u0435\\u0440\\u0442","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N
3	г. Тверь, ул. Грибоедова, 34/68 к.1	{3,2}	0		\N	\N	\N
4	г. Кимры, ул. Ленина, д.66,помещение 712	{3,2,5}	1		{"prev_value":["user_ids: 209,215,208\\nname: \\u0433. \\u041a\\u0438\\u043c\\u0440\\u044b, \\u0443\\u043b. \\u041b\\u0435\\u043d\\u0438\\u043d\\u0430, \\u0434. 111\\nownership_certificate: "],"date":["05.03.2020 14:29:37"],"user":["#209 \\u042e\\u043b\\u044f"]}	\N	\N
5	г. Москва, Ленинский пр., д. 11, стр. 1	{2}	1		{"prev_value":["name: \\u0433. \\u041c\\u043e\\u0441\\u043a\\u0432\\u0430, \\u0434. 11, \\u041b\\u0435\\u043d\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439 \\u043f\\u0440., \\u0441\\u0442\\u0440. 1"],"date":["07.04.2018 22:33:05"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	\N	\N
6	г. Москва, пр. Мира, д. 20, кор. 1, оф. 2	{2}	1		\N	\N	\N
7	Кимрский р-н, дер. Титово, д. 35	{2,3,4}	1		{"prev_value":["name: \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d, \\u0434\\u0435\\u0440.\\u0422\\u0438\\u0442\\u043e\\u0432\\u043e, \\u0434.35\\u0430","user_ids: 209,214,208\\nname: \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d, \\u0434\\u0435\\u0440. \\u0422\\u0438\\u0442\\u043e\\u0432\\u043e, \\u0434. 35"],"date":["05.12.2018 08:49:36","19.09.2019 13:07:38"],"user":["#208 \\u041d\\u0430\\u043c","#207 Super User"]}	\N	\N
8	г. Кимры, ул. Ульяновская, д. 22а	{3,2}	1		{"prev_value":["user_ids: 209,208\\nname: \\u0433.\\u041a\\u0438\\u043c\\u0440\\u044b,\\u0443\\u043b.\\u0423\\u043b\\u044c\\u044f\\u043d\\u043e\\u0432\\u0441\\u043a\\u0430\\u044f \\u0434.22\\u0430"],"date":["04.12.2018 18:37:39"],"user":["#208 \\u041d\\u0430\\u043c"]}	\N	\N
9	г. Кимры, ул. 50 Лет ВЛКСМ, д. 28, кв. 87	{3,2}	1		{"prev_value":["user_ids: 209,208\\nname: \\u0433.\\u041a\\u0438\\u043c\\u0440\\u044b,\\u0443\\u043b.50 \\u041b\\u0435\\u0442 \\u0412\\u041b\\u041a\\u0421\\u041c \\u0434.28\\u043a\\u0432.87"],"date":["04.12.2018 18:38:04"],"user":["#208 \\u041d\\u0430\\u043c"]}	\N	\N
11	г. Москва, ул. Перекопская, д. 21, кв. 56	{3,2}	1		{"prev_value":["user_ids: 209,208\\nname: \\u0433.\\u041c\\u043e\\u0441\\u043a\\u0432\\u0430 ,\\u0443\\u043b.\\u041f\\u0435\\u0440\\u0435\\u043a\\u043e\\u043f\\u0441\\u043a\\u0430\\u044f \\u0434.21\\u043a\\u0432.56"],"date":["04.12.2018 18:39:07"],"user":["#208 \\u041d\\u0430\\u043c"]}	\N	\N
13	Тверская обл., г. Кимры, пр. Лоткова, д.11, кв. 64	{2,3}	1		{"prev_value":["","user_ids: 209,208\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.,\\u0433.\\u041a\\u0438\\u043c\\u0440\\u044b,\\u043f\\u0440.\\u041b\\u043e\\u0442\\u043a\\u043e\\u0432\\u0430 \\u0434.11,\\u043a\\u0432.64"],"date":["10.01.2019 11:05:16","19.09.2019 13:07:02"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	\N	\N
14	г. Москва, ул. Крутицкий вал, д. 3, корп. 2, кв. 36	{2,3,4}	1		{"prev_value":["","user_ids: 209,214,208\\nname: \\u0433.\\u041c\\u043e\\u0441\\u043a\\u0432\\u0430 ,\\u0443\\u043b.\\u041a\\u0440\\u0443\\u0442\\u0438\\u0446\\u043a\\u0438\\u0439 \\u0432\\u0430\\u043b,\\u0434.3,\\u043a\\u043e\\u0440\\u043f.2,\\u043a\\u0432.36"],"date":["11.03.2019 15:09:40","19.09.2019 13:06:39"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	\N	\N
12	Тверская обл., Кимрский р-н, пгт. Белый Городок, ул. Главная, д. 22, кв. 3	{2,3,4}	1	\N	{"prev_value":["name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d, \\u043f\\u0433\\u0442. \\u0411\\u0435\\u043b\\u044b\\u0439 \\u0413\\u043e\\u0440\\u043e\\u0434\\u043e\\u043a, \\u0443\\u043b. \\u0413\\u043b\\u0430\\u0432\\u043d\\u0430\\u044f, \\u0434.22, \\u043a\\u0432. 3","user_ids: 209,214,208\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d, \\u043f\\u0433\\u0442. \\u0411\\u0435\\u043b\\u044b\\u0439 \\u0413\\u043e\\u0440\\u043e\\u0434\\u043e\\u043a, \\u0443\\u043b. \\u0413\\u043b\\u0430\\u0432\\u043d\\u0430\\u044f, \\u0434. 22, \\u043a\\u0432. 3"],"date":["05.12.2018 08:50:14","19.09.2019 13:06:18"],"user":["#208 \\u041d\\u0430\\u043c","#207 Super User"]}	\N	2021-05-17 19:04:02
15	Г. МОСКВА, УЛ. Б.МАРФИНСКАЯ, Д.4, КОРП. 3, КВ. 9	{2,3}	1		{"prev_value":["","user_ids: 209,208\\nname: \\u0413.\\u041c\\u041e\\u0421\\u041a\\u0412\\u0410,\\u0423\\u041b.\\u0411.\\u041c\\u0410\\u0420\\u0424\\u0418\\u041d\\u0421\\u041a\\u0410\\u042f \\u0414.4,\\u041a\\u041e\\u0420\\u041f.3,\\u041a\\u0412.9","name: \\u0413.\\u041c\\u041e\\u0421\\u041a\\u0412\\u0410,\\u0423\\u041b.\\u0411.\\u041c\\u0410\\u0420\\u0424\\u0418\\u041d\\u0421\\u041a\\u0410\\u042f, \\u0414.4,\\u041a\\u041e\\u0420\\u041f.3,\\u041a\\u0412.9"],"date":["29.03.2019 14:36:20","30.06.2019 00:37:48","19.09.2019 13:07:21"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#207 Super User"]}	\N	\N
16	г. Уфа, ул. Пушкина, д. 45, кор. 2, оф. 11,12,13,14	{}	1		{"prev_value":[""],"date":["06.02.2020 11:54:04"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N
18	142600 Московская обл., \r\nг. Орехово-Зуево, ул. Ленина, д. 102	{}	1		{"prev_value":[""],"date":["21.04.2020 12:16:55"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N
2	Тверская обл., Кимрский р-н, пос. Приволжский, ул. Лесная, д. 8	{3,2,4}	1	Тест Тест	{"prev_value":["user_ids: 209,214,208\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u044c, \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440\\u0430\\u0439\\u043e\\u043d, \\u043f. \\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434. 8","user_ids: 208,209,214\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043d, \\u043f. \\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434. 8","user_ids: 209,208,214\\nname: 171531\\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u044c,\\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440\\u0430\\u0439\\u043e\\u043d,\\u043f\\u043e\\u0441\\u0435\\u043b\\u043e\\u043a \\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,\\u0443\\u043b\\u0438\\u0446\\u0430 \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,\\u0434\\u043e\\u043c 8","name: 171531 \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d,\\u043f\\u043e\\u0441. \\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b.  \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434. 8","user_ids: 209,208,214\\nname: 171531\\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b. \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b.\\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434.8","user_ids: 209,208,214\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b. \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b.\\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434.8","name:  \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043e\\u043d \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b.\\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434.8","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b.\\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434.8","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u044c \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440\\u0430\\u0439\\u043e\\u043d \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439, \\u0443\\u043b.\\u041b\\u0435\\u0441\\u043d\\u0430\\u044f, \\u0434.8","user_ids: 209,208,214\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.  \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440-\\u043e\\u043d  \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434.8","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.        \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440-\\u043e\\u043d          \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434.8","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.                             \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440-\\u043e\\u043d          \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434.8","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b.         \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440-\\u043e\\u043d          \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434.8","user_ids: 209,208,214\\nname: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440-\\u043e\\u043d, \\u043f\\u043e\\u0441.\\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434.8","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439  \\u0440-\\u043d, \\u043f\\u043e\\u0441. \\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434. 8","ownership_certificate: ","ownership_certificate: \\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2018","ownership_certificate: \\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2018","ownership_certificate: \\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2018","ownership_certificate: {\\"ownership_certificate0\\":{\\"employer_id\\":\\"1\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 09.01.2018\\\\t\\"}}","ownership_certificate: {\\"ownership_certificate0\\":{\\"employer_id\\":\\"1\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 09.01.2018\\\\t\\"},\\"ownership_certificate1\\":{\\"employer_id\\":\\"7\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 01.09.2018\\\\t\\"},\\"ownership_certificate2\\":{\\"employer_id\\":\\"\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 01.11.2018\\\\t\\"}}","ownership_certificate: {\\"ownership_certificate0\\":{\\"employer_id\\":\\"1\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 09.01.2018\\\\t\\"},\\"ownership_certificate1\\":{\\"employer_id\\":\\"7\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 01.09.2018\\\\t\\"},\\"ownership_certificate2\\":{\\"employer_id\\":\\"4\\",\\"certificate\\":\\"\\\\u0414\\\\u043e\\\\u0433\\\\u043e\\\\u0432\\\\u043e\\\\u0440 \\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0434\\\\u044b \\\\u043f\\\\u043e\\\\u043c\\\\u0435\\\\u0449\\\\u0435\\\\u043d\\\\u0438\\\\u044f \\\\u2116 \\\\u0431\\\\\\/\\\\u043d \\\\u043e\\\\u0442 01.11.2018\\\\t\\"}}","name: \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b., \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439 \\u0440-\\u043d, \\u043f\\u043e\\u0441. \\u041f\\u0440\\u0438\\u0432\\u043e\\u043b\\u0436\\u0441\\u043a\\u0438\\u0439,  \\u0443\\u043b. \\u041b\\u0435\\u0441\\u043d\\u0430\\u044f,  \\u0434. 8","user_ids: 208,209,214\\nownership_certificate: {\\"employer_id\\":[\\"1\\",\\"7\\",\\"4\\"],\\"certificate\\":[\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 09.01.2018\\",\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.09.2018\\",\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2018\\\\n\\\\n\\"]}","ownership_certificate: {\\"employer_id\\":[\\"1\\",\\"7\\",\\"4\\"],\\"certificate\\":[\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2020\\",\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.09.2018\\",\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2018\\\\n\\\\n\\"]}","user_ids: 209,208,214\\nownership_certificate: {\\"employer_id\\":[\\"1\\",\\"7\\",\\"4\\"],\\"certificate\\":[\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 01.11.2020\\",\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 21.09.2020\\",\\"\\u0414\\u043e\\u0433\\u043e\\u0432\\u043e\\u0440 \\u0430\\u0440\\u0435\\u043d\\u0434\\u044b \\u043f\\u043e\\u043c\\u0435\\u0449\\u0435\\u043d\\u0438\\u044f \\u2116 \\u0431\\/\\u043d \\u043e\\u0442 31.08.2020\\\\n\\\\n\\"]}"],"date":["19.09.2019 13:06:02","07.10.2019 13:54:12","07.10.2019 14:25:13","07.10.2019 14:27:44","14.10.2019 13:48:59","17.10.2019 12:06:25","17.10.2019 12:09:11","17.10.2019 12:10:01","17.10.2019 12:12:32","29.10.2019 13:53:20","29.10.2019 13:55:00","29.10.2019 13:55:33","29.10.2019 14:11:00","01.11.2019 13:33:39","01.11.2019 13:37:33","15.11.2019 23:53:56","18.11.2019 00:42:20","18.11.2019 00:43:59","18.11.2019 00:45:27","18.11.2019 00:45:45","18.11.2019 00:46:09","18.11.2019 10:32:45","19.11.2019 09:12:58","18.11.2020 12:31:54","18.11.2020 12:33:59","13.01.2021 12:26:35"],"user":["#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	\N	2021-05-17 16:55:33
17	123308, Москва, ул. Мнёвники, д. 1	{2}	1	Тест Тест Тест	{"prev_value":[""],"date":["21.04.2020 12:11:38"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	2021-05-17 13:53:07
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.countries (id, name_ru, name_en, user_ids, published, iso_alpha2, iso_alpha3, iso_num, phone_code, created_at, updated_at) FROM stdin;
1	Афганистан	Afghanistan	{2}	1	AF	AFG	4	93	2021-05-16 12:40:19	\N
2	Албания	Albania	{2}	1	AL	ALB	8	355	2021-05-16 12:40:19	\N
3	Алжир	Algeria	{2}	1	DZ	DZA	12	213	2021-05-16 12:40:19	\N
4	Американское Самоа	American Samoa	{2}	1	AS	ASM	16	1684	2021-05-16 12:40:19	\N
5	Андорра	Andorra	{2}	1	AD	AND	20	376	2021-05-16 12:40:19	\N
6	Ангола	Angola	{2}	1	AO	AGO	24	244	2021-05-16 12:40:19	\N
7	Ангилья	Anguilla	{2}	1	AI	AIA	660	1264	2021-05-16 12:40:19	\N
8	Антарктида	Antarctica	{2}	1	AQ	\N	\N	0	2021-05-16 12:40:19	\N
9	Антигуа и Барбуда	Antigua and Barbuda	{2}	1	AG	ATG	28	1268	2021-05-16 12:40:19	\N
10	Аргентина	Argentina	{2}	1	AR	ARG	32	54	2021-05-16 12:40:19	\N
11	Армения	Armenia	{2}	1	AM	ARM	51	374	2021-05-16 12:40:19	\N
12	Аруба	Aruba	{2}	1	AW	ABW	533	297	2021-05-16 12:40:19	\N
13	Австралия	Australia	{2}	1	AU	AUS	36	61	2021-05-16 12:40:19	\N
14	Австрия	Austria	{2}	1	AT	AUT	40	43	2021-05-16 12:40:19	\N
15	Азербайджан	Azerbaijan	{2}	1	AZ	AZE	31	994	2021-05-16 12:40:19	\N
16	Багамы	Bahamas	{2}	1	BS	BHS	44	1242	2021-05-16 12:40:19	\N
17	Бахрейн	Bahrain	{2}	1	BH	BHR	48	973	2021-05-16 12:40:19	\N
18	Бангладеш	Bangladesh	{2}	1	BD	BGD	50	880	2021-05-16 12:40:19	\N
19	Барбадос	Barbados	{2}	1	BB	BRB	52	1246	2021-05-16 12:40:19	\N
20	Беларyсь	Belarus	{2}	1	BY	BLR	112	375	2021-05-16 12:40:19	\N
21	Бельгия	Belgium	{2}	1	BE	BEL	56	32	2021-05-16 12:40:19	\N
22	Белиз	Belize	{2}	1	BZ	BLZ	84	501	2021-05-16 12:40:19	\N
23	Бенин	Benin	{2}	1	BJ	BEN	204	229	2021-05-16 12:40:19	\N
24	Бермуды	Bermuda	{2}	1	BM	BMU	60	1441	2021-05-16 12:40:19	\N
25	Бутан	Bhutan	{2}	1	BT	BTN	64	975	2021-05-16 12:40:19	\N
26	Боливия	Bolivia	{2}	1	BO	BOL	68	591	2021-05-16 12:40:19	\N
27	Босния и Герцеговина	Bosnia and Herzegovina	{2}	1	BA	BIH	70	387	2021-05-16 12:40:19	\N
28	Ботсвана	Botswana	{2}	1	BW	BWA	72	267	2021-05-16 12:40:19	\N
29	Остров Буве	Bouvet Island	{2}	1	BV	\N	\N	0	2021-05-16 12:40:19	\N
30	Бразилия	Brazil	{2}	1	BR	BRA	76	55	2021-05-16 12:40:19	\N
31	Британская территория в Индийском океане	British Indian Ocean Territory	{2}	1	IO	\N	\N	246	2021-05-16 12:40:19	\N
32	Бруней	Brunei Darussalam	{2}	1	BN	BRN	96	673	2021-05-16 12:40:19	\N
33	Болгария	Bulgaria	{2}	1	BG	BGR	100	359	2021-05-16 12:40:19	\N
34	Буркина-Фасо	Burkina Faso	{2}	1	BF	BFA	854	226	2021-05-16 12:40:19	\N
35	Бурунди	Burundi	{2}	1	BI	BDI	108	257	2021-05-16 12:40:19	\N
36	Камбоджа	Cambodia	{2}	1	KH	KHM	116	855	2021-05-16 12:40:19	\N
37	Камерун	Cameroon	{2}	1	CM	CMR	120	237	2021-05-16 12:40:19	\N
38	Канада	Canada	{2}	1	CA	CAN	124	1	2021-05-16 12:40:19	\N
39	Кабо-Верде	Cape Verde	{2}	1	CV	CPV	132	238	2021-05-16 12:40:19	\N
40	Каймановы острова	Cayman Islands	{2}	1	KY	CYM	136	1345	2021-05-16 12:40:19	\N
41	ЦАР	Central African Republic	{2}	1	CF	CAF	140	236	2021-05-16 12:40:19	\N
42	Чад	Chad	{2}	1	TD	TCD	148	235	2021-05-16 12:40:19	\N
43	Чили	Chile	{2}	1	CL	CHL	152	56	2021-05-16 12:40:19	\N
44	КНР	China	{2}	1	CN	CHN	156	86	2021-05-16 12:40:19	\N
45	Остров Рождества	Christmas Island	{2}	1	CX	\N	\N	61	2021-05-16 12:40:19	\N
46	Кокосовые острова	Cocos (Keeling) Islands	{2}	1	CC	\N	\N	672	2021-05-16 12:40:19	\N
47	Колумбия	Colombia	{2}	1	CO	COL	170	57	2021-05-16 12:40:19	\N
48	Коморы	Comoros	{2}	1	KM	COM	174	269	2021-05-16 12:40:19	\N
49	ДР Конго	Congo	{2}	1	CG	COG	178	242	2021-05-16 12:40:19	\N
50	Республика Конго	Congo, the Democratic Republic of the	{2}	1	CD	COD	180	242	2021-05-16 12:40:19	\N
51	Острова Кука	Cook Islands	{2}	1	CK	COK	184	682	2021-05-16 12:40:19	\N
52	Коста-Рика	Costa Rica	{2}	1	CR	CRI	188	506	2021-05-16 12:40:19	\N
53	Кот-д’Ивуар	Cote D'Ivoire	{2}	1	CI	CIV	384	225	2021-05-16 12:40:19	\N
54	Хорватия	Croatia	{2}	1	HR	HRV	191	385	2021-05-16 12:40:19	\N
55	Куба	Cuba	{2}	1	CU	CUB	192	53	2021-05-16 12:40:19	\N
56	Кипр	Cyprus	{2}	1	CY	CYP	196	357	2021-05-16 12:40:19	\N
57	Чехия	Czech Republic	{2}	1	CZ	CZE	203	420	2021-05-16 12:40:19	\N
58	Дания	Denmark	{2}	1	DK	DNK	208	45	2021-05-16 12:40:19	\N
59	Джибути	Djibouti	{2}	1	DJ	DJI	262	253	2021-05-16 12:40:19	\N
60	Доминика	Dominica	{2}	1	DM	DMA	212	1767	2021-05-16 12:40:19	\N
61	Доминиканская Республика	Dominican Republic	{2}	1	DO	DOM	214	1809	2021-05-16 12:40:19	\N
62	Эквадор	Ecuador	{2}	1	EC	ECU	218	593	2021-05-16 12:40:19	\N
63	Египет	Egypt	{2}	1	EG	EGY	818	20	2021-05-16 12:40:19	\N
64	Сальвадор	El Salvador	{2}	1	SV	SLV	222	503	2021-05-16 12:40:19	\N
65	Экваториальная Гвинея	Equatorial Guinea	{2}	1	GQ	GNQ	226	240	2021-05-16 12:40:19	\N
66	Эритрея	Eritrea	{2}	1	ER	ERI	232	291	2021-05-16 12:40:19	\N
67	Эстония	Estonia	{2}	1	EE	EST	233	372	2021-05-16 12:40:19	\N
68	Эфиопия	Ethiopia	{2}	1	ET	ETH	231	251	2021-05-16 12:40:19	\N
69	Фолклендские острова (Мальвины)	Falkland Islands (Malvinas)	{2}	1	FK	FLK	238	500	2021-05-16 12:40:19	\N
70	Фарерские острова	Faroe Islands	{2}	1	FO	FRO	234	298	2021-05-16 12:40:19	\N
71	Фиджи	Fiji	{2}	1	FJ	FJI	242	679	2021-05-16 12:40:19	\N
72	Финляндия	Finland	{2}	1	FI	FIN	246	358	2021-05-16 12:40:19	\N
73	Франция	France	{2}	1	FR	FRA	250	33	2021-05-16 12:40:19	\N
74	Французская Гвиана	French Guiana	{2}	1	GF	GUF	254	594	2021-05-16 12:40:19	\N
75	Французская Полинезия	French Polynesia	{2}	1	PF	PYF	258	689	2021-05-16 12:40:19	\N
76	Французские Южные и Антарктические Территории	French Southern Territories	{2}	1	TF	\N	\N	0	2021-05-16 12:40:19	\N
77	Габон	Gabon	{2}	1	GA	GAB	266	241	2021-05-16 12:40:19	\N
78	Гамбия	Gambia	{2}	1	GM	GMB	270	220	2021-05-16 12:40:19	\N
79	Грузия	Georgia	{2}	1	GE	GEO	268	995	2021-05-16 12:40:19	\N
80	Германия	Germany	{2}	1	DE	DEU	276	49	2021-05-16 12:40:19	\N
81	Гана	Ghana	{2}	1	GH	GHA	288	233	2021-05-16 12:40:19	\N
82	Гибралтар	Gibraltar	{2}	1	GI	GIB	292	350	2021-05-16 12:40:19	\N
83	Греция	Greece	{2}	1	GR	GRC	300	30	2021-05-16 12:40:19	\N
84	Гренландия	Greenland	{2}	1	GL	GRL	304	299	2021-05-16 12:40:19	\N
85	Гренада	Grenada	{2}	1	GD	GRD	308	1473	2021-05-16 12:40:19	\N
86	Гваделупа	Guadeloupe	{2}	1	GP	GLP	312	590	2021-05-16 12:40:19	\N
87	Гуам	Guam	{2}	1	GU	GUM	316	1671	2021-05-16 12:40:19	\N
88	Гватемала	Guatemala	{2}	1	GT	GTM	320	502	2021-05-16 12:40:19	\N
89	Гвинея	Guinea	{2}	1	GN	GIN	324	224	2021-05-16 12:40:19	\N
90	Гвинея-Биссау	Guinea-Bissau	{2}	1	GW	GNB	624	245	2021-05-16 12:40:19	\N
91	Гвиана	Guyana	{2}	1	GY	GUY	328	592	2021-05-16 12:40:19	\N
92	Гаити	Haiti	{2}	1	HT	HTI	332	509	2021-05-16 12:40:19	\N
93	Херд и Макдональд	Heard Island and Mcdonald Islands	{2}	1	HM	\N	\N	0	2021-05-16 12:40:19	\N
94	Ватикан	Holy See (Vatican City State)	{2}	1	VA	VAT	336	39	2021-05-16 12:40:19	\N
95	Гондурас	Honduras	{2}	1	HN	HND	340	504	2021-05-16 12:40:19	\N
96	Гонконг	Hong Kong	{2}	1	HK	HKG	344	852	2021-05-16 12:40:19	\N
97	Венгрия	Hungary	{2}	1	HU	HUN	348	36	2021-05-16 12:40:19	\N
98	Исландия	Iceland	{2}	1	IS	ISL	352	354	2021-05-16 12:40:19	\N
99	Индия	India	{2}	1	IN	IND	356	91	2021-05-16 12:40:19	\N
100	Индонезия	Indonesia	{2}	1	ID	IDN	360	62	2021-05-16 12:40:19	\N
101	Иран	Iran, Islamic Republic of	{2}	1	IR	IRN	364	98	2021-05-16 12:40:19	\N
102	Ирак	Iraq	{2}	1	IQ	IRQ	368	964	2021-05-16 12:40:19	\N
103	Ирландия	Ireland	{2}	1	IE	IRL	372	353	2021-05-16 12:40:19	\N
104	Израиль	Israel	{2}	1	IL	ISR	376	972	2021-05-16 12:40:19	\N
105	Италия	Italy	{2}	1	IT	ITA	380	39	2021-05-16 12:40:19	\N
106	Ямайка	Jamaica	{2}	1	JM	JAM	388	1876	2021-05-16 12:40:19	\N
107	Япония	Japan	{2}	1	JP	JPN	392	81	2021-05-16 12:40:19	\N
108	Иордания	Jordan	{2}	1	JO	JOR	400	962	2021-05-16 12:40:19	\N
109	Казахстан	Kazakhstan	{2}	1	KZ	KAZ	398	7	2021-05-16 12:40:19	\N
110	Кения	Kenya	{2}	1	KE	KEN	404	254	2021-05-16 12:40:19	\N
111	Кирибати	Kiribati	{2}	1	KI	KIR	296	686	2021-05-16 12:40:19	\N
112	КНДР	Korea, Democratic People's Republic of	{2}	1	KP	PRK	408	850	2021-05-16 12:40:19	\N
113	Республика Корея	Korea, Republic of	{2}	1	KR	KOR	410	82	2021-05-16 12:40:19	\N
114	Кувейт	Kuwait	{2}	1	KW	KWT	414	965	2021-05-16 12:40:19	\N
115	Кыргызская Республика	Kyrgyz Republic	{2}	1	KG	KGZ	417	996	2021-05-16 12:40:19	\N
116	Лаос	Lao People's Democratic Republic	{2}	1	LA	LAO	418	856	2021-05-16 12:40:19	\N
117	Латвия	Latvia	{2}	1	LV	LVA	428	371	2021-05-16 12:40:19	\N
118	Ливан	Lebanon	{2}	1	LB	LBN	422	961	2021-05-16 12:40:19	\N
119	Лесото	Lesotho	{2}	1	LS	LSO	426	266	2021-05-16 12:40:19	\N
120	Либерия	Liberia	{2}	1	LR	LBR	430	231	2021-05-16 12:40:19	\N
121	Ливия	Libyan Arab Jamahiriya	{2}	1	LY	LBY	434	218	2021-05-16 12:40:19	\N
122	Лихтенштейн	Liechtenstein	{2}	1	LI	LIE	438	423	2021-05-16 12:40:19	\N
123	Литва	Lithuania	{2}	1	LT	LTU	440	370	2021-05-16 12:40:19	\N
124	Люксембург	Luxembourg	{2}	1	LU	LUX	442	352	2021-05-16 12:40:19	\N
125	Макао	Macao	{2}	1	MO	MAC	446	853	2021-05-16 12:40:19	\N
126	Македония	Macedonia, the Former Yugoslav Republic of	{2}	1	MK	MKD	807	389	2021-05-16 12:40:19	\N
127	Мадагаскар	Madagascar	{2}	1	MG	MDG	450	261	2021-05-16 12:40:19	\N
128	Малави	Malawi	{2}	1	MW	MWI	454	265	2021-05-16 12:40:19	\N
129	Малайзия	Malaysia	{2}	1	MY	MYS	458	60	2021-05-16 12:40:19	\N
130	Мальдивы	Maldives	{2}	1	MV	MDV	462	960	2021-05-16 12:40:19	\N
131	Мали	Mali	{2}	1	ML	MLI	466	223	2021-05-16 12:40:19	\N
132	Мальта	Malta	{2}	1	MT	MLT	470	356	2021-05-16 12:40:19	\N
133	Маршалловы Острова	Marshall Islands	{2}	1	MH	MHL	584	692	2021-05-16 12:40:19	\N
134	Мартиника	Martinique	{2}	1	MQ	MTQ	474	596	2021-05-16 12:40:19	\N
135	Мавритания	Mauritania	{2}	1	MR	MRT	478	222	2021-05-16 12:40:19	\N
136	Маврикий	Mauritius	{2}	1	MU	MUS	480	230	2021-05-16 12:40:19	\N
137	Майотта	Mayotte	{2}	1	YT	\N	\N	269	2021-05-16 12:40:19	\N
138	Мексика	Mexico	{2}	1	MX	MEX	484	52	2021-05-16 12:40:19	\N
139	Микронезия	Micronesia, Federated States of	{2}	1	FM	FSM	583	691	2021-05-16 12:40:19	\N
140	Молдова	Moldova, Republic of	{2}	1	MD	MDA	498	373	2021-05-16 12:40:19	\N
141	Монако	Monaco	{2}	1	MC	MCO	492	377	2021-05-16 12:40:19	\N
142	Монголия	Mongolia	{2}	1	MN	MNG	496	976	2021-05-16 12:40:19	\N
143	Монтсеррат	Montserrat	{2}	1	MS	MSR	500	1664	2021-05-16 12:40:19	\N
144	Марокко	Morocco	{2}	1	MA	MAR	504	212	2021-05-16 12:40:19	\N
145	Мозамбик	Mozambique	{2}	1	MZ	MOZ	508	258	2021-05-16 12:40:19	\N
146	Мьянма	Myanmar	{2}	1	MM	MMR	104	95	2021-05-16 12:40:19	\N
147	Намибия	Namibia	{2}	1	NA	NAM	516	264	2021-05-16 12:40:19	\N
148	Науру	Nauru	{2}	1	NR	NRU	520	674	2021-05-16 12:40:19	\N
149	Непал	Nepal	{2}	1	NP	NPL	524	977	2021-05-16 12:40:19	\N
150	Нидерланды	Netherlands	{2}	1	NL	NLD	528	31	2021-05-16 12:40:19	\N
151	Нидерландские Антильские острова	Netherlands Antilles	{2}	1	AN	ANT	530	599	2021-05-16 12:40:19	\N
152	Новая Каледония	New Caledonia	{2}	1	NC	NCL	540	687	2021-05-16 12:40:19	\N
153	Новая Зеландия	New Zealand	{2}	1	NZ	NZL	554	64	2021-05-16 12:40:19	\N
154	Никарагуа	Nicaragua	{2}	1	NI	NIC	558	505	2021-05-16 12:40:19	\N
155	Нигер	Niger	{2}	1	NE	NER	562	227	2021-05-16 12:40:19	\N
156	Нигерия	Nigeria	{2}	1	NG	NGA	566	234	2021-05-16 12:40:19	\N
157	Ниуэ	Niue	{2}	1	NU	NIU	570	683	2021-05-16 12:40:19	\N
158	Остров Норфолк	Norfolk Island	{2}	1	NF	NFK	574	672	2021-05-16 12:40:19	\N
159	Северные Марианские острова	Northern Mariana Islands	{2}	1	MP	MNP	580	1670	2021-05-16 12:40:19	\N
160	Норвегия	Norway	{2}	1	NO	NOR	578	47	2021-05-16 12:40:19	\N
161	Оман	Oman	{2}	1	OM	OMN	512	968	2021-05-16 12:40:19	\N
162	Пакистан	Pakistan	{2}	1	PK	PAK	586	92	2021-05-16 12:40:19	\N
163	Палау	Palau	{2}	1	PW	PLW	585	680	2021-05-16 12:40:19	\N
164	Государство Палестина	Palestinian Territory, Occupied	{2}	1	PS	\N	\N	970	2021-05-16 12:40:19	\N
165	Панама	Panama	{2}	1	PA	PAN	591	507	2021-05-16 12:40:19	\N
166	Папуа-Новая Гвинея	Papua New Guinea	{2}	1	PG	PNG	598	675	2021-05-16 12:40:19	\N
167	Парагвай	Paraguay	{2}	1	PY	PRY	600	595	2021-05-16 12:40:19	\N
168	Перу	Peru	{2}	1	PE	PER	604	51	2021-05-16 12:40:19	\N
169	Филиппины	Philippines	{2}	1	PH	PHL	608	63	2021-05-16 12:40:19	\N
170	Острова Питкэрн	Pitcairn	{2}	1	PN	PCN	612	0	2021-05-16 12:40:19	\N
171	Польша	Poland	{2}	1	PL	POL	616	48	2021-05-16 12:40:19	\N
172	Португалия	Portugal	{2}	1	PT	PRT	620	351	2021-05-16 12:40:19	\N
173	Пуэрто Рико	Puerto Rico	{2}	1	PR	PRI	630	1787	2021-05-16 12:40:19	\N
174	Катар	Qatar	{2}	1	QA	QAT	634	974	2021-05-16 12:40:19	\N
175	Реюньон	Reunion	{2}	1	RE	REU	638	262	2021-05-16 12:40:19	\N
176	Румыния	Romania	{2}	1	RO	ROM	642	40	2021-05-16 12:40:19	\N
177	Российская Федерация	Russian Federation	{2}	1	RU	RUS	643	70	2021-05-16 12:40:19	\N
178	Руанда	Rwanda	{2}	1	RW	RWA	646	250	2021-05-16 12:40:19	\N
179	Острова Святой Елены	Saint Helena	{2}	1	SH	SHN	654	290	2021-05-16 12:40:19	\N
180	Сент-Китс и Невис	Saint Kitts and Nevis	{2}	1	KN	KNA	659	1869	2021-05-16 12:40:19	\N
181	Сент-Люсия	Saint Lucia	{2}	1	LC	LCA	662	1758	2021-05-16 12:40:19	\N
182	Сен-Пьер и Микелон	Saint Pierre and Miquelon	{2}	1	PM	SPM	666	508	2021-05-16 12:40:19	\N
183	Сент-Винсент и Гренадины	Saint Vincent and the Grenadines	{2}	1	VC	VCT	670	1784	2021-05-16 12:40:19	\N
184	Самоа	Samoa	{2}	1	WS	WSM	882	684	2021-05-16 12:40:19	\N
185	Сан-Марино	San Marino	{2}	1	SM	SMR	674	378	2021-05-16 12:40:19	\N
186	Сан-Томе и Принсипи	Sao Tome and Principe	{2}	1	ST	STP	678	239	2021-05-16 12:40:19	\N
187	Саудовская Аравия	Saudi Arabia	{2}	1	SA	SAU	682	966	2021-05-16 12:40:19	\N
188	Сенегал	Senegal	{2}	1	SN	SEN	686	221	2021-05-16 12:40:19	\N
189	Сербия	Serbia	{2}	1	RS	SRB	688	381	2021-05-16 12:40:19	\N
190	Сейшельские Острова	Seychelles	{2}	1	SC	SYC	690	248	2021-05-16 12:40:19	\N
191	Сьерра-Леоне	Sierra Leone	{2}	1	SL	SLE	694	232	2021-05-16 12:40:19	\N
192	Сингапур	Singapore	{2}	1	SG	SGP	702	65	2021-05-16 12:40:19	\N
193	Словакия	Slovakia	{2}	1	SK	SVK	703	421	2021-05-16 12:40:19	\N
194	Словения	Slovenia	{2}	1	SI	SVN	705	386	2021-05-16 12:40:19	\N
195	Соломоновы Острова	Solomon Islands	{2}	1	SB	SLB	90	677	2021-05-16 12:40:19	\N
196	Сомали	Somalia	{2}	1	SO	SOM	706	252	2021-05-16 12:40:19	\N
197	ЮАР	South Africa	{2}	1	ZA	ZAF	710	27	2021-05-16 12:40:19	\N
198	Южная Георгия и Южные Сандвичевы острова	South Georgia and the South Sandwich Islands	{2}	1	GS	\N	\N	0	2021-05-16 12:40:19	\N
199	Испания	Spain	{2}	1	ES	ESP	724	34	2021-05-16 12:40:19	\N
200	Шри-Ланка	Sri Lanka	{2}	1	LK	LKA	144	94	2021-05-16 12:40:19	\N
201	Судан	Sudan	{2}	1	SD	SDN	736	249	2021-05-16 12:40:19	\N
202	Суринам	Suriname	{2}	1	SR	SUR	740	597	2021-05-16 12:40:19	\N
203	Шпицберген и Ян-Майен	Svalbard and Jan Mayen	{2}	1	SJ	SJM	744	47	2021-05-16 12:40:19	\N
204	Свазиленд	Swaziland	{2}	1	SZ	SWZ	748	268	2021-05-16 12:40:19	\N
205	Швеция	Sweden	{2}	1	SE	SWE	752	46	2021-05-16 12:40:19	\N
206	Швейцария	Switzerland	{2}	1	CH	CHE	756	41	2021-05-16 12:40:19	\N
207	Сирия	Syrian Arab Republic	{2}	1	SY	SYR	760	963	2021-05-16 12:40:19	\N
208	Тайвань	Taiwan, Province of China	{2}	1	TW	TWN	158	886	2021-05-16 12:40:19	\N
209	Таджикистан	Tajikistan	{2}	1	TJ	TJK	762	992	2021-05-16 12:40:19	\N
210	Танзания	Tanzania, United Republic of	{2}	1	TZ	TZA	834	255	2021-05-16 12:40:19	\N
211	Тайланд	Thailand	{2}	1	TH	THA	764	66	2021-05-16 12:40:19	\N
212	Восточный Тимор	Timor-Leste	{2}	1	TL	\N	\N	670	2021-05-16 12:40:19	\N
213	Того	Togo	{2}	1	TG	TGO	768	228	2021-05-16 12:40:19	\N
214	Токелау	Tokelau	{2}	1	TK	TKL	772	690	2021-05-16 12:40:19	\N
215	Тонга	Tonga	{2}	1	TO	TON	776	676	2021-05-16 12:40:19	\N
216	Тринидад и Тобаго	Trinidad and Tobago	{2}	1	TT	TTO	780	1868	2021-05-16 12:40:19	\N
217	Тунис	Tunisia	{2}	1	TN	TUN	788	216	2021-05-16 12:40:19	\N
218	Турция	Turkey	{2}	1	TR	TUR	792	90	2021-05-16 12:40:19	\N
219	Туркменистан	Turkmenistan	{2}	1	TM	TKM	795	7370	2021-05-16 12:40:19	\N
220	Острова Туркс и Кайкос	Turks and Caicos Islands	{2}	1	TC	TCA	796	1649	2021-05-16 12:40:19	\N
221	Тувалу	Tuvalu	{2}	1	TV	TUV	798	688	2021-05-16 12:40:19	\N
222	Уганда	Uganda	{2}	1	UG	UGA	800	256	2021-05-16 12:40:19	\N
223	Украина	Ukraine	{2}	1	UA	UKR	804	380	2021-05-16 12:40:19	\N
224	Арабские Эмираты	United Arab Emirates	{2}	1	AE	ARE	784	971	2021-05-16 12:40:19	\N
225	Великобритания	United Kingdom	{2}	1	GB	GBR	826	44	2021-05-16 12:40:19	\N
226	США	United States	{2}	1	US	USA	840	1	2021-05-16 12:40:19	\N
227	Отдаленные Острова США	United States Minor Outlying Islands	{2}	1	UM	\N	\N	1	2021-05-16 12:40:19	\N
228	Уругвай	Uruguay	{2}	1	UY	URY	858	598	2021-05-16 12:40:19	\N
229	Узбекистан	Uzbekistan	{2}	1	UZ	UZB	860	998	2021-05-16 12:40:19	\N
230	Вануату	Vanuatu	{2}	1	VU	VUT	548	678	2021-05-16 12:40:19	\N
231	Венесуэла	Venezuela	{2}	1	VE	VEN	862	58	2021-05-16 12:40:19	\N
232	Вьетнам	Viet Nam	{2}	1	VN	VNM	704	84	2021-05-16 12:40:19	\N
233	Виргинские острова (Британские)	Virgin Islands, British	{2}	1	VG	VGB	92	1284	2021-05-16 12:40:19	\N
234	Виргинские острова (США)	Virgin Islands, U.s.	{2}	1	VI	VIR	850	1340	2021-05-16 12:40:19	\N
235	Уэльс	Wallis and Futuna	{2}	1	WF	WLF	876	681	2021-05-16 12:40:19	\N
236	Западная Сахара	Western Sahara	{2}	1	EH	ESH	732	212	2021-05-16 12:40:19	\N
237	Йемен	Yemen	{2}	1	YE	YEM	887	967	2021-05-16 12:40:19	\N
238	Замбия	Zambia	{2}	1	ZM	ZMB	894	260	2021-05-16 12:40:19	\N
239	Зимбабве	Zimbabwe	{2}	1	ZW	ZWE	716	263	2021-05-16 12:40:19	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.employees (id, passport_number, last_name_ru, first_name_ru, citizenship_id, status_id, user_ids, published, gender, passport_serie, passport_issuer_code, resident_document_serie, resident_document_number, phone, work_permit_serie, work_permit_number, contract_number, invitation_number, cert_number, visa_multiplicity, visa_category, visa_serie, visa_number, migr_card_serie, migr_card_number, middle_name_ru, last_name_en, first_name_en, middle_name_en, entry_checkpoint, passport_issuer, resident_document, cert_issuer, birth_place, address, history, birth_date, passport_issued_date, passport_expired_date, resident_document_issued_date, resident_document_expired_date, work_permit_issued_date, work_permit_started_date, work_permit_expired_date, work_permit_paid_till_date, hired_date, fired_date, taxpayer_id_issued_date, cert_issued_date, visa_issued_date, visa_started_date, visa_expired_date, entry_date, migr_card_issued_date, reg_date, departure_date, whence_id, employer_id, employ_permit_id, occupation_id, work_address_id, taxpayer_id, host_id, reg_address_id, real_address_id, resident_document_issuer_id, work_permit_issuer_id, visa_issuer_id, created_at, updated_at) FROM stdin;
3	560511	Молякова	Наталия	177	1	{3,2}	1	FEMALE	2817																Хасановна					Отделение УФМС России по Тверской обл. в Кимрском р-не				Тверская обл.,г.Кимры,пр.Титова ,д.13а,корп.2,кв.49	{"prev_value":["address: \\nuser_ids: 208,209","user_ids: 209"],"date":["19.04.2018 13:05:39","20.04.2018 09:50:00"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	\N	2017-12-23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	0	0	\N	0	0	0	0	0	0	0	\N	\N
4	705704	Куманеева	Мария	177	2	{3,2}	1	FEMALE	2805																Федоровна					Кимрским ОВД Тверской области, код подразделения 692-017					{"prev_value":["work_permit_started: \\nvisa_started: "],"date":["20.11.2018 11:49:19"],"user":["#209 \\u042e\\u043b\\u044f"]}	\N	2007-02-16	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	177	1	0	0	\N	0	0	0	0	0	0	0	\N	\N
15	N1461431	НГО	ДИНЬ ХЫНГ	232	3	{3,2,4}	1	MALE						69	1800004775	63	202409497	00084373	MULTI	WORK	12	1349193	4618	9275395		NGO	DINH HUNG		Шереметьево 566	Посольством Вьетнама в РФ		Ханойский университет индустрии	Бакзянг		{"prev_value":["work_permit_started: 2019-11-28 00:00:00","work_permit_started: 2018-11-28 00:00:00","work_permit_started: 2018-11-29 00:00:00","user_ids: 209,214,208\\nstatus: WORKER\\nfired_date: 0000-00-00 00:00:00"],"date":["19.11.2018 12:02:19","01.03.2019 11:03:35","01.03.2019 11:04:33","25.11.2019 13:41:54"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#207 Super User","#209 \\u042e\\u043b\\u044f"]}	1983-05-15	2012-02-06	2022-02-06	\N	\N	2018-11-01	2018-11-28	2019-11-27	\N	2018-11-28	2019-11-26	\N	2009-07-02	2018-11-06	2018-11-29	2019-11-27	2018-06-24	2018-06-24	2018-11-20	\N	232	1	27	7	\N	0	1	2	2	0	2	0	\N	\N
16	166106	Морозова	Юлия	177	1	{3,2}	1	FEMALE	2811																Михайловна					Отделением УФМС России по Тверской обл. в Кимрском р-не			Тверская обл., Кимры г.	г. КИМРЫ, ул. ОРДЖОНИКИДЗЕ, д. 8/6	{"prev_value":["passport_issuer: \\u041e\\u0423\\u0424\\u041c\\u0421 \\u0420\\u0424 \\u043f\\u043e \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u043e\\u0439 \\u043e\\u0431\\u043b \\u0432 \\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u043e\\u043c \\u0440-\\u043d\\u0435"],"date":["28.09.2018 11:43:08"],"user":["#209 \\u042e\\u043b\\u044f"]}	1964-07-27	2012-03-29	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	177	4	0	0	\N	0	0	0	0	0	0	0	\N	\N
17	C0896316	БУЙ	ТХИ ЛУЕН	232	3	{2,3,4}	1	FEMALE						69	1800001703	14	202407745	010581-MCN/LDTBXH-DN	MULTI	WORK	12	1233332	4616	7307793		BUI	THI LUYEN		Шереметьево 335	миграционным департаментом		ЧАСТНОЕ ПТУ "ЗУИТОАН"	Тхайбинь		{"prev_value":["occupation_id: 1","hired_date: 2019-03-26 00:00:00","departure_date: 0000-00-00 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00","departure_date: 2019-03-24 00:00:00\\nreg_date: 2018-03-23 00:00:00","fired_date: 2019-03-22 00:00:00","occupation_id: 6","migr_card_issued: 2017-09-19 00:00:00","user_ids: 209,214,208\\noccupation_id: 1"],"date":["20.02.2019 16:46:09","12.03.2019 12:44:50","21.03.2019 22:34:59","22.03.2019 11:30:44","22.03.2019 11:32:29","22.03.2019 11:46:50","26.03.2019 10:54:52","26.03.2019 13:18:20","22.05.2019 10:28:32"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-06-20	2015-10-12	2025-10-12	\N	\N	2018-03-14	2018-03-27	2019-03-26	\N	2016-06-06	2019-03-24	\N	2012-07-04	2018-03-15	2018-03-28	2019-03-26	2016-06-04	2016-06-04	2019-03-26	\N	232	1	33	6	\N	0	1	2	2	0	2	0	\N	\N
18	#1	Иванов	Андрей	0	4	{3,2}	1	MALE																	Эдуардович										{"prev_value":["status: BOSS\\ncitizenship_name: \\nwhence_name: ","employer_id: ","current_value: \\npassport_number: \\u041d\\u0435\\u0442\\nmigr_card_issued: 0000-00-00 00:00:00","current_value: \\npassport_number: #3\\nmigr_card_issued: 0000-00-00 00:00:00"],"date":["13.02.2018 13:11:53","13.02.2018 23:08:37","03.04.2018 21:31:13","03.04.2018 21:34:34"],"user":["#207 Super User","#207 Super User","#207 Super User","#207 Super User"]}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2	0	0	\N	0	0	0	0	0	0	0	\N	\N
19	B6526933	НГУЕН	ДИНЬ ТУЕН	232	3	{3,5,2}	1	MALE						69	1800001767	3	202407741	003122319/LDTBXH-DN	MULTI	WORK	12	1233339	4616	8264443		NGUYEN	DINH TUYEN		ШЕРЕМЕТЬЕВО 760	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТОАН"	ХАНАМ	ВЬЕТНАМ	{"prev_value":["migr_card_issued: 2025-05-20 00:00:00"],"date":["04.02.2019 13:53:41"],"user":["#209 \\u042e\\u043b\\u044f"]}	1986-12-11	2012-04-11	2022-04-11	\N	\N	2018-03-14	2018-03-27	2019-03-26	\N	2018-03-27	2019-02-05	\N	2010-09-06	2018-03-15	2018-03-28	2019-03-26	2016-05-25	2016-05-25	2018-03-23	\N	232	1	19	1	\N	0	1	4	4	0	2	0	\N	\N
20	B8042084	НГУЕН	ТХАНЬ ТХАТ	232	3	{3,5,2}	1	MALE							1800001855	5	202407736	000978615/LDTBXH-DN	MULTI	WORK	12	1233331	4616	8264444		NGUYEN 	THANH THAT		ШЕРЕМЕТЬЕВО 760	миграционным департаментом		Намдиньское промышленное текстильно-швейное ПТУ	Тхайбинь		{"prev_value":["migr_card_issued: 0000-00-00 00:00:00"],"date":["03.12.2018 12:14:25"],"user":["#209 \\u042e\\u043b\\u044f"]}	1985-03-02	2013-06-19	2023-06-19	\N	\N	2018-03-20	2018-03-27	2019-03-26	\N	2018-03-27	2018-12-03	\N	2006-08-30	2018-03-15	2018-03-28	2019-03-26	2016-05-25	2016-05-25	2018-03-23	\N	232	1	19	2	\N	0	1	4	4	0	2	0	\N	\N
21	B8347944	НГУЕН	ТХИ ЛАН	232	3	{3,5,2}	1	FEMALE							1700001700	6	202407735	003125543/LDNDXH-DN			12	0971735	4617	8398982		NGUYEN	THI LAN		шереметьево 751	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ТХАНЬХОА		{"prev_value":["employ_permit_id: 1\\nwork_permit_started: 2017-03-28 00:00:00\\nwork_permit_expired: 2018-03-27 00:00:00"],"date":["25.07.2018 13:54:21"],"user":["#209 \\u042e\\u043b\\u044f"]}	1991-09-15	2013-10-04	2023-10-04	\N	\N	2017-03-17	2018-03-27	2019-03-26	\N	2016-05-26	2018-03-15	\N	2011-06-01	2017-03-24	2017-03-29	2018-03-27	2016-05-25	\N	2017-03-24	\N	232	1	19	1	\N	0	1	4	4	0	2	0	\N	\N
36	N1798597	НГУЕН	ТХАНЬ ЛИЕМ	232	3	{3,2,4}	1	MALE						69	1900002411	1	202400380	003124936/LDTBXH-DN	MULTI	WORK	12	1349979	4618	8368689		NGUYEN	THANH LIEM		шереметьево 715	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	БАКЖАНГ		{"prev_value":["reg_date: 2018-07-13 00:00:00","user_ids: 209,214,208\\ncurrent_passport_number: \\nstatus: WORKER","current_passport_number: \\nfired_date: 0000-00-00 00:00:00"],"date":["18.02.2019 12:19:07","09.01.2020 12:36:56","09.01.2020 12:37:11"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-04-24	2016-12-22	2026-12-22	\N	\N	2019-02-04	2019-02-18	2020-02-17	\N	2019-02-18	2020-01-09	\N	2010-06-30	2019-02-13	2019-02-19	2020-02-17	2018-05-11	2018-05-11	2019-02-15	\N	232	4	32	1	\N	0	4	2	2	0	2	0	\N	\N
22	C1273743 	НГУЕН	ТХИ ТХОАН	232	5	{3,2,4}	1	FEMALE						69	2100005260	18	202407749	003125545/LDTBXH-DN	MULTI	WORK	12	1946495	4617	8836224		NGUYEN 	THI THOAN		шереметьево 631	миграционным департаментом		Хайзыонгский профессиональный колледж	ХАЙЗЫОНГ		{"prev_value":["occupation_id: 1","hired_date: 2019-03-26 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2018-03-14 00:00:00\\nwork_permit_started: 2018-03-27 00:00:00\\nwork_permit_expired: 2019-03-26 00:00:00","visa_number: 1233327\\nvisa_issued: 2018-03-15 00:00:00\\nvisa_started: 2018-03-28 00:00:00\\nvisa_expired: 2019-03-26 00:00:00","migr_card_issued: 2019-09-20 00:00:00","visa_issued: 2018-03-18 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 33\\nwork_permit_number: 1900002940\\nwork_permit_issued: 2019-03-11\\nwork_permit_started: 2019-03-26\\nwork_permit_expired: 2020-03-25","visa_serie: 12\\nvisa_number: 1560155\\nvisa_issued: 2019-03-18\\nvisa_started: 2019-03-27\\nvisa_expired: 2020-03-25\\nreg_date: 2018-03-23","employ_permit_id: 48\\nwork_permit_number: 2000003982\\nwork_permit_issued: 2020-03-13\\nwork_permit_started: 2020-03-25\\nwork_permit_expired: 2021-03-24","visa_serie: 13\\nvisa_number: 0061691\\nvisa_issued: 2020-03-16\\nvisa_started: 2020-03-26\\nvisa_expired: 2021-03-24\\nreg_date: 2020-03-24"],"date":["20.02.2019 14:10:38","12.03.2019 12:46:47","25.03.2019 14:40:05","25.03.2019 14:42:56","25.03.2019 15:19:58","26.03.2019 11:34:11","20.03.2020 13:10:57","20.03.2020 13:12:03","18.03.2021 16:10:30","18.03.2021 16:12:14"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-09-05	2016-01-08	2026-01-08	\N	\N	2021-03-15	\N	2022-03-23	\N	2016-06-06	\N	\N	2011-06-01	2021-03-15	2021-03-25	2022-03-23	2017-09-19	2017-09-19	2021-03-23	\N	232	1	56	6	\N	0	1	2	2	0	2	0	\N	\N
23	B7068408	ЛЭ	ЧУНГ ДАМ	232	3	{3,4,2}	1	MALE							1800001735	13	202407739	003067 06/CDNHD	MULTI	WORK	12	1233330	4616	7307792		LE	TRUNG DAM		Шереметьево 335	миграционным департаментом		Хайзыонгский профессиональный колледж	Тхайбинь		{"prev_value":["fired_date: 0000-00-00 00:00:00"],"date":["28.01.2019 13:15:08"],"user":["#209 \\u042e\\u043b\\u044f"]}	1979-07-21	2012-08-27	2022-08-27	\N	\N	2018-03-14	2018-03-27	2019-03-26	\N	2018-03-27	2019-01-29	\N	2006-07-02	2018-03-15	2018-03-28	2019-03-26	2016-06-04	2004-06-20	2018-03-23	\N	232	1	19	6	\N	0	1	2	2	0	2	0	\N	\N
24	B9676332	ФАН 	ВАН ХОАНГ	232	3	{3,2,4}	1	MALE						69	1900002965	19	202407747	008145 14/CDKTHY	MULTI	WORK	12	1560153	4618	8165275		PHAN	VAN HOANG		шереметьево 732	миграционным департаментом		Хынгиенский промышленный колледж	БАКНИНЬ		{"prev_value":["passport_number: \\u04129676332\\nemploy_permit_id: 19\\nwork_permit_number: 1800001816\\nhired_date: 2018-03-27 00:00:00","hired_date: 2019-03-26 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2018-03-14 00:00:00\\nwork_permit_started: 2018-03-27 00:00:00\\nwork_permit_expired: 2019-03-26 00:00:00","visa_number: 1233335\\nvisa_issued: 2018-03-15 00:00:00\\nvisa_started: 2018-03-28 00:00:00\\nvisa_expired: 2019-03-26 00:00:00\\nreg_date: 2018-03-25 00:00:00","user_ids: 209,214,208\\nstatus: WORKER\\nfired_date: 0000-00-00","reg_date: 2018-04-20"],"date":["20.02.2019 14:17:35","12.03.2019 12:47:49","25.03.2019 15:09:09","25.03.2019 15:11:16","23.03.2020 13:29:29","23.03.2020 13:30:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1995-05-09	2014-10-24	2024-10-24	\N	\N	2019-03-11	2019-03-26	2020-03-25	\N	2016-06-06	2020-03-24	\N	2014-07-03	2019-03-18	2019-03-27	2020-03-25	2018-04-17	2018-04-17	2019-03-26	\N	232	1	33	6	\N	0	1	2	2	0	2	0	\N	\N
25	C0952854	ДАМ	ТХИ ТХАМ	232	3	{3,2,4}	1	FEMALE						69	2100005253	11	202407737	010319-MCN/LDTBXH-DN	MULTI	WORK	12	1946496	4616	7307788		DAM	THI THAM		Шереметьево 335	миграционным департаментом		ЧАСТНОЕ ПТУ "ЗУИТОАН"	Тхайбинь		{"prev_value":["passport_number: \\u04210952854\\nemploy_permit_id: 19\\nwork_permit_number: 1800001710\\nhired_date: 2018-03-27 00:00:00","hired_date: 2019-03-26 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2018-03-14 00:00:00\\nwork_permit_started: 2018-03-27 00:00:00\\nwork_permit_expired: 2019-03-26 00:00:00","visa_number: 1233333\\nvisa_issued: 2018-03-15 00:00:00\\nvisa_started: 2018-03-28 00:00:00\\nvisa_expired: 2019-03-26 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 33\\nwork_permit_number: 1900002919\\nwork_permit_issued: 2019-03-11\\nwork_permit_started: 2019-03-26\\nwork_permit_expired: 2020-03-25","visa_serie: 12\\nvisa_number: 1560158\\nvisa_issued: 2019-03-18\\nvisa_started: 2019-03-27\\nvisa_expired: 2020-03-25\\nreg_date: 2018-03-23","employ_permit_id: 48\\nwork_permit_number: 2000004009\\nwork_permit_issued: 2020-03-13\\nwork_permit_started: 2020-03-25\\nwork_permit_expired: 2021-03-24","visa_serie: 13\\nvisa_number: 0061690\\nvisa_issued: 2020-03-16\\nvisa_started: 2020-03-26\\nvisa_expired: 2021-03-24\\nreg_date: 2020-03-24","status: WORKER\\nfired_date: 0000-00-00"],"date":["20.02.2019 14:01:53","12.03.2019 12:45:30","25.03.2019 14:03:57","25.03.2019 14:06:15","20.03.2020 12:51:32","20.03.2020 12:52:53","18.03.2021 16:05:24","18.03.2021 16:07:45","12.04.2021 13:10:06"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-11-04	2015-09-24	2025-09-24	\N	\N	2021-03-15	\N	2022-03-23	\N	2016-06-06	2021-04-12	\N	2013-07-04	2021-03-15	2021-03-25	2022-03-23	2016-06-04	2016-06-04	2021-03-23	\N	232	1	56	1	\N	0	1	2	2	0	2	0	\N	\N
26	C0983811	ФАМ	КУОК ХУИ	232	3	{3,2,4}	1	MALE						69	2100005278	9	202407733	004431	MULTI	WORK	12	1946497	4619	7396812		PHAM	QUOC HUY		Шереметьево 335	миграционным департаментом		Намдинский технический техникум	Тхайбинь		{"prev_value":["passport_number: \\u04210983811\\nemploy_permit_id: 19\\nwork_permit_number: 1800001809\\nhired_date: 2018-03-27 00:00:00\\nmigr_card_issued: 2020-06-20 04:00:00","hired_date: 2019-03-26 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2018-03-14 00:00:00\\nwork_permit_started: 2018-03-27 00:00:00\\nwork_permit_expired: 2019-03-26 00:00:00","visa_number: 1233328\\nvisa_issued: 2018-03-15 00:00:00\\nvisa_started: 2018-03-28 00:00:00\\nvisa_expired: 2019-03-26 00:00:00","visa_number: 1560153","user_ids: 209,214,208\\nstatus: WORKER\\ndeparture_date: 0000-00-00 00:00:00","status: FURLOUGH\\ndeparture_date: 2019-06-03 00:00:00\\nmigr_card_serie: 4616\\nmigr_card_number: 7307791\\nmigr_card_issued: 2020-06-20 00:00:00\\nreg_date: 2018-03-23 00:00:00","entry_date: 2016-06-04 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","departure_date: 0000-00-00 00:00:00","status: FURLOUGH","departure_date: 2019-09-12 00:00:00\\nmigr_card_number: 6925080\\nmigr_card_issued: 2019-06-19 00:00:00","employ_permit_id: 33\\nwork_permit_number: 1900002958\\nwork_permit_issued: 2019-03-11\\nwork_permit_started: 2019-03-26\\nwork_permit_expired: 2020-03-25","visa_serie: 12\\nvisa_number: 1560154\\nvisa_issued: 2019-03-18\\nvisa_started: 2019-03-27\\nvisa_expired: 2020-03-25\\nreg_date: 0000-00-00","entry_date: 2019-06-19","employ_permit_id: 48\\nwork_permit_number: 2000003975\\nwork_permit_issued: 2020-03-13\\nwork_permit_started: 2020-03-25\\nwork_permit_expired: 2021-03-24\\nwork_permit_paid_till: 0000-00-00","visa_serie: 13\\nvisa_number: 0061693\\nvisa_issued: 2020-03-16\\nvisa_started: 2020-03-26\\nvisa_expired: 2021-03-24\\nreg_date: 2020-03-24","work_permit_paid_till: 2022-03-23","status: WORKER\\nfired_date: 0000-00-00"],"date":["20.02.2019 14:14:46","12.03.2019 12:47:25","25.03.2019 15:01:33","25.03.2019 15:02:30","25.03.2019 15:03:18","03.06.2019 12:06:40","24.06.2019 09:27:53","24.06.2019 11:30:52","12.09.2019 16:08:21","12.09.2019 16:08:46","17.09.2019 11:29:17","17.09.2019 14:13:29","20.03.2020 13:18:20","20.03.2020 13:19:29","23.03.2020 12:51:30","18.03.2021 16:15:20","18.03.2021 16:16:40","18.03.2021 16:30:30","12.04.2021 13:16:31"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-01-18	2015-10-07	2025-10-07	\N	\N	2021-03-15	2021-03-24	2022-03-23	\N	2016-06-06	2021-04-12	\N	2015-07-02	2021-03-15	2021-03-25	2022-03-23	2019-09-16	2019-09-16	2021-03-23	\N	232	1	56	6	\N	0	1	2	2	0	2	0	\N	\N
27	N1464340	НГО	ДИНЬ ДЫК	232	3	{3,2,4}	1	MALE						69	1900002926	2	202407742	003120430/LDNDXH-DN	MULTI	WORK	12	1560156	4616	7307790		NGO	DINH DUC		Шереметьево 335	ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ		Ханойское ПТУ швейной технологии и моды	БАКЖАНГ		{"prev_value":["passport_issuer: \\u041f\\u043e\\u0441\\u043e\\u043b\\u044c\\u0441\\u0442\\u0432\\u043e\\u043c \\u0412\\u044c\\u0435\\u0442\\u043d\\u0430\\u043c\\u0430 \\u0432 \\u0420\\u0424","hired_date: 2019-03-26 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2018-03-14 00:00:00\\nwork_permit_started: 2018-03-27 00:00:00\\nwork_permit_expired: 2019-03-26 00:00:00","visa_number: 1233337\\nvisa_issued: 2018-03-15 00:00:00\\nvisa_started: 2018-03-28 00:00:00\\nvisa_expired: 2019-03-26 00:00:00","migr_card_issued: 2004-06-16 00:00:00","user_ids: 209,214,208\\nfired_date: 0000-00-00","status: WORKER","work_address: ","reg_date: 2018-03-23"],"date":["20.02.2019 16:21:11","12.03.2019 12:46:11","25.03.2019 14:13:07","25.03.2019 14:14:40","25.03.2019 15:17:08","23.03.2020 13:16:34","23.03.2020 13:16:46","23.03.2020 13:16:57","23.03.2020 13:17:17"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1987-12-18	2012-06-06	2022-06-06	\N	\N	2019-03-11	2019-03-26	2020-03-25	\N	2016-06-06	2020-03-24	\N	2006-09-10	2019-03-18	2019-03-27	2020-03-25	2016-06-04	2016-06-04	2019-03-26	\N	232	1	33	1	\N	0	1	2	2	0	2	0	\N	\N
45	B8469009	ДО	ХЫУ ТАНГ	232	3	{3,5,2}	1	MALE							1700003432	30	202408761	00084375			12	0972420	4616	8757135		DO	HUU TANG		Шереметьево 800	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	ХЫНГИЕН		{"prev_value":["reg_date: 2017-10-14 00:00:00"],"date":["29.06.2018 11:43:20"],"user":["#209 \\u042e\\u043b\\u044f"]}	1984-07-18	2013-11-04	2023-11-04	\N	\N	2017-08-07	2017-08-16	2018-08-15	\N	2017-08-16	2018-06-30	\N	2009-07-02	2017-08-10	2017-08-16	2018-08-15	2016-10-01	2011-08-20	2017-08-15	\N	232	1	5	10	\N	0	1	4	4	0	2	0	\N	\N
28	C1088103	НГУЕН	ВАН ВЫОНГ	232	5	{3,2,4}	1	MALE						69	2000005027	89	202402391		MULTI	WORK	12	1771289	4619	9807272		NGUYEN	VAN VUONG		шереметьево 621	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАКНИНЬ		{"prev_value":["departure_date: 2019-03-26 00:00:00","passport_issued: 0000-00-00 00:00:00\\npassport_expired: 0000-00-00 00:00:00","work_permit_serie: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00\\nfired_date: 0000-00-00 00:00:00","departure_date: 2019-02-23 00:00:00\\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","birth_date: 0000-00-00 00:00:00","status: WORKER","user_ids: 209,214,208\\ncurrent_passport_number: \\npassport_number: C1088103","user_ids: 209,208,214\\npassport_number: C1088105\\npassport_issuer: \\u043c\\u0438\\u0433\\u0440\\u0430\\u0446\\u0438\\u043e\\u043d\\u043d\\u044b\\u043c \\u0434\\u0435\\u043f\\u0430\\u0440\\u0442\\u0430\\u043c\\u0435\\u043d\\u0442\\u043e\\u043c","user_ids: 208,209,214\\ncurrent_passport_number: \\nstatus: FIRED","current_passport_number: \\nemploy_permit_id: 19\\nwork_permit_serie: 69\\nwork_permit_number: 1800001750\\nwork_permit_issued: 2018-03-14 00:00:00\\nwork_permit_started: 2018-03-27 00:00:00\\nwork_permit_expired: 2019-03-26 00:00:00\\noccupation_id: 6\\ncontract_number: 17\\nhired_date: 2019-03-27 00:00:00\\nfired_date: 2019-02-28 00:00:00\\ncert_number: 007626 05\\/CDKTHY\\ncert_issuer: \\u0425\\u044b\\u043d\\u0433\\u0438\\u0435\\u043d\\u0441\\u043a\\u0438\\u0439 \\u043f\\u0440\\u043e\\u043c\\u044b\\u0448\\u043b\\u0435\\u043d\\u043d\\u044b\\u0439 \\u043a\\u043e\\u043b\\u043b\\u0435\\u0434\\u0436","current_passport_number: \\ninvitation_number: 202407748\\nvisa_issuer: \\u0420\\u0424, \\u0433.\\u0422\\u0432\\u0435\\u0440\\u044c\\nvisa_serie: 12\\nvisa_number: 1233338\\nvisa_issued: 2018-03-15 00:00:00\\nvisa_started: 2018-03-28 00:00:00\\nvisa_expired: 2019-03-26 00:00:00\\nentry_date: 2019-02-28 00:00:00\\nentry_checkpoint: \\u0448\\u0435\\u0440\\u0435\\u043c\\u0435\\u0442\\u044c\\u0435\\u0432\\u043e 663\\nmigr_card_serie: 4616\\nmigr_card_number: 8338054\\nmigr_card_issued: 2016-06-08 00:00:00\\nreg_date: 2018-03-23 00:00:00","current_passport_number: \\nvisa_multiplicity: MULTI","current_passport_number: \\ninvitation_number: \\nvisa_issuer: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","current_passport_number: ","current_passport_number: \\nstatus: SEEKER\\nwork_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_address: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","current_passport_number: ","fired_date: 2019-02-28","visa_serie: 24\\nvisa_number: 2685476\\nvisa_issued: 2020-02-03","visa_started: 2020-02-03\\nvisa_expired: 2020-04-23","visa_started: 2020-04-03","employ_permit_id: 43\\nwork_permit_number: 2000003870\\nhired_date: 2020-02-21","employ_permit_id: \\nwork_permit_issued: 2020-02-14\\nwork_permit_started: 2020-02-14\\nwork_permit_expired: 2020-11-21","visa_multiplicity: SINGLE\\nvisa_serie: 13\\nvisa_number: 0061818\\nvisa_issued: 2020-04-03\\nvisa_started: 2020-04-24\\nvisa_expired: 2020-11-21","reg_date: 2020-02-07","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nreg_date: 0000-00-00"],"date":["28.02.2019 15:40:26","01.03.2019 12:45:14","01.03.2019 12:46:45","01.03.2019 12:51:48","01.03.2019 12:52:54","01.03.2019 12:57:47","16.12.2019 13:56:30","17.12.2019 12:44:26","17.12.2019 13:11:20","17.12.2019 13:12:25","17.12.2019 13:13:31","17.12.2019 13:14:16","07.02.2020 12:34:50","07.02.2020 12:37:49","20.02.2020 18:02:32","20.02.2020 18:04:06","11.03.2020 11:11:38","09.04.2020 13:03:56","09.04.2020 13:08:45","09.04.2020 13:11:52","16.11.2020 16:53:46","16.11.2020 17:00:10","16.11.2020 17:06:34","16.11.2020 17:34:06","19.11.2020 12:44:33"],"user":["#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-05-02	2015-11-26	2025-11-26	\N	\N	2020-10-28	2020-11-21	2021-11-20	\N	2020-11-21	\N	\N	\N	2020-11-09	2020-11-22	2021-11-20	2020-02-06	2020-02-06	2020-11-18	\N	232	1	51	1	\N	0	1	2	2	0	2	0	\N	\N
29	C1088104	ДО	ТХИ МИНЬ	232	3	{3,4,2}	1	FEMALE						69	1800001728	16	202407746	003125495/LDNDXH-DN	MULTI	WORK	12	1233336	4616	8351922		DO	THI MINH		Шереметьево 836	миграционным департаментом		Ханойское ПТУ швейной технологии и моды	БАКНИНЬ		{"prev_value":["work_permit_serie: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00\\nfired_date: 0000-00-00 00:00:00","visa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00","birth_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","departure_date: 2019-02-23 00:00:00"],"date":["01.03.2019 12:26:49","01.03.2019 12:28:44","01.03.2019 12:34:54","01.03.2019 12:36:19","12.03.2019 14:14:14"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-06-20	2015-11-26	2025-11-26	\N	\N	2018-03-14	2018-03-27	2019-03-26	\N	2018-03-27	2019-02-28	\N	\N	2018-03-15	2018-03-28	2019-03-26	2016-06-08	2016-06-08	2018-03-23	\N	232	1	19	1	\N	0	1	2	2	0	2	0	\N	\N
30	B6208210	ХОАНГ	ТХИ ХАНЬ	232	6	{3,2,5}	1	FEMALE									202408127				12	1233334	4616	8431873		HOANG	THI HANH		шереметьево 626	миграционным департаментом			Тхайбинь		{"prev_value":["fired_date: 0000-00-00 00:00:00","user_ids: 209,215,208"],"date":["04.02.2019 10:40:33","13.03.2020 11:46:03"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-12-20	2012-02-10	2022-02-10	\N	\N	\N	\N	\N	\N	\N	2019-02-05	\N	\N	2018-03-15	2018-03-28	2019-03-26	2016-07-20	2020-07-20	2018-03-23	\N	232	1	19	0	\N	0	1	4	4	0	0	0	\N	\N
31	N1901375	НИНЬ	ТХИ ЛУАН	232	3	{3,5,2}	1	FEMALE							1800002739	26	202408135	003121203/LDNDXH-DN	MULTI	WORK	12	1233626	4617	8966004		NINH	THI LUAN		Шереметьево 564	ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ		Ханойское ПТУ швейной технологии и моды	ХАЙЗЫОНГ		{"prev_value":["departure_date: 2019-01-15 00:00:00\\nreg_date: 2018-03-23 00:00:00"],"date":["28.02.2019 11:49:05"],"user":["#209 \\u042e\\u043b\\u044f"]}	1969-05-25	2018-02-05	2028-02-05	\N	\N	2018-05-10	2018-05-18	2019-05-17	\N	2018-05-18	2019-02-28	\N	2007-09-04	2018-05-15	2018-05-19	2019-05-17	2017-10-22	2017-10-22	2018-05-18	\N	232	1	23	1	\N	0	1	4	4	0	2	0	\N	\N
32	B5629081	НГУЕН	ХЫУ ТХАНГ	232	3	{3,5,2}	1	MALE							1800002721	25	202408134	003125234/LDNDXH-DN	MULTI	WORK	12	1233625	4618	7883754		NGUYEN	HUU THANG		шереметьево 715	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ХАНОЙ		{"prev_value":["departure_date: 2019-01-15 00:00:00\\nreg_date: 2018-04-04 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["28.02.2019 11:45:35","23.03.2019 17:49:49"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	1968-04-04	2011-08-05	2021-08-05	\N	\N	2018-05-10	2018-05-18	2019-05-17	\N	2018-05-18	2019-02-28	\N	2010-06-02	2018-05-15	2018-05-19	2019-05-17	2018-04-02	2018-04-02	2018-05-18	\N	232	1	23	1	\N	0	1	4	4	0	2	0	\N	\N
33	B4610274	ДАНГ	ВАН КЕ	232	3	{3,5,2}	1	MALE							1700002622	29	202408131	015945356			12	0972032	4616	8385697		DANG	VAN KE		Шереметьево 675	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Намдиньское промышленное текстильно-швейное ПТУ	ХАНОЙ		{"prev_value":["status: WORKER\\npassport_number: \\u04124610274\\nfired_date: 0000-00-00 00:00:00\\nmigr_card_issued: 2020-07-20 16:00:00","status: FURLOUGH"],"date":["11.05.2018 12:08:53","17.05.2018 18:45:12"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	1989-12-23	2010-11-05	2020-11-05	\N	\N	2017-05-12	2017-05-19	2018-05-18	\N	2017-05-19	2018-05-10	\N	2009-07-07	2017-05-15	2017-05-20	2018-05-18	2016-07-20	2020-07-20	2017-05-18	\N	232	1	2	1	\N	0	1	4	4	0	2	0	\N	\N
34	B7676506	НГУЕН	ТХИ БИНЬ	232	3	{2,3,4}	1	FEMALE						69	1800002707	22	202408126	003125548/LDTBXH-DN	MULTI	WORK	12	1233624	4616	8510538		NGUYEN	THI BINH		Шереметьево 678	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ХЫНГИЕН		{"prev_value":["passport_number: \\u04127676506\\nwork_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nvisa_number: 0972038\\nvisa_issued: 2017-05-15 00:00:00\\nvisa_started: 2017-05-20 00:00:00\\nvisa_expired: 2018-05-18 00:00:00","user_ids: 209,214,208\\ndeparture_date: 0000-00-00 00:00:00","departure_date: 2019-05-15 00:00:00\\nreg_date: 2018-03-23 00:00:00","status: WORKER","work_permit_serie: \\nfired_date: 0000-00-00 00:00:00"],"date":["17.05.2018 12:54:54","06.05.2019 18:42:28","07.05.2019 12:40:33","07.05.2019 14:04:18","07.05.2019 14:04:44"],"user":["#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-01-01	2013-03-25	2023-03-25	\N	\N	2018-05-10	2018-05-18	2019-05-17	\N	2018-05-18	2019-05-06	\N	2011-06-01	2018-05-15	2018-05-19	2019-05-17	2016-08-03	2016-08-03	2018-05-18	\N	232	1	23	1	\N	0	1	2	2	0	2	0	\N	\N
46	B3997686	НГУЕН	ТХИ ХУЕН ЧАНГ	232	3	{3,4,2}	1	FEMALE							1700003440	31	202408760	00084381 09/DHCNHN			12	0972421	4616	8715435		NGUYEN	THI HUYEN TRANG		шереметьево 742	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	БАКЗАНГ		{"prev_value":["status: WORKER\\npassport_number: \\u04123997686\\nfired_date: 0000-00-00 00:00:00\\nmigr_card_issued: 2001-10-20 16:00:00"],"date":["18.07.2018 11:26:14"],"user":["#209 \\u042e\\u043b\\u044f"]}	1984-06-11	2010-04-14	2020-04-14	\N	\N	2017-08-07	2017-08-16	2018-08-15	\N	2016-10-01	2018-07-17	\N	2009-07-02	2017-08-10	2017-08-16	2018-08-15	2016-10-01	2016-10-01	2017-08-15	\N	232	1	5	11	\N	0	1	2	2	0	2	0	\N	\N
37	C0987699	ДАНГ	ВАН ХУНГ	232	3	{3,2,4}	1	MALE						69	1900002429	4	202401052		MULTI	WORK	12	1349982	4618	9661324		DANG	VAN HUNG		Шереметьево 870	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХАНОЙ		{"prev_value":["reg_date: 2018-08-15 00:00:00","user_ids: 209,214,208\\nstatus: WORKER","current_passport_number: \\nstatus: FURLOUGH","current_passport_number: \\nfired_date: 0000-00-00 00:00:00"],"date":["18.02.2019 12:09:16","20.11.2019 16:12:24","09.01.2020 12:23:59","09.01.2020 12:24:21"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1993-01-10	2015-10-02	2025-10-02	\N	\N	2019-02-04	2019-02-18	2020-02-17	\N	2019-02-18	2020-01-09	\N	\N	2019-02-13	2019-02-19	2020-02-17	2018-08-10	2018-08-10	2019-02-15	\N	232	4	32	1	\N	0	4	2	2	0	2	0	\N	\N
38	B4596711	НГУЕН	ТХИ ХОНГ	232	3	{3,5,2}	1	FEMALE							1800002714	21	202408128		MULTI	WORK	12	1233629	4616	8431883		NGUYEN	THI HONG		шереметьево 627	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский профессиональный колледж	Тхайбинь		{"prev_value":["fired_date: 2019-01-05 00:00:00"],"date":["09.01.2019 11:47:48"],"user":["#209 \\u042e\\u043b\\u044f"]}	1989-08-11	2010-10-14	2020-10-14	\N	\N	2018-05-10	2018-05-18	2019-01-10	\N	2018-05-18	2019-01-09	\N	\N	2018-05-15	2018-05-19	2019-01-10	2016-07-20	2016-07-20	2017-11-17	\N	232	1	18	6	\N	0	1	4	4	0	2	0	\N	\N
39	B7816894	ФАМ	ВАН ЫОК	232	3	{3,4,2}	1	MALE						69	1800002746	28	202408130	003125553/LDTBXH-DN	MULTI	WORK	12	1233628	4616	8510537		PHAM 	VAN UOC		Шереметьево 678	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ХАЙЗЫОНГ		{"prev_value":["departure_date: 0000-00-00 00:00:00","status: FURLOUGH","work_permit_serie: \\nfired_date: 0000-00-00 00:00:00"],"date":["28.01.2019 11:08:53","12.03.2019 12:30:33","12.03.2019 12:30:52"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1994-05-07	2013-04-09	2023-04-09	\N	\N	2018-05-10	2018-05-18	2019-05-17	\N	2018-05-18	2019-03-12	\N	2011-06-01	2018-05-15	2018-05-19	2019-05-17	2016-08-03	2016-08-03	2018-03-23	2019-01-29	232	1	23	1	\N	0	1	2	2	0	2	0	\N	\N
40	B7677386	ФАМ	ТХИ ХАУ	232	3	{2,3,4}	1	FEMALE							1800002753	23	202408129	003125547/LDTBXH-DN	MULTI	WORK	12	1233627	4616	8510536		PHAM	THI HAU		Шереметьево 678	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ХЫНГИЕН		{"prev_value":["passport_number: \\u04127677386\\nwork_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nvisa_number: 0972034\\nvisa_issued: 2017-05-15 00:00:00\\nvisa_started: 2017-05-20 00:00:00\\nvisa_expired: 2018-05-18 00:00:00","user_ids: 209,214,208\\ndeparture_date: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["17.05.2018 13:18:43","26.04.2019 09:55:33","29.04.2019 11:48:56","29.04.2019 11:49:16"],"user":["#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1991-01-20	2013-03-20	2023-03-20	\N	\N	2018-05-10	2018-05-18	2019-05-17	\N	2018-05-18	2019-04-30	\N	2011-06-01	2018-05-15	2018-05-19	2019-05-17	2016-08-03	2016-08-03	2018-03-23	2019-04-26	232	1	23	1	\N	0	1	2	2	0	2	0	\N	\N
41	C2403752	НГУЕН	ТХИ ТХУ ХАНГ	232	3	{3,2,4}	1	FEMALE						69	1900003655	76	202401878	003124911/LDNDXH-DN	MULTI	WORK	12	1560696	4617	9015358		NGUYEN	THI THU HANG		Шереметьево 695	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ТУЕНКУАНГ		{"prev_value":["work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nvisa_number: 1017905\\nvisa_issued: 2017-12-07 00:00:00\\nvisa_started: 2017-12-07 00:00:00\\nvisa_expired: 2018-06-24 00:00:00\\nreg_date: 2017-12-20 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 24\\nwork_permit_serie: \\nwork_permit_number: 1800002961\\nwork_permit_issued: 2018-06-04 00:00:00\\nwork_permit_started: 2018-06-24 00:00:00\\nwork_permit_expired: 2019-06-23 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nhired_date: 2018-06-24 00:00:00","visa_number: 1348078\\nvisa_issued: 2018-06-13 00:00:00\\nvisa_started: 2018-06-25 00:00:00\\nvisa_expired: 2019-06-23 00:00:00","user_ids: 208,209,214\\ncurrent_passport_number: \\nstatus: WORKER","current_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nreg_date: 2018-06-19 00:00:00"],"date":["19.06.2018 11:35:10","20.05.2019 11:55:54","21.06.2019 10:41:54","21.06.2019 10:44:39","09.01.2020 12:52:47","09.01.2020 12:53:03","09.01.2020 12:53:45"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1974-09-20	2016-11-29	2026-11-29	\N	\N	2019-06-10	2019-06-23	2020-03-25	\N	2019-06-23	2020-01-09	\N	2010-06-30	2019-06-11	2019-06-24	2020-03-25	2017-11-07	2017-11-07	2019-06-21	\N	232	1	33	1	\N	0	1	2	2	0	2	0	\N	\N
42	B9577191	ЛЕ	ТХАНЬ ТУ	232	3	{3,4,2}	1	MALE							1700003986	71	202401595	00088841			12	1017866	4617	8887049		LE	THANH TU		Шереметьево 564	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	ТХАНЬХОА		{"prev_value":["passport_issued: 2017-12-07 00:00:00\\npassport_expired: 2027-12-07 00:00:00"],"date":["25.06.2018 13:16:11"],"user":["#209 \\u042e\\u043b\\u044f"]}	1990-02-08	2014-09-11	2024-09-11	\N	\N	2017-08-23	2017-08-23	2018-06-24	\N	2017-10-03	2018-06-24	\N	2015-07-02	2017-12-07	2017-12-07	2018-06-24	2017-09-29	2017-09-29	2017-12-08	\N	232	1	4	9	\N	0	1	2	2	0	2	0	\N	\N
43	N1902027	НГУЕН	БАО ШОН	232	3	{3,5,2}	1	MALE							1800002979	73	202401662	011472-MCN/LDTBXH-DN			12	1348080	4617	8955152		NGUYEN	BAO SON		шереметьево 785	ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ		ЧАСТНОЕ ПТУ "ЗУИТАН"	НГЕАН		{"prev_value":["fired_date: 2018-06-04 00:00:00"],"date":["27.02.2019 11:57:27"],"user":["#209 \\u042e\\u043b\\u044f"]}	1998-10-26	2018-03-27	2028-03-27	\N	\N	2018-06-04	2018-06-24	2019-06-23	\N	2018-06-24	2018-07-04	\N	2016-07-04	2018-06-13	2018-06-25	2019-06-23	2017-10-17	2017-10-17	2018-06-19	\N	232	1	24	1	\N	0	1	4	4	0	2	0	\N	\N
44	C2871092	НГУЕН	АНЬ ТУАН	232	3	{3,2,5}	1	MALE						69	1900003662	74	202401663		MULTI	WORK	12	1560697	4618	7966490		NGUYEN	ANH TUAN		Шереметьево 825	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ТХАНЬХОА		{"prev_value":["work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nvisa_number: 1017845\\nvisa_issued: 2017-12-07 00:00:00\\nvisa_started: 2017-12-07 00:00:00\\nvisa_expired: 2018-06-24 00:00:00","user_ids: 209,215,208\\nemploy_permit_id: 24\\nwork_permit_serie: \\noccupation_id: 1","cert_number: 011477-MCN\\/LDTBXH-DN\\ncert_issuer: \\u0427\\u0410\\u0421\\u0422\\u041d\\u041e\\u0415 \\u041f\\u0422\\u0423 \\"\\u0417\\u0423\\u0418\\u0422\\u0410\\u041d\\"\\ncert_issued: 2016-07-04 00:00:00","reg_date: 2018-04-04 00:00:00","work_permit_number: 1800002954\\nwork_permit_issued: 2018-06-04 00:00:00\\nwork_permit_started: 2018-06-24 00:00:00\\nwork_permit_expired: 2019-06-23 00:00:00","visa_serie: 12\\nvisa_number: 1348079\\nvisa_issued: 2018-06-13 00:00:00\\nvisa_started: 2018-06-25 00:00:00\\nvisa_expired: 2019-06-23 00:00:00","occupation_id: 6","visa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nhired_date: 2018-06-24 00:00:00","visa_number: 1348079\\nvisa_issued: 2018-06-13 00:00:00\\nvisa_started: 2018-06-25 00:00:00\\nvisa_expired: 2019-06-23 00:00:00","user_ids: 208,209,215\\nstatus: WORKER\\nfired_date: 0000-00-00 00:00:00","reg_date: 2018-06-19 00:00:00"],"date":["19.06.2018 11:13:50","20.05.2019 11:28:42","20.05.2019 11:29:06","20.05.2019 11:29:56","20.05.2019 11:54:35","20.05.2019 11:54:56","22.05.2019 10:36:19","22.05.2019 11:51:15","21.06.2019 10:31:14","21.06.2019 10:33:32","27.11.2019 13:41:23","28.11.2019 16:48:10"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1998-10-23	2017-02-24	2027-02-24	\N	\N	2019-06-10	2019-06-23	2020-03-25	\N	2019-06-23	2019-11-27	\N	\N	2019-06-11	2019-06-24	2020-03-25	2018-04-02	2018-04-02	2019-06-21	\N	232	1	33	1	\N	0	1	4	4	0	2	0	\N	\N
47	B6691088	ЛЫОНГ	ВАН ХАЙ	232	3	{2,3,4}	1	MALE						69	1800004084	49	202409040	0084392 09/DHCNHN	MULTI	WORK	12	1348731	4616	7848852		LUONG	VAN HAI		ДОМОДЕВО 464	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	ХЫНГИЕН		{"prev_value":["work_permit_number: 1700004718\\nwork_permit_issued: 2017-09-22 00:00:00\\nwork_permit_started: 2017-10-07 00:00:00\\nmigr_card_issued: 2010-11-20 00:00:00","user_ids: 209,214,208\\ndeparture_date: 0000-00-00 00:00:00","status: WORKER","departure_date: 2019-04-26 00:00:00\\nfired_date: 0000-00-00 00:00:00"],"date":["05.10.2018 10:52:05","26.04.2019 09:56:04","29.04.2019 11:40:08","29.04.2019 11:40:38"],"user":["#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-09-02	2012-05-10	2022-05-10	\N	\N	2018-09-24	2018-10-06	2019-07-11	\N	2018-10-06	2019-04-30	\N	2009-07-02	2018-10-01	2018-10-07	2019-07-11	2016-11-10	2016-11-10	2017-10-06	\N	232	1	26	13	\N	0	1	2	2	0	2	0	\N	\N
48	B8744969	ФАМ	ТХИ ЛИНЬ	232	3	{3,4,2}	1	FEMALE							1700004740	50	202409039	010312			12	0972964	4616	7848853		PHAM	THI LINH		Шереметьево 464	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	ХЫНГИЕН		{"prev_value":["migr_card_issued: 2010-11-20 00:00:00"],"date":["18.05.2018 15:01:17"],"user":["#209 \\u042e\\u043b\\u044f"]}	1995-09-22	2014-01-10	2024-01-10	\N	\N	2017-09-22	2017-10-07	2018-10-06	\N	2017-10-07	2018-05-17	\N	2013-07-04	2017-10-04	2017-10-08	2018-10-06	2016-11-10	2016-11-10	2017-10-06	\N	232	1	6	6	\N	0	1	2	2	0	2	0	\N	\N
49	B5659335	ЛЕ	ТХИ НАМ	232	3	{3,4,2}	1	FEMALE							1700004820	43	202409101	004102 10/CDNHD			12	1017177	4617	8836223		LE	THI NAM		шереметьево 631	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	КУАНГНИНЬ		{"prev_value":["reg_date: 2017-09-20 00:00:00"],"date":["29.06.2018 11:48:40"],"user":["#209 \\u042e\\u043b\\u044f"]}	1992-06-15	2011-08-25	2021-08-25	\N	\N	2017-10-02	2017-10-19	2018-10-18	\N	2017-10-19	2018-06-30	\N	2010-07-02	2017-10-16	2017-10-20	2018-10-18	2017-09-19	2017-09-19	2017-10-18	\N	232	1	7	6	\N	0	1	2	2	0	2	0	\N	\N
50	C0890341	ЛЕ	ВАН ТХАНГ	232	3	{3,2,4}	1	MALE						69	1900003790	45	202409098		MULTI	WORK	12	1560796	4618	9331686		LE	VAN THANG		Шереметьево 396	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХЫНГИЕН		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2017-10-02 00:00:00\\nwork_permit_started: 2017-10-19 00:00:00\\nwork_permit_expired: 2018-10-18 00:00:00\\nvisa_number: 1017173\\nvisa_issued: 2017-10-16 00:00:00\\nvisa_started: 2017-10-20 00:00:00\\nvisa_expired: 2018-10-18 00:00:00\\nreg_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 26\\nwork_permit_number: 1800004077\\nwork_permit_issued: 2018-09-24 00:00:00\\nwork_permit_started: 2018-10-18 00:00:00\\nwork_permit_expired: 2019-07-11 00:00:00","visa_number: 1348737\\nvisa_issued: 2018-10-01 00:00:00\\nvisa_started: 2018-10-19 00:00:00\\nvisa_expired: 2019-07-11 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nhired_date: 2018-10-18 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2017-10-18 00:00:00","entry_date: 2016-11-10 00:00:00\\nmigr_card_serie: 4616\\nmigr_card_number: 7857485\\nmigr_card_issued: 2016-11-10 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2018-10-05 00:00:00"],"date":["05.10.2018 11:45:34","24.06.2019 10:54:16","24.06.2019 10:54:55","10.07.2019 12:37:56","10.07.2019 12:39:40","10.07.2019 14:26:44","06.12.2019 13:13:24","06.12.2019 13:13:48","06.12.2019 13:14:18"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1994-08-23	2015-10-15	2025-10-15	\N	\N	2019-06-28	2019-07-11	2020-07-10	\N	2019-07-11	2019-12-06	\N	\N	2019-07-04	2019-07-12	2020-07-10	2018-07-10	2018-07-10	2019-07-10	\N	232	1	35	11	\N	0	1	2	2	0	2	0	\N	\N
51	123456	Иванов	Иван	177	1	{2}	1	MALE	4811																Иванович					ОУФМС РФ по району Медведково			г. Урюпинск	1234321, г. Москва, ул. Хохлова, д. 1, кв. 2	{"prev_value":["birth_place: \\ngender: \\naddress: \\ncitizenship: \\nwhence: \\npassport_issuer: \\npassport_issued: 0000-00-00 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: \\ncitizenship_name: \\nwhence_name: \\nreg_address_name: \\nreal_address_name: "],"date":["02.04.2018 19:12:39"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	1972-04-02	2012-04-10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	177	5	0	0	\N	0	0	5	5	0	0	0	\N	\N
52	#2	Сергиенко	Дмитрий	0	4	{2}	1																		Владимирович										{"prev_value":["migr_card_issued: 0000-00-00 00:00:00\\ncitizenship_name: \\nwhence_name: ","passport_number: \\nmigr_card_issued: 0000-00-00 00:00:00","current_value: \\npassport_number: ---- ------\\nmigr_card_issued: 0000-00-00 00:00:00"],"date":["02.04.2018 22:38:35","03.04.2018 17:03:39","03.04.2018 22:49:28"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c","#207 Super User","#207 Super User"]}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	6	0	0	\N	0	0	0	0	0	0	0	\N	\N
54	U1234567	Рахмонов	Асламбек	229	5	{2}	1	MALE				1234/17			1700001602	221		00084373					4617	7877107	Кужугетович	Rakhmonov	Aslambek Kuzhugetovich		шереметьево 715	Иммиграциооный департамент	TEMPORARY_RESIDENT_LICENSE	Ташкентское ПТУ	Ташкент	Узбекистан, г.Ташкент, ул.Тамерлана, д.16, кв.108	{"prev_value":["employ_permit_id: 21","hired_date: 2018-03-05 00:00:00"],"date":["09.04.2018 10:05:16","07.04.2019 15:12:59"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c","#207 Super User"]}	1988-06-14	2017-07-25	2027-07-25	2017-05-12	1970-01-01	2018-03-25	2018-04-03	2019-04-02	\N	2018-04-05	\N	2017-06-15	2015-08-11	\N	\N	\N	2018-03-26	2018-03-26	2018-03-26	\N	229	5	0	17	\N	7712345678	5	5	5	6	6	0	\N	\N
55	K4567891	Чен	Цао Цао	44	5	{2}	1	MALE							1700001621	3	12347890	 А111222	MULTI	WORK	12	0971715	4617	8351911		Chen	Xiao Xiao		Шереметьево 836	Посольством КНР в РФ		Пекинский колледж	Пекин	КНР, г. Пекин, пл. Тянаньминь, д. 10, кв. 20	{"prev_value":["current_value: \\nreg_address_name: \\u0433. \\u041c\\u043e\\u0441\\u043a\\u0432\\u0430, \\u041b\\u0435\\u043d\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439 \\u043f\\u0440., \\u0434. 11, \\u0441\\u0442\\u0440. 1, \\u043a\\u0432. 2\\nreal_address_name: \\u0433. \\u041c\\u043e\\u0441\\u043a\\u0432\\u0430, \\u041b\\u0435\\u043d\\u0438\\u043d\\u0441\\u043a\\u0438\\u0439 \\u043f\\u0440., \\u0434. 11, \\u0441\\u0442\\u0440. 1, \\u043a\\u0432. 2"],"date":["07.04.2018 00:30:10"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	1991-07-23	2010-10-07	2020-10-07	\N	\N	2017-06-17	2017-06-17	2018-06-02	\N	2017-06-17	\N	2017-06-27	2014-07-04	2017-06-17	2017-06-17	2018-06-02	2017-06-15	2017-06-15	2017-06-15	\N	44	5	22	20	\N	773456789	5	5	5	0	6	0	\N	\N
58	N2345678	НГУЕН	ТХИ ТЕО	232	7	{2}	1	FEMALE							770001234567											NGUYEN	THI TEO			Иммиграционный департамент			Бакзянг	Бакзянг, Дыкхю, Камжанг, д. 16	{"prev_value":["passport_issuer: \\u0418\\u043c\\u043c\\u0438\\u0433\\u0440\\u0430\\u0446\\u0438\\u043e\\u043e\\u043d\\u044b\\u0439 \\u0434\\u0435\\u043f\\u0430\\u0440\\u0442\\u0430\\u043c\\u0435\\u043d\\u0442","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","hired_date: 0000-00-00 00:00:00","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","status: SEEKER","status: WORKER","current_passport_number: \\noccupation_id: \\nwork_address: "],"date":["12.02.2019 11:45:34","11.11.2019 22:33:39","11.11.2019 22:36:54","11.11.2019 22:39:18","11.11.2019 22:40:32","11.11.2019 22:42:30","11.11.2019 22:58:38","11.11.2019 22:58:45","11.11.2019 22:59:10","11.11.2019 22:59:23","11.11.2019 22:59:29","11.11.2019 23:02:30","11.11.2019 23:02:36","11.11.2019 23:03:49","11.11.2019 23:03:53","11.11.2019 23:04:43","11.11.2019 23:04:47","11.11.2019 23:06:41","11.11.2019 23:06:46","11.11.2019 23:09:31","11.11.2019 23:09:36","11.11.2019 23:11:53","11.11.2019 23:11:57","12.11.2019 00:02:56","12.11.2019 00:04:11","12.11.2019 00:08:27","12.11.2019 08:04:31","12.11.2019 08:22:16","12.11.2019 08:22:23","12.11.2019 08:29:59","12.11.2019 08:30:05","12.11.2019 08:33:44","12.11.2019 08:33:49","12.11.2019 08:35:27","12.11.2019 08:35:32","12.11.2019 08:45:06","12.11.2019 08:45:12","12.11.2019 08:45:17","23.12.2019 15:04:01"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	1990-06-22	2018-02-16	2028-02-16	\N	\N	2018-07-06	2018-09-06	\N	\N	2019-11-11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	5	21	22	\N	0	0	6	0	0	6	0	\N	\N
59	C4755275	ДО	ВАН ЧУНГ	232	3	{3,2,5}	1	MALE						69	1900002404	14	202401546		MULTI	WORK	12	1349980	4618	9899484		DO	VAN TRUNG		Шереметьево 584	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ТХАНЬХОА		{"prev_value":["reg_date: 2018-11-30 00:00:00","user_ids: 209,215,208\\nstatus: WORKER\\nfired_date: 0000-00-00 00:00:00"],"date":["18.02.2019 12:16:36","29.11.2019 12:46:37"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-01-25	2018-03-09	2028-03-09	\N	\N	2019-02-04	2019-02-18	2020-02-17	\N	2019-02-18	2019-11-29	\N	\N	2019-02-13	2019-02-19	2020-02-17	2018-10-21	2018-10-21	2019-02-15	\N	232	4	32	1	\N	0	4	4	4	0	2	0	\N	\N
60	C3047553	ЧЫОНГ	ТХИ ДАМ	232	8	{3,4,2}	1	FEMALE																		TRUONG	THI DAM			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			КАМАУ		{"prev_value":["status: BUSINESS_VISA"],"date":["08.08.2018 11:47:02"],"user":["#209 \\u042e\\u043b\\u044f"]}	1984-02-12	2017-05-11	2027-05-11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	4	25	3	\N	0	4	2	2	0	0	0	\N	\N
61	N1462430	ЛЕ 	СУАН АНЬ	232	5	{213}	1	MALE																		LE	XUAN ANX			ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ			ВЬЕТНАМ, ХАНОЙ	ВЬЕТНАМ, Г. ХАНОЙ, РАЙОН ТХАНЬ СУАН БАК, УЛ. НГУЕН КВИ ДЫК, ДОМ Б6	{"prev_value":["user_ids: 213","user_ids: 208,213"],"date":["13.04.2018 00:08:38","13.04.2018 00:11:27"],"user":["#207 Super User","#207 Super User"]}	1985-01-20	2012-04-11	2022-04-11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	0	0	0	\N	0	0	0	0	0	0	0	\N	\N
62	C2395562	ЛИ	ШИНЬ ХОАН АНЬ	232	3	{3,4,2}	1	MALE							1800001051	72					12	1107640	4617	8887179		LI	SINH HOAN ANH			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ИЕНБАЙ		{"prev_value":["status: WORKER\\npassport_number: \\u04212395562","status: FURLOUGH"],"date":["23.04.2018 16:12:25","17.05.2018 18:44:31"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	1998-05-12	2016-11-22	2026-11-22	\N	\N	2018-01-11	2018-01-11	2019-01-10	\N	2018-01-11	2018-04-20	\N	\N	2018-01-10	2018-01-12	2019-01-10	2017-10-02	2017-10-02	2018-01-12	\N	232	1	8	6	\N	0	1	2	2	0	2	0	\N	\N
63	C0941862	НГУЕН	ХОАНГ СУАН БАК	232	3	{2,3,4}	1	MALE						69	1800004101	47	202409103	004413 14/CDNHD	MULTI	WORK	12	1348738	4616	7834654		NGUYEN	HOANG XUAN BAC		Шереметьево 387	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский промышленный  колледж	НГЕАН		{"prev_value":["visa_number: 1017174\\nvisa_issued: 2017-10-16 00:00:00\\nvisa_started: 2017-10-20 00:00:00\\nvisa_expired: 2018-10-18 00:00:00","user_ids: 209,214,208\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["05.10.2018 12:50:15","03.06.2019 12:05:13","03.06.2019 12:06:07"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-06-18	2015-09-23	2025-09-23	\N	\N	2018-09-24	2018-10-18	2019-07-11	\N	2018-10-18	2019-06-03	\N	2014-07-03	2018-10-01	2018-10-19	2019-07-11	2016-11-10	2016-11-10	2017-10-18	\N	232	1	26	1	\N	0	1	2	2	0	2	0	\N	\N
64	C2117471	ХОАНГ	ВАН ЗИЕН	232	3	{3,2,4}	1	MALE						69	1900003800	46	202409102	00084808 15/DHCNHN	MULTI	WORK	12	1560795	4616	7849834		HOANG	VAN DIEN		шереметьево 715	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	БАККАН		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 2017-10-02 00:00:00\\nwork_permit_started: 2017-10-19 00:00:00\\nwork_permit_expired: 2018-10-18 00:00:00\\nhired_date: 2017-10-19 00:00:00\\nvisa_number: 1017176\\nvisa_issued: 2017-10-16 00:00:00\\nvisa_started: 2017-10-20 00:00:00\\nvisa_expired: 2018-10-18 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 26\\nwork_permit_number: 1800004119\\nwork_permit_issued: 2018-09-24 00:00:00\\nwork_permit_started: 2018-10-18 00:00:00\\nwork_permit_expired: 2019-07-11 00:00:00\\nhired_date: 2018-10-18 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00","visa_number: 1348739\\nvisa_issued: 2018-10-01 00:00:00\\nvisa_started: 2018-10-19 00:00:00\\nvisa_expired: 2019-07-11 00:00:00\\nreg_date: 2017-10-18 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2018-10-05 00:00:00"],"date":["05.10.2018 11:33:13","24.06.2019 10:58:08","10.07.2019 13:48:05","10.07.2019 13:49:29","29.08.2019 11:50:57","29.08.2019 11:51:33","29.08.2019 11:53:18"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1992-06-06	2016-08-01	2026-08-01	\N	\N	2019-06-28	2019-07-11	2020-07-10	\N	2019-07-11	2019-08-29	\N	2015-07-02	2019-07-04	2019-07-12	2020-07-10	2016-11-10	2016-11-10	2019-07-10	\N	232	1	35	10	\N	0	1	2	2	0	2	0	\N	\N
65	C1067572	НГУЕН	ТУАН ТУ	232	3	{3,2,4}	1	MALE						69	1900003831	48	202409100	004415 14/CDNHD	MULTI	WORK	12	1560794	4616	7847062		NGUYEN	TUAN TU		Шереметьево 412	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский промышленный колледж	ХАНОЙ		{"prev_value":["hired_date: 2017-10-19 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 26\\nwork_permit_number: 1800004091\\nwork_permit_issued: 2018-09-24 00:00:00\\nwork_permit_started: 2018-10-18 00:00:00\\nwork_permit_expired: 2019-07-11 00:00:00","visa_number: 1348740\\nvisa_issued: 2018-10-01 00:00:00\\nvisa_started: 2018-10-19 00:00:00\\nvisa_expired: 2019-07-11 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nhired_date: 2018-10-18 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2017-10-18 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2018-10-05 00:00:00"],"date":["05.10.2018 11:29:22","24.06.2019 10:55:50","24.06.2019 10:56:07","10.07.2019 13:01:38","10.07.2019 13:02:41","16.10.2019 12:02:21","16.10.2019 12:02:41","16.10.2019 12:03:44"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-09-18	2015-11-25	2025-11-25	\N	\N	2019-06-28	2019-07-11	2020-07-10	\N	2019-07-11	2019-10-16	\N	2014-07-03	2019-07-04	2019-07-11	2020-07-10	2016-11-10	2016-11-10	2019-07-10	\N	232	1	35	1	\N	0	1	2	2	0	2	0	\N	\N
66	C2224003	ФАМ	ВАН БАК	232	3	{3,2,5}	1	MALE						69	1800004800	52	202409493	00084422	MULTI	WORK	12	1349195	4616	8960552		PHAM 	VAN BAC		Шереметьево 576	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	Тхайбинь		{"prev_value":["visa_number: 1017656\\nvisa_issued: 2017-11-24 00:00:00\\nvisa_started: 2017-11-30 00:00:00\\nvisa_expired: 2018-11-28 00:00:00\\nreg_date: 2017-11-29 00:00:00","user_ids: 209,215,208\\nstatus: WORKER\\nfired_date: 0000-00-00 00:00:00"],"date":["15.11.2018 13:49:51","25.11.2019 13:17:42"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1988-04-26	2016-08-22	2026-08-22	\N	\N	2018-11-01	2018-11-28	2019-11-27	\N	2018-11-28	2019-11-25	\N	2010-07-02	2018-11-06	2018-11-29	2019-11-27	2016-12-31	2016-12-31	2018-11-20	\N	232	1	27	10	\N	0	1	4	4	0	2	0	\N	\N
67	B8915840	ВУ	ТХИ ХОНГ ИЕН	232	3	{3,4,2}	1	FEMALE							1700005214	53	202409487	007916			12	1017659	4616	8989113		VU	THI HONG YEN		шереметьево 627	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	ХАНОЙ		{"prev_value":["fired_date: 0000-00-00 00:00:00"],"date":["27.02.2019 11:56:30"],"user":["#209 \\u042e\\u043b\\u044f"]}	1989-01-18	2014-02-25	2024-02-25	\N	\N	2017-11-20	2017-11-29	2018-11-28	\N	2017-11-29	2018-07-17	\N	2009-07-02	2017-11-24	2017-11-30	2018-11-28	2016-12-31	2016-12-31	2017-11-29	\N	232	1	9	6	\N	0	1	2	2	0	2	0	\N	\N
68	C2224813	ДИНЬ	ТХУ ЧАНГ	232	3	{3,2,4}	1	FEMALE						69	1900004730	54	202409486	00084375	MULTI	WORK	13	0053855	4619	7541468		DINH 	THU TRANG		Шереметьево 584	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	ТУЕНКУАНГ		{"prev_value":["visa_number: 1017658\\nvisa_issued: 2017-11-24 00:00:00\\nvisa_started: 2017-11-30 00:00:00\\nvisa_expired: 2018-11-28 00:00:00","user_ids: 209,214,208\\nstatus: WORKER","status: FURLOUGH","entry_date: 2016-12-31 00:00:00\\nentry_checkpoint: \\u0428\\u0435\\u0440\\u0435\\u043c\\u0435\\u0442\\u044c\\u0435\\u0432\\u043e 576\\nmigr_card_serie: 4616\\nmigr_card_number: 8960551\\nmigr_card_issued: 2016-12-31 00:00:00\\nreg_date: 2017-11-29 00:00:00","employ_permit_id: 27\\nwork_permit_number: 1800004768\\nwork_permit_issued: 2018-11-01 00:00:00\\nwork_permit_started: 2018-11-28 00:00:00\\nwork_permit_expired: 2019-11-27 00:00:00\\noccupation_id: 10","visa_serie: 12\\nvisa_number: 1349199\\nvisa_issued: 2018-11-06 00:00:00\\nvisa_started: 2018-11-29 00:00:00\\nvisa_expired: 2019-11-27 00:00:00\\nreg_date: 0000-00-00 00:00:00","reg_date: 2019-10-15 00:00:00","departure_date: 0000-00-00\\nwork_permit_paid_till: 0000-00-00","status: WORKER","status: FURLOUGH\\nfired_date: 0000-00-00"],"date":["19.11.2018 11:43:09","27.09.2019 11:26:48","14.10.2019 11:20:10","14.10.2019 11:25:48","26.11.2019 12:23:50","26.11.2019 12:25:07","28.11.2019 17:14:09","10.03.2020 11:28:31","11.03.2020 11:13:56","07.04.2020 11:13:30"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-11-21	2016-08-25	2026-08-25	\N	\N	2019-11-12	2019-11-27	2020-11-26	\N	2018-11-28	2020-04-07	\N	2009-07-02	2019-11-13	2019-11-28	2020-11-26	2019-10-12	2019-10-12	2019-11-26	2020-03-10	232	1	41	1	\N	0	1	2	2	0	2	0	\N	\N
69	C2176899	ЧАН	ТХИ НЯН	232	3	{3,2,4}	1	FEMALE						69	2000005010	55	202409484	00084381	MULTI	WORK	12	1771268	4616	8960550		TRAN 	THI NHAN		Шереметьево 576	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	БАКЖАНГ		{"prev_value":["hired_date: 2017-11-29 00:00:00\\nvisa_number: 1017662\\nvisa_issued: 2017-11-24 00:00:00\\nvisa_started: 2017-11-30 00:00:00\\nvisa_expired: 2018-11-28 00:00:00\\nreg_date: 2017-11-29 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 27\\nwork_permit_number: 1800004824\\nwork_permit_issued: 2018-11-01 00:00:00\\nwork_permit_started: 2018-11-28 00:00:00\\nwork_permit_expired: 2019-11-27 00:00:00\\noccupation_id: 13","visa_serie: 12\\nvisa_number: 1349194\\nvisa_issued: 2018-11-06 00:00:00\\nvisa_started: 2018-11-29 00:00:00\\nvisa_expired: 2019-11-27 00:00:00","hired_date: 2018-11-28 00:00:00","reg_date: 2018-11-20 00:00:00","employ_permit_id: 41\\nwork_permit_number: 1900004722","work_permit_issued: 2019-11-12\\nwork_permit_started: 2019-11-27\\nwork_permit_expired: 2020-11-26\\nhired_date: 2019-11-27","work_permit_issued: 2020-10-21","work_permit_issued: 2020-10-20","visa_serie: 13\\nvisa_number: 0053854\\nvisa_issued: 2019-11-13\\nvisa_started: 2019-11-28\\nvisa_expired: 2020-11-26","reg_date: 2019-11-26","reg_date: 0000-00-00","reg_date: 2020-11-19","status: WORKER\\nfired_date: 0000-00-00"],"date":["15.11.2018 14:25:13","26.11.2019 12:45:14","26.11.2019 12:46:18","28.11.2019 17:52:32","28.11.2019 17:52:56","16.11.2020 17:09:19","16.11.2020 17:12:26","16.11.2020 17:13:21","16.11.2020 17:14:31","16.11.2020 17:15:56","16.11.2020 17:16:46","19.11.2020 12:37:06","19.11.2020 12:37:48","12.04.2021 13:23:55"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-10-24	2016-08-18	2026-08-18	\N	\N	2020-10-21	2020-11-26	2021-11-25	\N	2020-11-26	2021-04-12	\N	2009-07-02	2020-11-03	2020-11-27	2021-11-25	2016-12-31	2016-12-31	2020-11-18	\N	232	1	52	1	\N	0	1	2	2	0	2	0	\N	\N
70	B6078375	ФАМ	ВАН ЗУЕТ	232	3	{3,2,4}	1	MALE						69	1800004817	56	202409482	004124	MULTI	WORK	12	1349196	4619	6690359		PHAM	VAN DUYET		шереметьево 129	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский профессиональный колледж	ХАНОЙ		{"prev_value":["visa_number: 1017664\\nvisa_issued: 2017-11-24 00:00:00\\nvisa_started: 2017-11-30 00:00:00\\nvisa_expired: 2018-11-28 00:00:00\\nreg_date: 2018-06-26 00:00:00","departure_date: 0000-00-00 00:00:00\\nbirth_date: 1992-10-13 00:00:00\\npassport_issued: 2012-03-20 00:00:00\\npassport_expired: 2022-03-20 00:00:00\\nwork_permit_issued: 2018-11-01 00:00:00\\nwork_permit_started: 2018-11-28 00:00:00\\nwork_permit_expired: 2019-11-27 00:00:00\\nhired_date: 2018-11-28 00:00:00\\ncert_issued: 2010-07-02 00:00:00\\nvisa_issued: 2018-11-06 00:00:00\\nvisa_started: 2018-11-29 00:00:00\\nvisa_expired: 2019-11-27 00:00:00\\nentry_date: 2018-06-24 00:00:00\\nmigr_card_issued: 2018-06-24 00:00:00\\nreg_date: 2018-11-20 00:00:00","birth_date: 0000-00-00 00:00:00\\npassport_issued: 0000-00-00 00:00:00\\npassport_expired: 0000-00-00 00:00:00\\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00\\ncert_issued: 0000-00-00 00:00:00\\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","birth_date: 2019-03-15 00:00:00\\npassport_issued: 2025-09-02 00:00:00\\npassport_expired: 2025-09-12 00:00:00\\nwork_permit_issued: 2007-05-11 00:00:00\\nwork_permit_started: 2034-05-11 00:00:00\\nwork_permit_expired: 2033-05-11 00:00:00\\nhired_date: 2034-05-11 00:00:00\\ncert_issued: 2007-12-31 00:00:00\\nvisa_issued: 2012-05-10 00:00:00\\nvisa_started: 2035-05-11 00:00:00\\nvisa_expired: 2033-05-11 00:00:00\\nentry_date: 2029-12-09 00:00:00\\nmigr_card_issued: 2029-12-09 00:00:00\\nreg_date: 2026-05-11 00:00:00","status: WORKER","user_ids: 209,214,208\\nstatus: FURLOUGH\\ndeparture_date: 2019-03-13 00:00:00\\nentry_date: 2018-04-26 00:00:00\\nentry_checkpoint: \\u0428\\u0435\\u0440\\u0435\\u043c\\u0435\\u0442\\u044c\\u0435\\u0432\\u043e 566\\nmigr_card_serie: 4618\\nmigr_card_number: 9275397\\nmigr_card_issued: 2018-04-26 00:00:00","visa_issued: 2019-03-13 00:00:00","entry_date: 2019-05-06 00:00:00","entry_date: 2019-05-05 00:00:00","user_ids: 208,209,214\\npassport_issuer: \\u041c\\u0418\\u0413\\u0420\\u0410\\u0426\\u0418\\u041e\\u041d\\u041d\\u042b\\u0419 \\u0414\\u0415\\u041f\\u0410\\u0420\\u0422\\u0410\\u041c\\u0415\\u041d\\u0422","status: WORKER","reg_date: 2018-11-20 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["15.11.2018 14:17:56","12.03.2019 22:45:14","13.03.2019 13:34:50","13.03.2019 13:38:57","13.03.2019 13:46:14","07.05.2019 14:53:36","07.05.2019 15:16:48","21.05.2019 14:36:56","21.05.2019 14:37:14","14.10.2019 10:51:08","11.11.2019 13:08:46","11.11.2019 13:09:34","11.11.2019 13:45:02"],"user":["#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#207 Super User","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1992-10-13	2012-03-20	2022-03-20	\N	\N	2018-11-01	2018-11-28	2019-11-27	\N	2018-11-28	2019-11-08	\N	2010-07-02	2018-11-06	2018-11-29	2019-11-27	2019-05-06	2019-05-06	2019-05-07	\N	232	1	27	6	\N	0	1	2	2	0	2	0	\N	\N
71	B7664229	НГУЕН	НГОК ХЫНГ	232	5	{3,2,4}	1	MALE						69	2000004993	57	202409498	004117	MULTI	WORK	12	1771269	4616	8960559		NGUYEN	NGOC HUNG		Шереметьево 576	ИММИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский профессиональный колледж	ТЭИНИНЬ		{"prev_value":["visa_number: 1017663\\nvisa_issued: 2017-11-24 00:00:00\\nvisa_started: 2017-11-30 00:00:00\\nvisa_expired: 2018-11-28 00:00:00\\nreg_date: 2017-11-29 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 27\\nwork_permit_number: 1800004782\\nwork_permit_issued: 2018-11-01 00:00:00\\nwork_permit_started: 2018-11-28 00:00:00\\nwork_permit_expired: 2019-11-27 00:00:00\\noccupation_id: 6","visa_serie: 12\\nvisa_number: 1349192\\nvisa_issued: 2018-11-06 00:00:00\\nvisa_started: 2018-11-29 00:00:00\\nvisa_expired: 2019-11-27 00:00:00","hired_date: 2018-11-28 00:00:00","reg_date: 2018-11-20 00:00:00","employ_permit_id: 41\\nwork_permit_number: 1900004747\\nwork_permit_issued: 2019-11-12\\nwork_permit_started: 2019-11-27\\nwork_permit_expired: 2020-11-26\\nhired_date: 2019-11-27","visa_serie: 13\\nvisa_number: 0053856\\nvisa_issued: 2019-11-13\\nvisa_started: 2019-11-28\\nvisa_expired: 2020-11-26","reg_date: 2019-11-26","reg_date: 0000-00-00"],"date":["15.11.2018 13:32:08","26.11.2019 12:29:12","26.11.2019 12:30:15","28.11.2019 17:21:50","28.11.2019 17:22:04","16.11.2020 17:24:48","16.11.2020 17:26:10","16.11.2020 17:26:57","19.11.2020 12:43:15"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1991-01-08	2013-02-19	2023-02-19	\N	\N	2020-10-21	2020-11-26	2021-11-25	\N	2020-11-26	\N	\N	2010-07-02	2020-11-03	2020-11-27	2021-11-25	2016-12-31	2016-12-31	2020-11-18	\N	232	1	52	2	\N	0	1	2	2	0	2	0	\N	\N
72	B8761869	ДАНГ	ТХАНЬ НАМ	232	3	{3,2,5}	1	MALE						69	1800004750	59	202409494	004511	MULTI	WORK	12	1349198	4617	7797777		DANG	THANH NAM		шереметьево 627	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский профессиональный колледж	Тхайбинь		{"prev_value":["reg_date: 2017-11-29 00:00:00","user_ids: 209,215,208\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["15.11.2018 13:00:58","14.11.2019 13:52:11","14.11.2019 13:52:50"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1996-05-10	2014-02-17	2024-02-17	\N	\N	2018-11-01	2018-11-28	2019-11-27	\N	2018-11-28	2019-11-14	\N	2014-07-02	2018-11-06	2018-11-29	2019-11-27	2017-01-31	2017-01-31	2018-11-20	\N	232	1	27	6	\N	0	1	4	4	0	2	0	\N	\N
73	B9257917	ХОАНГ	ТХИ ИЭН	232	3	{3,4,2}	1	FEMALE							1700005341	60	202409483	007685			12	1017665	4617	7797760		HOANG	THI YEN		шереметьево 627	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	БАКЖАНГ		{"prev_value":["status: FURLOUGH\\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00"],"date":["29.06.2018 11:24:47"],"user":["#209 \\u042e\\u043b\\u044f"]}	1984-03-10	2014-05-26	2024-05-26	\N	\N	2017-11-20	2017-11-29	2018-11-28	\N	2017-11-29	2018-05-22	\N	2006-07-04	2017-11-24	2017-11-30	2018-11-28	2017-01-31	2017-01-31	2017-11-29	\N	232	1	9	6	\N	0	1	2	2	0	2	0	\N	\N
74	B7153398	ХОАНГ	СУАН ЗУНГ	232	3	{2,3,4}	1	MALE						69	1800004983	64	202409660	007988 13/CDKTHY	MULTI	WORK	12	1349531	2806	0000678		HOANG	XUAN DUNG		Шереметьево 584	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	ХАНОЙ		{"prev_value":["departure_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nstatus: FURLOUGH","departure_date: 2019-01-25 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["25.01.2019 13:57:12","22.04.2019 11:33:22","22.04.2019 11:34:13","22.04.2019 11:34:54"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1993-08-20	2012-09-05	2022-09-05	\N	\N	2018-11-27	2018-12-07	2019-12-06	\N	2018-12-07	2019-04-22	\N	2013-07-03	2018-11-28	2018-12-08	2019-12-06	2017-03-25	2017-03-25	2018-12-07	\N	232	1	28	6	\N	0	1	2	2	0	2	0	\N	\N
75	B7608906	ХОАНГ	ВАН КХОЙ	232	3	{3,4,2}	1	MALE						69	1800005017	66	202409659	007985 13/CDKTHY	MULTI	WORK	12	1017729	4617	7943515		HOANG	VAN KHOI		Шереметьево 817	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	НГЕАН		{"prev_value":["status: FURLOUGH\\nfired_date: 0000-00-00 00:00:00"],"date":["03.12.2018 14:26:05"],"user":["#209 \\u042e\\u043b\\u044f"]}	1993-05-05	2013-03-15	2023-03-15	\N	\N	2018-11-27	2018-12-07	2019-12-06	\N	2018-12-07	2018-12-03	\N	\N	2017-11-28	2017-12-08	2018-12-07	2017-02-24	2017-02-24	\N	2018-10-14	232	1	28	6	\N	0	1	2	2	0	2	0	\N	\N
76	C2432026	ХОАНГ	ВАН ТИЕН	232	3	{3,2,4}	1	MALE						69	1900004779	67	202409656	008274 14/CDKTHY	MULTI	WORK	13	0053857	4617	7929503		HOANG	VAN TIEN		Шереметьево 801	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	НГЕАН		{"prev_value":["visa_number: 13495632","user_ids: 209,214,208\\nemploy_permit_id: 28\\nwork_permit_number: 1800005024\\nwork_permit_issued: 2018-11-27 00:00:00\\nwork_permit_started: 2018-12-07 00:00:00\\nwork_permit_expired: 2019-12-06 00:00:00","visa_serie: 12\\nvisa_number: 1349532\\nvisa_issued: 2018-11-28 00:00:00\\nvisa_started: 2018-12-08 00:00:00\\nvisa_expired: 2019-12-06 00:00:00","reg_date: 2018-12-07 00:00:00","current_passport_number: \\nstatus: WORKER\\ndeparture_date: 0000-00-00 00:00:00","current_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: FURLOUGH","current_passport_number: "],"date":["07.12.2018 13:24:36","26.11.2019 11:59:42","26.11.2019 12:00:53","11.12.2019 15:27:44","21.01.2020 13:19:26","29.01.2020 11:32:43","29.01.2020 11:32:51","29.01.2020 11:33:07"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-01-10	2016-10-21	2026-10-21	\N	\N	2019-11-12	2019-12-06	2020-12-05	\N	2018-12-07	2020-01-29	\N	2014-07-02	2019-11-13	2019-12-07	2020-12-05	2017-02-24	2017-02-24	2019-11-26	2020-01-21	232	1	40	6	\N	0	1	2	2	0	2	0	\N	\N
77	C2250527	ХОАНГ	ЗОАН ТХАНГ	232	3	{3,4,2}	1	MALE						69	1800005031	68	202409654	008271 14/CDKTHY	MULTI	WORK	12	1349533	4617	7929502		HOANG	DOAN THANG		Шереметьево 801	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	НГЕАН		{"prev_value":["fired_date: 0000-00-00 00:00:00"],"date":["27.02.2019 11:59:25"],"user":["#209 \\u042e\\u043b\\u044f"]}	1998-11-10	2016-09-12	2026-09-12	\N	\N	2018-11-27	2018-12-07	2019-12-06	\N	2018-12-07	2019-02-19	\N	2014-07-02	2018-11-28	2018-12-08	2019-12-06	2017-02-24	2017-02-24	2018-12-07	2019-02-19	232	1	28	6	\N	0	1	2	2	0	2	0	\N	\N
78	B7233512	ДАНГ	ВАН ДОАН	232	3	{3,2,4}	1	MALE						69	1900004761	69	202409657	00084817 15/DHCNHN	MULTI	WORK	13	0053858	4619	7895931		DANG	VAN DOAN		Шереметьево 589	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	НГЕАН		{"prev_value":["visa_number: 1017732\\nvisa_issued: 2017-11-28 00:00:00\\nvisa_started: 2017-12-08 00:00:00\\nvisa_expired: 2018-12-07 00:00:00\\nreg_date: 2017-12-07 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 28\\nwork_permit_number: 1800004990\\nwork_permit_issued: 2018-11-27 00:00:00\\nwork_permit_started: 2018-12-07 00:00:00\\nwork_permit_expired: 2019-12-06 00:00:00\\noccupation_id: 8","visa_serie: 12\\nvisa_number: 1349530\\nvisa_issued: 2018-11-28 00:00:00\\nvisa_started: 2018-12-08 00:00:00\\nvisa_expired: 2019-12-06 00:00:00","reg_date: 2018-12-07 00:00:00","citizenship: 232","current_passport_number: \\ncitizenship: 177","current_passport_number: ","current_passport_number: \\nstatus: WORKER","current_passport_number: \\nstatus: FURLOUGH\\nentry_date: 2017-02-24 00:00:00\\nentry_checkpoint: \\u0428\\u0435\\u0440\\u0435\\u043c\\u0435\\u0442\\u044c\\u0435\\u0432\\u043e 817\\nmigr_card_serie: 4617\\nmigr_card_number: 7943514\\nmigr_card_issued: 2017-02-24 00:00:00","current_passport_number: ","current_passport_number: \\nreg_date: 2019-11-26 00:00:00","fired_date: 0000-00-00","departure_date: 0000-00-00\\nwork_address: \\nreg_date: 2020-01-31","status: WORKER"],"date":["07.12.2018 10:19:24","26.11.2019 11:53:19","26.11.2019 11:55:14","02.12.2019 17:02:07","04.12.2019 21:39:20","11.12.2019 15:43:10","11.12.2019 15:43:31","21.01.2020 13:12:42","30.01.2020 16:06:21","30.01.2020 16:32:02","31.01.2020 12:09:23","02.12.2020 13:41:21","02.12.2020 13:51:59","02.12.2020 13:52:12"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1992-12-17	2012-10-04	2022-10-04	\N	\N	2019-11-12	2019-12-06	2020-12-05	\N	2018-12-07	2020-12-04	\N	2015-07-02	2019-11-13	2019-12-07	2020-12-05	2020-01-29	2020-01-29	2020-01-30	2020-12-04	232	1	40	6	\N	0	1	2	2	0	2	0	\N	\N
79	C2317122	ТА	ТХИ ЛИЕН	232	3	{3,4,2}	1	FEMALE						69	1800005000	70	202409653	00070117 00/DHCNHN	MULTI	WORK	12	1349529	4617	7943513		TA	THI LIEN		Шереметьево 817	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойский университет индустрии	ХАНОЙ		{"prev_value":["status: FURLOUGH\\nfired_date: 0000-00-00 00:00:00"],"date":["25.02.2019 14:03:57"],"user":["#209 \\u042e\\u043b\\u044f"]}	1964-01-28	2016-09-28	2026-09-28	\N	\N	2018-11-27	2018-12-07	2019-12-06	\N	2018-12-07	2019-02-25	\N	2000-07-03	2018-11-28	2018-12-08	2019-12-06	2017-02-24	2017-02-24	2018-12-07	2019-01-25	232	1	28	12	\N	0	1	2	2	0	2	0	\N	\N
80	C3373260	НГУЕН	ВАН ФЫОНГ	232	3	{3,2,5}	1	MALE						69	1800004976	77	202401877	004135 10/CDNHD	MULTI	WORK	12	1349534	4617	9053102		NGUYEN	VAN PHUONG		шереметьево 651	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хайзыонгский профессиональный колледж	ТХАНЬХОА		{"prev_value":["visa_number: 1107639\\nvisa_issued: 2018-01-10 00:00:00\\nvisa_started: 2018-01-11 00:00:00\\nvisa_expired: 2019-01-10 00:00:00\\nreg_date: 2018-01-12 00:00:00","user_ids: 209,215,208\\nstatus: WORKER\\nfired_date: 0000-00-00 00:00:00"],"date":["07.12.2018 10:24:29","29.11.2019 13:12:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-06-01	2017-05-17	2027-05-17	\N	\N	2018-11-27	2019-10-10	2020-01-09	\N	2019-01-10	2019-11-29	\N	2010-07-02	2018-11-28	2019-01-11	2020-01-09	2017-11-07	2017-11-07	2018-12-07	\N	232	1	29	6	\N	0	1	4	4	0	2	0	\N	\N
93	AA1541728	АЗИЗОВ	РУСТАМХОН	229	8	{3,4,2}	1	MALE															5317	1933741	МУХТ0РОВИЧ					ОВД КАСАНСАЙСКОГО РАЙОНА НАМАГАНСКОЙ ОБЛАСТИ			КАСАНСАЙСКИЙ РАЙОН		{"prev_value":["user_ids: 209,208,214\\nstatus: SEEKER"],"date":["07.11.2018 11:08:34"],"user":["#209 \\u042e\\u043b\\u044f"]}	1972-09-30	2013-05-19	2023-05-18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2018-09-03	2018-09-03	\N	\N	229	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
81	C4117730	ХОАНГ	ДЫК МАНЬ	232	3	{3,2,4}	1	MALE						69	1900002436	2	202400891	007991	MULTI	WORK	12	1349981	4618	9375881		HOANG	DUC MANH		Шереметьево 564	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Хынгиенский промышленный колледж	ХАНОЙ		{"prev_value":["visa_number: 1348521\\nvisa_issued: 2018-08-31 00:00:00\\nvisa_started: 2018-08-31 00:00:00\\nvisa_expired: 2019-02-18 00:00:00\\nreg_date: 2018-07-18 00:00:00","user_ids: 209,214,208\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["15.02.2019 15:44:17","21.10.2019 12:32:28","21.10.2019 12:32:41"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1999-07-13	2017-11-07	2027-11-07	\N	\N	2019-02-04	2019-02-18	2020-02-17	\N	2019-02-18	2019-10-21	\N	2013-07-03	2019-02-13	2019-02-19	2020-02-17	2018-07-17	2018-07-17	2019-02-15	\N	232	4	32	1	\N	0	4	2	2	0	2	0	\N	\N
82	C4893943	АН	ВИЕТ ТИНЬ	232	3	{3,2,4}	1	MALE						69	2000004601	80	202401355	003125542/LDTBXH-DN	MULTI	WORK	12	1770607	4618	9827726		AN	VIET TINH		Шереметьево 800	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ТХАНЬХОА		{"prev_value":["work_permit_serie: \\nvisa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_serie: 23\\nvisa_number: 8261727\\nvisa_issued: 2018-09-10 00:00:00\\nvisa_started: 2018-09-10 00:00:00\\nvisa_expired: 2018-11-22 00:00:00","user_ids: 209,214,208\\nentry_date: 2018-09-13 00:00:00","entry_date: 2018-09-14 00:00:00","employ_permit_id: 26\\nwork_permit_serie: 69\\nwork_permit_number: 1800003852\\nwork_permit_issued: 2018-08-27 00:00:00\\nwork_permit_started: 2018-08-27 00:00:00\\nwork_permit_expired: 2019-07-11 00:00:00","visa_number: 1348818\\nvisa_issued: 2018-10-05 00:00:00\\nvisa_started: 2018-11-23 00:00:00\\nvisa_expired: 2019-07-11 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nreg_date: 2018-09-14 00:00:00","current_passport_number: \\nwork_address: ","user_ids: 208,209,214","employ_permit_id: 35\\nwork_permit_number: 1900003824\\nwork_permit_issued: 2019-06-28\\nwork_permit_started: 2019-07-11\\nwork_permit_expired: 2020-07-10","visa_number: 1560797\\nvisa_issued: 2019-07-04\\nvisa_started: 2019-07-12\\nvisa_expired: 2020-07-10\\nreg_date: 2018-10-19","status: WORKER\\nfired_date: 0000-00-00","work_permit_started: 2020-07-10"],"date":["19.10.2018 12:22:07","21.05.2019 12:22:45","21.05.2019 12:23:01","24.06.2019 10:51:15","24.06.2019 10:51:29","10.07.2019 12:26:38","10.07.2019 12:27:45","19.12.2019 14:56:08","13.05.2020 15:29:46","23.06.2020 12:44:50","23.06.2020 12:50:40","23.12.2020 12:56:52","24.12.2020 11:16:43"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-07-11	2018-04-02	2028-04-02	\N	\N	2020-06-17	2020-07-01	2021-06-30	\N	2018-09-17	2020-12-24	\N	2011-06-01	2020-06-18	2020-07-11	2021-06-30	2018-09-13	2018-09-13	2020-06-26	\N	232	1	49	5	\N	0	1	2	2	0	2	0	\N	\N
83	C2960819	НГУЕН	ТХИ ТХАНЬ ХЫОНГ	232	5	{3,2,4}	1	FEMALE						69	2000005002	78	202400816		MULTI	WORK	12	1771270	4619	7541467		NGUYEN	THI THANH HUONG		Шереметьево 584	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХАНОЙ		{"prev_value":["passport_issuer: \\u043c\\u0438\\u0433\\u0440\\u0430\\u0446\\u0438\\u043e\\u043d\\u043d\\u044b\\u043c \\u0434\\u0435\\u043f\\u0430\\u0440\\u0442\\u0430\\u043c\\u0435\\u043d\\u0442\\u043e\\u043c","user_ids: 209,214,208\\nstatus: WORKER","departure_date: 0000-00-00 00:00:00","status: FURLOUGH","departure_date: 2019-09-26 00:00:00\\nentry_date: 2018-07-17 00:00:00\\nentry_checkpoint: \\u0428\\u0435\\u0440\\u0435\\u043c\\u0435\\u0442\\u044c\\u0435\\u0432\\u043e 564\\nmigr_card_serie: 4618\\nmigr_card_number: 9375876\\nmigr_card_issued: 2018-07-17 00:00:00\\nreg_date: 2018-11-20 00:00:00","employ_permit_id: 27\\nwork_permit_number: 1800004790\\nwork_permit_issued: 2018-11-01 00:00:00\\nwork_permit_started: 2018-11-28 00:00:00\\nwork_permit_expired: 2019-11-27 00:00:00","visa_serie: 12\\nvisa_number: 1349197\\nvisa_issued: 2018-11-08 00:00:00\\nvisa_started: 2018-12-01 00:00:00\\nvisa_expired: 2019-11-27 00:00:00\\nreg_date: 0000-00-00 00:00:00","hired_date: 2018-11-28 00:00:00","reg_date: 2019-10-15 00:00:00","occupation_id: 4","employ_permit_id: 41\\nwork_permit_number: 1900004754\\nwork_permit_issued: 2019-11-12\\nwork_permit_started: 2019-11-27\\nwork_permit_expired: 2020-11-26\\nwork_address: \\nhired_date: 2019-11-27","visa_serie: 13\\nvisa_number: 0053853\\nvisa_issued: 2019-11-13\\nvisa_started: 2019-11-28\\nvisa_expired: 2020-11-26","reg_date: 2019-11-26","reg_date: 0000-00-00"],"date":["19.11.2018 11:45:58","27.09.2019 11:22:07","04.10.2019 11:27:11","14.10.2019 11:37:33","14.10.2019 11:43:58","26.11.2019 12:34:41","26.11.2019 12:36:02","28.11.2019 17:36:25","28.11.2019 17:36:44","15.09.2020 14:41:27","16.11.2020 17:20:48","16.11.2020 17:22:39","16.11.2020 17:33:17","19.11.2020 12:39:13"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1974-03-20	2017-03-30	2027-03-30	\N	\N	2020-10-21	2020-11-26	2021-11-25	\N	2020-11-26	\N	\N	\N	2020-11-03	2020-11-27	2021-11-25	2019-10-12	2019-10-12	2020-11-18	\N	232	1	52	1	\N	0	1	2	2	0	2	0	\N	\N
84	C4638103	ХО	ВИЕТ ХОАНГ	232	3	{3,4,2}	1	MALE						69	1800003972	8	202401430		MULTI	WORK	12	1349071	4618	9878207		HO	VIET HOANG		Шереметьев 830	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ТХЫАТХИЕН-ХЮЭ		{"prev_value":["fired_date: 0000-00-00 00:00:00"],"date":["27.02.2019 12:00:42"],"user":["#209 \\u042e\\u043b\\u044f"]}	1996-11-03	2018-03-14	2028-03-14	\N	\N	2018-09-11	2018-09-11	2019-07-14	\N	2018-09-19	2019-02-19	\N	\N	2018-10-26	2018-12-03	2019-07-14	2018-09-17	2018-09-17	2018-11-08	2019-02-19	232	4	25	1	\N	0	4	2	2	0	2	0	\N	\N
85	C5033951	ТА	ВАН ВУ	232	3	{3,2,4}	1	MALE						69	2000004506	6	202401353	003137253/LDTBXH-DN	MULTI	WORK	12	1770601	4618	9820820		TA	VAN VU		шереметьево 700	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	Тхайбинь		{"prev_value":["visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_serie: 23\\nvisa_number: 8260608\\nvisa_issued: 2018-09-03 00:00:00\\nvisa_started: 2018-09-03 00:00:00\\nvisa_expired: 2018-11-22 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 25\\nwork_permit_serie: \\nwork_permit_number: 1800003940\\nwork_permit_issued: 2018-09-10 00:00:00\\nwork_permit_started: 2018-09-10 00:00:00\\nwork_permit_expired: 2019-07-14 00:00:00","visa_number: 1348821\\nvisa_issued: 2018-10-05 00:00:00\\nvisa_started: 2018-11-23 00:00:00\\nvisa_expired: 2019-07-14 00:00:00\\nreg_date: 2018-09-14 00:00:00","work_permit_started: 2019-07-13 00:00:00\\nwork_permit_expired: 2020-07-14 00:00:00","user_ids: 208,209,214\\nemploy_permit_id: 36","reg_date: 2018-10-19","occupation_id: 2\\nwork_address: ","work_permit_number: 1900003849\\nwork_permit_issued: 2019-06-28\\nwork_permit_started: 2019-07-14\\nwork_permit_expired: 2020-07-13","visa_number: 1560792\\nvisa_issued: 2019-07-04\\nvisa_started: 2019-07-15\\nvisa_expired: 2020-07-13\\nreg_date: 2019-07-12","departure_date: 0000-00-00\\nfired_date: 0000-00-00","status: WORKER"],"date":["19.10.2018 12:37:13","10.07.2019 17:31:01","10.07.2019 17:32:34","10.07.2019 17:36:42","15.05.2020 12:53:53","15.05.2020 12:54:23","15.05.2020 12:55:55","23.06.2020 14:37:21","23.06.2020 14:38:54","02.12.2020 13:54:06","02.12.2020 14:04:13"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1990-03-22	2018-04-19	2028-04-19	\N	\N	2020-06-08	2020-07-13	2021-01-26	\N	2018-09-14	2020-12-04	\N	2014-06-03	2020-06-11	2020-07-14	2021-01-26	2018-09-12	2018-09-12	2020-06-26	2020-12-04	232	4	45	6	\N	0	4	2	2	0	2	0	\N	\N
86	C4781904	ЧАН	ТХИ МИЕН	232	3	{3,2,4}	1	FEMALE						69	1900003870	9	202401427		MULTI	WORK	12	1560789	4618	9882025		TRAN 	THI MIEN		Шереметьево 800	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			НИНЬБИНЬ		{"prev_value":["visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_serie: 23\\nvisa_number: 8261920\\nvisa_issued: 2018-09-11 00:00:00\\nvisa_started: 2018-09-11 00:00:00\\nvisa_expired: 2018-12-02 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 25\\nwork_permit_number: 1800003980\\nwork_permit_issued: 2018-09-11 00:00:00\\nwork_permit_started: 2018-09-11 00:00:00\\nwork_permit_expired: 2019-07-14 00:00:00","visa_number: 1349068\\nvisa_issued: 2018-10-26 00:00:00\\nvisa_started: 2018-12-03 00:00:00\\nvisa_expired: 2019-07-14 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2018-09-19 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2018-11-08 00:00:00"],"date":["07.11.2018 15:03:47","24.06.2019 11:03:27","24.06.2019 11:03:44","10.07.2019 19:10:54","10.07.2019 19:11:58","18.09.2019 13:23:49","18.09.2019 13:24:14","18.09.2019 13:24:56"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-10-05	2018-03-17	2028-03-17	\N	\N	2018-06-28	2019-07-14	2020-07-13	\N	2018-09-19	2019-09-17	\N	\N	2019-07-04	2019-07-15	2020-07-13	2018-09-17	2018-09-17	2019-07-12	\N	232	4	36	1	\N	0	4	2	2	0	2	0	\N	\N
124	AB9449631	БАЗАРОВА	МИНГАЙИМХОН	229	3	{2,3,4}	1	FEMALE						69	1900007900	14							4519	0111487					ВНУКОВО 237	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_expired: 2020-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","fired_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nstatus: WORKER","fired_date: 2019-04-03 00:00:00"],"date":["14.02.2019 16:39:27","01.04.2019 17:05:27","03.04.2019 12:54:09","08.04.2019 12:14:56","08.04.2019 12:15:15"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1983-11-19	2018-05-01	2028-04-30	\N	\N	2019-02-12	2019-02-12	2019-04-04	2019-04-04	2019-02-14	2019-04-04	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-01-06	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
87	C4869023	НГУЕН	ТХИ НЯН	232	3	{3,2,4}	1	FEMALE						69	1900003817	79		003121239/LDTBXH-DN	MULTI	WORK	12	1560793	4618	9827674		NGUYEN	THI NHAN		шереметьево 747	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	Тхайбинь		{"prev_value":["contract_number: \\nvisa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_serie: 23\\nvisa_number: 8260609\\nvisa_issued: 2018-09-03 00:00:00\\nvisa_started: 2018-09-03 00:00:00\\nvisa_expired: 2018-11-22 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 26\\nwork_permit_serie: \\nwork_permit_number: 1800003933\\nwork_permit_issued: 2018-09-10 00:00:00\\nwork_permit_started: 2018-09-10 00:00:00\\nwork_permit_expired: 2019-07-11 00:00:00","visa_number: 1348817\\nvisa_issued: 2018-10-05 00:00:00\\nvisa_started: 2018-11-23 00:00:00\\nvisa_expired: 2019-07-11 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2018-09-14 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2018-10-19 00:00:00"],"date":["19.10.2018 12:50:50","24.06.2019 10:52:42","24.06.2019 10:57:14","10.07.2019 13:17:08","10.07.2019 13:18:03","06.12.2019 13:46:53","06.12.2019 13:47:07","06.12.2019 13:47:35"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1979-03-27	2018-04-04	2028-04-04	\N	\N	2019-06-28	2019-07-11	2019-07-10	\N	2018-09-14	2019-12-06	\N	2007-09-04	2019-07-04	2019-07-11	2020-07-10	2018-09-12	2018-09-12	2019-07-10	\N	232	1	35	3	\N	0	1	2	2	0	2	0	\N	\N
88	C4858457	ЛЕ	ВАН ТХАНЬ	232	3	{3,2,4}	1	MALE						69	1900003888	7	202401431		MULTI	WORK	12	1560790	4618	9882027		LE	VAN THANH		Шереметьево 800	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАРИА-ВУНГТАУ		{"prev_value":["visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419","user_ids: 209,214,208\\nemploy_permit_id: 25\\nwork_permit_number: 1800003965\\nwork_permit_issued: 2018-09-11 00:00:00\\nwork_permit_started: 2018-09-11 00:00:00\\nwork_permit_expired: 2019-07-14 00:00:00","visa_number: 1349070\\nvisa_issued: 2018-10-26 00:00:00\\nvisa_started: 2018-12-03 00:00:00\\nvisa_expired: 2019-07-14 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 2020-11-11 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2018-09-19 00:00:00","user_ids: 208,209,214\\nreg_date: 2018-11-08 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["07.11.2018 14:35:17","24.06.2019 11:00:37","24.06.2019 11:01:19","10.07.2019 14:43:36","10.07.2019 14:44:39","06.12.2019 12:48:47","06.12.2019 12:53:01","06.12.2019 12:53:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1994-02-01	2018-04-04	2028-04-04	\N	\N	2019-06-28	2019-07-14	2020-07-13	\N	2018-09-19	2019-12-06	\N	\N	2019-07-04	2019-07-15	2020-07-13	2018-09-17	2018-09-17	2019-07-12	\N	232	4	36	1	\N	0	4	2	2	0	2	0	\N	\N
89	C5256765	НГУЕН	ДИНЬ КИЕН	232	5	{3,2,4}	1	MALE						69	2100005180	7	202401428		MULTI	WORK	12	1946379	4618	9827725		NGUYEN	DINH KIEN		Шереметьево 800	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАКНИНЬ		{"prev_value":["visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_serie: 23\\nvisa_number: 8261572\\nvisa_issued: 2018-09-10 00:00:00\\nvisa_started: 2018-09-10 00:00:00\\nvisa_expired: 2018-12-02 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 25\\nwork_permit_number: 1800003860\\nwork_permit_issued: 2018-09-18 00:00:00\\nwork_permit_started: 2018-09-18 00:00:00\\nwork_permit_expired: 2019-07-14 00:00:00","visa_number: 1349072\\nvisa_issued: 2018-10-26 00:00:00\\nvisa_started: 2018-12-03 00:00:00\\nvisa_expired: 2019-07-14 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2018-09-14 00:00:00","user_ids: 208,209,214\\nemploy_permit_id: 36","reg_date: 2018-11-08","work_permit_number: 1900003895\\nwork_permit_issued: 2019-06-28\\nwork_permit_started: 2019-07-14\\nwork_permit_expired: 2020-07-13","visa_number: 1560787\\nvisa_issued: 2019-07-04\\nvisa_started: 2019-07-15\\nvisa_expired: 2020-07-13\\nreg_date: 2019-07-12","employ_permit_id: 46\\nwork_permit_number: 2000004513\\nwork_permit_issued: 2020-06-08\\nwork_permit_started: 2020-07-13\\nwork_permit_expired: 2021-02-16","visa_number: 1770602\\nvisa_issued: 2020-06-11\\nvisa_started: 2020-07-14\\nvisa_expired: 2021-02-16\\nreg_date: 2020-06-26"],"date":["07.11.2018 14:30:25","24.06.2019 11:02:43","24.06.2019 11:02:58","10.07.2019 16:26:17","10.07.2019 16:27:17","15.05.2020 12:24:54","15.05.2020 12:25:20","23.06.2020 14:21:49","23.06.2020 14:22:56","15.02.2021 11:25:57","15.02.2021 11:27:24"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1989-11-28	2018-05-23	2028-05-23	\N	\N	2021-02-05	2021-02-16	2022-02-15	\N	2018-09-21	\N	\N	\N	2021-02-12	2021-02-17	2022-02-15	2018-09-13	2018-09-13	2021-02-16	\N	232	4	55	1	\N	0	4	2	2	0	2	0	\N	\N
90	C1282750	НГУЕН	ТХИ НГОК АНЬ	232	3	{3,4,2}	1	FEMALE						69	1800003556	5	202401290				23	8259530	4618	9748265		NGUYEN	THI NGOC ANH		Шереметьево 564	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХАНОЙ		{"prev_value":["departure_date: 2018-09-27 00:00:00"],"date":["28.09.2018 23:48:58"],"user":["#208 \\u0420\\u043e\\u0431\\u0435\\u0440\\u0442"]}	1983-07-28	2016-01-15	2026-01-15	\N	\N	2018-07-31	2018-07-31	2019-02-18	\N	2018-09-06	2018-09-28	\N	\N	2018-08-24	2018-08-24	2018-11-11	2018-08-26	2018-08-26	2018-08-28	2018-09-28	232	4	20	1	\N	0	4	2	2	0	2	0	\N	\N
91	C5414628	НГУЕН	ВАН ФУК	232	5	{3,2,4}	1	MALE						69	2000005122	11	202401426		MULTI	WORK	12	1946287	4618	9827727		NGUYEN	VAN PHUC		Шереметьево 800	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАКНИНЬ		{"prev_value":["visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 23\\nvisa_number: 8261247\\nvisa_issued: 2018-09-06 00:00:00\\nvisa_started: 2018-09-06 00:00:00\\nvisa_expired: 2018-12-02 00:00:00","user_ids: 209,214,208\\nemploy_permit_id: 25\\nwork_permit_number: 1800004373\\nwork_permit_issued: 2018-09-26 00:00:00\\nwork_permit_started: 2018-09-26 00:00:00\\nwork_permit_expired: 2019-07-14 00:00:00","visa_number: 1349255\\nvisa_issued: 2018-11-15 00:00:00\\nvisa_started: 2018-12-03 00:00:00\\nvisa_expired: 2019-07-14 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nreg_date: 2018-09-14 00:00:00","user_ids: 208,209,214\\nemploy_permit_id: 36\\noccupation_id: 5","reg_date: 2018-11-20","work_permit_started: 2019-07-14","work_permit_number: 1900003856\\nwork_permit_issued: 2019-06-28\\nwork_permit_started: 2019-07-15\\nwork_permit_expired: 2020-07-13","visa_number: 1560791\\nvisa_issued: 2019-07-04\\nvisa_started: 2019-07-14\\nvisa_expired: 2020-07-13\\nreg_date: 2019-07-12","employ_permit_id: 45\\nwork_permit_number: 2000004496\\nwork_permit_issued: 2019-06-08\\nwork_permit_expired: 2021-01-26\\nhired_date: 2018-10-03","hired_date: 0000-00-00","visa_number: 1770603","visa_issued: 2020-06-11\\nvisa_started: 2020-07-14\\nvisa_expired: 2021-01-26","work_permit_started: 2020-07-15"],"date":["19.11.2018 10:03:48","24.06.2019 11:01:58","24.06.2019 11:02:16","10.07.2019 15:00:43","10.07.2019 15:02:14","15.05.2020 12:05:12","15.05.2020 12:08:00","20.05.2020 12:34:31","23.06.2020 14:05:03","23.06.2020 14:14:58","20.01.2021 17:23:22","20.01.2021 17:28:36","20.01.2021 17:30:57","20.01.2021 17:31:43","21.01.2021 11:38:35"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1995-01-22	2018-07-11	2028-07-11	\N	\N	2020-12-28	2021-01-26	2022-01-25	\N	2021-01-26	\N	\N	\N	2021-01-14	2021-01-27	2022-01-25	2018-09-13	2018-09-13	2020-06-26	\N	232	4	54	6	\N	0	4	2	2	0	2	0	\N	\N
92	ID1026323	САИТКАСИМОВ	ЗАЙЛОБИДИН	115	3	{3,2,4}	1	MALE								82							2019	0078114	ЛАЧИНОВИЧ				ДОМОДЕВО 387	МКК 214041			КЫРГЫЗСКАЯ РЕСПУБЛИКА		{"prev_value":["entry_date: 2018-08-12 00:00:00\\nentry_checkpoint: \\u041c\\u0410\\u0428\\u0422\\u0410\\u041a\\u041e\\u0412\\u041e 87\\nmigr_card_serie: 5317\\nmigr_card_number: 1818708","visa_expired: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 0000-00-00 00:00:00","visa_expired: 2019-05-13 00:00:00","hired_date: 2018-08-22 00:00:00","visa_expired: 2019-08-21 00:00:00\\nreg_date: 2019-02-19 00:00:00","status: WORKER","status: FURLOUGH","fired_date: 0000-00-00 00:00:00","status: FIRED","fired_date: 2019-08-20 00:00:00","visa_expired: 2020-08-20 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","user_ids: 208,209,214\\nhired_date: 2019-08-21 00:00:00","current_passport_number: \\nwork_address: ","current_passport_number: \\nvisa_expired: 2019-08-21 00:00:00\\nentry_date: 2019-02-13 00:00:00\\nmigr_card_serie: 4618\\nmigr_card_number: 02596490\\nmigr_card_issued: 2019-02-13 00:00:00\\nhost: 4\\nreg_date: 2019-04-26 00:00:00","current_passport_number: \\nhired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: FIRED","current_passport_number: \\nemployer_id: 4","current_passport_number: \\nhired_date: 2020-01-14 00:00:00","current_passport_number: \\nreg_date: 2020-01-10 00:00:00","current_passport_number: \\nwork_permit_paid_till: 0000-00-00\\ncontract_number: 3\\nfired_date: 2019-08-20","current_passport_number: \\nstatus: WORKER\\nwork_permit_paid_till: 0000-00-00\\nfired_date: 0000-00-00","current_passport_number: \\nstatus: FIRED\\nhired_date: 2020-01-16\\nfired_date: 2020-03-04","status: WORKER\\nfired_date: 0000-00-00"],"date":["18.02.2019 14:38:06","28.03.2019 11:25:55","23.04.2019 10:30:10","23.04.2019 10:30:34","16.08.2019 11:26:23","16.08.2019 11:27:03","19.08.2019 11:06:44","19.08.2019 12:11:05","19.08.2019 12:11:42","19.08.2019 14:26:58","19.08.2019 14:27:08","19.08.2019 14:27:33","20.08.2019 12:07:36","20.08.2019 12:07:49","26.08.2019 15:17:00","14.01.2020 14:18:05","14.01.2020 14:19:51","14.01.2020 14:20:21","14.01.2020 14:20:26","14.01.2020 14:20:41","16.01.2020 13:15:40","16.01.2020 13:15:52","04.03.2020 10:30:05","04.03.2020 12:38:53","04.03.2020 13:17:37","07.04.2020 12:44:22"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1990-02-25	2019-01-16	2029-01-16	\N	\N	\N	\N	\N	\N	2020-03-05	2020-04-07	\N	\N	\N	\N	\N	2019-12-14	2019-12-14	2020-01-16	\N	115	7	0	5	\N	0	7	2	2	0	0	0	\N	\N
94	C5931785	ДИНЬ	ТХИ ЗЫОНГ	232	5	{3,2,4}	1	FEMALE						69	2100005197	16	202401819		MULTI	WORK	12	1946380	4619	6015715		DINH	THI DUONG		шереметьево 799	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАКНИНЬ		{"prev_value":["visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 23\\nvisa_number: 8995124\\nvisa_issued: 2018-10-29 00:00:00\\nvisa_started: 2018-10-29 00:00:00\\nvisa_expired: 2019-01-18 00:00:00","user_ids: 209,214,208\\nreg_date: 0000-00-00 00:00:00","work_permit_number: 1800004856\\nwork_permit_started: 2018-11-16 00:00:00\\nwork_permit_expired: 2019-07-14 00:00:00","employ_permit_id: 25\\nwork_permit_issued: 2018-11-16 00:00:00\\nwork_permit_started: 2019-07-14 00:00:00","visa_number: 1349715\\nvisa_issued: 2018-12-11 00:00:00\\nvisa_started: 2019-01-19 00:00:00\\nvisa_expired: 2019-07-14 00:00:00","work_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00","visa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00","user_ids: 208,209,214\\nreg_date: 2018-12-20","employ_permit_id: 36","occupation_id: 3\\nwork_address: ","visa_started: 2019-07-14","work_permit_number: 1900003863\\nwork_permit_issued: 2019-06-28\\nwork_permit_started: 2019-07-14\\nwork_permit_expired: 2020-07-13","visa_number: 1560788\\nvisa_issued: 2019-07-04\\nvisa_started: 2019-07-15\\nvisa_expired: 2020-07-13\\nreg_date: 2019-07-12","employ_permit_id: 46\\nwork_permit_number: 2000004520\\nwork_permit_issued: 2020-06-08\\nwork_permit_started: 2020-07-13\\nwork_permit_expired: 2021-02-16","visa_number: 1770604\\nvisa_issued: 2020-06-11\\nvisa_started: 2020-07-14\\nvisa_expired: 2021-02-16\\nreg_date: 2020-06-26"],"date":["20.12.2018 11:20:16","10.06.2019 10:52:25","10.06.2019 11:48:12","24.06.2019 10:59:38","24.06.2019 11:00:05","10.07.2019 14:16:41","10.07.2019 14:17:40","13.05.2020 16:02:25","13.05.2020 16:02:55","15.05.2020 11:39:14","15.05.2020 13:34:09","23.06.2020 13:56:31","23.06.2020 13:57:55","15.02.2021 12:09:47","15.02.2021 12:11:11"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1966-01-01	2018-08-27	2028-08-27	\N	\N	2021-02-05	2021-02-16	2022-02-15	\N	2018-11-28	\N	\N	\N	2021-02-12	2021-02-17	2022-02-15	2018-10-31	2018-10-31	2021-02-16	\N	232	4	55	1	\N	0	4	2	2	0	2	0	\N	\N
95	#3	Мейссер	Наталья	0	4	{3,2}	1	FEMALE																	Александровна										{"prev_value":["","user_ids: 208"],"date":["01.10.2018 22:20:27","01.10.2018 22:25:05"],"user":["#208 \\u0420\\u043e\\u0431\\u0435\\u0440\\u0442","#207 Super User"]}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	8	0	0	\N	0	0	0	0	0	0	0	\N	\N
96	ID1342012	САИТКАСИМОВ	ХУСАН	115	3	{3,2,4}	1	MALE								43							4620	0259014	ЛАЧИНОВИЧ				домодедово 1007	МКК 214041			КЫРГЫЗСТАН		{"prev_value":["citizenship: 229","user_ids: 209,214,208\\nstatus: WORKER","user_ids: 208,209,214\\nstatus: FURLOUGH","fired_date: 0000-00-00 00:00:00","reg_date: 2018-10-15 00:00:00","current_passport_number: \\nstatus: FIRED\\nentry_date: 2018-10-03 00:00:00\\nentry_checkpoint: \\u0420\\u041e\\u0421\\u0421\\u0418\\u042f \\u041a\\u041f\\u041f","current_passport_number: \\npassport_number: AN4510565\\npassport_issuer: \\u041c\\u041a\\u041a 50-32\\npassport_issued: 2016-05-18 00:00:00\\npassport_expired: 2026-05-18 00:00:00","current_passport_number: \\nmigr_card_serie: 5318\\nmigr_card_number: 0621978\\nmigr_card_issued: 2018-10-03 00:00:00\\nreg_date: 2018-10-19 00:00:00","current_passport_number: \\nemployer_id: 4\\nwork_address: \\ncontract_number: 13\\nhired_date: 2018-10-19 00:00:00\\nfired_date: 2019-09-05 00:00:00","current_passport_number: \\nvisa_expired: 0000-00-00 00:00:00\\nmigr_card_serie: 46 20\\nhost: 4\\nreg_date: 2020-02-26 00:00:00","current_passport_number: \\nstatus: SEEKER\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","current_passport_number: \\nreg_date: 0000-00-00 00:00:00","status: WORKER\\nfired_date: 0000-00-00"],"date":["09.01.2019 13:48:28","16.07.2019 11:19:07","05.09.2019 11:07:47","05.09.2019 11:07:59","05.09.2019 12:31:18","26.02.2020 12:29:55","26.02.2020 12:31:50","26.02.2020 12:33:04","27.02.2020 11:21:30","27.02.2020 11:22:20","02.03.2020 12:05:14","02.03.2020 12:06:04","07.04.2020 12:49:34"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-08-18	2019-08-08	2029-08-08	\N	\N	\N	\N	\N	\N	2020-03-02	2020-04-07	\N	\N	\N	\N	2020-05-22	2020-02-23	2020-02-23	2020-02-27	\N	115	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
97	401023937	МАХМУДОВ	НЕЪМАТШЕХ	209	3	{3,2,4}	1	MALE						69	1800103617	12							4618	6304854	МУХАМАДШЕХОВИЧ					ОМВД В Б.ГАФУРОВ					{"prev_value":["migr_card_serie: 4118\\nreg_date: 2018-11-06 00:00:00","visa_expired: 0000-00-00 00:00:00","visa_expired: 2008-04-19 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d\\nvisa_expired: 2019-04-08 00:00:00\\nentry_date: 0000-00-00 00:00:00","work_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-04-04 00:00:00","visa_expired: 0000-00-00 00:00:00","reg_date: 2019-06-05 00:00:00","work_permit_paid_till: 2019-08-06 00:00:00","visa_expired: 2019-08-06 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-07-03 00:00:00","work_permit_issued: 2018-09-06 00:00:00\\nwork_permit_started: 2018-09-06 00:00:00\\nwork_permit_expired: 2019-09-06 00:00:00\\nwork_permit_paid_till: 2019-09-06 00:00:00","visa_expired: 2019-09-06 00:00:00","reg_date: 2019-07-31 00:00:00","work_permit_paid_till: 2019-10-07 00:00:00","reg_date: 2019-09-03 00:00:00","work_permit_paid_till: 2019-11-07 00:00:00","visa_expired: 2019-10-07 00:00:00","reg_date: 2019-09-25 00:00:00","work_permit_paid_till: 2019-12-07 00:00:00","visa_expired: 2019-12-07 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2019-01-07 00:00:00\\nvisa_expired: 2019-01-07 00:00:00\\nreg_date: 2019-10-29 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2019-02-07 00:00:00","current_passport_number: \\nvisa_expired: 2020-02-07 00:00:00","work_permit_paid_till: 2019-03-07","visa_expired: 2020-03-07\\nreg_date: 2019-12-05","status: WORKER\\nfired_date: 0000-00-00","work_address: \\nreg_address: 2","real_address: 2"],"date":["15.01.2019 13:29:31","28.03.2019 11:28:02","29.03.2019 12:38:16","01.04.2019 17:03:26","25.04.2019 11:38:02","25.04.2019 12:25:14","03.07.2019 14:16:52","03.07.2019 14:21:46","03.07.2019 14:22:08","16.07.2019 11:01:08","31.07.2019 13:28:05","31.07.2019 13:28:14","27.08.2019 13:49:38","03.09.2019 11:47:53","03.09.2019 11:48:29","10.09.2019 13:26:25","04.10.2019 12:23:29","04.10.2019 12:23:43","29.10.2019 13:47:22","29.10.2019 13:47:32","04.12.2019 15:05:06","04.12.2019 15:06:54","04.12.2019 15:07:07","24.12.2019 09:54:53","25.02.2020 10:44:59","25.02.2020 10:45:16","18.03.2020 13:30:21","18.03.2020 13:30:51","07.04.2020 12:19:56","07.04.2020 12:20:55","07.04.2020 12:21:28"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1981-10-28	2016-03-30	2026-03-29	\N	\N	2019-09-07	2019-09-07	2020-09-07	2020-04-07	2018-10-19	2020-04-07	\N	\N	\N	\N	2020-04-07	2019-01-11	2019-01-11	2020-03-03	\N	209	4	0	5	\N	0	4	7	7	0	2	0	\N	\N
98	C5578666	ДАО	ВАН ШИНЬ	232	3	{3,2,4}	1	MALE						69	2000004930	20	202402319	011583	MULTI	WORK	12	1771282	4619	6142287		DAO	VAN SINH		шереметьево 615	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТАН"	ХАЙЗЫОНГ		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 23\\nvisa_number: 8998244\\nvisa_issued: 2018-12-25 00:00:00\\nvisa_started: 2018-12-25 00:00:00\\nvisa_expired: 2019-03-23 00:00:00","user_ids: 209,214,208","reg_date: 2018-12-29 00:00:00","work_permit_number: 1900002299\\nwork_permit_issued: 2019-01-18 00:00:00\\nwork_permit_started: 2019-01-18 00:00:00\\nwork_permit_expired: 2019-11-18 00:00:00\\nhired_date: 2019-01-25 00:00:00","visa_serie: 12\\nvisa_number: 1560081\\nvisa_issued: 2019-03-04 00:00:00\\nvisa_started: 2019-03-24 00:00:00\\nvisa_expired: 2019-11-18 00:00:00","employ_permit_id: 30","reg_date: 2019-03-13 00:00:00","visa_serie: 13\\nvisa_number: 0053633\\nvisa_issued: 2019-10-28\\nvisa_started: 2019-11-19\\nvisa_expired: 2020-11-17\\nreg_date: 2019-11-15","employ_permit_id: 39\\nwork_permit_number: 1900004627\\nwork_permit_issued: 2019-10-23\\nwork_permit_started: 2019-11-18\\nwork_permit_expired: 2020-11-17\\nwork_address: \\nhired_date: 2019-11-18","reg_date: 0000-00-00","status: WORKER\\nfired_date: 0000-00-00"],"date":["25.01.2019 12:13:58","13.03.2019 11:47:25","23.09.2019 11:24:52","23.09.2019 11:25:35","01.11.2019 10:47:51","01.11.2019 10:50:07","13.11.2019 15:41:26","18.11.2019 11:04:51","16.11.2020 17:42:32","17.11.2020 10:50:26","17.11.2020 10:51:02","12.04.2021 13:04:50"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1974-05-08	2018-07-13	2028-07-13	\N	\N	2020-10-13	2020-11-17	2021-11-16	\N	2020-11-17	2021-04-12	\N	2016-07-04	2020-11-05	2020-11-18	2021-11-16	2018-12-28	2018-12-28	2020-11-17	\N	232	4	53	1	\N	0	4	2	2	0	2	0	\N	\N
99	C5891217	НГУЕН	ТХИ АНЬ	232	5	{3,2,4}	1	FEMALE						69	2000004947	19		011590	MULTI	WORK	12	1771283	4619	6142288		NGUYEN	THI ANH		шереметьево 615	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТАН"	ХАТИНЬ		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 23\\nvisa_number: 8998243\\nvisa_issued: 2018-12-25 00:00:00\\nvisa_started: 2018-12-25 00:00:00\\nvisa_expired: 2019-03-23 00:00:00","user_ids: 209,214,208\\nreg_date: 2018-12-29 00:00:00","occupation_id: 1","employ_permit_id: 30\\nwork_permit_number: 1900002309\\nwork_permit_issued: 2019-01-18 00:00:00\\nwork_permit_started: 2019-01-18 00:00:00\\nwork_permit_expired: 2019-11-18 00:00:00\\nhired_date: 2019-01-25 00:00:00","visa_serie: 12\\nvisa_number: 1560080\\nvisa_issued: 2019-03-04 00:00:00\\nvisa_started: 2019-03-24 00:00:00\\nvisa_expired: 2019-11-18 00:00:00","visa_expired: 2020-11-11 00:00:00","reg_date: 2019-03-13 00:00:00","visa_serie: 13\\nvisa_number: 0053632\\nvisa_issued: 2019-10-28\\nvisa_started: 2019-11-19\\nvisa_expired: 2020-11-17\\nreg_date: 2019-11-15","employ_permit_id: 39\\nwork_permit_number: 1900004634\\nwork_permit_issued: 2019-10-23\\nwork_permit_started: 2019-11-18\\nwork_permit_expired: 2020-11-17\\nwork_address: \\nhired_date: 2019-11-18","reg_date: 0000-00-00"],"date":["25.01.2019 12:09:20","13.03.2019 11:33:55","23.09.2019 12:07:37","09.10.2019 12:31:08","13.11.2019 15:46:21","13.11.2019 15:48:02","14.11.2019 13:50:45","18.11.2019 11:16:58","16.11.2020 17:40:31","17.11.2020 10:13:51","17.11.2020 10:15:46"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-01-20	2018-08-16	2028-08-16	\N	\N	2020-10-13	2020-11-17	2021-11-16	\N	2020-11-17	\N	\N	2016-07-04	2020-11-05	2020-11-18	2021-11-16	2018-12-28	2018-12-28	2020-11-17	\N	232	4	53	4	\N	0	4	2	2	0	2	0	\N	\N
100	C5984381	ХОАНГ	НГОК КИМ	232	8	{3,2,4}	1	MALE										011594								HOANG	NGOC KIM			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТАН"	ИЕНБАЙ		{"prev_value":["","user_ids: 209,214,208\\nstatus: SEEKER"],"date":["19.11.2018 12:45:21","11.09.2019 14:31:22"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-06-10	2018-08-28	2028-08-28	\N	\N	\N	\N	\N	\N	\N	\N	\N	2016-07-04	\N	\N	\N	\N	\N	\N	\N	232	4	30	1	\N	0	4	2	2	0	0	0	\N	\N
135	401927161	ХОЧАЕВА	МАМЛАКАТ	209	3	{2,3,4}	1	FEMALE						69	1900006487	9							4618	6304855	ИКРОМЧОНОВНА				РАМЕНСКОЕ 059				ТАДЖИКИСТАН		{"prev_value":["reg_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["07.02.2019 15:00:48","01.04.2019 17:05:06","24.04.2019 11:22:39","29.04.2019 14:34:59","29.04.2019 14:35:39"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1975-07-25	2018-02-01	2028-01-31	\N	\N	2019-02-06	2019-02-06	2019-04-10	2019-04-04	2019-02-07	2019-04-30	\N	\N	\N	\N	\N	2019-01-11	2019-01-11	2019-04-09	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
101	750733	РЕПИНА	АЛЕКСАНДРА	177	3	{2,3,4}	1	FEMALE	97 09							16									ВИТАЛЬЕВНА					ОТДЕЛОМ УФМС РОССИИ ПО ЧУВАШСКОЙ РЕСПУБЛИКЕ В КАЛИНИНСКОМ РАЙОНЕ ГОР.ЧЕБОКСАРЫ			С.АМАНБУКТЕР САРКАНДСКОГО Р-НА ТАЛДЫ-КУРГАНСКОЙ ОБЛ. КАЗАХСКОЙ ССР	Тверская обл.,Кимрский р-он ,пос.Белый городок ,ул.Главная д.22,кв.3	{"prev_value":["reg_address: ","user_ids: 209,214,208\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","fired_date: 2019-08-02 00:00:00"],"date":["13.12.2018 13:28:52","14.08.2019 11:45:25","14.08.2019 11:45:40","14.08.2019 12:03:24"],"user":["#208 \\u041d\\u0430\\u043c","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1975-03-21	2009-09-09	\N	\N	\N	\N	\N	\N	\N	2018-11-08	2019-08-16	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	4	0	1	\N	423101000750	0	12	0	0	0	0	\N	\N
102	621829	КОЗЛОВ	АЛЕКСАНДР	177	5	{3,2}	1	MALE	28 02																ИВАНОВИЧ					ОВД КИМРСКОГО РАЙОНА ТВЕРСКОЙ ОБЛАСТИ			ДЕР.ФИЛИППОВО КИМРСКОГО Р-НА ТВЕРСКОЙ ОБЛАСТИ	г.Кимры ,ул.50 Лет ВЛКСМ д.28,кв.87	{"prev_value":["user_ids: 209,208\\naddress: "],"date":["21.11.2018 11:34:31"],"user":["#209 \\u042e\\u043b\\u044f"]}	1951-02-12	2002-05-22	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	0	0	\N	0	0	0	0	0	0	0	\N	\N
103	229995	НИКОНОВ	ВЛАДИМИР	177	5	{3,2}	1	MALE	28 00																МИХАЙЛОВИЧ					ОВД КИМРСКОГО РАЙОНА ТВЕРСКОЙ ОБЛАСТИ			ГОР.КИМРЫ	гор.Кимры,ул.Ульяновская д.22а	{"prev_value":["address: "],"date":["21.11.2018 11:35:26"],"user":["#209 \\u042e\\u043b\\u044f"]}	1952-09-03	2000-12-30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	0	0	\N	0	1	0	0	0	0	0	\N	\N
104	400802416	ХОШИМОВА	МАНЗУРА	209	3	{2,3,4}	1	FEMALE						69	1800126808	15							46 18	2013962	ГАФОРОВНА				ДОМОДЕВО 1400	ПРС В ХУДЖАНД			ТАДЖИКИСТАН		{"prev_value":["visa_expired: 0000-00-00 00:00:00","visa_expired: 2019-03-23 00:00:00\\nreg_date: 2019-01-15 00:00:00","user_ids: 209,214,208\\nwork_permit_paid_till: 0000-00-00 00:00:00","visa_expired: 2019-04-23 00:00:00\\nreg_date: 2019-02-22 00:00:00","work_permit_paid_till: 2019-05-23 00:00:00","reg_date: 2019-03-19 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2019-04-19 00:00:00"],"date":["25.02.2019 11:17:36","19.03.2019 10:47:03","19.04.2019 11:00:10","19.04.2019 11:00:42","20.05.2019 13:26:39","20.05.2019 13:27:18","07.06.2019 10:29:15","07.06.2019 10:29:40","07.06.2019 10:31:20"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-10-06	2015-09-17	2025-09-16	\N	\N	2018-11-23	2018-11-23	2019-11-23	2019-06-23	2018-11-28	2019-06-07	2018-11-13	\N	\N	\N	\N	2018-10-17	2018-10-17	2019-05-22	\N	209	4	0	1	\N	692701670057	4	2	2	0	2	0	\N	\N
105	N1789540	НГУЕН	ФЫОНГ НАМ	232	5	{3,2}	1	MALE			82	0261656				5а										NQUYEN	PHUONG NAM			ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ	RESIDENT_CARD		ХАТИНЬ		{"prev_value":["resident_document: \\nresident_document_serie: \\nresident_document_number: \\nresident_document_issuer: \\nresident_document_issued: 0000-00-00 00:00:00\\nresident_document_expired: 0000-00-00 00:00:00","user_ids: 209,208\\nresident_document_issuer: 2"],"date":["28.11.2018 15:18:02","15.03.2019 10:37:12"],"user":["#209 \\u042e\\u043b\\u044f","#208 \\u041d\\u0430\\u043c"]}	1967-03-07	2016-09-19	2026-09-19	2012-04-16	2022-04-05	\N	\N	\N	\N	2018-09-03	\N	\N	\N	\N	\N	\N	\N	\N	2017-01-25	\N	232	4	0	27	\N	0	4	11	0	0	0	0	\N	\N
106	AN4101442	ТОХТАМИРЗАЕВ	ИСМАИЛХОДЖА	115	3	{2,3,4}	1	MALE								17							4118	0183642	РОЗУБАЕВИЧ					МКК 50-43			КЫРГЫЗСТАН		{"prev_value":["fired_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nstatus: FIRED","status: WORKER"],"date":["09.01.2019 11:55:50","13.06.2019 10:58:10","13.06.2019 10:58:53"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1998-07-21	2015-03-02	2025-03-02	\N	\N	\N	\N	\N	\N	2018-12-04	2019-01-09	\N	\N	\N	\N	\N	2018-11-24	2018-11-24	2018-11-30	\N	0	4	0	1	\N	0	4	12	2	0	0	0	\N	\N
107	AC2649184	ЗАЙНАБИДИНОВ	ИСОМИДДИН	115	3	{2,3,4}	1	MALE								18							5318	0520366						ГОСУДАРСТВЕННАЯ РЕГИСТРАЦИОННАЯ СЛУЖБА			КЫРГЫЗСКАЯ РЕСПУБЛИКА		{"prev_value":["fired_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\ncitizenship: "],"date":["09.01.2019 12:11:26","16.04.2019 09:18:00"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	1998-06-25	2015-12-09	2025-12-09	\N	\N	\N	\N	2019-12-06	\N	2018-12-10	2019-01-09	\N	\N	\N	\N	\N	2018-11-27	2018-11-27	\N	\N	0	4	0	2	\N	0	4	2	2	0	0	0	\N	\N
108	AA5744125	БУРХАНОВА	ГУЛАСАРХОН	229	3	{3,2,4}	1	FEMALE						69	1900001707	5							4618	3095943	ПУЛАТБОЕВНА				ДОМОДЕВО 347	1-отдел милиции города Андижан Андижанской области			ГОРОД АНДИЖАН		{"prev_value":["work_permit_expired: 2019-01-15 00:00:00","visa_expired: 0000-00-00 00:00:00","reg_date: 2018-12-11 00:00:00","departure_date: 0000-00-00 00:00:00","status: WORKER","departure_date: 2019-03-22 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2020-01-15 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00","status: FURLOUGH","status: WORKER\\ndeparture_date: 2019-03-24 00:00:00\\nvisa_expired: 2019-04-16 00:00:00\\nentry_date: 2018-12-08 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: 4518\\nmigr_card_number: 1074156\\nmigr_card_issued: 2018-12-08 00:00:00\\nreg_date: 2019-03-05 00:00:00","status: FURLOUGH","work_permit_paid_till: 2019-06-16 00:00:00","visa_expired: 2019-08-13 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_paid_till: 2019-07-16 00:00:00","visa_expired: 2019-07-16 00:00:00","work_permit_paid_till: 2019-08-16 00:00:00","reg_date: 2019-06-13 00:00:00","visa_expired: 2019-08-16 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-09-16 00:00:00\\nreg_date: 2019-07-09 00:00:00"],"date":["22.01.2019 14:50:24","12.03.2019 13:17:37","12.03.2019 13:18:49","24.03.2019 20:59:51","25.03.2019 12:50:19","25.03.2019 12:50:28","05.06.2019 12:28:31","05.06.2019 12:28:40","05.06.2019 12:31:58","05.06.2019 12:38:28","17.06.2019 10:44:29","17.06.2019 10:44:48","28.06.2019 11:07:38","16.07.2019 10:36:27","16.07.2019 10:36:38","07.08.2019 13:31:20","07.08.2019 13:31:37","07.08.2019 14:00:56","26.08.2019 11:08:00","26.08.2019 11:08:15","26.08.2019 11:08:36"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1970-02-20	2014-06-13	2024-06-12	\N	\N	2019-01-16	2019-01-16	2020-01-16	2019-09-16	2019-01-23	2019-08-26	2017-02-03	\N	\N	\N	\N	2019-05-16	2019-05-16	2019-08-08	\N	229	7	0	1	\N	331604730009	7	2	2	0	2	0	\N	\N
109	AB4356912	УМУРЗАКОВА	САИДАХОН	229	8	{3,4,2}	1	FEMALE															4518	1074160											{"prev_value":["status: SEEKER"],"date":["14.01.2019 13:42:52"],"user":["#209 \\u042e\\u043b\\u044f"]}	1991-06-06	2016-07-05	2026-07-04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2018-12-08	2018-12-08	\N	2018-12-28	229	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
160	401311548	ДАДАБАЕВА	МАНЗУРА	209	6	{3,4,2}	1	FEMALE															4618	6416947	МАХСУДБОЕВНА				РАМЕНСКОЕ 057						{"prev_value":["","employer_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","status: SEEKER","fired_date: 0000-00-00 00:00:00"],"date":["29.04.2019 12:33:36","29.04.2019 12:33:57","29.04.2019 12:35:46","13.05.2019 11:01:55","13.05.2019 11:02:09"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1972-04-13	2017-01-12	2027-01-11	\N	\N	\N	\N	\N	\N	\N	2019-05-13	\N	\N	\N	\N	\N	2019-04-25	2019-04-25	2019-04-29	\N	209	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
110	AA1199223	СОДИКОВА	ЖАМИЛАХОН	229	3	{2,3,4}	1	FEMALE						69	1900001841	3							4518	1074153	ТУРСУНОВНА					ОВД Алтынкульского района Андижанской области			АНДИЖАН		{"prev_value":["work_permit_expired: 2020-01-16 00:00:00","visa_expired: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_paid_till: 0000-00-00 00:00:00","reg_date: 2018-12-11 00:00:00","visa_expired: 2019-04-16 00:00:00","work_permit_paid_till: 2019-05-16 00:00:00","reg_date: 2019-04-12 00:00:00","work_permit_paid_till: 2019-06-16 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER","reg_date: 2019-04-26 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["22.01.2019 14:08:43","12.03.2019 13:16:48","11.04.2019 10:14:34","11.04.2019 10:15:17","15.04.2019 10:05:26","07.06.2019 12:26:46","07.06.2019 12:27:44","17.06.2019 10:46:56","17.06.2019 10:47:08","02.07.2019 11:27:48","02.07.2019 11:28:17","02.07.2019 11:28:34"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1988-06-04	2013-04-09	2023-04-08	\N	\N	2019-01-16	2019-01-16	2020-01-15	2019-07-16	2019-01-23	2019-07-02	\N	\N	\N	\N	2019-07-16	2018-12-08	2018-12-08	2019-06-13	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
111	AA0703876	БУРХОНОВ	АДХАМЖОН	229	3	{2,3,4}	1	MALE						69	1900001714	6							4518	1075606	СУЛТОНОВИЧ				ВНУКОВО 228	Андижанский 1-городской отдел милиции Андижанской области			ГОРОД АНДИЖАН		{"prev_value":["reg_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 2018-12-11 00:00:00","user_ids: 209,214,208\\nwork_permit_paid_till: 0000-00-00 00:00:00","visa_expired: 2019-04-16 00:00:00\\nentry_checkpoint: \\nreg_date: 2019-03-05 00:00:00","status: WORKER","work_permit_paid_till: 2019-05-16 00:00:00","reg_date: 2019-04-12 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["22.01.2019 14:44:54","12.03.2019 13:32:27","11.04.2019 11:14:19","11.04.2019 11:15:27","07.06.2019 11:40:02","07.06.2019 11:40:44","07.06.2019 11:41:27","09.07.2019 14:07:05"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1968-02-03	2013-01-19	2023-01-18	\N	\N	2019-01-16	2019-01-16	2020-01-15	2019-06-16	2019-01-23	2019-06-07	2018-12-18	\N	\N	\N	\N	2018-12-08	2018-12-08	2019-06-26	\N	229	7	0	1	\N	692701671406	7	2	2	0	2	0	\N	\N
112	C6397660	НГУЕН 	ТОАН ЧУНГ	232	3	{3,4,2}	1	MALE						69	1900002490	22	202402326	003124835	SINGLE	WORK	23	8999413	4619	6323384		NGUYEN	TOAN TRUNG		Шереметьево 825	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ХАНОЙ		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","departure_date: 0000-00-00 00:00:00\\nbirth_date: 1990-06-28 00:00:00\\npassport_issued: 2018-11-22 00:00:00\\npassport_expired: 2028-11-22 00:00:00\\nwork_permit_issued: 2019-02-08 00:00:00\\nwork_permit_started: 2019-02-08 00:00:00\\nwork_permit_expired: 2019-04-17 00:00:00\\nhired_date: 2019-02-19 00:00:00\\ncert_issued: 2010-06-30 00:00:00\\nvisa_issued: 2019-01-24 00:00:00\\nvisa_started: 2019-01-24 00:00:00\\nvisa_expired: 2019-04-17 00:00:00\\nentry_date: 2019-01-28 00:00:00\\nmigr_card_issued: 2019-01-28 00:00:00\\nreg_date: 2019-01-29 00:00:00","visa_issued: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00","birth_date: 0000-00-00 00:00:00\\npassport_issued: 0000-00-00 00:00:00\\npassport_expired: 0000-00-00 00:00:00","work_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00\\nfired_date: 0000-00-00 00:00:00","status: WORKER","departure_date: 2019-03-13 00:00:00\\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","departure_date: 0000-00-00 00:00:00","cert_issued: 0000-00-00 00:00:00","departure_date: 2019-03-13 00:00:00","departure_date: 0000-00-00 00:00:00"],"date":["19.02.2019 12:54:28","12.03.2019 22:46:54","13.03.2019 13:25:12","13.03.2019 13:28:19","13.03.2019 13:30:48","13.03.2019 13:31:01","13.03.2019 13:37:50","13.03.2019 16:13:55","13.03.2019 16:30:00","13.03.2019 16:34:24","13.03.2019 16:35:04"],"user":["#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#214 \\u0427\\u044d\\u043d","#208 \\u041d\\u0430\\u043c","#214 \\u0427\\u044d\\u043d","#214 \\u0427\\u044d\\u043d"]}	1990-06-28	2018-11-22	2028-11-22	\N	\N	2019-02-08	2019-02-08	2019-12-01	\N	2019-02-19	2019-03-13	\N	2010-06-30	2019-01-24	2019-01-24	2019-04-17	2019-01-28	2019-01-28	2019-01-29	2019-03-13	232	4	31	1	\N	0	4	2	2	0	2	0	\N	\N
113	C5972751	ВУ	ХЫУ ХУАН	232	3	{2,3,4}	1	MALE						69	1900002475	21	202402324	011484	SINGLE	WORK	12	1560238	4619	6323383		VU	HUU HUAN		Шереметьево 825	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТУАН"	БАКНИНЬ		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nvisa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_serie: 23\\nvisa_number: 8999224\\nvisa_issued: 2019-01-24 00:00:00\\nvisa_started: 2019-01-24 00:00:00\\nvisa_expired: 2019-04-17 00:00:00\\nreg_date: 2019-01-29 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","reg_date: 2019-04-12 00:00:00","user_ids: 209,208,214\\nfired_date: 0000-00-00 00:00:00"],"date":["19.02.2019 12:48:35","11.04.2019 12:32:53","06.11.2019 13:12:44","06.11.2019 13:13:41","03.12.2019 23:52:56"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	1998-11-02	2018-09-14	2028-09-14	\N	\N	2019-02-08	2019-02-08	2019-12-01	\N	2019-02-19	2019-11-04	\N	2016-07-04	2019-03-26	2019-04-18	2019-12-01	2019-01-28	2019-01-28	2019-04-17	\N	232	4	31	1	\N	0	4	2	2	0	2	0	\N	\N
114	B9603571	НГУЕН	ВАН ШОН	232	6	{3,4,2}	1	MALE									202402325	003125022	SINGLE	WORK	23	8999225	4619	6323385		NGUYEN	VAN SON		Шереметьево 825	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	НГЕАН		{"prev_value":["departure_date: 0000-00-00 00:00:00"],"date":["19.02.2019 12:44:04"],"user":["#209 \\u042e\\u043b\\u044f"]}	1983-10-22	2014-09-23	2024-09-23	\N	\N	\N	\N	2019-04-17	\N	\N	\N	\N	2011-06-30	2019-01-24	2019-01-24	2019-04-17	2019-01-28	2019-01-28	2019-01-29	2019-02-19	232	4	31	4	\N	0	4	2	2	0	0	0	\N	\N
115	AA7438786	АБДУРАХМОНОВА	ОДИНАХОН	229	3	{3,4,2}	1	FEMALE						69	1900001601	4							4518	1081209						ОВД Булакбашинского района Андижанской области			ГОРОД АНДИЖАН		{"prev_value":["work_permit_expired: 2019-01-15 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["22.01.2019 14:56:46","01.03.2019 14:42:18","01.03.2019 14:44:34"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-10-19	2014-11-03	2024-11-02	\N	\N	2019-01-16	2019-01-16	2020-01-15	\N	2019-01-23	2019-02-28	2018-12-19	\N	\N	\N	\N	2018-12-08	2018-12-08	2018-12-11	\N	229	7	0	1	\N	692701671646	7	2	2	0	2	0	\N	\N
116	C6377062	ДО	ЧЫОНГ ЗАНГ	232	8	{3,2,4}	1	MALE										003124838								DO	TRUONG GIANG			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	НИНЬБИНЬ		{"prev_value":["host: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER"],"date":["24.12.2018 11:06:54","11.09.2019 14:31:03"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1978-01-06	2018-11-28	2028-11-28	\N	\N	\N	\N	\N	\N	\N	\N	\N	2010-06-30	\N	\N	\N	\N	\N	\N	\N	232	4	31	1	\N	0	4	2	2	0	0	0	\N	\N
117	C6377065	НГУЕН	ТХИ ТУ	232	8	{3,2,4}	1	FEMALE																		NGUYEN	THI TU			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			НИНЬБИНЬ		{"prev_value":["employer_id: \\nemploy_permit_id: \\noccupation_id: ","user_ids: 209,214,208\\nstatus: SEEKER"],"date":["24.12.2018 11:07:22","11.09.2019 14:31:12"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-04-04	2018-11-28	2028-11-28	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	4	31	1	\N	0	4	2	2	0	0	0	\N	\N
118	AA2539987	ХАМДАМХУЖАЕВ	АХМАДУЛЛО	229	3	{3,2,4}	1	MALE						69	1900008082	21							4519	0143134					ВНУКОВО 241	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_expired: 2019-04-14 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2019-04-04 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-01-06 00:00:00","reg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-07-12 00:00:00","visa_expired: 2019-07-12 00:00:00","status: WORKER","departure_date: 0000-00-00 00:00:00","user_ids: 208,209,214\\nwork_permit_paid_till: 2019-08-12 00:00:00","status: FURLOUGH","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-08-12 00:00:00\\nreg_date: 2019-04-26 00:00:00"],"date":["14.02.2019 17:04:38","01.04.2019 17:08:54","09.04.2019 10:33:13","09.04.2019 10:33:26","07.06.2019 12:46:29","13.06.2019 09:33:24","13.06.2019 09:33:36","16.07.2019 10:37:43","16.07.2019 10:37:52","09.08.2019 09:12:52","09.08.2019 09:13:09","10.09.2019 13:10:29","17.09.2019 15:00:36","17.09.2019 15:00:54","17.09.2019 15:01:40"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1996-11-14	2013-08-10	2023-08-09	\N	\N	2019-02-12	2019-02-12	2020-02-12	2019-09-12	2019-02-14	2019-09-13	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-07-10	2019-08-09	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
119	AA4166311	ТОШМАТОВА	ОКИТАХОН	229	3	{2,3,4}	1	FEMALE						69	1900009167	23							4519	0123649					ВНУКОВО 254	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-01-06 00:00:00","reg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-05-14 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER","visa_expired: 2019-07-14 00:00:00\\nreg_date: 2019-04-26 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["19.02.2019 14:01:34","01.04.2019 17:08:38","09.04.2019 10:53:33","09.04.2019 10:53:43","07.06.2019 12:43:45","17.06.2019 10:46:11","17.06.2019 10:46:27","16.07.2019 11:23:42","16.07.2019 11:25:30","16.07.2019 11:26:28"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1966-08-16	2014-02-05	2024-02-04	\N	\N	2019-02-14	2019-02-14	2020-02-14	2019-07-14	2019-02-19	2019-07-14	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-06-13	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
120	AB7935777	АШУРАЛИЕВ	АЛИШЕР	229	3	{3,4,2}	1	MALE						69	1900007890	13							4519	0143130					ВНУКОВО 241	Государственный центр персонализации			УЗБЕКИСТАН		{"prev_value":["work_permit_expired: 2020-02-12 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00"],"date":["14.02.2019 16:38:40","12.03.2019 11:59:15"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1999-04-14	2017-10-20	2027-10-19	\N	\N	2019-02-12	2019-02-12	2019-04-04	\N	2019-02-14	2019-03-12	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-01-06	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
121	AB4226252	БЕГИЖОНОВА	МАВЛУДА	229	3	{3,2,4}	1	FEMALE						69	1900007924	16							4519	0111489					ВНУКОВО 237	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_expired: 2019-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2019-04-04 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","migr_card_issued: 2019-01-05 00:00:00","reg_date: 2019-01-06 00:00:00","reg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-06-12 00:00:00","visa_expired: 2019-06-12 00:00:00","work_permit_paid_till: 2019-07-12 00:00:00","visa_expired: 2019-07-12 00:00:00","work_permit_paid_till: 2019-08-12 00:00:00","visa_expired: 2019-08-12 00:00:00\\nreg_date: 2019-04-26 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-09-12 00:00:00\\nreg_date: 2019-07-09 00:00:00","user_ids: 209,208,214\\nmigr_card_issued: 2019-04-03 00:00:00"],"date":["14.02.2019 16:57:17","01.04.2019 17:06:09","09.04.2019 10:23:08","09.04.2019 10:23:35","25.04.2019 11:03:35","07.06.2019 12:33:50","13.06.2019 09:28:00","13.06.2019 09:28:16","13.06.2019 09:29:12","13.06.2019 09:29:21","16.07.2019 10:37:01","16.07.2019 10:37:08","07.08.2019 14:01:08","07.08.2019 14:01:40","26.08.2019 10:43:29","26.08.2019 10:43:45","26.08.2019 10:44:23","26.08.2019 11:45:15"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1998-07-28	2016-06-22	2026-06-21	\N	\N	2019-02-12	2019-02-12	2020-02-12	2019-09-12	2019-02-14	2019-08-26	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-08-08	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
122	AB6790709	НОМОЗОВА	НАРГИЗАХОН	229	3	{3,2,4}	1	FEMALE						69	1900009142	22							4519	0111490	СОЛИЕВНА				ВНУКОВО 237	ОВД Андижанского района Андижанской области 			Андижанский район		{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-01-06 00:00:00","hired_date: 2019-02-19 00:00:00","hired_date: 2019-05-19 00:00:00","reg_date: 2019-04-03 00:00:00","birth_place: \\u0423\\u0417\\u0411\\u0415\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","birth_place: \\u0410\\u043d\\u0434\\u0438\\u0436\\u0430\\u043d\\u0441\\u043a\\u0430\\u044f \\u0440\\u0430\\u0439\\u043e\\u043d","work_permit_paid_till: 2019-02-14 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-07-14 00:00:00","visa_expired: 2019-07-14 00:00:00\\nreg_date: 2019-04-26 00:00:00","work_permit_paid_till: 2019-08-14 00:00:00","visa_expired: 2019-08-14 00:00:00","user_ids: 208,209,214\\nstatus: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-09-14 00:00:00\\nreg_date: 2019-07-09 00:00:00"],"date":["19.02.2019 13:47:59","01.04.2019 17:07:02","09.04.2019 10:52:24","09.04.2019 10:52:35","09.04.2019 10:52:57","12.04.2019 14:35:06","07.06.2019 12:42:14","10.06.2019 10:45:55","13.06.2019 11:16:37","17.06.2019 10:47:41","17.06.2019 10:48:06","16.07.2019 10:33:37","16.07.2019 10:34:07","07.08.2019 16:15:22","07.08.2019 16:15:38","26.08.2019 11:21:55","26.08.2019 11:22:08","26.08.2019 11:22:53"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1975-08-13	2017-05-25	2027-05-25	\N	\N	2019-02-14	2019-02-14	2020-02-14	2019-09-14	2019-02-19	2019-08-26	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-08-08	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
123	AB3834393	БАЗАРОВА	ХУРИЯТХОН	229	3	{3,2,4}	1	FEMALE						69	1900007917	15							4519	0143129					ВНУКОВО 241	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_started: 2019-04-04 00:00:00\\nwork_permit_expired: 2020-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_started: 2019-02-12 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","work_permit_expired: 2019-04-04 00:00:00","reg_date: 2019-01-06 00:00:00","reg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-07-12 00:00:00","visa_expired: 2019-07-12 00:00:00\\nreg_date: 2019-05-08 00:00:00","work_permit_paid_till: 2019-08-12 00:00:00","visa_expired: 2019-08-12 00:00:00","user_ids: 208,209,214\\nwork_permit_paid_till: 2019-09-12 00:00:00","visa_expired: 2019-09-12 00:00:00\\nreg_date: 2019-07-09 00:00:00","work_permit_paid_till: 2019-10-12 00:00:00","reg_date: 2019-09-05 00:00:00","visa_expired: 2019-10-12 00:00:00","work_permit_paid_till: 2019-11-12 00:00:00","visa_expired: 2019-11-12 00:00:00","work_permit_paid_till: 2019-12-12 00:00:00","visa_expired: 2019-12-12 00:00:00\\nreg_date: 2019-10-03 00:00:00","work_permit_paid_till: 2019-01-12 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2020-01-12 00:00:00\\nvisa_expired: 2020-01-12 00:00:00","current_passport_number: \\nwork_permit_issued: 2019-02-12 00:00:00\\nwork_permit_started: 2019-04-04 00:00:00\\nwork_permit_expired: 2020-02-12 00:00:00\\nwork_permit_paid_till: 2020-02-12 00:00:00\\nwork_address: ","current_passport_number: \\nvisa_expired: 2020-02-12 00:00:00\\nreg_date: 2019-10-29 00:00:00","current_passport_number: ","work_permit_paid_till: 2020-03-13","visa_expired: 2020-03-12\\nreg_date: 2020-02-11","work_permit_paid_till: 2020-04-12","visa_expired: 2020-04-12","work_permit_paid_till: 2020-05-12","visa_expired: 2020-05-12\\nreg_date: 2020-03-04","work_permit_paid_till: 2020-06-12","visa_expired: 2020-06-12\\nreg_date: 2020-04-09","reg_date: 2020-04-28","fired_date: 0000-00-00","status: WORKER"],"date":["14.02.2019 16:56:48","01.04.2019 17:05:57","09.04.2019 10:20:06","09.04.2019 10:20:55","09.04.2019 10:22:26","07.06.2019 12:31:36","13.06.2019 09:30:04","13.06.2019 09:30:16","16.07.2019 10:35:49","16.07.2019 10:36:09","07.08.2019 15:38:29","07.08.2019 15:38:50","10.09.2019 13:07:00","10.09.2019 13:07:25","04.10.2019 12:09:19","04.10.2019 12:09:37","07.10.2019 12:52:18","29.10.2019 14:15:22","29.10.2019 14:15:30","04.12.2019 16:08:59","04.12.2019 16:09:30","04.12.2019 16:09:41","24.12.2019 16:09:08","11.02.2020 15:29:02","11.02.2020 15:30:46","11.02.2020 15:32:25","18.03.2020 12:54:45","18.03.2020 12:55:08","07.04.2020 11:53:57","07.04.2020 13:23:02","27.04.2020 13:43:33","27.04.2020 13:43:58","01.06.2020 11:14:01","01.06.2020 11:14:55","08.07.2020 14:28:02","08.07.2020 14:29:58","08.07.2020 14:30:10"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1988-09-01	2016-05-04	2026-05-03	\N	\N	2020-02-13	2020-02-13	2021-02-13	2020-07-13	2019-02-14	2020-07-08	\N	\N	\N	\N	2020-07-13	2019-01-05	2019-01-05	2020-06-10	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
125	AC3189470	ТОКТАМИРЗАЕВ	АДИЛЖАН	115	3	{3,2,4}	1	MALE								2							4618	6459115					РАМЕНСКОЕ 097	ГОСУДАРСТВЕННАЯ РЕГИСТРАЦИОННАЯ СЛУЖБА			КЫРГЫЗСКАЯ РЕСПУБЛИКА		{"prev_value":["reg_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nstatus: WORKER\\ndeparture_date: 0000-00-00 00:00:00","status: FURLOUGH","departure_date: 2019-05-17 00:00:00\\nentry_date: 2019-01-05 00:00:00\\nentry_checkpoint: \\u0414\\u041e\\u041c\\u041e\\u0414\\u0415\\u0412\\u041e 1446\\nmigr_card_number: 2417589\\nmigr_card_issued: 2019-01-05 00:00:00\\nreg_date: 2019-01-06 00:00:00","user_ids: 208,209,214\\ncurrent_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: WORKER","current_passport_number: \\nreg_date: 0000-00-00 00:00:00","current_passport_number: \\npassport_issuer: "],"date":["14.01.2019 13:50:41","16.05.2019 14:06:00","13.06.2019 10:03:17","13.06.2019 10:57:56","21.01.2020 14:29:40","21.01.2020 14:29:48","21.01.2020 14:30:15","21.01.2020 15:05:17"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1989-12-21	2018-02-20	2028-02-20	\N	\N	\N	\N	2020-01-13	\N	2019-01-14	2020-01-20	\N	\N	\N	\N	\N	2019-06-11	2019-06-11	2019-06-13	\N	115	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
126	AA7715349	КАМАЛОВА	ШАХНОЗАХОН	229	3	{3,2,4}	1	FEMALE						69	1900007995	17							4519	0123653	КАХРАМАНЖАНОВНА				ВНУКОВО 254	Андижанский 2-городской отдел милиции Андижанской области			УЗБЕКИСТАН		{"prev_value":["work_permit_expired: 2020-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2019-04-04 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-01-09 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00","reg_date: 2019-04-03 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-06-12 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2019-04-26 00:00:00","user_ids: 208,209,214\\nvisa_expired: 2019-07-12 00:00:00"],"date":["14.02.2019 16:58:29","01.04.2019 17:06:28","09.04.2019 10:24:49","09.04.2019 10:25:18","07.06.2019 12:21:46","07.06.2019 12:22:07","10.06.2019 10:36:54","13.06.2019 09:36:22","02.07.2019 11:32:37","02.07.2019 11:32:49","02.07.2019 11:33:13","06.09.2019 12:33:19"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-11-04	2014-11-26	2024-11-25	\N	\N	2019-02-12	2019-02-12	2020-02-12	2019-07-12	2019-02-14	2019-07-02	\N	\N	\N	\N	\N	2019-01-05	2019-01-05	2019-06-11	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
127	AA7084618	КАМБАРОВА	ШАХНОЗАХОН	229	3	{3,2,4}	1	FEMALE						69	1900008004	18							4519	0143132					ВНУКОВО 241	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_expired: 2020-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2019-04-04 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-01-09 00:00:00","birth_place: \\u0423\\u0417\\u0411\\u0415\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","reg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-06-12 00:00:00","work_permit_paid_till: 2019-07-12 00:00:00","visa_expired: 2019-07-12 00:00:00\\nreg_date: 2019-04-26 00:00:00","work_permit_paid_till: 2019-08-12 00:00:00","visa_expired: 2019-08-12 00:00:00","user_ids: 208,209,214\\nwork_permit_paid_till: 2019-09-12 00:00:00","visa_expired: 2019-09-12 00:00:00\\nreg_date: 2019-07-09 00:00:00","work_permit_paid_till: 2019-10-12 00:00:00","reg_date: 2019-09-05 00:00:00","visa_expired: 2019-10-12 00:00:00","work_permit_paid_till: 2019-11-12 00:00:00","visa_expired: 2019-11-12 00:00:00","work_permit_paid_till: 2019-12-12 00:00:00","visa_expired: 2019-12-12 00:00:00\\nreg_date: 2019-10-03 00:00:00","work_permit_paid_till: 2019-01-12 00:00:00","visa_expired: 2019-01-12 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2020-01-12 00:00:00","current_passport_number: \\nvisa_expired: 2020-01-12 00:00:00","current_passport_number: \\nwork_permit_issued: 2019-02-12 00:00:00\\nwork_permit_started: 2019-02-12 00:00:00\\nwork_permit_expired: 2020-02-12 00:00:00\\nwork_permit_paid_till: 2020-02-12 00:00:00\\nwork_address: ","current_passport_number: \\nreg_date: 2019-10-29 00:00:00","current_passport_number: \\nwork_permit_issued: 2020-02-13 00:00:00","current_passport_number: \\nvisa_expired: 2020-02-12 00:00:00","work_permit_paid_till: 2020-03-13","visa_expired: 2020-03-12\\nreg_date: 2020-02-11","work_permit_paid_till: 2020-04-12","visa_expired: 2020-04-12","reg_date: 2020-03-04","work_permit_paid_till: 2020-05-12","visa_expired: 2020-05-12\\nreg_date: 2020-04-09","status: WORKER\\nfired_date: 0000-00-00","reg_date: 2020-04-28"],"date":["14.02.2019 16:59:36","01.04.2019 17:06:38","09.04.2019 10:27:17","09.04.2019 10:27:54","25.04.2019 11:07:14","07.06.2019 12:36:20","13.06.2019 09:28:36","13.06.2019 09:28:56","13.06.2019 09:29:38","16.07.2019 10:35:12","16.07.2019 10:35:30","07.08.2019 14:45:58","07.08.2019 14:46:05","10.09.2019 13:08:30","10.09.2019 13:08:50","04.10.2019 12:07:48","04.10.2019 12:08:10","04.10.2019 13:17:13","29.10.2019 14:16:48","29.10.2019 14:16:58","04.12.2019 16:06:22","04.12.2019 16:06:43","04.12.2019 16:11:27","04.12.2019 16:15:51","24.12.2019 16:23:27","09.01.2020 20:00:20","11.02.2020 15:33:38","11.02.2020 15:34:17","25.02.2020 11:02:04","25.02.2020 11:03:52","18.03.2020 12:52:57","18.03.2020 12:53:59","07.04.2020 13:23:32","07.04.2020 13:23:46","27.04.2020 13:38:11","01.06.2020 11:19:01","01.06.2020 11:19:45","08.07.2020 15:04:56","08.07.2020 15:05:19"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1987-11-30	2014-09-26	2024-09-25	\N	\N	2020-03-13	2020-02-13	2021-02-13	2020-07-13	2019-02-14	2020-07-08	\N	\N	\N	\N	2020-07-13	2019-01-05	2019-01-05	2020-06-10	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
128	AC0653435	САМСАКОВА	ФЕРУЗАХОН	229	3	{2,3,4}	1	FEMALE						69	1900008043	20							4519	0143133					ВНУКОВО 241	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_expired: 2020-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2019-04-04 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2018-01-09 00:00:00","reg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2019-04-26 00:00:00","status: FIRED","fired_date: 2019-07-04 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["14.02.2019 17:03:26","01.04.2019 17:07:13","09.04.2019 10:31:36","09.04.2019 10:31:50","07.06.2019 12:40:10","13.06.2019 09:33:55","13.06.2019 09:34:11","03.07.2019 12:05:13","03.07.2019 12:05:28","03.07.2019 13:40:44","08.07.2019 11:35:42","08.07.2019 11:35:52","31.07.2019 10:20:20","31.07.2019 10:20:33"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1974-12-11	2018-08-11	2028-08-10	\N	\N	2019-02-12	2019-02-12	2020-02-12	2019-07-12	2019-02-14	2019-07-08	\N	\N	\N	\N	2019-07-12	2019-01-05	2019-01-05	2019-06-11	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
129	AB7833993	МАТЯКУБОВА	МУКАДДАСХОН	229	3	{2,3,4}	1	FEMALE						69	1900008029	19							4519	0123654					ВНУКОВО 254	Государственный центр персонализации			Андижанская область		{"prev_value":["work_permit_expired: 2020-02-12 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nwork_permit_expired: 2019-04-04 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00","reg_date: 2019-01-09 00:00:00","work_permit_paid_till: 2019-05-12 00:00:00\\nreg_date: 2019-04-03 00:00:00","work_permit_paid_till: 2019-06-12 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","work_permit_issued: 2018-02-12 00:00:00\\nwork_permit_started: 2018-02-12 00:00:00"],"date":["14.02.2019 17:00:50","01.04.2019 17:06:50","09.04.2019 10:29:56","09.04.2019 10:30:10","07.06.2019 12:38:25","13.06.2019 09:35:45","13.06.2019 09:36:01","02.07.2019 11:20:23","02.07.2019 11:22:31","03.07.2019 13:47:05"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1976-08-01	2017-10-03	2027-10-02	\N	\N	2019-02-12	2019-02-12	2020-02-12	2019-07-12	2019-02-14	2019-07-02	\N	\N	\N	\N	2019-07-12	2019-01-05	2019-01-05	2019-04-26	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
130	402034502	СОБИРОВА	ЗАМИРА 	209	3	{3,2,4}	1	FEMALE						69	1900007530	12							4618	6573094	ЧУРАЕВНА				РАМЕНСКОЕ 042	ОВД В ХУДЖАНДЕ					{"prev_value":["contract_number: ","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","work_permit_expired: 2019-04-10 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00","visa_expired: 2019-04-10 00:00:00\\nreg_date: 2019-04-09 00:00:00","visa_expired: 2019-06-11 00:00:00","work_permit_paid_till: 2019-06-11 00:00:00","work_permit_paid_till: 2019-07-11 00:00:00","visa_expired: 2019-07-11 00:00:00\\nreg_date: 2019-05-07 00:00:00","reg_date: 2019-06-05 00:00:00","visa_expired: 2019-08-11 00:00:00","work_permit_paid_till: 2019-08-11 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-07-04 00:00:00","work_permit_paid_till: 2019-09-11 00:00:00","visa_expired: 2019-09-11 00:00:00\\nreg_date: 2019-07-31 00:00:00","work_permit_paid_till: 2019-10-11 00:00:00","reg_date: 2019-09-03 00:00:00","visa_expired: 2019-10-11 00:00:00","status: WORKER","departure_date: 0000-00-00 00:00:00","status: FURLOUGH","departure_date: 2019-10-11 00:00:00\\nentry_date: 2019-01-11 00:00:00\\nentry_checkpoint: \\u0420\\u0410\\u041c\\u0415\\u041d\\u0421\\u041a\\u041e\\u0415 059\\nmigr_card_number: 6304853\\nmigr_card_issued: 2019-01-11 00:00:00\\nreg_date: 2019-09-25 00:00:00","work_permit_paid_till: 2019-11-11 00:00:00","visa_expired: 2019-11-11 00:00:00","work_permit_paid_till: 2019-12-11 00:00:00","visa_expired: 2019-12-11 00:00:00\\nreg_date: 0000-00-00 00:00:00","work_permit_paid_till: 2019-01-11 00:00:00","visa_expired: 2019-01-11 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2020-01-11 00:00:00","current_passport_number: ","current_passport_number: \\nvisa_expired: 2020-01-11 00:00:00","current_passport_number: \\nwork_permit_issued: 2019-02-11 00:00:00\\nwork_permit_started: 2019-02-11 00:00:00\\nwork_permit_expired: 2020-02-11 00:00:00\\nwork_permit_paid_till: 2020-02-11 00:00:00\\nwork_address: ","current_passport_number: \\nvisa_expired: 2020-02-11 00:00:00\\nreg_date: 2019-10-29 00:00:00","current_passport_number: \\nreg_date: 2019-12-25 00:00:00","work_permit_paid_till: 2020-02-12","visa_expired: 2020-03-12\\nreg_date: 2020-02-11","status: WORKER\\nfired_date: 0000-00-00","reg_address: 2\\nreal_address: 2"],"date":["13.02.2019 12:56:47","24.04.2019 12:05:41","03.06.2019 14:03:57","03.06.2019 14:04:46","03.06.2019 14:05:15","07.06.2019 10:08:16","03.07.2019 14:55:57","03.07.2019 15:13:27","03.07.2019 15:15:07","16.07.2019 10:47:15","31.07.2019 12:50:58","31.07.2019 12:51:15","27.08.2019 12:42:57","10.09.2019 13:27:28","10.09.2019 13:28:21","04.10.2019 11:53:13","04.10.2019 11:53:32","07.10.2019 11:01:35","14.10.2019 12:36:51","14.10.2019 12:37:10","23.10.2019 11:08:38","23.10.2019 11:10:40","29.10.2019 13:53:36","29.10.2019 13:54:00","04.12.2019 15:41:41","04.12.2019 15:42:15","04.12.2019 16:13:51","04.12.2019 16:13:59","24.12.2019 16:35:28","24.12.2019 16:35:47","09.01.2020 20:01:05","10.02.2020 12:21:20","10.02.2020 12:23:44","11.02.2020 15:24:48","18.03.2020 13:27:33","18.03.2020 13:27:59","07.04.2020 12:11:15","07.04.2020 12:34:48"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-12-03	2018-05-31	2028-05-30	\N	\N	2020-02-12	2020-02-12	2021-02-12	2020-04-12	2019-02-13	2020-04-07	\N	\N	\N	\N	2020-04-12	2019-10-20	2019-10-20	2020-03-03	\N	209	7	0	1	\N	0	7	7	7	0	2	0	\N	\N
131	402348702	ДОДОБОЕВА	МАХСУДА	209	3	{3,2,4}	1	FEMALE						69	1900006670	11							4618	6304421	САИДМУРОДОВНА				РАМЕНСКОЕ 033	ОВД В ХУДЖАНДЕ					{"prev_value":["status: SEEKER","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d\\npassport_issuer: ","work_permit_expired: 2019-04-10 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nreg_date: 2019-04-09 00:00:00","visa_expired: 2019-06-07 00:00:00","work_permit_paid_till: 2019-04-04 00:00:00","visa_expired: 2019-07-07 00:00:00\\nreg_date: 2019-05-07 00:00:00","reg_date: 2019-06-05 00:00:00","work_permit_paid_till: 2019-08-07 00:00:00","visa_expired: 2019-08-07 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-07-03 00:00:00","work_permit_paid_till: 2019-09-07 00:00:00","visa_expired: 2019-09-07 00:00:00\\nreg_date: 2019-08-01 00:00:00","work_permit_paid_till: 2019-10-07 00:00:00","visa_expired: 2019-10-07 00:00:00\\nreg_date: 2019-08-29 00:00:00","work_permit_paid_till: 2019-11-07 00:00:00","visa_expired: 2019-11-07 00:00:00","work_permit_paid_till: 2019-12-07 00:00:00","reg_date: 2019-09-25 00:00:00","visa_expired: 2019-12-07 00:00:00","work_permit_paid_till: 2019-01-07 00:00:00","visa_expired: 2019-01-07 00:00:00","current_passport_number: \\nstatus: WORKER","current_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nvisa_expired: 2020-01-07 00:00:00\\nreg_date: 2019-10-29 00:00:00"],"date":["11.02.2019 10:11:18","01.04.2019 17:03:04","24.04.2019 11:57:14","03.06.2019 13:44:48","03.06.2019 13:51:08","07.06.2019 10:05:58","03.07.2019 14:56:40","03.07.2019 14:57:45","16.07.2019 11:00:08","31.07.2019 12:35:17","31.07.2019 12:52:37","26.08.2019 12:07:11","10.09.2019 13:17:21","10.09.2019 13:18:08","04.10.2019 11:49:41","04.10.2019 11:52:27","29.10.2019 13:40:03","29.10.2019 13:40:22","04.12.2019 15:45:08","04.12.2019 15:45:43","04.12.2019 15:46:00","04.12.2019 16:18:20","04.12.2019 16:18:33","09.01.2020 13:25:17","09.01.2020 13:25:30","09.01.2020 13:26:31"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1972-03-15	2018-10-29	2028-10-28	\N	\N	2019-02-07	2019-02-07	2020-02-07	2020-01-07	2019-02-08	2020-01-09	\N	\N	\N	\N	\N	2019-01-11	2019-01-11	2019-12-05	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
132	401118569	МУРОДБОЕВА	МУХАЙЁ	209	3	{2,3,4}	1	FEMALE						69	1900006021	7							2808	0000723	АБДУВОХИДОВНА				РАМЕНСКОЕ 034	ОВД В ХУДЖАНДЕ			ТАДЖИКИСТАН		{"prev_value":["migr_card_serie: 4618\\nmigr_card_number: 6305364\\nmigr_card_issued: 2019-01-11 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","work_permit_expired: 2019-04-10 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["07.02.2019 14:45:25","01.04.2019 17:03:41","24.04.2019 10:41:50","24.04.2019 13:07:42","29.04.2019 14:20:33","29.04.2019 14:20:51"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1972-09-04	2016-06-22	2026-06-21	\N	\N	2019-02-05	2019-02-05	2020-02-05	2019-04-04	2019-02-07	2019-04-30	\N	\N	\N	\N	\N	2019-01-11	2019-02-01	2019-04-09	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
133	402081606	АЛИЖОНОВА	ДИЛБАР	209	3	{2,3,4}	1	FEMALE						69	1900005959	8							4618	6306730	АХАТОВНА				РАМЕНСКОЕ 086	ОВД В ХУДЖАНДЕ					{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d\\nwork_permit_expired: 2019-04-10 00:00:00\\nwork_permit_paid_till: 2019-04-04 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nreg_date: 2019-04-09 00:00:00","reg_date: 2019-04-30 00:00:00","work_permit_paid_till: 2019-07-05 00:00:00","visa_expired: 2019-07-05 00:00:00\\nreg_date: 2019-06-04 00:00:00","status: WORKER","status: SEEKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-08-05 00:00:00"],"date":["07.02.2019 14:54:45","01.04.2019 17:02:49","24.04.2019 11:02:16","03.06.2019 13:12:07","03.07.2019 11:27:07","16.07.2019 10:59:09","16.07.2019 10:59:30","22.07.2019 16:48:51","23.07.2019 11:20:11","23.07.2019 11:20:47","23.07.2019 11:22:36"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-06-17	2018-05-04	2028-05-03	\N	\N	2019-02-05	2019-02-05	2020-02-05	2019-08-05	2019-02-07	2019-07-22	\N	\N	\N	\N	\N	2019-01-11	2019-01-11	2019-07-03	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
134	402214817	ТОИРОВ	ЖАХОНГИР	209	3	{2,3,4}	1	MALE						69	1900006455	10							4618	6303386	НОЗИМЧОНОВИЧ				РАМЕНСКОЕ 034	ОВД МВД  ЁВА					{"prev_value":["work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-15 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d\\npassport_issuer: ","visa_expired: 2019-04-10 00:00:00\\nreg_date: 2019-04-09 00:00:00","visa_expired: 2019-06-06 00:00:00","work_permit_paid_till: 2019-04-04 00:00:00","visa_expired: 2019-07-06 00:00:00\\nreg_date: 2019-04-30 00:00:00","work_permit_paid_till: 2019-08-06 00:00:00","visa_expired: 2019-08-06 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2019-07-03 00:00:00","work_permit_expired: 2019-04-10 00:00:00"],"date":["07.02.2019 15:07:55","01.04.2019 17:04:24","24.04.2019 11:38:07","03.06.2019 13:29:15","03.06.2019 13:31:07","07.06.2019 10:06:50","16.07.2019 10:58:37","16.07.2019 10:58:55","31.07.2019 13:00:03","31.07.2019 13:00:24","05.08.2019 10:34:11","05.08.2019 10:35:10","05.08.2019 10:40:09","05.08.2019 11:41:17"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1998-04-19	2018-07-26	2028-07-25	\N	\N	2019-02-06	2019-02-06	2020-02-06	2019-09-06	2019-02-07	2019-08-05	\N	\N	\N	\N	2019-09-06	2019-01-11	2019-01-11	2019-08-01	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
136	402241421	ХАЛИМОВ	ДАВРОН	209	3	{3,2,4}	1	MALE						69	1900018806	24							4618	2492737	ХАСАНОВИЧ				ДОМОДЕВО 321	ОМВД В Б.ГАФУРОВЕ					{"prev_value":["employer_id: \\noccupation_id: \\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,208,214\\nstatus: SEEKER\\nbirth_place: \\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-23 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","work_permit_paid_till: 2019-04-05 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 2019-04-09 00:00:00","visa_expired: 2019-06-07 00:00:00","reg_date: 2019-04-30 00:00:00","reg_date: 2019-06-04 00:00:00","work_permit_paid_till: 2019-06-07 00:00:00","visa_expired: 2019-07-07 00:00:00\\nreg_date: 2019-06-05 00:00:00","work_permit_paid_till: 2019-08-07 00:00:00","visa_expired: 2019-08-07 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-07-03 00:00:00","work_permit_paid_till: 2019-09-07 00:00:00","visa_expired: 2019-09-07 00:00:00\\nreg_date: 2019-08-01 00:00:00","work_permit_paid_till: 2019-10-07 00:00:00","reg_date: 2019-08-29 00:00:00","work_permit_paid_till: 2019-11-07 00:00:00","visa_expired: 2019-10-07 00:00:00","work_permit_paid_till: 2019-12-07 00:00:00","visa_expired: 2019-12-07 00:00:00\\nreg_date: 2019-09-25 00:00:00","work_permit_paid_till: 2019-01-07 00:00:00","visa_expired: 2019-01-07 00:00:00","current_passport_number: ","current_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nreg_date: 2019-10-29 00:00:00","current_passport_number: \\nstatus: WORKER"],"date":["23.01.2019 12:29:57","11.03.2019 13:17:17","11.03.2019 13:18:51","11.03.2019 13:19:30","01.04.2019 17:01:00","24.04.2019 12:14:25","03.06.2019 14:26:36","03.06.2019 14:28:24","03.06.2019 14:28:55","07.06.2019 10:03:29","03.07.2019 11:04:42","03.07.2019 11:07:04","16.07.2019 10:57:17","16.07.2019 10:57:34","31.07.2019 13:03:00","31.07.2019 13:03:20","27.08.2019 13:05:15","10.09.2019 13:22:45","10.09.2019 13:23:02","04.10.2019 12:01:37","04.10.2019 12:02:11","29.10.2019 13:57:18","29.10.2019 13:57:29","04.12.2019 15:49:04","04.12.2019 15:49:28","04.12.2019 16:20:32","04.12.2019 16:20:42","09.01.2020 16:48:01","09.01.2020 16:48:14","09.01.2020 16:49:08","13.01.2020 11:38:05"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-04-13	2018-08-22	2028-08-21	\N	\N	2019-03-07	2019-03-07	2020-03-07	2020-01-07	2019-03-11	2020-01-09	\N	\N	\N	\N	2020-01-07	2019-01-23	2019-01-23	2019-12-05	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
137	402445961	ХАЛИМОВА	МУКАДДАС	209	3	{3,2,4}	1	FEMALE						69	1900017898	27							4618	2479883	АБДУАХАДОВНА				ДОМОДЕВО 342	ОВД УМВД в СУГДЕ					{"prev_value":["entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,208,214\\nstatus: SEEKER\\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-23 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d\\nwork_permit_paid_till: 2019-04-05 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 2019-04-09 00:00:00","reg_date: 2019-04-30 00:00:00","work_permit_paid_till: 2019-06-06 00:00:00","visa_expired: 2019-07-06 00:00:00\\nreg_date: 2019-06-04 00:00:00","work_permit_paid_till: 2019-08-06 00:00:00","visa_expired: 2019-08-06 00:00:00\\nreg_date: 2019-07-05 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-07-03 00:00:00","work_permit_paid_till: 2019-09-06 00:00:00","visa_expired: 2019-09-06 00:00:00\\nreg_date: 2019-08-01 00:00:00","work_permit_paid_till: 2019-10-06 00:00:00","reg_date: 2019-08-19 00:00:00","work_permit_paid_till: 2019-11-06 00:00:00","visa_expired: 2019-10-06 00:00:00","work_permit_paid_till: 2019-12-06 00:00:00","visa_expired: 2019-12-06 00:00:00\\nreg_date: 2019-09-25 00:00:00","work_permit_paid_till: 2019-01-06 00:00:00","visa_expired: 2019-01-06 00:00:00","current_passport_number: \\nstatus: WORKER","current_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nreg_date: 2019-10-29 00:00:00"],"date":["23.01.2019 12:35:51","11.03.2019 13:40:21","11.03.2019 13:41:28","11.03.2019 13:41:45","01.04.2019 17:01:26","24.04.2019 12:41:04","03.06.2019 15:07:06","03.06.2019 15:07:51","03.07.2019 13:27:36","16.07.2019 10:47:40","16.07.2019 10:48:01","31.07.2019 13:11:39","31.07.2019 13:12:34","27.08.2019 13:14:36","10.09.2019 13:23:22","10.09.2019 13:23:38","04.10.2019 12:02:35","04.10.2019 12:02:55","29.10.2019 14:08:17","29.10.2019 14:08:36","04.12.2019 15:51:18","04.12.2019 15:51:45","04.12.2019 16:22:16","04.12.2019 16:22:34","09.01.2020 17:05:41","09.01.2020 17:05:54","09.01.2020 17:06:37"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-06-07	2019-01-09	2029-01-08	\N	\N	2019-03-06	2019-03-06	2020-03-06	2020-01-06	2019-03-11	2020-01-09	\N	\N	\N	\N	2020-01-06	2019-01-23	2019-01-23	2019-12-05	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
138	402448991	ХАЛИМОВА	ИСТАДЧОН	209	3	{2,3,4}	1	FEMALE						69	1900018813	26							4618	2495381	ХАСАНОВНА				ДОМОДЕВО 614	ОВД УМВД в СУГДЕ					{"prev_value":["birth_date: 1977-02-22 00:00:00","user_ids: 209,208,214\\nstatus: SEEKER\\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","hired_date: 2019-03-07 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-23 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","work_permit_paid_till: 2019-04-05 00:00:00","reg_date: 2019-04-09 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["23.01.2019 14:24:32","11.03.2019 13:35:41","11.03.2019 13:36:50","11.03.2019 13:37:23","11.03.2019 13:39:40","01.04.2019 17:01:15","24.04.2019 12:33:00","03.06.2019 15:16:24","03.06.2019 15:17:09","03.06.2019 15:17:26","05.06.2019 13:13:58","05.06.2019 13:24:09"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1977-02-20	2019-01-10	2029-01-09	\N	\N	2019-03-07	2019-03-07	2020-03-07	2019-06-07	2019-03-11	2019-06-05	\N	\N	\N	\N	\N	2019-01-23	2019-01-23	2019-04-30	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
139	402448851	ХОЛИКОВ	ИНОМЧОН	209	3	{2,3,4}	1	MALE						69	1900018468	25							4618	2495382	ИСОБОЕВИЧ				ДОМОДЕВО 614	ОВД УМВД в СУГДЕ					{"prev_value":["entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,208,214\\nstatus: SEEKER\\nbirth_place: \\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-01-23 00:00:00","birth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","work_permit_paid_till: 2019-04-05 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 2019-04-09 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00"],"date":["23.01.2019 12:53:41","11.03.2019 13:30:38","11.03.2019 13:32:05","11.03.2019 13:32:31","01.04.2019 17:01:56","24.04.2019 12:24:09","03.06.2019 14:43:05","03.06.2019 14:43:56","03.06.2019 14:44:18","05.06.2019 12:55:29"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1975-12-31	2019-01-10	2029-01-09	\N	\N	2019-03-06	2019-03-06	2020-03-06	2019-06-06	2019-03-11	2019-06-05	\N	\N	\N	\N	2019-06-06	2019-01-23	2019-01-23	2019-04-30	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
145	N1901192	НГУЕН	ЧУНГ ХИЕУ	232	3	{3,2,4}	1	MALE			82	0938366				28							4619	6134877		NGUYEN	TRUNG HIEU		Шереметьево 582	ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ	RESIDENT_CARD		ХАНОЙ		{"prev_value":["","employer_id: \\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","host: ","reg_address: ","user_ids: 209,208\\nresident_document: \\nresident_document_serie: \\nresident_document_number: \\nresident_document_issuer: \\nresident_document_issued: 0000-00-00 00:00:00\\nresident_document_expired: 0000-00-00 00:00:00","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nreal_address: ","migr_card_serie: 4618","user_ids: 209,214,208\\nfired_date: 0000-00-00 00:00:00","status: WORKER","fired_date: 2019-09-27 00:00:00"],"date":["11.03.2019 15:02:13","11.03.2019 15:02:42","11.03.2019 15:02:56","11.03.2019 15:10:55","15.03.2019 10:38:51","20.03.2019 11:45:26","29.03.2019 12:56:31","27.09.2019 11:12:03","27.09.2019 11:29:57","27.09.2019 11:34:52"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#208 \\u041d\\u0430\\u043c","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-11-04	2017-12-20	2027-12-20	2016-10-05	2021-10-05	\N	\N	\N	\N	2019-03-11	2019-09-30	\N	\N	\N	\N	\N	2018-11-26	2018-11-26	\N	\N	232	7	0	14	\N	0	7	14	2	0	0	0	\N	\N
140	401577599	УСМОНОВ	УСМОН	209	3	{2,3,4}	1	MALE						69	1900015139	23							4618	6314534	ИСОБОЕВИЧ				РАМЕНСКОЕ 062	ОМВД В Б.ГАФУРОВЕ					{"prev_value":["entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","user_ids: 209,208,214\\nstatus: SEEKER\\nbirth_place: \\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","user_ids: 209,214,208\\nbirth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d","reg_date: 2019-01-25 00:00:00","work_permit_paid_till: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 2019-04-09 00:00:00","work_permit_paid_till: 2019-06-28 00:00:00","visa_expired: 2019-06-28 00:00:00","status: WORKER","visa_expired: 2019-07-28 00:00:00\\nreg_date: 2019-05-28 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["25.01.2019 11:20:01","04.03.2019 15:10:43","04.03.2019 15:12:17","08.04.2019 13:37:50","24.04.2019 12:49:48","03.06.2019 12:43:35","03.06.2019 12:44:45","03.07.2019 14:06:07","03.07.2019 14:06:15","22.07.2019 16:42:03","22.07.2019 16:42:55","23.07.2019 11:19:35"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1978-06-28	2017-07-05	2027-07-04	\N	\N	2019-02-28	2019-02-28	2020-02-28	2019-07-28	2019-03-04	2019-07-22	\N	\N	\N	\N	\N	2019-01-17	2019-01-17	2019-06-26	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
141	N2093988	НГУЕН	КОНГ ХАУ	232	9	{3,2,4}	1	MALE																						ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ			РОССИЯ		{"prev_value":["host: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nwhence: \\npassport_serie: II-OH \\npassport_number: 565763\\npassport_issuer: \\u0424\\u0438\\u043b\\u0438\\u0430\\u043b \\u21165 \\u043e\\u0442\\u0434\\u0435\\u043b\\u0430 \\u0437\\u0430\\u043f\\u0438\\u0441\\u0438 \\u0430\\u043a\\u0442\\u043e\\u0432 \\u0433\\u0440\\u0430\\u0436\\u0434\\u0430\\u043d\\u0441\\u043a\\u043e\\u0433\\u043e \\u0441\\u043e\\u0441\\u0442\\u043e\\u044f\\u043d\\u0438\\u044f \\u0430\\u0434\\u043c\\u0438\\u043d\\u0438\\u0441\\u0442\\u0440\\u0430\\u0446\\u0438\\u0438 \\u0433\\u043e\\u0440\\u043e\\u0434\\u0430 \\u0422\\u0432\\u0435\\u0440\\u0438 \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u043e\\u0439 \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u0438\\npassport_issued: 2018-09-05 00:00:00\\npassport_expired: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","visa_expired: 2019-11-27 00:00:00","birth_place: \\u0433\\u043e\\u0440\\u043e\\u0434 \\u0422\\u0432\\u0435\\u0440\\u044c \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u0430\\u044f \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u044c ","visa_expired: 2020-11-26\\nreg_date: 2019-11-15","reg_date: 2020-11-18","reg_date: 2020-11-19"],"date":["28.01.2019 12:32:28","14.11.2019 11:17:46","04.12.2019 17:04:52","04.12.2019 17:10:14","18.11.2020 12:12:04","18.11.2020 12:15:13","19.11.2020 12:35:38","19.11.2020 12:38:30"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	2018-08-28	2019-10-15	2024-10-15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2021-11-25	\N	\N	2020-11-18	\N	232	1	0	0	\N	0	1	2	2	0	0	0	\N	\N
142	401128769	ДОМЛОЧОНОВА	АЗИЗА	209	3	{3,2,4}	1	FEMALE						69	1900037319	29							4618	6497359	РАМОНХОЧАЕВНА				РАМЕНСКОЕ 103	ОВД В ХУДЖАНДЕ			ТАДЖИКИСТАН		{"prev_value":["","employer_id: \\noccupation_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER\\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","status: WORKER","contract_number: 29\\nhired_date: 2019-04-16 00:00:00","status: SEEKER","contract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 2019-03-05 00:00:00","visa_expired: 0000-00-00 00:00:00","visa_expired: 2019-06-10 00:00:00","status: WORKER","departure_date: 0000-00-00 00:00:00","work_permit_paid_till: 2019-05-10 00:00:00","status: FURLOUGH","work_permit_paid_till: 2019-08-10 00:00:00","departure_date: 2019-07-03 00:00:00\\nvisa_expired: 2019-07-10 00:00:00\\nentry_date: 2019-03-03 00:00:00\\nentry_checkpoint: \\u0414\\u041e\\u041c\\u041e\\u0414\\u0415\\u0412\\u041e 1347\\nmigr_card_number: 02645806\\nmigr_card_issued: 2019-03-03 00:00:00\\nreg_date: 2019-05-07 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-06-05 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-09-10 00:00:00"],"date":["04.03.2019 10:22:11","04.03.2019 10:22:31","04.03.2019 10:24:04","16.04.2019 13:08:39","16.04.2019 14:01:34","16.04.2019 14:02:12","16.04.2019 14:39:35","16.04.2019 14:39:50","23.04.2019 13:45:14","23.04.2019 13:45:37","03.06.2019 12:47:11","03.06.2019 13:06:51","07.06.2019 10:02:59","03.07.2019 12:31:32","03.07.2019 12:31:44","16.07.2019 11:08:28","31.07.2019 12:12:47","31.07.2019 12:13:08","31.07.2019 12:15:16","26.08.2019 12:16:19","03.09.2019 10:51:50","03.09.2019 10:52:04","06.09.2019 12:33:03"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-05-25	2016-07-25	2026-07-24	\N	\N	2019-04-10	2019-04-10	2020-04-10	2019-09-10	2019-04-23	2019-09-02	\N	\N	\N	\N	\N	2019-07-27	2019-07-27	2019-08-01	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
143	402053032	УСМОНОВА	БИСАБОАТ	209	6	{3,4,2}	1	FEMALE															4618	02641853	МУХАМАДАЛИЕВНА				ДОМОДЕВО 370				ТАДЖИКИСТАН		{"prev_value":["","employer_id: \\noccupation_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,208,214\\nstatus: SEEKER","reg_date: 0000-00-00 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["04.03.2019 10:28:38","04.03.2019 10:28:49","04.03.2019 10:30:18","26.03.2019 11:54:13","26.03.2019 11:55:21","26.03.2019 11:55:51"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1964-02-01	2018-04-20	2028-04-19	\N	\N	\N	\N	\N	\N	\N	2019-03-25	\N	\N	\N	\N	\N	2019-03-03	2019-03-03	2019-03-15	\N	209	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
144	402520296	МАХКАМОВА	ДИЛОРОМ	209	3	{2,3,4}	1	FEMALE						69	1900037414	30							4618	02641852	НЕЪМАТОВНА				ДОМОДЕВО 370	ОВД В ХУДЖАНДЕ			ТАДЖИКИСТАН		{"prev_value":["","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","employer_id: \\nwork_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","passport_issuer: "],"date":["04.03.2019 10:34:29","04.03.2019 10:35:36","06.05.2019 13:33:10","06.05.2019 13:34:54","06.05.2019 13:35:28","13.05.2019 10:32:30","13.05.2019 10:32:44","13.05.2019 11:09:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-01-07	2019-02-14	2029-02-13	\N	\N	2019-04-10	2019-04-10	2020-04-10	2019-06-10	2019-05-06	2019-05-13	\N	\N	\N	\N	\N	2019-03-03	2019-03-03	2019-03-05	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
146	402528514	ГАДОЙБОЕВА	МАЛОХАТЧОН	209	3	{2,3,4}	1	FEMALE						69	1900047476	32							4618	6369258	АБДУРАХМОНОВНА				РАМЕНСКОЕ 014	ОВД В ХУДЖАНДЕ			ТАДЖИКИСТАН		{"prev_value":["","employer_id: \\noccupation_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","passport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_number: 190004746","contract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 2019-06-09 00:00:00","status: WORKER","departure_date: 0000-00-00 00:00:00","status: FURLOUGH","departure_date: 2019-07-03 00:00:00\\nvisa_expired: 2019-07-25 00:00:00\\nreg_date: 2019-03-14 00:00:00","fired_date: 0000-00-00 00:00:00"],"date":["14.03.2019 12:54:40","14.03.2019 12:55:01","14.03.2019 12:56:52","27.05.2019 11:19:07","27.05.2019 11:19:29","27.05.2019 11:21:27","27.05.2019 11:21:59","28.05.2019 11:38:44","28.05.2019 11:43:20","03.06.2019 12:31:25","03.07.2019 12:32:07","03.07.2019 12:32:19","24.07.2019 13:49:57","24.07.2019 13:50:46","24.07.2019 13:51:14"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1976-03-31	2019-02-28	2029-02-27	\N	\N	2019-04-25	2019-04-25	2020-04-25	2019-06-24	2019-05-27	2019-07-24	\N	\N	\N	\N	\N	2019-03-12	2019-03-12	2019-06-04	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
147	401078036	ЧАБОРОВ	КЕНЧАБОЙ	209	5	{3,2,4}	1	MALE						69	2100093926	42							4618	6371335	ЧАЛИЛОВИЧ				РАМЕНСКОЕ 004	ОВД В ХУДЖАНДЕ			ТАДЖИКИСТАН		{"prev_value":["","employer_id: \\noccupation_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_paid_till: 2019-05-25 00:00:00","passport_issuer: ","visa_expired: 2019-06-09 00:00:00","work_permit_paid_till: 2019-06-25 00:00:00","visa_expired: 2019-07-25 00:00:00\\nreg_date: 2019-03-14 00:00:00","work_permit_paid_till: 2019-07-25 00:00:00","reg_date: 2019-06-05 00:00:00","work_permit_paid_till: 2019-08-25 00:00:00","visa_expired: 2019-08-25 00:00:00","user_ids: 208,209,214\\nreg_date: 2019-07-04 00:00:00","work_permit_paid_till: 2019-09-25 00:00:00","visa_expired: 2019-09-25 00:00:00\\nreg_date: 2019-08-01 00:00:00","work_permit_paid_till: 2019-11-25 00:00:00","fired_date: 0000-00-00 00:00:00\\nreg_date: 2019-08-29 00:00:00","work_permit_paid_till: 2019-12-25 00:00:00","visa_expired: 2019-11-25 00:00:00","work_permit_paid_till: 2019-01-25 00:00:00","visa_expired: 2019-01-25 00:00:00\\nreg_date: 2019-09-25 00:00:00","work_permit_paid_till: 2019-02-25 00:00:00","visa_expired: 2019-02-25 00:00:00","current_passport_number: \\nvisa_expired: 2020-02-25 00:00:00\\nreg_date: 2019-10-29 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2020-02-25 00:00:00","work_permit_paid_till: 2020-03-25","visa_expired: 2020-03-25\\nreg_date: 2019-12-05","work_permit_issued: 2019-04-25\\nwork_permit_started: 2019-04-25\\nwork_permit_expired: 2020-04-25\\nwork_permit_paid_till: 2020-04-25\\nwork_address: ","visa_expired: 2020-04-25","work_permit_started: 2021-04-26\\nwork_permit_expired: 2020-05-26\\nwork_permit_paid_till: 2020-05-26","work_permit_expired: 2021-05-26","visa_expired: 2020-05-26\\nreg_date: 2020-01-31","reg_date: 2020-04-23","work_permit_paid_till: 2020-06-26","visa_expired: 2020-06-26\\nreg_date: 2020-05-22","work_permit_paid_till: 2020-07-26","visa_expired: 2020-07-26","work_permit_paid_till: 2020-08-26\\nvisa_expired: 2020-08-26\\nreg_date: 2020-06-26","work_permit_paid_till: 2020-09-26","visa_expired: 2020-09-26\\nreg_date: 2020-07-21","work_permit_paid_till: 2020-10-26","visa_expired: 2020-10-26","reg_date: 2020-08-20","work_permit_paid_till: 2020-12-26","visa_expired: 2020-12-26","work_permit_paid_till: 2021-01-26\\nvisa_expired: 2021-01-26","work_permit_paid_till: 2021-02-26","visa_expired: 2021-02-26","reg_date: 2020-11-19","work_permit_number: 1900047998\\nwork_permit_issued: 2020-04-26\\nwork_permit_started: 2020-04-26\\nwork_permit_expired: 2021-04-26\\nwork_permit_paid_till: 2021-03-26","status: WORKER\\nfired_date: 0000-00-00","status: FIRED\\ncontract_number: 31\\nhired_date: 2019-05-06","contract_number: 32\\nfired_date: 2021-04-26","visa_expired: 2021-03-26\\nreg_date: 2021-01-13","work_permit_started: 2021-04-26\\nwork_permit_expired: 2022-04-26\\nwork_permit_paid_till: 2021-04-26","visa_expired: 2021-05-26"],"date":["14.03.2019 13:03:06","14.03.2019 13:03:22","14.03.2019 13:04:45","06.05.2019 12:13:07","06.05.2019 12:18:33","06.05.2019 12:20:42","27.05.2019 12:54:21","03.06.2019 12:32:12","07.06.2019 10:04:48","03.07.2019 16:02:51","03.07.2019 16:03:30","16.07.2019 10:48:22","16.07.2019 10:53:18","31.07.2019 13:18:40","31.07.2019 13:19:05","27.08.2019 13:28:09","10.09.2019 13:24:53","10.09.2019 13:25:12","04.10.2019 11:54:16","04.10.2019 12:00:43","29.10.2019 14:11:44","29.10.2019 14:11:54","04.12.2019 15:53:57","04.12.2019 15:54:16","04.12.2019 16:25:04","04.12.2019 16:25:12","25.12.2019 09:25:17","25.12.2019 09:26:03","18.03.2020 13:28:50","18.03.2020 13:29:20","23.04.2020 12:23:36","23.04.2020 12:23:49","22.05.2020 13:26:21","22.05.2020 13:34:15","22.05.2020 13:36:09","01.06.2020 11:41:57","20.07.2020 11:49:37","20.07.2020 11:50:02","20.07.2020 13:47:17","20.07.2020 13:47:25","20.08.2020 13:29:20","21.09.2020 13:08:57","21.09.2020 13:10:08","18.11.2020 12:57:44","18.11.2020 12:58:20","19.11.2020 12:33:29","23.12.2020 12:19:12","23.12.2020 12:19:33","13.01.2021 12:31:19","16.02.2021 14:38:02","16.02.2021 14:38:17","16.02.2021 14:38:59","26.04.2021 13:14:44","26.04.2021 13:29:35","26.04.2021 13:37:43","26.04.2021 13:39:03","26.04.2021 13:40:01","26.04.2021 14:06:24","07.05.2021 10:45:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1969-07-04	2016-05-17	2026-05-16	\N	\N	2021-04-19	2021-04-19	2022-04-19	2021-05-19	2021-04-27	\N	\N	\N	\N	\N	2021-05-19	2019-03-12	2019-03-12	2021-04-27	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
148	402528516	ИСМАТОВА	ХОСИЯТ	209	3	{3,2,4}	1	FEMALE						69	1900050479	34							4618	02772121	СОЛИЕВНА				ДОМОДЕВО 611	ОВД  ХУДЖАНДЕ					{"prev_value":["","employer_id: \\noccupation_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER\\nbirth_place: \\u0422\\u0410\\u0414\\u0416\\u0418\\u041a\\u0418\\u0421\\u0422\\u0410\\u041d\\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","passport_issuer: \\u041e\\u0412\\u0414 \\u0412 \\u0425\\u0423\\u0414\\u0416\\u0410\\u041d\\u0414\\u0415","visa_expired: 2019-06-15 00:00:00","work_permit_paid_till: 2019-05-30 00:00:00\\nreg_date: 2019-03-22 00:00:00","work_permit_paid_till: 2019-06-30 00:00:00","visa_expired: 2019-06-30 00:00:00","reg_date: 2019-05-28 00:00:00","user_ids: 208,209,214\\nvisa_expired: 2019-07-30 00:00:00\\nreg_date: 2019-06-26 00:00:00","work_permit_paid_till: 2019-07-30 00:00:00","visa_expired: 2019-08-30 00:00:00\\nreg_date: 2019-07-30 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["20.03.2019 12:27:25","20.03.2019 12:27:51","20.03.2019 12:29:38","27.05.2019 13:06:18","27.05.2019 13:07:42","27.05.2019 13:08:25","28.05.2019 12:00:17","03.06.2019 12:21:36","03.06.2019 12:25:25","03.07.2019 14:10:37","03.07.2019 14:10:45","26.07.2019 09:38:45","27.08.2019 12:14:50","10.09.2019 13:21:24","10.09.2019 13:21:52","04.10.2019 11:17:35","04.10.2019 11:17:58"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-05-13	2019-02-28	2029-02-27	\N	\N	2019-04-30	2019-04-30	2020-04-30	2019-09-30	2019-05-27	2019-09-26	\N	\N	\N	\N	2019-09-30	2019-03-18	2019-03-18	2019-08-29	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
149	400420856	ИСМАТОВА	ЗАМИРА	209	3	{3,2,4}	1	FEMALE						69	1900050461	35							4618	02773086	СОЛИЕВНА				ДОМОДЕВО 1402	ОВД ХУДЖАНДЕ					{"prev_value":["","employer_id: \\nwork_permit_expired: 0000-00-00 00:00:00\\noccupation_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER\\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 2019-06-15 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","passport_issuer: \\u041e\\u0412\\u0414 \\u0412 \\u0425\\u0423\\u0414\\u0416\\u0410\\u041d\\u0414\\u0415","work_permit_paid_till: 2019-05-30 00:00:00\\nvisa_expired: 2019-06-15 00:00:00","departure_date: 0000-00-00 00:00:00\\nreg_date: 2019-03-22 00:00:00","work_permit_paid_till: 2019-06-30 00:00:00","visa_expired: 2019-06-30 00:00:00","reg_date: 2019-05-28 00:00:00","user_ids: 208,209,214\\nwork_permit_issuer: ","visa_expired: 2019-07-30 00:00:00\\nreg_date: 2019-06-26 00:00:00","work_permit_paid_till: 2019-07-30 00:00:00","visa_expired: 2019-08-30 00:00:00\\nreg_date: 2019-07-30 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["20.03.2019 12:51:44","20.03.2019 12:52:21","20.03.2019 12:53:50","27.05.2019 14:57:03","27.05.2019 15:00:04","27.05.2019 15:00:36","28.05.2019 12:14:34","03.06.2019 12:14:48","03.06.2019 12:22:42","03.07.2019 14:07:26","03.07.2019 14:08:10","26.07.2019 09:47:24","26.08.2019 13:37:25","26.08.2019 13:38:55","10.09.2019 13:20:26","10.09.2019 13:21:07","04.10.2019 11:18:15","04.10.2019 11:18:26"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1990-02-08	2014-12-23	2024-12-22	\N	\N	2019-04-30	2019-04-30	2020-04-30	2019-09-30	2019-05-27	2019-09-26	\N	\N	\N	\N	2019-09-30	2019-03-18	2019-03-18	2019-08-29	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
150	C6835952	ВУ	КУАНГ ВИНЬ	232	8	{3,2,4}	1	MALE										003125148								VU	QUANG VINH			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ВИНЬФУК		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: \\ncert_number: \\ncert_issuer: \\ncert_issued: 0000-00-00 00:00:00","host: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","user_ids: 208,209,214\\ncurrent_passport_number: \\nstatus: CANCELLED\\noccupation_id: 1\\nwork_address: ","current_passport_number: \\nemployer_id: 1","employer_id: 4","employ_permit_id: 33","employ_permit_id: 43","employer_id: 1","host: 1","employ_permit_id: 33","status: SEEKER"],"date":["20.03.2019 13:31:21","20.03.2019 13:47:39","20.03.2019 13:48:01","31.07.2019 10:12:05","10.02.2020 14:50:06","10.02.2020 15:04:56","11.03.2020 11:04:22","18.03.2020 11:13:55","18.03.2020 11:25:17","18.03.2020 11:29:38","18.03.2020 11:29:45","18.03.2020 11:30:21","16.04.2020 14:10:08"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-10-12	2019-03-01	2029-03-01	\N	\N	\N	\N	\N	\N	\N	\N	\N	2009-09-04	\N	\N	\N	\N	\N	\N	\N	232	4	45	6	\N	0	4	2	2	0	0	0	\N	\N
151	402534491	ХОТАМОВ	МУСТАФО	209	6	{3,2,4}	1	MALE															4618	02772122	МУРОДЧОНОВИЧ				ДОМОДЕВО 611				ХУДЖАНД		{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nvisa_expired: 0000-00-00 00:00:00","user_ids: 208,209,214\\nwork_permit_expired: 0000-00-00 00:00:00","visa_expired: 2019-07-30 00:00:00\\nreg_date: 0000-00-00 00:00:00","status: FAMILY","fired_date: 0000-00-00 00:00:00"],"date":["20.03.2019 14:08:42","20.03.2019 14:09:08","20.03.2019 14:10:42","03.07.2019 14:11:42","10.09.2019 13:24:05","10.09.2019 13:24:23","04.10.2019 11:19:06","04.10.2019 11:19:20"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	2010-01-29	2019-03-04	2023-03-03	\N	\N	\N	\N	2019-09-30	\N	\N	2019-09-26	\N	\N	\N	\N	2019-09-30	2019-03-18	2019-03-18	2019-08-29	\N	209	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
153	N1779822	БУЙ	НГОК КЫОНГ	232	3	{3,2,5}	1	MALE			82	0484224				39							4619	6545960		BUI	NGOC CUONG		шереметьево 626	ПОСОЛЬСТВО СРВ В РОССИЙСКОЙ ФЕДЕРАЦИИ	RESIDENT_CARD		Тхай бинь		{"prev_value":["","employer_id: \\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","host: ","reg_address: ","reg_address: 11","user_ids: 209","user_ids: 209,215,208\\nreal_address: \\nresident_document: \\nresident_document_serie: \\nresident_document_number: \\nresident_document_issuer: \\nresident_document_issued: 0000-00-00 00:00:00\\nresident_document_expired: 0000-00-00 00:00:00","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00","passport_issuer: \\u041f\\u041e\\u0421\\u041e\\u041b\\u042c\\u0421\\u0422\\u0412\\u041e \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c\\u0410 \\u0412 \\u0420\\u041e\\u0421\\u0421\\u0418\\u0418","passport_expired: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00"],"date":["29.03.2019 14:32:58","29.03.2019 14:33:56","29.03.2019 14:35:17","29.03.2019 14:35:35","29.03.2019 14:36:38","02.04.2019 17:31:39","09.12.2019 14:08:28","09.12.2019 14:09:48","09.12.2019 14:10:12","11.12.2019 11:58:43","11.12.2019 11:59:01","11.12.2019 11:59:37"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1966-10-21	2016-04-20	2026-04-20	2016-12-05	2021-12-05	\N	\N	\N	\N	2016-07-07	2019-12-09	\N	\N	\N	\N	\N	2019-03-19	2019-03-19	2017-01-18	\N	232	1	0	27	\N	0	1	15	15	0	0	0	\N	\N
154	N1747379	ХОАНГ	ТХИ ШЫ	232	3	{3,2,5}	1	FEMALE			82	0480888				41							4616	8028513		HOANG	THI SU		Шереметьево 829	ПОСОЛЬСТВО СРВ В РФ	RESIDENT_CARD		ХАНОЙ		{"prev_value":["","employer_id: \\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","host: \\nreg_address: \\nreal_address: ","user_ids: 209","user_ids: 209,215,208\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","resident_document: \\nresident_document_serie: \\nresident_document_number: \\nresident_document_issuer: \\nresident_document_issued: 0000-00-00 00:00:00\\nresident_document_expired: 0000-00-00 00:00:00"],"date":["29.03.2019 14:40:18","29.03.2019 14:40:57","29.03.2019 14:42:00","02.04.2019 17:31:54","09.12.2019 15:35:16","09.12.2019 15:35:25","09.12.2019 15:35:41","09.12.2019 15:36:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1966-01-16	2015-05-20	2025-05-20	2016-02-25	2021-02-25	\N	\N	\N	\N	2016-07-07	2019-12-09	\N	\N	\N	\N	\N	2016-03-15	2016-03-15	2016-04-01	\N	232	1	0	27	\N	0	1	15	15	0	0	0	\N	\N
155	401026930	ХОШИМОВ	ДИЛШОД	209	6	{2,3,4}	1	MALE						69	1900056826								4618	6387404	ТЕМУРОВИЧ				РАМЕНСКОЕ 068	ОВД В ХУДЖАНДЕ					{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","occupation_id: ","visa_expired: 0000-00-00 00:00:00","visa_started: 0000-00-00 00:00:00","visa_started: 2019-06-25 00:00:00\\nvisa_expired: 1970-01-01 00:00:00","visa_expired: 2019-06-25 00:00:00","visa_expired: 0000-00-00 00:00:00","user_ids: 209,208,214\\nstatus: SEEKER\\nwhence: \\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_expired: 2014-05-20 00:00:00","status: WORKER","contract_number: 33\\nhired_date: 2019-05-27 00:00:00","status: SEEKER"],"date":["29.03.2019 15:54:06","29.03.2019 15:55:08","29.03.2019 16:02:48","29.03.2019 16:03:53","29.03.2019 16:05:51","02.04.2019 15:37:52","02.04.2019 15:38:27","02.04.2019 15:49:03","02.04.2019 16:28:00","27.05.2019 12:50:17","27.05.2019 12:52:28","27.05.2019 12:53:17","27.05.2019 13:02:35","28.05.2019 10:33:48","28.05.2019 10:34:13","07.06.2019 10:22:53"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-09-27	2016-04-08	2026-04-07	\N	\N	2019-05-14	2019-05-14	2020-05-14	2019-06-14	\N	\N	\N	\N	\N	\N	2019-06-25	2019-03-28	2019-03-28	2019-04-02	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
156	401525377	САДИКОВА	ФАРХУНДА	209	8	{2,3}	1	FEMALE															4618	6388099	ТУРСУНОВНА				РАМЕНСКОЕ 061						{"prev_value":["","employer_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: ","user_ids: 209,208\\nstatus: SEEKER"],"date":["29.03.2019 16:16:35","29.03.2019 16:16:55","29.03.2019 16:18:33","31.07.2019 12:54:18"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1990-03-13	2017-06-01	2027-05-31	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-06-25	2019-03-28	2019-03-28	\N	\N	0	7	0	0	\N	0	7	0	0	0	0	0	\N	\N
157	400853755	ИШОНОВА	МАСЪУДА	209	8	{2,3,4}	1	FEMALE															4618	6386474	УМАРОВНА				РАМЕНСКОЕ 095						{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","birth_date: 0000-00-00 00:00:00\\nbirth_place: 04.02.1984","user_ids: 209,208,214\\nstatus: SEEKER"],"date":["02.04.2019 09:56:35","02.04.2019 09:57:24","02.04.2019 10:00:39","02.04.2019 10:01:45","31.07.2019 12:54:49"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-02-04	2015-11-16	2025-11-15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-03-28	2019-03-28	2019-04-02	\N	0	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
158	402193417	ИКРАМОВА	МАНЗУРА	209	6	{2,3,4}	1	FEMALE															4618	6388100	МУБИНОВНА				РАМЕНСКОЕ 061						{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","user_ids: 209,208,214\\nstatus: SEEKER\\ndeparture_date: 0000-00-00 00:00:00\\nreg_date: 2019-04-02 00:00:00"],"date":["02.04.2019 10:13:47","02.04.2019 10:14:16","02.04.2019 10:15:38","08.04.2019 14:28:09"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-10-14	2018-07-19	2028-07-18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-03-28	2019-03-28	\N	\N	0	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
159	331340	НГУЕН	ВАН ТЫОК	177	5	{3,4,2}	1	MALE	4515							42														ОТДЕЛЕНИЕМ УФМС РОССИИ ПО ГОР.МОСКВЕ ПО РАЙОНУ МАРФИНО			ХАНОЙ		{"prev_value":["","passport_issuer: \\npassport_issued: 0000-00-00 00:00:00","employer_id: \\noccupation_id: \\nhired_date: 0000-00-00 00:00:00","host: \\nreg_address: \\nreal_address: ","contract_number: ","user_ids: 209","citizenship: "],"date":["16.04.2019 10:40:19","16.04.2019 10:45:12","16.04.2019 10:45:48","16.04.2019 10:47:23","16.04.2019 10:47:30","16.04.2019 11:54:13","21.04.2019 12:46:09"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 Super User","#207 Super User"]}	\N	2016-01-21	\N	\N	\N	\N	\N	\N	\N	2016-07-01	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	1	0	27	\N	0	1	15	15	0	0	0	\N	\N
161	402196748	ШАРИПОВА	МАВЗУНА	209	6	{3,4,2}	1	FEMALE															4618	6416949	КОСИМЧОНОВНА				РАМЕНСКОЕ 057						{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","status: SEEKER","fired_date: 0000-00-00 00:00:00"],"date":["29.04.2019 12:47:02","29.04.2019 12:47:33","29.04.2019 12:50:07","13.05.2019 10:57:35","13.05.2019 10:57:51"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1979-10-22	2018-07-25	2028-07-24	\N	\N	\N	\N	\N	\N	\N	2019-05-13	\N	\N	\N	\N	\N	2019-04-25	2019-03-25	2019-04-25	\N	209	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
162	AB9640268	КУШАКОВА	ГУЛСАНАМ	229	3	{3,2,4}	1	FEMALE						69	1900084887	36							4618	3147111					ДОМОДЕВО 192	Государственный центр персонализации			Андижанская область		{"prev_value":["","employer_id: \\noccupation_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00","passport_issuer: \\u041e\\u0412\\u0414 \\u0411\\u0443\\u043b\\u0430\\u043a\\u0431\\u0430\\u0448\\u0438\\u043d\\u0441\\u043a\\u043e\\u0433\\u043e \\u0440\\u0430\\u0439\\u043e\\u043d\\u0430 \\u0410\\u043d\\u0434\\u0438\\u0436\\u0430\\u043d\\u0441\\u043a\\u043e\\u0439 \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u0438","work_permit_paid_till: 2019-07-13 00:00:00","visa_expired: 2019-08-13 00:00:00\\nreg_date: 2019-05-20 00:00:00","birth_place: ","user_ids: 208,209,214\\nwork_permit_paid_till: 2019-09-13 00:00:00","visa_expired: 2019-09-13 00:00:00\\nreg_date: 2019-06-04 00:00:00","work_permit_paid_till: 2019-10-13 00:00:00","reg_date: 2019-09-05 00:00:00","visa_expired: 2019-10-13 00:00:00","work_permit_paid_till: 2019-11-13 00:00:00","visa_expired: 2019-11-13 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00","reg_date: 2019-10-03 00:00:00"],"date":["20.05.2019 13:53:53","20.05.2019 13:54:10","20.05.2019 13:55:52","18.06.2019 14:31:20","18.06.2019 14:32:52","18.06.2019 14:33:11","18.06.2019 14:34:21","09.08.2019 12:36:05","09.08.2019 12:36:31","09.08.2019 12:38:42","10.09.2019 13:09:13","10.09.2019 13:09:29","04.10.2019 12:03:23","04.10.2019 12:07:14","07.10.2019 12:53:24","29.10.2019 14:18:06","29.10.2019 14:18:18","02.12.2019 15:53:30","02.12.2019 15:53:56"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-12-10	2018-05-23	2028-05-22	\N	\N	2019-06-13	2019-06-13	2020-06-13	2019-12-13	2019-06-18	2019-12-02	\N	\N	\N	\N	2019-12-13	2019-05-16	2019-05-16	2019-10-29	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
163	AA0916848	АБДУАЛИМОВА	СЕВАРАХОН	229	3	{3,2,4}	1	FEMALE						69	1900084485	37							4618	3147110					ДОМОДЕВО 192	Государственный центр персонализации			Андижанская область		{"prev_value":["","employer_id: \\noccupation_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","passport_issuer: ","birth_place: ","work_permit_paid_till: 2019-07-13 00:00:00","user_ids: 208,209,214\\nvisa_expired: 2019-08-13 00:00:00","visa_expired: 2019-09-13 00:00:00\\nreg_date: 2019-05-20 00:00:00","fired_date: 0000-00-00 00:00:00","status: WORKER"],"date":["20.05.2019 14:33:50","20.05.2019 14:34:02","20.05.2019 14:36:51","18.06.2019 14:53:29","18.06.2019 14:55:17","18.06.2019 14:56:26","19.06.2019 11:51:47","19.06.2019 11:53:15","09.08.2019 12:10:16","29.08.2019 13:21:44","05.09.2019 10:42:24","05.09.2019 10:43:07","05.09.2019 10:50:51"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-07-17	2013-02-18	2023-02-17	\N	\N	2019-06-13	2019-06-13	2020-06-13	2019-09-13	2019-06-18	2019-09-05	\N	\N	\N	\N	\N	2019-05-16	2019-05-16	2019-08-09	\N	0	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
164	AA4264484	ОРЗУКУЛОВ	БАХТИЁРЖОН	229	3	{2,3,4}	1	MALE						69	1900084904	38							4618	3136262					ДОМОДЕВО 627	Государственный центр персонализации			Андижанская область		{"prev_value":["","employer_id: \\noccupation_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","user_ids: 209,214,208\\nstatus: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00","birth_place: \\npassport_issuer: ","status: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-08-13 00:00:00","reg_date: 2019-05-20 00:00:00"],"date":["20.05.2019 14:48:19","20.05.2019 14:48:32","20.05.2019 14:49:50","21.06.2019 11:19:48","21.06.2019 11:27:08","21.06.2019 11:27:54","21.06.2019 11:29:32","24.07.2019 13:59:05","24.07.2019 13:59:31","24.07.2019 14:00:09","24.07.2019 14:30:02"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1973-05-02	2014-02-13	2024-02-12	\N	\N	2019-06-13	2019-06-13	2020-06-13	2019-07-13	2019-06-21	2019-07-24	\N	\N	\N	\N	\N	2019-05-16	2019-05-16	2019-06-04	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
165	AA1312668	БОЗОРОВ	МУХАММАДСОДИК	229	3	{3,2,4}	1	MALE						69	1900098150	38							4619	8385696					Шереметьево 414	Государственный центр персонализации			Андижанская область		{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","status: SEEKER\\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00","work_permit_paid_till: 2019-08-11 00:00:00","visa_expired: 2019-08-29 00:00:00","birth_place: ","user_ids: 209,214,208\\nwork_permit_paid_till: 2019-09-11 00:00:00","visa_expired: 2019-09-11 00:00:00\\nreg_date: 2019-06-04 00:00:00","work_permit_paid_till: 2019-10-11 00:00:00","reg_date: 2019-09-05 00:00:00","hired_date: 2019-07-15 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00","status: FIRED","hired_date: 2019-10-04 00:00:00","fired_date: 2019-10-03 00:00:00","reg_date: 2019-10-03 00:00:00","visa_expired: 2019-10-11 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00"],"date":["04.06.2019 10:24:50","04.06.2019 10:25:02","04.06.2019 10:26:42","16.07.2019 11:56:27","16.07.2019 12:30:17","16.07.2019 12:30:53","09.08.2019 12:26:03","09.08.2019 12:26:28","09.08.2019 12:27:03","10.09.2019 13:07:48","10.09.2019 13:08:10","04.10.2019 12:08:35","04.10.2019 12:08:54","04.10.2019 13:18:07","07.10.2019 12:52:49","08.10.2019 11:18:04","08.10.2019 11:18:22","08.10.2019 11:18:34","08.10.2019 11:18:53","10.10.2019 11:25:22","30.10.2019 11:13:14","30.10.2019 11:14:42"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1995-12-12	2013-04-23	2023-04-22	\N	\N	2019-07-11	2019-07-11	2020-07-11	2019-11-11	2019-10-08	2019-10-31	\N	\N	\N	\N	2019-10-31	2019-06-01	2019-06-01	2019-10-08	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
166	C7262293	НГУЕН	ХЫУ ДЫК	232	8	{3,4,2}	1	MALE																		NGUYEN	HUU DUC			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХАЙЗЫОНГ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","status: SEEKER"],"date":["10.06.2019 15:18:30","10.06.2019 15:19:07","10.06.2019 15:19:27","12.08.2019 14:30:11"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1982-03-15	2019-05-07	2029-05-07	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	1	34	6	\N	0	1	2	2	0	0	0	\N	\N
167	AB3247577	ХАКИМОВ	АКМАЛЖОН	229	3	{3,2,4}	1	MALE						69	1900098311	39							5319	0003440	АНВАРЖОНОВИЧ				МАШТАКОВО 3	Государственный центр персонализации			Андижанская область		{"prev_value":["","employer_id: ","visa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","status: SEEKER\\nbirth_place: \\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 2019-09-10 00:00:00\\nreg_date: 2019-06-13 00:00:00","work_permit_paid_till: 2019-08-11 00:00:00","user_ids: 209,214,208\\nreg_date: 2019-06-14 00:00:00","work_permit_paid_till: 2019-09-11 00:00:00","visa_expired: 2019-09-07 00:00:00\\nreg_date: 2019-08-09 00:00:00","fired_date: 0000-00-00 00:00:00","status: WORKER"],"date":["13.06.2019 11:32:41","13.06.2019 11:33:01","13.06.2019 11:38:05","16.07.2019 13:02:46","16.07.2019 13:04:11","16.07.2019 13:05:31","09.08.2019 12:00:48","29.08.2019 13:50:52","10.09.2019 13:09:48","10.09.2019 13:10:09","01.10.2019 12:59:37","04.10.2019 11:36:01"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1986-02-23	2016-02-26	2026-02-25	\N	\N	2019-07-11	2019-07-11	2020-07-11	2019-10-11	2019-07-15	2019-10-01	\N	\N	\N	\N	2019-10-07	2019-06-10	2019-06-10	2019-09-05	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
168	C6970836	НГУЕН	ХОАНГ НАМ	232	8	{3,2,4}	1	MALE										003126263								NGUYEN 	HOANG NAM			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		Ханойское ПТУ швейной технологии и моды	ХАНАМ		{"prev_value":["","employer_id: \\noccupation_id: \\ncert_number: \\ncert_issuer: \\ncert_issued: 0000-00-00 00:00:00","host: \\nreg_address: \\nreal_address: ","employ_permit_id: ","user_ids: 209,214,208\\nstatus: SEEKER"],"date":["27.06.2019 11:37:18","27.06.2019 11:38:27","27.06.2019 11:38:48","05.08.2019 12:32:20","19.09.2019 12:04:58"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1997-03-17	2019-03-21	2029-03-21	\N	\N	\N	\N	\N	\N	\N	\N	\N	2015-06-26	\N	\N	\N	\N	\N	\N	\N	232	1	37	1	\N	0	1	2	2	0	0	0	\N	\N
169	C6871511	ХОАНГ	ТХИ НЯН	232	8	{3,2,4}	1	FEMALE																		HOANG	THI NHAN			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			Тхайбинь		{"prev_value":["","employer_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","employ_permit_id: ","user_ids: 209,214,208\\nstatus: SEEKER"],"date":["27.06.2019 11:56:10","27.06.2019 11:56:35","27.06.2019 11:56:47","05.08.2019 12:31:51","19.09.2019 12:05:20"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1979-05-30	2019-03-12	2029-03-12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	1	37	1	\N	0	1	2	2	0	0	0	\N	\N
170	B8338663	ФАМ	ДЫК ТХАНГ	232	3	{3,2,4}	1	MALE						69	1900004190	81	202401189		MULTI	WORK	13	0053420	4619	7177390		PHAM	DUC THANG		Шереметьево 074	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХЫНГИЕН		{"prev_value":["","employer_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","employ_permit_id: ","invitation_number: \\nvisa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","user_ids: 209,214,208\\nstatus: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 0667079\\nvisa_issued: 2019-08-12 00:00:00\\nvisa_started: 2019-08-12 00:00:00\\nvisa_expired: 2019-10-30 00:00:00","status: WORKER\\nwork_permit_paid_till: 0000-00-00","work_address: ","reg_date: 2019-08-14","departure_date: 0000-00-00","departure_date: 2020-09-10","status: FURLOUGH\\nfired_date: 0000-00-00"],"date":["27.06.2019 12:13:20","27.06.2019 12:13:36","27.06.2019 12:13:50","05.08.2019 12:32:44","14.08.2019 12:36:34","05.09.2019 13:54:56","05.09.2019 14:09:31","05.09.2019 14:09:54","17.10.2019 12:02:25","10.03.2020 10:53:48","10.03.2020 10:55:10","10.03.2020 10:55:29","10.03.2020 11:25:51","27.03.2020 11:31:24","07.04.2020 11:42:35"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-04-24	2013-09-07	2023-09-07	\N	\N	2019-08-28	2019-07-02	2020-07-01	\N	2019-09-05	2020-04-07	\N	\N	2019-10-15	2019-10-31	2020-07-01	2019-08-13	2019-08-13	2019-10-18	2020-03-10	232	1	37	1	\N	0	1	2	2	0	2	0	\N	\N
171	ID0459883	ДИКАНОВ	ШОХАББОС	115	3	{3,2,4}	1	MALE								40							5319	0078020	УЛУГБЕКОВИЧ				САГАРЧИН 043	МКК 214041			КЫРГЫЗСКАЯ РЕСПУБЛИКА		{"prev_value":["","employer_id: \\noccupation_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","passport_number: ID459883","status: SEEKER\\nbirth_place: ","contract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","citizenship: ","user_ids: 209,214,208\\ncurrent_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: WORKER"],"date":["10.07.2019 11:48:29","10.07.2019 11:48:43","10.07.2019 11:50:29","10.07.2019 12:08:25","24.07.2019 14:38:56","24.07.2019 14:39:14","24.07.2019 14:39:51","19.08.2019 14:17:42","21.01.2020 14:36:33","21.01.2020 14:36:39"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1999-11-03	2017-12-21	\N	\N	\N	\N	\N	\N	\N	2019-07-24	2020-01-20	\N	\N	\N	\N	\N	2019-06-22	2019-06-22	2019-07-10	\N	115	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
172	AA0831771	СУЛТОНОВА	ФЕРУЗА	229	3	{3,2,4}	1	FEMALE						69	1900110255	43							5319	0245229	МУБИНОВНА				САГАРЧИН 042	Государственный центр персонализации			Бухарская область		{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","last_name_ru: \\u0421\\u0423\\u041b\\u0422\\u0410\\u041d\\u041e\\u0412\\u0410","birth_date: 2079-07-24 00:00:00","status: SEEKER\\nbirth_place: ","passport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-10-15 00:00:00"],"date":["22.07.2019 15:34:37","22.07.2019 15:34:48","22.07.2019 15:37:02","22.07.2019 16:00:27","22.07.2019 16:25:54","23.08.2019 14:05:43","23.08.2019 14:05:51","23.08.2019 14:06:55","23.08.2019 14:07:20","05.09.2019 10:57:00","05.09.2019 10:57:21","05.09.2019 10:57:37"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1979-07-24	2013-02-08	2023-02-07	\N	\N	2019-08-22	2019-08-22	2020-08-22	2019-09-22	2019-08-23	2019-09-05	\N	\N	\N	\N	\N	2019-07-18	2019-07-18	2019-07-23	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
173	AB7843159	ТУРГУНОВА	НАСИБАХОН	229	3	{3,2,4}	1	FEMALE						69	1900110262	42							5319	0245228	ТУЙЧИБАЕВНА				САГАРЧИН 042	Государственный центр персонализации			Андижанская область		{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","middle_name_ru: \\u0422\\u0423\\u0419\\u0413\\u0418\\u0411\\u041e\\u0415\\u0412\\u041d\\u0410","status: SEEKER\\nbirth_place: \\npassport_issuer: ","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","visa_expired: 2019-10-15 00:00:00"],"date":["22.07.2019 15:45:17","22.07.2019 15:45:27","22.07.2019 15:47:15","22.07.2019 16:32:23","23.08.2019 14:01:46","23.08.2019 14:03:06","23.08.2019 14:03:30","05.09.2019 11:03:16","05.09.2019 11:03:31","05.09.2019 11:03:43"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1987-01-12	2017-10-04	2027-10-03	\N	\N	2019-08-22	2019-08-22	2020-08-22	2019-09-22	2019-08-23	2019-09-05	\N	\N	\N	\N	\N	2019-07-18	2019-07-18	2019-07-23	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
174	AB0660826	КУРБАНОВ	ФАРРУХБЕК	229	3	{3,2,4}	1	MALE						69	1900110230	41							5319	0245248	БАХРАМОВИЧ				САГАРЧИН 042	Государственный центр персонализации			Андижанская область		{"prev_value":["","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","status: SEEKER\\nbirth_place: \\npassport_issuer: ","employer_id: \\nwork_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\noccupation_id: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","visa_expired: 0000-00-00 00:00:00","status: WORKER\\nfired_date: 0000-00-00 00:00:00","visa_expired: 2019-10-15 00:00:00","work_permit_expired: 2019-08-22 00:00:00"],"date":["22.07.2019 16:11:11","22.07.2019 16:13:10","23.08.2019 13:50:44","23.08.2019 13:52:46","23.08.2019 13:53:22","05.09.2019 10:52:48","06.09.2019 12:33:33","06.09.2019 12:33:44"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-02-17	2015-08-06	2025-08-05	\N	\N	2019-08-22	2019-08-22	2020-08-22	2019-09-22	2019-08-23	2019-09-05	\N	\N	\N	\N	\N	2019-07-18	2019-07-18	2019-07-23	\N	229	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
175	AA4013107	ИМЯМИНОВ	БАХОДИР	229	6	{3,2,4}	1	MALE															4618	3578901					ДОМОДЕВО 209						{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","status: SEEKER"],"date":["26.07.2019 09:21:42","26.07.2019 09:21:54","26.07.2019 09:22:59","29.07.2019 11:54:46"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1989-01-31	2014-01-20	2024-01-19	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-07-22	2019-07-22	\N	\N	0	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
176	402051168	РУСТАМОВ	РАХИМДЖОН	209	6	{3,2,4}	1	MALE															4618	6497358	РАВШАНОВИЧ				РАМЕНСКОЕ 103					КИМРСКИЙ РАЙОН, ПОС. ПРИВОЛЖСКИЙ, УЛ.ЛЕСНАЯ, ДОМ8	{"prev_value":["","employer_id: ","entry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: \\nreal_address: ","status: SEEKER","fired_date: 0000-00-00 00:00:00"],"date":["30.07.2019 10:41:10","30.07.2019 10:41:46","30.07.2019 10:43:47","02.09.2019 13:16:22","02.09.2019 13:21:28"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	2000-05-27	2018-04-09	2028-04-08	\N	\N	\N	\N	\N	\N	\N	2018-09-30	\N	\N	\N	\N	\N	2019-07-27	2019-07-27	2019-07-30	\N	209	7	0	0	\N	0	7	2	2	0	0	0	\N	\N
177	C7845183	ДОАН	ТХИ ХЫОНГ ЛАН	232	3	{3,2,4}	1	FEMALE						69	2000003990	83	202401577	011486	MULTI	WORK	13	0061692	4619	7396816		DOAN	THI HUONG LAN		Шереметьево 844	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТАН"	ХАЙЗЫОНГ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: \\ncert_number: \\ncert_issuer: \\ncert_issued: 0000-00-00 00:00:00","host: \\nreg_address: \\nreal_address: ","invitation_number: \\nvisa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","status: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_expired: 2019-03-25 00:00:00","contract_number: ","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 1096881\\nvisa_issued: 2019-09-12 00:00:00\\nvisa_started: 2019-09-13 00:00:00\\nvisa_expired: 2019-12-11 00:00:00","employ_permit_id: 33\\nwork_permit_number: 1900004507\\nwork_permit_issued: 2019-10-04\\nwork_permit_started: 2019-10-04\\nwork_permit_expired: 2020-03-25","visa_number: 0053840\\nvisa_issued: 2019-11-07\\nvisa_started: 2019-12-12\\nvisa_expired: 2020-03-25\\nreg_date: 2019-09-17","status: WORKER\\nfired_date: 0000-00-00"],"date":["31.07.2019 11:25:19","31.07.2019 11:27:37","31.07.2019 11:28:49","17.09.2019 14:37:19","07.10.2019 13:00:22","07.10.2019 13:01:32","07.10.2019 13:01:57","07.10.2019 14:02:55","13.11.2019 16:43:44","13.11.2019 16:45:33","20.03.2020 13:02:03","20.03.2020 13:03:26","23.12.2020 12:49:53"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1990-02-25	2019-07-19	2029-07-19	\N	\N	2020-03-13	2020-03-25	2021-03-24	\N	2019-10-07	2020-12-24	\N	2016-07-04	2020-03-16	2020-03-26	2021-03-24	2019-09-16	2019-09-16	2020-03-24	\N	232	1	48	1	\N	0	7	2	2	0	2	0	\N	\N
178	C7256145	НГУЕН	ВАН МАНЬ	232	3	{3,2,4}	1	MALE						69	1900004641	84			MULTI	WORK	13	0061033	4619	7541469		NGUYEN	VAN MANH		Шереметьево 584	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХАЙЗЫОНГ		{"prev_value":["","employer_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","employ_permit_id: ","status: SEEKER","status: CANCELLED","employ_permit_id: 35","visa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","status: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","current_passport_number: \\nvisa_issuer: \\nvisa_serie: 24\\nvisa_number: 1100730\\nvisa_issued: 2019-10-04 00:00:00\\nvisa_started: 2019-10-04 00:00:00\\nvisa_expired: 2019-12-29 00:00:00","current_passport_number: \\nstatus: WORKER\\nwork_permit_paid_till: 0000-00-00\\nfired_date: 0000-00-00","current_passport_number: \\nwork_address: ","current_passport_number: \\nvisa_multiplicity: SINGLE\\nreg_date: 2019-10-15"],"date":["05.08.2019 12:10:48","05.08.2019 12:11:20","05.08.2019 12:11:32","05.08.2019 13:14:40","09.08.2019 09:30:40","14.08.2019 11:47:56","29.08.2019 12:37:36","14.10.2019 12:13:45","30.10.2019 11:47:27","01.11.2019 10:20:40","01.11.2019 10:22:00","16.12.2019 12:52:23","04.03.2020 10:50:44","04.03.2020 10:51:06","04.03.2020 10:52:08"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1988-08-20	2019-04-26	2029-04-26	\N	\N	2019-10-29	2019-10-29	2020-09-11	\N	2019-11-01	2020-03-03	\N	\N	2019-11-25	2019-11-25	2020-09-11	2019-10-12	2019-10-12	2019-12-18	\N	232	1	38	1	\N	0	1	2	2	0	2	0	\N	\N
179	C6289749	НГУЕН	ВАН ЗУНГ	232	10	{2,3,4}	1	MALE																		NGUYEN	VAN DUNG			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			Тхайбинь		{"prev_value":["","employer_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","employ_permit_id: ","status: SEEKER","user_ids: 209,208,214\\ncurrent_passport_number: \\nstatus: CANCELLED"],"date":["09.08.2019 09:37:18","09.08.2019 09:37:31","09.08.2019 09:37:44","29.08.2019 12:36:52","30.10.2019 11:38:57","17.01.2020 11:42:34"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	1990-04-21	2018-10-31	2028-10-31	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	1	38	1	\N	0	1	2	2	0	0	0	\N	\N
180	C1924533	ФАМ	ТХИ ХИЕН	232	3	{3,2,4}	1	FEMALE						69	1900004497	82	202401578		MULTI	WORK	13	0053839	4619	7396815		PHAM 	THI HIEN		Шереметьево 844	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАКЗАНГ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","visa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","visa_serie: 21","invitation_number: ","status: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","work_permit_expired: 2019-07-10 00:00:00","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 1096880\\nvisa_issued: 2019-09-12 00:00:00\\nvisa_started: 2019-09-13 00:00:00\\nvisa_expired: 2019-12-11 00:00:00","status: WORKER","fired_date: 0000-00-00 00:00:00","reg_date: 2019-09-17 00:00:00","reg_date: 2019-09-15 00:00:00"],"date":["09.08.2019 09:51:56","09.08.2019 09:52:19","09.08.2019 09:52:34","17.09.2019 14:24:24","17.09.2019 14:45:41","17.09.2019 14:45:59","07.10.2019 12:54:00","07.10.2019 12:55:10","07.10.2019 12:55:36","07.10.2019 13:57:13","13.11.2019 18:08:21","11.12.2019 12:12:03","11.12.2019 12:14:34","11.12.2019 12:17:13","11.12.2019 12:25:21"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1975-11-02	2016-06-30	2026-06-30	\N	\N	2019-10-04	2019-10-04	2020-07-10	\N	2019-10-07	2019-12-10	\N	\N	2019-11-07	2019-12-12	2020-07-10	2019-09-16	2019-09-16	2019-11-15	\N	232	1	35	1	\N	0	1	2	2	0	2	0	\N	\N
181	C7855138	НГУЕН	ТХИ НГАН	232	10	{2,3,4}	1	FEMALE																		NGUYEN	THI NGAN			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			Тхайбинь		{"prev_value":["","employer_id: \\noccupation_id: ","host: \\nreg_address: \\nreal_address: ","passport_issued: 0000-00-00 00:00:00\\npassport_expired: 0000-00-00 00:00:00","employ_permit_id: ","status: SEEKER","user_ids: 209,208,214\\ncurrent_passport_number: \\nstatus: CANCELLED"],"date":["09.08.2019 10:22:58","09.08.2019 10:23:16","09.08.2019 10:23:29","09.08.2019 11:10:28","29.08.2019 12:37:14","30.10.2019 11:39:11","17.01.2020 11:42:43"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	1990-11-15	2019-07-12	2029-07-12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	1	38	1	\N	0	1	2	2	0	0	0	\N	\N
182	N2093037	НГУЕН	ТХАНЬ ЛУАН	232	5	{3,2,4}	1	MALE						69	2100005285	87		00031905	MULTI	WORK	12	1946498	2808	0000728		NGUYEN 	THANH LUAN		Шереметьево 685	ПОСОЛЬСТВО ВЬЕТНАМА В РОССИИ		Хынгиенский промышленный колледж	БАКЖАНГ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: \\ncert_number: \\ncert_issuer: \\ncert_issued: 0000-00-00 00:00:00","user_ids: 209,208,214,215\\nhost: \\nreg_address: \\nreal_address: ","occupation_id: 1","user_ids: 209,208,214\\nstatus: SEEKER","status: WORKER","user_ids: 208,209,214\\nvisa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","status: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00","contract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","migr_card_serie: 4619\\nmigr_card_number: 7646541","current_passport_number: \\nvisa_serie: 24\\nvisa_number: 1628704\\nvisa_issued: 2019-11-11 00:00:00\\nvisa_started: 2019-11-11 00:00:00\\nvisa_expired: 2020-01-22 00:00:00","current_passport_number: ","employ_permit_id: 34\\nwork_permit_number: 1900004962\\nwork_permit_issued: 2019-12-10\\nwork_permit_started: 2019-12-10\\nwork_permit_expired: 2020-04-04","visa_number: 0061424\\nvisa_issued: 2019-12-23\\nvisa_started: 2019-12-23\\nvisa_expired: 2020-04-04\\nreg_date: 2019-11-26","work_permit_started: 2020-03-25\\nwork_permit_expired: 2021-03-24","employ_permit_id: 47\\nwork_permit_number: 2000003968\\nwork_permit_issued: 2020-03-13\\nwork_permit_started: 2020-03-13\\nwork_permit_expired: 2021-04-03","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 13\\nvisa_number: 0061689\\nvisa_issued: 2020-03-16\\nvisa_started: 2020-04-05\\nvisa_expired: 2021-04-03\\nreg_date: 2020-03-24","work_permit_started: 0000-00-00"],"date":["19.09.2019 14:30:57","19.09.2019 14:32:26","19.09.2019 14:32:41","23.09.2019 13:03:26","11.11.2019 22:34:46","11.11.2019 22:35:15","25.11.2019 17:23:45","10.12.2019 14:59:50","10.12.2019 15:01:39","10.12.2019 15:03:12","10.12.2019 15:04:14","10.12.2019 15:21:07","26.12.2019 18:38:37","26.12.2019 18:43:46","20.03.2020 13:29:06","20.03.2020 13:30:24","13.05.2020 16:31:11","18.03.2021 16:24:18","18.03.2021 16:28:54","22.03.2021 13:26:54"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-08-15	2019-05-06	2029-05-06	\N	\N	2021-03-15	2021-04-03	2022-03-31	\N	2019-12-10	\N	\N	2009-07-02	2021-03-15	2021-04-04	2022-03-31	2019-11-20	2019-11-20	2021-03-23	\N	232	1	57	6	\N	0	1	2	2	0	2	0	\N	\N
183	C8094297	ВУ	ВАН ДИЕП	232	3	{3,2,4}	1	MALE						69	1900004698	86		00312205	MULTI	WORK	13	0061425	4619	7579601		VU	VAN DIEP		Шереметьево 677	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ		ЧАСТНОЕ ПТУ "ЗУИТАН"	ХАЙЗЫОНГ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: \\ncert_number: \\ncert_issuer: \\ncert_issued: 0000-00-00 00:00:00","user_ids: 209,208,214,215\\nhost: \\nreg_address: \\nreal_address: ","passport_issued: 0000-00-00 00:00:00\\npassport_expired: 0000-00-00 00:00:00","passport_issued: 2019-05-06 00:00:00\\npassport_expired: 2029-05-06 00:00:00","visa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","visa_number: 1627632","status: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","current_passport_number: \\nvisa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 1627756\\nvisa_issued: 2019-10-24 00:00:00\\nvisa_started: 2019-10-25 00:00:00\\nvisa_expired: 2020-01-22 00:00:00","current_passport_number: \\nwork_permit_paid_till: 0000-00-00","current_passport_number: \\nstatus: WORKER\\nwork_permit_paid_till: 0000-00-00","current_passport_number: \\nwork_address: ","current_passport_number: \\nfired_date: 0000-00-00","current_passport_number: \\nreg_date: 2019-10-29","current_passport_number: \\nfired_date: 2020-03-04","current_passport_number: "],"date":["19.09.2019 15:41:58","19.09.2019 15:43:27","19.09.2019 15:43:38","19.09.2019 15:48:21","23.09.2019 12:53:19","29.10.2019 13:18:51","29.10.2019 14:50:24","25.11.2019 15:38:16","25.11.2019 15:40:43","25.11.2019 15:40:59","09.01.2020 17:38:16","04.03.2020 10:32:55","04.03.2020 10:33:08","04.03.2020 10:40:27","04.03.2020 10:40:56","04.03.2020 10:42:40","04.03.2020 10:46:57","04.03.2020 10:47:04"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1988-11-25	2019-08-27	2029-08-27	\N	\N	2019-11-12	2019-11-12	2020-07-01	\N	2019-11-25	2020-03-03	\N	2008-09-05	2019-12-23	2020-01-23	2020-07-01	2019-10-27	2019-10-27	2020-01-10	\N	232	1	37	1	\N	0	1	2	2	0	2	0	\N	\N
184	C1546070	ДИНЬ	ХЫУ КХЫОНГ	232	5	{3,2,4}	1	MALE						69	2000004619	85	202401866		MULTI	WORK	12	1770608	4619	7579602		DINH	HUU KHUONG		Шереметьево 677	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ИЕНБАЙ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: ","user_ids: 209,208,214,215\\nhost: \\nreg_address: \\nreal_address: ","invitation_number: \\nvisa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00","status: SEEKER","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00","reg_date: 0000-00-00 00:00:00","current_passport_number: \\ncontract_number: ","current_passport_number: \\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 1627632\\nvisa_issued: 2019-10-24 00:00:00\\nvisa_started: 2019-10-25 00:00:00\\nvisa_expired: 2020-01-22 00:00:00","work_address: ","reg_date: 2019-10-29","employ_permit_id: 37\\nwork_permit_number: 1900004708\\nwork_permit_issued: 2019-11-12\\nwork_permit_started: 2019-11-12\\nwork_permit_expired: 2019-07-01","visa_serie: 13\\nvisa_number: 0061426\\nvisa_issued: 2019-12-23\\nvisa_started: 2020-01-23\\nvisa_expired: 2020-07-01\\nreg_date: 2020-07-10"],"date":["19.09.2019 15:46:54","19.09.2019 15:47:08","19.09.2019 15:47:29","29.10.2019 13:33:08","25.11.2019 14:44:09","25.11.2019 14:45:27","25.11.2019 14:45:55","09.01.2020 18:15:23","09.01.2020 18:17:31","13.05.2020 15:05:25","13.05.2020 15:06:32","23.06.2020 13:46:39","23.06.2020 13:48:49"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1985-02-10	2016-03-24	2026-03-24	\N	\N	2020-06-17	2020-07-01	2021-06-30	\N	2019-11-25	\N	\N	\N	2020-06-18	2020-07-02	2021-06-30	2019-10-27	2019-10-27	2020-06-26	\N	232	1	49	1	\N	0	1	2	2	0	2	0	\N	\N
185	C8081367	НГУЕН	ВАН ДЫК	232	3	{3,2,4}	1	MALE						69	2000004922	23	202402234		MULTI	WORK	12	1771217	4619	7818272		NGUYEN	VAN DUC		шереметьево 646	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			Тхайбинь		{"prev_value":["","employer_id: ","user_ids: 209,208,214,215\\nhost: \\nreg_address: \\nreal_address: ","employer_id: 1","occupation_id: ","employ_permit_id: ","user_ids: 209,208,214\\nstatus: SEEKER\\nhired_date: 0000-00-00 00:00:00","status: WORKER\\nhired_date: 2019-12-04 00:00:00","user_ids: 208,209,214\\ncurrent_passport_number: \\ninvitation_number: \\nvisa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","current_passport_number: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: SEEKER","current_passport_number: \\nwork_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_address: ","current_passport_number: \\nwork_permit_number: 1000003703","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 1630761\\nvisa_issued: 2019-12-23\\nvisa_started: 2019-12-23\\nvisa_expired: 2020-03-21","work_permit_number: 2000003703\\nwork_permit_issued: 2020-01-20\\nwork_permit_started: 2020-01-20\\nwork_permit_expired: 2020-10-23\\nwork_permit_paid_till: 0000-00-00","employ_permit_id: 42","visa_serie: 13\\nvisa_number: 0061631\\nvisa_issued: 2020-03-10\\nvisa_started: 2020-03-22\\nvisa_expired: 2020-10-23","status: WORKER\\nfired_date: 0000-00-00","reg_date: 2019-12-28"],"date":["19.09.2019 15:55:02","19.09.2019 15:56:36","19.09.2019 15:56:52","19.09.2019 15:57:00","20.11.2019 13:59:28","20.11.2019 14:00:41","04.12.2019 10:05:15","04.12.2019 10:05:59","28.12.2019 10:31:36","21.01.2020 12:54:54","21.01.2020 12:55:01","21.01.2020 12:56:02","21.01.2020 12:57:35","17.03.2020 10:42:51","22.10.2020 12:22:37","22.10.2020 12:25:33","22.10.2020 12:27:18","12.04.2021 13:05:24","12.04.2021 13:06:06"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1994-10-20	2019-08-28	2029-08-28	\N	\N	2020-10-13	2020-10-23	2021-10-22	\N	2020-01-21	2021-04-12	\N	\N	2020-10-20	2020-10-24	2021-10-22	2019-12-26	2019-12-26	2020-10-23	\N	232	4	50	6	\N	0	4	2	2	0	2	0	\N	\N
186	400989903	МАХМУДОВ	ТОХИРШЕХ	209	6	{3,2,4}	1	MALE															4618	6560457	НЕЪМАТШЕХОВИЧ				РАМЕНСКОЕ 048	УМВД В Б.ГАФУРОВЕ					{"prev_value":["","passport_issued: 0000-00-00 00:00:00\\npassport_expired: 0000-00-00 00:00:00","user_ids: 209,208,214,215\\nemployer_id: \\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","current_passport_number: \\nvisa_expired: 0000-00-00 00:00:00","current_passport_number: \\nstatus: FAMILY\\nwork_permit_paid_till: 0000-00-00"],"date":["10.10.2019 11:36:49","10.10.2019 11:37:37","10.10.2019 11:39:34","16.12.2019 12:41:01","04.03.2020 11:46:50"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	2006-11-13	2016-03-31	2020-03-30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-01-03	2019-10-06	2019-10-06	\N	\N	209	4	0	0	\N	0	4	2	2	0	0	0	\N	\N
187	400989905	МАХМУДОВА	БИРОБИЯ	209	6	{3,2,4}	1	FEMALE															4618	6560456	НЕЪМАТШЕХОВНА				ДОМОДЕВО 583	УМВД В Б.ГАФУРОВЕ					{"prev_value":["","employer_id: ","user_ids: 209,208,214,215\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","current_passport_number: \\nvisa_expired: 0000-00-00 00:00:00","current_passport_number: \\nstatus: FAMILY\\nwork_permit_paid_till: 0000-00-00"],"date":["10.10.2019 12:16:19","10.10.2019 12:16:28","10.10.2019 12:17:55","16.12.2019 12:41:25","04.03.2020 11:47:07"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	2007-12-07	2016-03-31	2020-03-30	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-01-03	2019-10-06	2019-10-06	\N	\N	209	4	0	0	\N	0	4	2	2	0	0	0	\N	\N
188	401935860	ФОЗИЛОВА	ФИРУЗА	209	3	{3,2,4}	1	FEMALE						69	1900136768	40							4618	6585820	АБДУМАВЛОНОВНА				РАМЕНСКОЕ 097	ОМВД В Б.ГАФУРОВ					{"prev_value":["","employer_id: \\noccupation_id: ","user_ids: 209,208,214,215\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","status: SEEKER\\npassport_issuer: ","hired_date: 0000-00-00 00:00:00","contract_number: ","reg_date: 0000-00-00 00:00:00","work_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00","current_passport_number: \\nwork_permit_paid_till: 2020-01-06 00:00:00","current_passport_number: \\nvisa_expired: 0000-00-00 00:00:00","current_passport_number: \\nfired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: WORKER","current_passport_number: \\nvisa_expired: 2020-02-06 00:00:00\\nreg_date: 2019-11-08 00:00:00"],"date":["08.11.2019 12:42:54","08.11.2019 12:43:14","08.11.2019 12:45:31","11.12.2019 13:13:07","11.12.2019 13:13:23","11.12.2019 13:17:33","11.12.2019 13:17:58","11.12.2019 13:34:57","25.12.2019 09:14:15","25.12.2019 09:15:44","27.01.2020 15:03:50","27.01.2020 15:03:57","27.01.2020 15:06:06"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1969-04-13	2018-01-31	2028-01-30	\N	\N	2019-12-06	2019-12-06	2020-12-06	2020-02-06	2019-12-11	2020-01-27	\N	\N	\N	\N	\N	2019-11-07	2019-11-07	2019-12-25	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
189	402054833	ФАЁЗОВА	АДОЛАТ	209	6	{3,2,4}	1	FEMALE															4618	6585819	МУЙДИНОВНА				РАМЕНСКОЕ 097						{"prev_value":["","employer_id: \\noccupation_id: ","user_ids: 209,208,214,215\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","current_passport_number: \\nstatus: SEEKER\\ndeparture_date: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","current_passport_number: "],"date":["08.11.2019 12:50:17","08.11.2019 12:50:29","08.11.2019 12:51:35","23.12.2019 14:22:00","23.12.2019 14:23:14"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1972-01-25	2018-04-18	2028-04-17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2019-11-07	2019-11-07	2019-11-08	2019-12-23	209	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
190	C6598031	НГУЕН	ДАК ХАО	232	5	{3,2,4}	1	MALE						69	2000005034	89	202402235		MULTI	WORK	12	1771294	4619	7818270		NGUYEN	DAC HAO		шереметьево 646	МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			БАКНИНЬ		{"prev_value":["","employer_id: \\nemploy_permit_id: \\noccupation_id: ","user_ids: 209,208,214,215\\nhost: \\nreg_address: \\nreal_address: ","current_passport_number: \\ninvitation_number: \\nvisa_issuer: \\nvisa_multiplicity: \\nvisa_category: \\nvisa_serie: \\nvisa_number: \\nvisa_issued: 0000-00-00 00:00:00\\nvisa_started: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00\\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","current_passport_number: \\nreg_date: 2019-12-30 00:00:00","current_passport_number: \\ncontract_number: \\nhired_date: 0000-00-00 00:00:00","current_passport_number: \\nstatus: SEEKER","current_passport_number: \\nwork_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_address: ","current_passport_number: ","visa_issuer: \\u0412\\u042c\\u0415\\u0422\\u041d\\u0410\\u041c \\u0413.\\u0425\\u0410\\u041d\\u041e\\u0419\\nvisa_multiplicity: SINGLE\\nvisa_serie: 24\\nvisa_number: 1630760\\nvisa_issued: 2019-12-23\\nvisa_started: 2019-12-23\\nvisa_expired: 2020-03-21","employ_permit_id: 41\\nwork_permit_number: 2000003693\\nwork_permit_issued: 2020-01-20\\nwork_permit_started: 2020-01-20\\nwork_permit_expired: 2020-11-26\\nhired_date: 2020-01-21","visa_serie: 13\\nvisa_number: 0061630\\nvisa_issued: 2020-03-10\\nvisa_started: 2020-03-22\\nvisa_expired: 2020-11-26\\nreg_date: 2019-12-28","reg_date: 0000-00-00"],"date":["20.11.2019 14:59:30","20.11.2019 15:00:41","20.11.2019 15:00:53","28.12.2019 10:04:50","28.12.2019 10:05:09","21.01.2020 12:27:02","21.01.2020 12:27:08","21.01.2020 12:28:29","21.01.2020 12:29:55","17.03.2020 11:01:02","16.11.2020 17:28:28","16.11.2020 17:30:18","19.11.2020 12:45:19"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1980-05-25	2019-01-10	2029-01-10	\N	\N	2020-10-28	2020-11-21	2021-11-20	\N	2020-11-21	\N	\N	\N	2020-11-09	2020-11-27	2021-11-20	2019-12-26	2019-12-26	2020-11-18	\N	232	1	51	1	\N	0	1	2	2	0	2	0	\N	\N
191	401488265	ПОЧОДЖОНОВА	РУХСАТОЙ	209	3	{3,2,4}	1	FEMALE						69	1900139617	41							4618	6595129	АСКАРОВНА					ОВД В ХУДЖАНДЕ					{"prev_value":["","employer_id: \\noccupation_id: ","user_ids: 209,208,214,215\\nentry_date: 0000-00-00 00:00:00\\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_address: \\nreal_address: ","current_passport_number: \\nwork_permit_serie: \\nwork_permit_number: \\nwork_permit_issuer: \\nwork_permit_issued: 0000-00-00 00:00:00\\nwork_permit_started: 0000-00-00 00:00:00\\nwork_permit_expired: 0000-00-00 00:00:00\\nwork_permit_paid_till: 0000-00-00 00:00:00\\nhired_date: 0000-00-00 00:00:00","current_passport_number: \\nvisa_expired: 0000-00-00 00:00:00\\nreg_date: 0000-00-00 00:00:00","current_passport_number: ","current_passport_number: \\ncontract_number: ","current_passport_number: \\nstatus: SEEKER","current_passport_number: \\npassport_issuer: ","current_passport_number: \\npassport_issuer: \\u041e\\u0412\\u0414 \\u0425\\u0423\\u0414\\u0416\\u0410\\u041d\\u0414\\u0415","current_passport_number: \\nwork_permit_paid_till: 2020-01-16 00:00:00","current_passport_number: \\nstatus: WORKER","current_passport_number: \\nfired_date: 0000-00-00 00:00:00"],"date":["22.11.2019 12:48:06","22.11.2019 12:48:31","22.11.2019 12:49:39","17.12.2019 16:28:45","17.12.2019 16:29:53","17.12.2019 16:29:55","17.12.2019 16:35:42","17.12.2019 16:35:51","17.12.2019 16:36:04","18.12.2019 10:11:44","25.12.2019 09:02:13","09.01.2020 16:31:04","09.01.2020 16:31:17"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1972-09-28	2017-04-17	2027-04-16	\N	\N	2019-12-16	2019-12-16	2020-12-16	2020-02-16	2019-12-18	2020-01-09	\N	\N	\N	\N	2020-02-17	2019-11-20	2019-11-20	2019-11-22	\N	209	7	0	1	\N	0	7	2	2	0	2	0	\N	\N
193	#4	Басов	Дмитрий	0	11	{}	1	MALE																	Борисович										{"prev_value":[""],"date":["06.02.2020 11:49:15"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	\N	0	0	0	0	0	0	0	\N	\N
194	C3552764	ВУ	ХОНГ ВИНЬ	232	8	{3,2,4}	1	MALE																		VU	HONG VINH			МИГРАЦИОННЫЙ ДЕПАРТАМЕНТ			ХЫНГИЕН		{"prev_value":["","current_passport_number: \\nemployer_id: \\nemploy_permit_id: \\noccupation_id: \\nwork_address: ","user_ids: 209,208,214,215\\ncurrent_passport_number: \\nhost: \\nreg_address: \\nreal_address: ","current_passport_number: \\nemploy_permit_id: 44","status: SEEKER"],"date":["06.02.2020 14:04:29","06.02.2020 14:05:21","06.02.2020 14:05:47","25.02.2020 10:42:41","16.04.2020 14:10:23"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1993-02-11	2017-06-23	2027-06-23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	232	4	45	6	\N	0	4	2	2	0	0	0	\N	\N
195	AN4838083	ДИКАНОВ	ШУХРАТ	115	3	{3,2,4}	1	MALE								45							4620	0263837	САДИКЖАНОВИЧ				ДОМОДЕДОВО 640	МКК 50-32			КЫРГЫЗСТАН		{"prev_value":["","user_ids: 209,208,214,215\\ncurrent_passport_number: \\nentry_date: 0000-00-00 00:00:00\\nentry_checkpoint: \\nmigr_card_serie: \\nmigr_card_number: \\nmigr_card_issued: 0000-00-00 00:00:00\\nhost: \\nreg_date: 0000-00-00 00:00:00\\nreg_address: ","current_passport_number: ","current_passport_number: \\nemployer_id: \\noccupation_id: \\nwork_address: ","current_passport_number: \\nreal_address: ","current_passport_number: \\nmigr_card_serie: 46 20","current_passport_number: \\nwork_permit_paid_till: 0000-00-00 00:00:00\\nvisa_expired: 0000-00-00 00:00:00","contract_number: \\nhired_date: 0000-00-00","status: SEEKER","host: 4","hired_date: 2010-03-11","work_permit_paid_till: 0000-00-00\\nvisa_expired: 2020-05-22","status: WORKER\\nfired_date: 0000-00-00"],"date":["26.02.2020 12:38:09","26.02.2020 12:39:40","26.02.2020 12:39:46","27.02.2020 11:14:12","27.02.2020 11:14:24","27.02.2020 11:15:41","27.02.2020 11:20:36","11.03.2020 11:30:25","11.03.2020 11:30:34","11.03.2020 11:30:57","17.03.2020 10:19:34","07.04.2020 12:02:58","07.04.2020 12:54:51"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	1984-10-23	2017-02-22	2027-02-22	\N	\N	\N	\N	\N	\N	2020-03-11	2020-04-07	\N	\N	\N	\N	2021-03-10	2020-02-23	2020-02-23	2020-02-27	\N	0	7	0	1	\N	0	7	2	2	0	0	0	\N	\N
196	#7734418884	Сосновская	Яна	177	1	{}	1																		Ивановна										{"prev_value":[""],"date":["21.04.2020 12:14:06"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	\N	0	0	0	0	0	0	0	\N	\N
197	#6910023875	Чинь	Динь Лан	177	1	{}	1																												{"prev_value":[""],"date":["21.04.2020 12:16:28"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	0	\N	0	0	0	0	0	0	0	\N	\N
\.


--
-- Data for Name: employers; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.employers (id, name_ru, full_name_ru, director_id, type_id, user_ids, published, taxpayer_code, active_business_type, rcoad, bcc, acc_book_number, account_number, bank, ca, bic, acc_reg_number, uni_reg_number, phone, prime_reg_number, history, acc_reg_date, prime_reg_date, uni_reg_date, booker_id, taxpayer_id, address_id, created_at, updated_at) FROM stdin;
1	ООО "Унисервис"	Общество с ограниченной ответственностью "Унисервис"	3	2	{2,3,4,5}	1	691001001	14.12 Производство спецодежды	28426000000		506		ООО КБ "Гефест", г. Кимры	30101810028090000992	042809992	69 002236098	69 002236097	+7 48236 31771	1166952050077	{"prev_value":["user_ids: 209,215,214,208\\nbank: \\u041e\\u041e\\u041e \\u041a\\u0411\\"\\u0413\\u0435\\u0444\\u0435\\u0441\\u0442\\",\\u0433.\\u041a\\u0438\\u043c\\u0440\\u044b"],"date":["01.11.2019 22:19:19"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	2016-01-11	2016-01-11	2016-01-12	4	6910022825	1	\N	\N
2	УВМ УМВД РОССИИ по Тверской области	Управление по вопросам миграции УМВД России по Тверской области	18	10	{3,5,4,2}	1														{"prev_value":["name: \\u0423\\u0412\\u041c \\u0423\\u041c\\u0412\\u0414 \\u043f\\u043e \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u043e\\u0439 \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u0438"],"date":["08.11.2018 11:02:14"],"user":["#209 \\u042e\\u043b\\u044f"]}	\N	\N	\N	0	0	0	\N	\N
3	Отделение по вопросам Миграции МО МВД России "Кимрский"	Отделение  по вопросам миграции «Кимрский» УВМ УМВД по Тверской области	0	11	{3,4,5,2}	1														{"prev_value":["user_ids: 208,209,215,214\\nname: \\u041e\\u0412\\u041c \\u00ab\\u041a\\u0438\\u043c\\u0440\\u0441\\u043a\\u0438\\u0439\\u00bb \\u0423\\u0412\\u041c \\u0423\\u041c\\u0412\\u0414 \\u043f\\u043e \\u0422\\u0432\\u0435\\u0440\\u0441\\u043a\\u043e\\u0439 \\u043e\\u0431\\u043b\\u0430\\u0441\\u0442\\u0438"],"date":["19.02.2019 12:25:07"],"user":["#209 \\u042e\\u043b\\u044f"]}	\N	\N	\N	0	0	0	\N	\N
4	ООО "Белка"	Общество с ограниченной ответственностью "Белка"	16	2	{3,4,5,2}	1	691001001	14.12 Производство спецодежды			332					69 001767108	69 001765627	+7 48236 31771	1096910002298	{"prev_value":["user_ids: 208,209,215,214\\nuni_reg_date: 2009-12-01 00:00:00"],"date":["19.11.2018 12:28:10"],"user":["#209 \\u042e\\u043b\\u044f"]}	2009-06-30	2009-06-30	2009-06-30	4	6910019068	1	\N	\N
5	ООО "Рога и копыта"	Общество с ограниченной ответственностью "Рога и копыта"	51	1	{2}	1	771231001	46.42 Торговля оптовая одеждой и	45000000000		567	 4070 1810 9000 0000 0598	ПАО Сбербанк	30101810400000000225	044525225	69 002345432	77 002345678	+7 495 1234567	5147712345678	{"prev_value":["director: \\nbooker: "],"date":["09.04.2018 10:06:22"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	2015-04-28	2015-04-28	2015-04-28	51	7712345678	5	\N	\N
6	УВМ ГУ МВД по г. Москве	Управление по вопросам миграции ГУ МВД России по городу Москве	52	10	{2}	1														{}	\N	\N	\N	0	0	0	\N	\N
7	ООО "Элеганс"	Общество с ограниченной ответственностью "Элеганс"	16	1	{3,4,5,2}	1	691001001	14.13										+7 48236 31771	1186952007549	{"prev_value":["user_ids: 209,208,215,214\\nname: \\u041e\\u041e\\u041e\\"\\u042d\\u043b\\u0435\\u0433\\u0430\\u043d\\u0441\\""],"date":["05.12.2018 08:44:02"],"user":["#208 \\u041d\\u0430\\u043c"]}	2018-05-30	2018-05-30	\N	4	6910023875	4	\N	\N
8	Отдел трудовой миграции УВМ УМВД России по Тверской области	Отдел трудовой миграции Управления по вопросам миграции УМВД России по Тверской области	0	10	{3,5,4,2}	1														{"prev_value":[""],"date":["01.10.2018 20:55:03"],"user":["#207 Super User"]}	\N	\N	\N	0	0	0	\N	\N
9	АО "Комбинат рабочей одежды"	Акционерное общество ""Комбинат рабочей одежды""	193	12	{2,4}	1	027401001													{"prev_value":["user_ids: "],"date":["06.02.2020 13:18:28"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N	\N	0	274043510	16	\N	\N
10	ООО «Детская одежда»	Общество с ограниченной ответственностью «Детская одежда»	196	12	{2,4}	1	773401001					40702810502820001915	АО "АЛЬФА-БАНК"	30101810200000000593	044525593				5187746017938	{"prev_value":["user_ids: "],"date":["21.04.2020 12:24:12"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N	\N	0	7734418884	17	\N	\N
11	ООО «Звездочка»	Общество с ограниченной ответственностью «Звездочка»	0	12	{2,4}	1	503401001					40702810701590000420	Филиал "Центральный" Банк ВТБ (ПАО)	30101810145250000411	044525411				1145034001881	{"prev_value":["user_ids: "],"date":["21.04.2020 12:24:24"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	\N	\N	\N	197	5034048585	18	\N	\N
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.migrations (id, migration, batch) FROM stdin;
3	2021_05_16_000001_create_addresses_table	2
4	2021_05_16_000001_create_countries_table	2
6	2021_05_16_000001_create_employers_table	3
7	2021_05_16_000001_create_occupations_table	4
9	2021_05_16_000001_create_quotas_table	4
10	2021_05_16_000001_create_statuses_table	4
11	2021_05_16_000001_create_types_table	4
12	2021_05_16_000001_create_usage_permits_table	4
14	2021_05_16_000001_add_two_factor_columns_to_users_table	6
15	2021_05_16_000001_create_failed_jobs_table	6
16	2021_05_16_000001_create_password_resets_table	6
17	2021_05_16_000001_create_sessions_table	6
18	2021_05_16_000001_create_users_table	7
19	2021_05_16_000001_create_employees_table	8
20	2019_12_14_000001_create_personal_access_tokens_table	9
21	2021_05_16_000001_create_permits_table	9
22	2021_05_16_000001_create_telescope_entries_table	10
\.


--
-- Data for Name: occupations; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.occupations (id, user_ids, code, name_ru, published, description, history, created_at, updated_at) FROM stdin;
1	{3,5,4,2}	19601	швея	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
2	{3,5,4,2}	17738	раскройщик	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
3	{3,5,4,2}	27142	технолог	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
4	{3,5,4,2}	23504	конструктор одежды	1		{"prev_value":["name: \\u043a\\u043e\\u043d\\u0441\\u0442\\u0440\\u0443\\u043a\\u0442\\u043e\\u0440"],"date":["25.07.2018 11:16:57"],"user":["#209 \\u042e\\u043b\\u044f"]}	2021-05-16 13:10:45	2021-05-16 13:10:45
5	{3,5,4,2}	24110	механик	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
6	{3,5,4,2}	27041	техник по наладке и испытаниям	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
7	{3,5,4,2}	22583	инженер по качеству	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
8	{3,5,4,2}	22678	инженер  по подготовке производства	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
9	{3,5,4,2}	22605	инженер по автоматизации и механизации производственных процессов	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
10	{3,5,4,2}	22544	инженер по внедрению новой техники и технологии	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
11	{3,5,4,2}	22642	инженер по организации управления производством	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
12	{3,5,4,2}	22491	инженер-конструктор	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
13	{3,5,4,2}	22854	инженер-технолог	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
14	{3,5,4,2}	25114	начальник цеха	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
15	{3,5,4,2}	25857	программист	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
16	{3,5,4,2}	27120	техник-технолог	1		\N	2021-05-16 13:10:45	2021-05-16 13:10:45
17	{2}	18576	Слесарь строительный	1		{}	2021-05-16 13:10:45	2021-05-16 13:10:45
18	{2}	18880	Столяр строительный	1		{}	2021-05-16 13:10:45	2021-05-16 13:10:45
19	{2}	18883	Сторож (вахтер)	1		{}	2021-05-16 13:10:45	2021-05-16 13:10:45
20	{2}	14544	Монтажник	1		{}	2021-05-16 13:10:45	2021-05-16 13:10:45
21	{2}	11786	Дворник	1		{}	2021-05-16 13:10:45	2021-05-16 13:10:45
22	{2}	23369	Кассир	1		{}	2021-05-16 13:10:46	2021-05-16 13:10:46
25	{2}	27866	энергетик	1		{"prev_value":[""],"date":["20.11.2018 15:13:47"],"user":["#208 \\u041d\\u0430\\u043c"]}	2021-05-16 13:10:46	2021-05-16 13:10:46
26	{2}	22149	специалист по охране труда	1		{"prev_value":[""],"date":["20.11.2018 15:13:58"],"user":["#208 \\u041d\\u0430\\u043c"]}	2021-05-16 13:10:46	2021-05-16 13:10:46
27	{3,4,2}	25531	ПЕРЕВОДЧИК	1		{"prev_value":[""],"date":["28.11.2018 14:20:01"],"user":["#209 \\u042e\\u043b\\u044f"]}	2021-05-16 13:10:46	2021-05-16 13:10:46
28	{3,2,4}	25531	наладчик оборудования	1		{"prev_value":[""],"date":["27.05.2019 13:33:11"],"user":["#209 \\u042e\\u043b\\u044f"]}	2021-05-16 13:10:46	2021-05-16 13:10:46
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permits; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.permits (id, employer_id, user_ids, number, published, total, issued_date, expired_date, history, details, created_at, updated_at) FROM stdin;
1	1	{3,5,4,2}	1700000093	1	16	\N	2018-03-27	{"prev_value":["details: {\\"occupation\\":[\\"2\\",\\"1\\",\\"6\\"],\\"quantity\\":[\\"1\\",\\"7\\",\\"8\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"7"},{"country_id":"232","occupation_id":"6","quantity":"8"}]	\N	\N
2	1	{3,5,4,2}	1700000216	1	8	\N	2018-05-18	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"1\\",\\"15\\"],\\"quantity\\":[\\"2\\",\\"5\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"2"},{"country_id":"232","occupation_id":"1","quantity":"5"},{"country_id":"232","occupation_id":"15","quantity":"1"}]	\N	\N
3	1	{3,5,4,2}	1700000294	1	3	\N	2018-06-01	{"prev_value":["details: {\\"occupation\\":[\\"1\\"],\\"quantity\\":[\\"3\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"1","quantity":"3"}]	\N	\N
4	1	{3,5,4,2}	1700000368	1	5	\N	2018-06-24	{"prev_value":["details: {\\"occupation\\":[\\"1\\",\\"6\\",\\"9\\"],\\"quantity\\":[\\"3\\",\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"1","quantity":"3"},{"country_id":"232","occupation_id":"6","quantity":"1"},{"country_id":"232","occupation_id":"9","quantity":"1"}]	\N	\N
5	1	{3,5,4,2}	1700000390	1	2	\N	2018-08-15	{"prev_value":["details: {\\"occupation\\":[\\"11\\",\\"10\\"],\\"quantity\\":[\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"11","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"1"}]	\N	\N
6	1	{3,5,4,2}	1700000520	1	2	\N	2018-10-06	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"13\\"],\\"quantity\\":[\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"},{"country_id":"232","occupation_id":"13","quantity":"1"}]	\N	\N
7	1	{3,5,4,2}	1700000544	1	5	\N	2018-10-18	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"13\\",\\"10\\"],\\"quantity\\":[\\"3\\",\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"3"},{"country_id":"232","occupation_id":"13","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"1"}]	\N	\N
8	1	{3,5,4,2}	1700000625	1	7	\N	2018-01-11	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"12\\",\\"8\\",\\"9\\",\\"11\\"],\\"quantity\\":[\\"3\\",\\"1\\",\\"1\\",\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"3"},{"country_id":"232","occupation_id":"12","quantity":"1"},{"country_id":"232","occupation_id":"8","quantity":"1"},{"country_id":"232","occupation_id":"9","quantity":"1"},{"country_id":"232","occupation_id":"11","quantity":"1"}]	\N	\N
9	1	{3,5,4,2}	1700000632	1	9	\N	2018-11-28	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"13\\",\\"7\\",\\"10\\"],\\"quantity\\":[\\"5\\",\\"1\\",\\"1\\",\\"2\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"5"},{"country_id":"232","occupation_id":"13","quantity":"1"},{"country_id":"232","occupation_id":"7","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"2"}]	\N	\N
10	1	{3,5,4,2}	1700000657	1	6	\N	2018-12-07	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"12\\",\\"8\\"],\\"quantity\\":[\\"4\\",\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"4"},{"country_id":"232","occupation_id":"12","quantity":"1"},{"country_id":"232","occupation_id":"8","quantity":"1"}]	\N	\N
11	1	{3,5,4,2}	1600000614	1	8	\N	2017-12-08	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"7\\",\\"12\\",\\"8\\",\\"9\\"],\\"quantity\\":[\\"4\\",\\"1\\",\\"1\\",\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"4"},{"country_id":"232","occupation_id":"7","quantity":"1"},{"country_id":"232","occupation_id":"12","quantity":"1"},{"country_id":"232","occupation_id":"8","quantity":"1"},{"country_id":"232","occupation_id":"9","quantity":"1"}]	\N	\N
13	1	{3,5,4,2}	1600000558	1	17	\N	2017-11-29	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"8\\",\\"12\\",\\"16\\",\\"10\\",\\"7\\"],\\"quantity\\":[\\"10\\",\\"1\\",\\"1\\",\\"1\\",\\"2\\",\\"2\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"10"},{"country_id":"232","occupation_id":"8","quantity":"1"},{"country_id":"232","occupation_id":"12","quantity":"1"},{"country_id":"232","occupation_id":"16","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"2"},{"country_id":"232","occupation_id":"7","quantity":"2"}]	\N	\N
17	1	{3,5,4,2}	1700000640	1	4	2017-10-27	2018-11-30	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"2\\",\\"1\\"],\\"quantity\\":[\\"1\\",\\"1\\",\\"2\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"},{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"2"}]	\N	\N
18	1	{3,5,4,2}	1700000720	1	5	2017-12-08	2019-01-10	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"11\\",\\"12\\"],\\"quantity\\":[\\"3\\",\\"1\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"3"},{"country_id":"232","occupation_id":"11","quantity":"1"},{"country_id":"232","occupation_id":"12","quantity":"1"}]	\N	\N
19	1	{3,5,4,2}	1800000114	1	12	2018-02-14	2019-03-26	{"prev_value":["details: {\\"occupation\\":[\\"6\\",\\"1\\",\\"2\\"],\\"quantity\\":[\\"4\\",\\"7\\",\\"1\\"]}\\r\\nemployer_name: "],"date":["21.03.2018 21:23:21"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"6","quantity":"4"},{"country_id":"232","occupation_id":"1","quantity":"7"},{"country_id":"232","occupation_id":"2","quantity":"1"}]	\N	\N
20	4	{3,5,4,2}	1800000107	1	5	2018-02-14	2019-02-18	{"prev_value":["issued: 2018-02-14 00:00:00\\nexpired: 2019-02-18 00:00:00\\ndetails: {'occupation':[], 'quantity':[]}","details: {\\"occupation\\":[\\"1\\"],\\"quantity\\":[\\"5\\"]}\\r\\nemployer_name: "],"date":["13.03.2018 12:11:47","21.03.2018 21:23:21"],"user":["#209 \\u042e\\u043b\\u044f","#207 Super User"]}	[{"country_id":"232","occupation_id":"1","quantity":"5"}]	\N	\N
23	1	{3,5,4,2}	1800000259	1	5	2018-04-04	2019-05-17	{"prev_value":["user_ids: 209,208\\nexpired: 2018-05-18 00:00:00\\nquota_id: 2017"],"date":["16.05.2018 13:42:14"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"5"}]	\N	\N
24	1	{3,5,4,2}	1800000298	1	3	2018-05-14	2019-06-23	{"prev_value":["details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["08.06.2018 12:38:31"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"3"}]	\N	\N
25	4	{3,5,4,2}	1800000450	1	7	2018-07-04	2019-07-14	{"prev_value":["number: 180000450"],"date":["11.07.2018 12:56:39"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"4"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"3","quantity":"1"}]	\N	\N
26	1	{3,5,4,2}	1800000428	1	7	2018-07-04	2019-07-11	{"prev_value":["number: 180000428"],"date":["11.07.2018 12:56:28"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"2"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"13","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"1"},{"country_id":"232","occupation_id":"11","quantity":"1"}]	\N	\N
27	1	{3,4,5,2}	1800000629	1	8	2018-10-02	2019-11-27	{"prev_value":["user_ids: 209,208,215,214\\ndetails: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["14.11.2018 12:21:12"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"3"},{"country_id":"232","occupation_id":"13","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"2"},{"country_id":"232","occupation_id":"7","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	\N
28	1	{3,5,4,2}	1800000717	1	6	2018-10-30	2019-12-06	{"prev_value":[""],"date":["07.11.2018 10:01:19"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"12","quantity":"1"},{"country_id":"232","occupation_id":"8","quantity":"1"},{"country_id":"232","occupation_id":"6","quantity":"4"}]	\N	\N
29	1	{3,5,4,2}	1800000724	1	1	2018-10-30	2020-01-19	{"prev_value":[""],"date":["07.11.2018 10:03:25"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
30	4	{3,4,2}	1800000731	1	3	2018-10-30	2019-11-18	{"prev_value":["details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["19.11.2018 10:26:34"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"3"}]	\N	\N
31	4	{3,4,2}	1800000756	1	5	2018-11-26	2019-12-01	{"prev_value":["details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["11.12.2018 11:18:53"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"4"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	\N
32	4	{3,4,2}	1900000069	1	4	2019-02-04	2020-02-17	{"prev_value":["","user_ids: 209,208,214\\ndetails: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["15.02.2019 12:21:55","01.03.2019 13:02:05"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"4"}]	\N	\N
33	1	{3,4,2}	1900000132	1	9	2019-02-15	2020-03-25	{"prev_value":["details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.02.2019 13:52:43"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"5"},{"country_id":"232","occupation_id":"6","quantity":"4"}]	\N	\N
34	1	{3,4,2}	1900000260	1	1	2019-03-28	2020-04-04	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.05.2019 10:58:22","20.05.2019 10:59:25"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
35	1	{3,2}	1900000365	1	6	2019-06-10	2020-07-10	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}","details: {\\"country\\":[\\"232\\",\\"232\\",\\"232\\",\\"232\\"],\\"occupation\\":[\\"1\\",\\"11\\",\\"10\\",\\"5\\"],\\"quantity\\":[\\"2\\",\\"1\\",\\"1\\",\\"1\\"]}","user_ids: 209,214,208\\ndetails: {\\"country\\":[\\"232\\",\\"232\\",\\"232\\",\\"232\\",\\"232\\"],\\"occupation\\":[\\"1\\",\\"11\\",\\"10\\",\\"5\\",\\"5\\"],\\"quantity\\":[\\"2\\",\\"1\\",\\"1\\",\\"1\\",\\"1\\"]}","details: {\\"country\\":[\\"232\\",\\"232\\",\\"232\\",\\"232\\",\\"232\\",\\"232\\"],\\"occupation\\":[\\"1\\",\\"11\\",\\"10\\",\\"5\\",\\"5\\",\\"3\\"],\\"quantity\\":[\\"2\\",\\"1\\",\\"1\\",\\"1\\",\\"1\\",\\"1\\"]}"],"date":["24.06.2019 10:46:19","24.06.2019 10:48:08","05.08.2019 12:46:30","05.09.2019 10:09:30","05.09.2019 10:13:29"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"2"},{"country_id":"232","occupation_id":"11","quantity":"1"},{"country_id":"232","occupation_id":"10","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"3","quantity":"1"}]	\N	\N
36	4	{3,4,2}	1900000358	1	6	2019-06-10	2020-07-13	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["24.06.2019 10:48:57","24.06.2019 10:50:14"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"3"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"}]	\N	\N
37	1	{3,2}	1900000397	1	3	2019-06-26	2020-07-01	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["05.08.2019 12:23:05","05.08.2019 12:23:47"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"3"}]	\N	\N
22	5	{2}	7700003456	1	13	2017-06-07	2018-06-02	{"prev_value":["expired: 2018-06-06 00:00:00\\nuser_ids: Array"],"date":["05.04.2018 12:47:23"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	[{"country_id":"44","occupation_id":"20","quantity":"4"},{"country_id":"11","occupation_id":"11","quantity":"9"}]	\N	2021-05-18 08:07:10
38	1	{3,2}	1900000492	1	3	2019-08-28	2020-09-11	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}","expired: 2019-09-12 00:00:00\\nquota_id: 2018"],"date":["29.08.2019 12:21:50","29.08.2019 12:22:27","05.09.2019 10:21:16"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"3"}]	\N	\N
39	4	{3,2}	1900000647	1	2	2019-10-23	2020-11-17	{"prev_value":["","expired: 1970-01-01 00:00:00\\nquota_id: 1969","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["13.11.2019 15:39:43","13.11.2019 15:40:11","13.11.2019 15:41:04"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	\N
40	1	{3,2}	1900000679	1	2	2019-11-12	2020-12-05	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.11.2019 13:45:00","20.11.2019 13:45:25"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"2"}]	\N	\N
41	1	{3,2}	1900000661	1	5	2019-11-12	2020-11-26	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.11.2019 13:46:09","20.11.2019 13:47:55"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"2"},{"country_id":"232","occupation_id":"6","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	\N
42	4	{3,2}	1900000573	1	1	2019-10-23	2020-10-23	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.11.2019 13:48:52","20.11.2019 13:49:15"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
43	1	{3,2}	1900000686	1	1	2019-11-19	2020-11-21	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["16.12.2019 13:36:29","16.12.2019 13:36:51"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"1"}]	\N	\N
44	4	{3,2}	1900000703	1	1	2019-12-16	2020-12-22	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["09.01.2020 11:44:43","27.01.2020 10:38:43"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
45	4	{3,2}	2000000029	1	5	2020-01-21	2021-01-26	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["10.02.2020 14:47:58","25.02.2020 10:34:19"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"5"}]	\N	\N
46	4	{3,2}	2000000050	1	2	2020-02-04	2021-02-16	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["25.02.2020 10:31:34","25.02.2020 10:32:05"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"2"}]	\N	\N
47	1	{3,2}	2000000195	1	1	2020-03-11	2021-04-03	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.03.2020 12:43:46","20.03.2020 12:47:34"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
48	1	{3,2}	2000000205	1	4	2020-03-11	2021-03-24	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.03.2020 12:48:17","20.03.2020 12:49:06"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"2"},{"country_id":"232","occupation_id":"6","quantity":"2"}]	\N	\N
49	1	{3,2}	2000000300	1	2	2020-06-17	2021-06-30	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["23.06.2020 12:40:55","23.06.2020 12:41:41"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"1"}]	\N	\N
50	4	{3,2}	2000000413	1	1	2020-10-12	2021-10-22	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["22.10.2020 12:24:42","22.10.2020 12:25:01"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
51	1	{3,2}	2000000484	1	2	2020-11-21	2021-11-20	{"prev_value":["","issued: 2020-10-28","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["16.11.2020 16:56:42","16.11.2020 16:57:06","17.11.2020 10:11:11"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"2"}]	\N	\N
52	1	{3,2}	2000000460	1	3	2020-11-26	2021-11-25	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["16.11.2020 16:57:56","17.11.2020 10:10:33"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"2"}]	\N	\N
53	4	{3,2}	2000000420	1	2	2020-11-17	2021-11-16	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["17.11.2020 10:05:48","17.11.2020 10:09:04"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	\N
54	4	{3,2}	2000000501	1	1	2021-01-26	2022-01-25	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["20.01.2021 17:18:59","20.01.2021 17:20:09"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
55	4	{3,2}	2100000544	1	2	2021-02-05	2022-02-15	{"prev_value":["","expired: 2021-02-16\\nquota_id: 2020","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["15.02.2021 11:22:08","15.02.2021 11:22:22","15.02.2021 11:22:45"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"2"}]	\N	\N
56	1	{3,2}	2100000590	1	3	2021-03-12	2022-03-23	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["18.03.2021 15:51:32","18.03.2021 15:53:38"],"user":["#209 \\u042e\\u043b\\u044f","#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"1","quantity":"1"},{"country_id":"232","occupation_id":"6","quantity":"2"}]	\N	\N
57	1	{3,2}	2100000600	1	1	2021-03-15	2022-03-31	{"prev_value":[""],"date":["18.03.2021 16:01:52"],"user":["#209 \\u042e\\u043b\\u044f"]}	[{"country_id":"232","occupation_id":"6","quantity":"1"}]	\N	\N
21	5	{2}	7700001234	1	21	2018-04-03	2019-04-02	{"prev_value":["issued: 2018-04-02 00:00:00\\nuser_ids: Array"],"date":["05.04.2018 09:54:35"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	[{"country_id":"229","occupation_id":"22","quantity":"6"},{"country_id":"229","occupation_id":"20","quantity":"5"},{"country_id":"229","occupation_id":"21","quantity":"8"},{"country_id":"13","occupation_id":"21","quantity":"2"}]	\N	2021-05-18 06:46:17
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quotas; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.quotas (id, year, employer_id, user_ids, published, total, history, details, issued_date, expired_date, created_at, updated_at) FROM stdin;
1	2017	1	{3,5,4,2}	1	38	{"prev_value":["issued: 2017-01-01 00:00:00"],"date":["20.04.2018 09:48:53"],"user":["#208 \\u0420\\u043e\\u0431\\u0435\\u0440\\u0442"]}	[{"country_id":"232","occupation_id":"1","quantity":"29"},{"country_id":"232","occupation_id":"2","quantity":"6"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"}]	\N	2017-12-31	\N	\N
2	2018	1	{3,5,4,2}	1	21	\N	[{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"17"},{"country_id":"232","occupation_id":"2","quantity":"1"}]	\N	2018-12-31	\N	\N
3	2018	4	{3,4,5,2}	1	20	{"prev_value":["user_ids: 208,209,215,214"],"date":["20.11.2018 14:06:33"],"user":["#208 \\u041d\\u0430\\u043c"]}	[{"country_id":"232","occupation_id":"4","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"16"},{"country_id":"232","occupation_id":"3","quantity":"1"}]	\N	2018-12-31	\N	\N
4	2018	5	{2}	1	68	{"prev_value":["details: {\\"country\\":[\\"229\\",\\"229\\",\\"209\\",\\"44\\",\\"229\\"],\\"occupation\\":[\\"20\\",\\"21\\",\\"20\\",\\"18\\",\\"22\\"],\\"quantity\\":[\\"12\\",\\"25\\",\\"6\\",\\"10\\",\\"15\\"]}\\nuser_ids: Array"],"date":["05.04.2018 18:31:29"],"user":["#211 \\u0414\\u0435\\u043c\\u043e-\\u043f\\u043e\\u043b\\u044c\\u0437\\u043e\\u0432\\u0430\\u0442\\u0435\\u043b\\u044c"]}	[{"country_id":"229","occupation_id":"20","quantity":"12"},{"country_id":"229","occupation_id":"21","quantity":"25"},{"country_id":"232","occupation_id":"20","quantity":"6"},{"country_id":"44","occupation_id":"18","quantity":"10"},{"country_id":"229","occupation_id":"22","quantity":"15"}]	\N	2018-12-31	\N	\N
5	2019	4	{2,3,5}	1	12	{"prev_value":["user_ids: 208,215"],"date":["22.08.2019 14:59:15"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"1","quantity":"8"},{"country_id":"232","occupation_id":"4","quantity":"1"},{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"}]	\N	2020-12-31	\N	\N
6	2019	1	{3,4,2}	1	20	{"prev_value":["user_ids: 208"],"date":["20.11.2018 15:18:11"],"user":["#207 Super User"]}	[{"country_id":"232","occupation_id":"1","quantity":"16"},{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"}]	\N	2020-12-31	\N	\N
7	2020	4	{3,2}	1	20	{"prev_value":["user_ids: "],"date":["15.09.2020 14:07:56"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	[{"country_id":"232","occupation_id":"4","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"2","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"16"},{"country_id":"232","occupation_id":"3","quantity":"1"}]	\N	2020-12-31	\N	\N
8	2020	1	{3,2}	1	20	{"prev_value":["user_ids: "],"date":["15.09.2020 14:08:03"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	[{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"5","quantity":"1"},{"country_id":"232","occupation_id":"1","quantity":"17"},{"country_id":"232","occupation_id":"2","quantity":"1"}]	\N	2020-12-31	\N	\N
9	2021	1	{}	1	13	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["10.01.2021 14:25:53","10.01.2021 14:26:38"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	[{"country_id":"232","occupation_id":"1","quantity":"11"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	2021-12-31	\N	\N
10	2021	4	{}	1	7	{"prev_value":["","details: {'country':[], 'occupation':[], 'quantity':[]}"],"date":["10.01.2021 14:27:16","10.01.2021 14:27:54"],"user":["#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d","#207 \\u0413\\u043b\\u0430\\u0432\\u043d\\u044b\\u0439 \\u0410\\u0434\\u043c\\u0438\\u043d"]}	[{"country_id":"232","occupation_id":"1","quantity":"5"},{"country_id":"232","occupation_id":"3","quantity":"1"},{"country_id":"232","occupation_id":"4","quantity":"1"}]	\N	2021-12-31	\N	\N
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
TYRU80yvDa7eiELgOjGfrc5MOBfVle7fZ4zIDFnc	2	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	YToxMDp7czo1OiJ2aWV3cyI7YTo2OntpOjA7czo4OiJlbXBsb3llZSI7aToxO3M6ODoiZW1wbG95ZXIiO2k6MjtzOjY6InBlcm1pdCI7aTozO3M6NToicXVvdGEiO2k6NDtzOjEwOiJvY2N1cGF0aW9uIjtpOjU7czo3OiJhZGRyZXNzIjt9czo2OiJfdG9rZW4iO3M6NDA6IkRNNUVHT1RCSWJqMmNuZWgxWG14Vmd0end5Y2U3YXlHak16UVZPQzIiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjE5OiJodHRwOi8vZW0vYWRkcmVzc2VzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMCRYQ20zaktMNjczbk44OUtndHdzV1FldHFwWldmaVh4OTN3NmdiU2pYS29kTEp4Y2guQXZGdSI7czoxMjoiZmlsdGVyc01vZGFsIjtiOjA7czo0OiJwYWdlIjtOO3M6NzoicGVybWl0cyI7YToxOntzOjc6InF1ZXJpZXMiO2E6MTp7czoxMzoidmFsaWRfcGVybWl0cyI7YToxOntpOjA7YToxOntzOjg6IndoZXJlUmF3IjtzOjI4OiJwZXJtaXRzLmV4cGlyZWRfZGF0ZSA+IE5PVygpIjt9fX19fQ==	1622189881
WNoZ9NKT1RMP8EG8q5yE1j7TrTOj65bNbAEgU0em	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	YTozOntzOjU6InZpZXdzIjthOjY6e2k6MDtzOjg6ImVtcGxveWVlIjtpOjE7czo4OiJlbXBsb3llciI7aToyO3M6NjoicGVybWl0IjtpOjM7czo1OiJxdW90YSI7aTo0O3M6MTA6Im9jY3VwYXRpb24iO2k6NTtzOjc6ImFkZHJlc3MiO31zOjY6Il90b2tlbiI7czo0MDoiUjd4bUVaZURHUnhZb2JOa1VibWlEQVg5c1hhOVVFNEcwUnRRODMwbCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1622187303
zrD6vRV2USRVPsaUYmFa6U9O8ZxtrJXP2fWjFNkC	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	YTozOntzOjU6InZpZXdzIjthOjY6e2k6MDtzOjg6ImVtcGxveWVlIjtpOjE7czo4OiJlbXBsb3llciI7aToyO3M6NjoicGVybWl0IjtpOjM7czo1OiJxdW90YSI7aTo0O3M6MTA6Im9jY3VwYXRpb24iO2k6NTtzOjc6ImFkZHJlc3MiO31zOjY6Il90b2tlbiI7czo0MDoiTzZTNHVIWG82eU5sSm54Wm44ejFnT3cyVHB4bjlqT09tYWtPaTVySCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1622298768
Ji4sUhYuczMjpeZ3CIdv1zhAJ0DquIWG85IMOx7H	2	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36	YToxMTp7czo1OiJ2aWV3cyI7YTo2OntpOjA7czo4OiJlbXBsb3llZSI7aToxO3M6ODoiZW1wbG95ZXIiO2k6MjtzOjY6InBlcm1pdCI7aTozO3M6NToicXVvdGEiO2k6NDtzOjEwOiJvY2N1cGF0aW9uIjtpOjU7czo3OiJhZGRyZXNzIjt9czo2OiJfdG9rZW4iO3M6NDA6IklLSFNjMUJtcjl4WnRFb2dQWnFhNGFVSEhvM0htQmlraUdyWTRyckQiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjE1OiJodHRwOi8vZW0vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJFhDbTNqS0w2NzNuTjg5S2d0d3NXUWV0cXBaV2ZpWHg5M3c2Z2JTalhLb2RMSnhjaC5BdkZ1IjtzOjEyOiJmaWx0ZXJzTW9kYWwiO2I6MDtzOjQ6InBhZ2UiO047czo3OiJwZXJtaXRzIjthOjE6e3M6NzoicXVlcmllcyI7YToxOntzOjEzOiJ2YWxpZF9wZXJtaXRzIjthOjE6e2k6MDthOjE6e3M6ODoid2hlcmVSYXciO3M6Mjg6InBlcm1pdHMuZXhwaXJlZF9kYXRlID4gTk9XKCkiO319fX1zOjg6ImVtcGxveWVlIjthOjE6e3M6ODoidXNlcl9pZHMiO3M6MToiMiI7fX0=	1622299043
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.statuses (id, name_ru, user_ids, created_at, updated_at, name_en) FROM stdin;
1	Руководитель	{2}	2021-05-16 13:18:46	\N	Boss
2	Главбух	{2}	2021-05-16 13:18:46	\N	Booker
3	Уволен	{2}	2021-05-16 13:18:46	\N	Fired
4	Чиновник	{2}	2021-05-16 13:18:46	\N	Official
5	Работающий	{2}	2021-05-16 13:18:46	\N	Worker
6	Убыл	{2}	2021-05-16 13:18:46	\N	Left
7	Соискатель	{2}	2021-05-16 13:18:46	\N	Seeker
8	Аннулирован	{2}	2021-05-16 13:18:46	\N	Cancelled
9	Член семьи	{2}	2021-05-16 13:18:46	\N	Family
10	Отказан	{2}	2021-05-16 13:18:46	\N	Denied
11	Контрагент	{2}	2021-05-16 13:18:46	\N	Client
\.


--
-- Data for Name: telescope_entries; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.telescope_entries (sequence, uuid, batch_id, family_hash, should_display_on_index, type, content, created_at) FROM stdin;
1	938c1922-1774-4fe5-a01e-71750d46ea99	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select * from information_schema.tables where table_schema = 'public' and table_name = 'migrations' and table_type = 'BASE TABLE'","time":"13.92","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\artisan","line":37,"hash":"ad7d07e5104cadcc6e9623dfc5fefdd8","hostname":"PN-HP"}	2021-05-29 14:41:03
2	938c1922-1f1e-45ac-81c9-9dc3e478e788	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select * from information_schema.tables where table_schema = 'public' and table_name = 'migrations' and table_type = 'BASE TABLE'","time":"2.58","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\artisan","line":37,"hash":"ad7d07e5104cadcc6e9623dfc5fefdd8","hostname":"PN-HP"}	2021-05-29 14:41:03
3	938c1922-20a1-4735-a297-1d5b4d36e1ec	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select \\"migration\\" from \\"migrations\\" order by \\"batch\\" asc, \\"migration\\" asc","time":"3.10","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\artisan","line":37,"hash":"84af29f5c40ba2eeda76663cdfcee4df","hostname":"PN-HP"}	2021-05-29 14:41:03
4	938c1922-21e5-4b77-9a8e-422aea597154	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select \\"migration\\" from \\"migrations\\" order by \\"batch\\" asc, \\"migration\\" asc","time":"0.95","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\artisan","line":37,"hash":"84af29f5c40ba2eeda76663cdfcee4df","hostname":"PN-HP"}	2021-05-29 14:41:03
5	938c1922-2320-41a9-9c10-358507d664c6	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select max(\\"batch\\") as aggregate from \\"migrations\\"","time":"1.18","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\artisan","line":37,"hash":"891c93593b7807a7dfc0848070936947","hostname":"PN-HP"}	2021-05-29 14:41:03
6	938c1922-4ee6-4626-89a9-0abc39dfd0e1	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"telescope_entries\\" (\\"sequence\\" bigserial primary key not null, \\"uuid\\" uuid not null, \\"batch_id\\" uuid not null, \\"family_hash\\" varchar(255) null, \\"should_display_on_index\\" boolean not null default '1', \\"type\\" varchar(20) not null, \\"content\\" text not null, \\"created_at\\" timestamp(0) without time zone null)","time":"53.07","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":58,"hash":"7f60788c23c316cc3861e7fe47dc0d5c","hostname":"PN-HP"}	2021-05-29 14:41:03
7	938c1922-5135-4339-8837-8c785f241a5a	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"telescope_entries\\" add constraint \\"telescope_entries_uuid_unique\\" unique (\\"uuid\\")","time":"5.24","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":58,"hash":"65516b962cdccf5d313657a083ce8e23","hostname":"PN-HP"}	2021-05-29 14:41:03
8	938c1922-531e-40a0-b081-9a3561dafa2d	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_batch_id_index\\" on \\"telescope_entries\\" (\\"batch_id\\")","time":"4.21","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":58,"hash":"e10b43e84e03625fedc71f28fb117fcd","hostname":"PN-HP"}	2021-05-29 14:41:03
9	938c1922-54f0-4b22-b2be-cfbb4e5efa0f	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_family_hash_index\\" on \\"telescope_entries\\" (\\"family_hash\\")","time":"4.01","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":58,"hash":"83054e6de7da4fc398165e89e56e6579","hostname":"PN-HP"}	2021-05-29 14:41:03
10	938c1922-56dc-4591-b9a6-57d5735682e3	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_created_at_index\\" on \\"telescope_entries\\" (\\"created_at\\")","time":"4.29","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":58,"hash":"480c085033a759f5759c64439988b7ad","hostname":"PN-HP"}	2021-05-29 14:41:03
11	938c1922-58a1-4b51-9810-eb73f76a6496	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_type_should_display_on_index_index\\" on \\"telescope_entries\\" (\\"type\\", \\"should_display_on_index\\")","time":"3.89","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":58,"hash":"2dde9b32f7ec3cbde8e7233229f9e72a","hostname":"PN-HP"}	2021-05-29 14:41:03
12	938c1922-60e1-4420-a043-a27017c7fbcc	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"telescope_entries_tags\\" (\\"entry_uuid\\" uuid not null, \\"tag\\" varchar(255) not null)","time":"1.92","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":71,"hash":"84423770c386428de619551ca156a52b","hostname":"PN-HP"}	2021-05-29 14:41:03
13	938c1922-62bb-4f4a-8a86-5eb8dd4e01cf	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_tags_entry_uuid_tag_index\\" on \\"telescope_entries_tags\\" (\\"entry_uuid\\", \\"tag\\")","time":"4.01","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":71,"hash":"0aa317ef60a60d390897f91e421bf77e","hostname":"PN-HP"}	2021-05-29 14:41:03
14	938c1922-64c4-4f3b-aead-521e267f7cb1	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_tags_tag_index\\" on \\"telescope_entries_tags\\" (\\"tag\\")","time":"4.39","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":71,"hash":"fb3cf587edc205c8c419d474ea351a78","hostname":"PN-HP"}	2021-05-29 14:41:03
15	938c1922-6c98-4fdd-a84f-acde21069200	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"telescope_entries_tags\\" add constraint \\"telescope_entries_tags_entry_uuid_foreign\\" foreign key (\\"entry_uuid\\") references \\"telescope_entries\\" (\\"uuid\\") on delete cascade","time":"19.29","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":71,"hash":"84715bebe24deb92d4af7a4800fc4a2b","hostname":"PN-HP"}	2021-05-29 14:41:03
16	938c1922-6dcb-4c07-bbc0-06ef59c0166d	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"telescope_monitoring\\" (\\"tag\\" varchar(255) not null)","time":"2.21","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\database\\\\migrations\\\\2021_05_16_000001_create_telescope_entries_table.php","line":75,"hash":"ae42f8fdcbfbd265b65572f79934d1ae","hostname":"PN-HP"}	2021-05-29 14:41:03
17	938c1922-7ddc-4130-8085-3e2e86e2e352	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2021_05_16_000001_create_telescope_entries_table', 10)","time":"2.98","slow":false,"file":"C:\\\\OpenServer\\\\domains\\\\localhost\\\\em\\\\artisan","line":37,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"PN-HP"}	2021-05-29 14:41:03
18	938c1922-84bc-4b96-b5e6-e398fd59ce64	938c1922-84ed-4861-b2fa-f59b3a67d7ce	\N	t	command	{"command":"migrate","exit_code":0,"arguments":{"command":"migrate"},"options":{"database":null,"force":false,"path":[],"realpath":false,"schema-path":null,"pretend":false,"seed":false,"step":false,"help":false,"quiet":false,"verbose":false,"version":false,"ansi":false,"no-ansi":false,"no-interaction":false,"env":null},"hostname":"PN-HP"}	2021-05-29 14:41:03
\.


--
-- Data for Name: telescope_entries_tags; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.telescope_entries_tags (entry_uuid, tag) FROM stdin;
\.


--
-- Data for Name: telescope_monitoring; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.telescope_monitoring (tag) FROM stdin;
\.


--
-- Data for Name: types; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.types (id, user_ids, code, created_at, updated_at) FROM stdin;
1	{2,3}	LEGAL_RUS	2021-05-16 13:19:12	\N
2	{2,3}	LEGAL_SEMI	2021-05-16 13:19:12	\N
3	{2,3}	LEGAL_FOREIGN	2021-05-16 13:19:12	\N
4	{2,3}	INDIVIDUAL	2021-05-16 13:19:12	\N
5	{2,3}	PRIVATE	2021-05-16 13:19:12	\N
6	{2,3}	NOTARY	2021-05-16 13:19:12	\N
7	{2,3}	LAWYER	2021-05-16 13:19:12	\N
8	{2,3}	FOREIGN_BRANCH	2021-05-16 13:19:12	\N
9	{2,3}	FOREIGN_REP	2021-05-16 13:19:12	\N
10	{2,3}	UFMS	2021-05-16 13:19:12	\N
11	{2,3}	OUFMS	2021-05-16 13:19:12	\N
12	{2,3}	CLIENT	2021-05-16 13:19:12	\N
\.


--
-- Data for Name: usage_permits; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.usage_permits (id, name_ru, user_ids, signing_date, history, address_id, employer_id, created_at, updated_at) FROM stdin;
12	Тест	{3,2,4}	2021-05-01	\N	2	1	2021-05-17 20:23:35	2021-05-17 20:23:35
14	ТестТестТест	{3,2,4}	2021-05-03	\N	2	7	2021-05-17 20:23:35	2021-05-17 20:30:09
16	test	{2}	2021-05-04	\N	20	1	2021-05-21 14:51:31	2021-05-21 14:51:31
17	test test test	{2}	2021-05-01	\N	21	1	2021-05-21 14:52:13	2021-05-21 14:52:13
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, current_team_id, profile_photo_path, is_admin, created_at, updated_at) FROM stdin;
1	Robert	nrobert@mail.ru	\N	$2y$10$R6jOO.Ec1YZnolZeOVsQD.qN9a6Czd/fY3SrNYyAuyZ0Da5cxhnxa	\N	\N	\N	f	\N	\N
2	Nam	7715377@mail.ru	\N	$2y$10$XCm3jKL673nN89KgtwsWQetqpZWfiXx93w6gbSjXKodLJxch.AvFu	\N	\N	profile-photos/gYl0R5dhgnquHn2iYFdKi6CAkL8fcwxKTYDe6a1x.jpg	t	\N	2021-05-06 12:19:10
3	Роберт	ngphnam@gmail.com	\N	$2y$10$iqYhaeqGH9cgdHfKcTJ5.eDSBpLz9BzCnTwT2aNvbqBn0fy7DBSvy	\N	\N	\N	f	2020-11-09 08:50:18	2020-11-09 08:50:18
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.addresses_id_seq', 21, true);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.countries_id_seq', 239, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.employees_id_seq', 253, true);


--
-- Name: employers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.employers_id_seq', 11, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.migrations_id_seq', 22, true);


--
-- Name: occupations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.occupations_id_seq', 28, true);


--
-- Name: permits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.permits_id_seq', 57, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: quotas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.quotas_id_seq', 10, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.statuses_id_seq', 11, true);


--
-- Name: telescope_entries_sequence_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.telescope_entries_sequence_seq', 18, true);


--
-- Name: types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.types_id_seq', 12, true);


--
-- Name: usage_permits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.usage_permits_id_seq', 17, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: employers employers_name_ru_taxpayer_id_unique; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.employers
    ADD CONSTRAINT employers_name_ru_taxpayer_id_unique UNIQUE (name_ru, taxpayer_id);


--
-- Name: employers employers_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.employers
    ADD CONSTRAINT employers_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: occupations occupations_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.occupations
    ADD CONSTRAINT occupations_pkey PRIMARY KEY (id);


--
-- Name: permits permits_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.permits
    ADD CONSTRAINT permits_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: quotas quotas_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.quotas
    ADD CONSTRAINT quotas_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_name_ru_unique; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_name_ru_unique UNIQUE (name_ru);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: telescope_entries telescope_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.telescope_entries
    ADD CONSTRAINT telescope_entries_pkey PRIMARY KEY (sequence);


--
-- Name: telescope_entries telescope_entries_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.telescope_entries
    ADD CONSTRAINT telescope_entries_uuid_unique UNIQUE (uuid);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: usage_permits usage_permits_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.usage_permits
    ADD CONSTRAINT usage_permits_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: employees_last_name_ru_citizenship_id_passport_number_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX employees_last_name_ru_citizenship_id_passport_number_index ON public.employees USING btree (last_name_ru, citizenship_id, passport_number);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: quotas_year_employer_id_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX quotas_year_employer_id_index ON public.quotas USING btree (year, employer_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: telescope_entries_batch_id_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX telescope_entries_batch_id_index ON public.telescope_entries USING btree (batch_id);


--
-- Name: telescope_entries_created_at_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX telescope_entries_created_at_index ON public.telescope_entries USING btree (created_at);


--
-- Name: telescope_entries_family_hash_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX telescope_entries_family_hash_index ON public.telescope_entries USING btree (family_hash);


--
-- Name: telescope_entries_tags_entry_uuid_tag_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX telescope_entries_tags_entry_uuid_tag_index ON public.telescope_entries_tags USING btree (entry_uuid, tag);


--
-- Name: telescope_entries_tags_tag_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX telescope_entries_tags_tag_index ON public.telescope_entries_tags USING btree (tag);


--
-- Name: telescope_entries_type_should_display_on_index_index; Type: INDEX; Schema: public; Owner: robert
--

CREATE INDEX telescope_entries_type_should_display_on_index_index ON public.telescope_entries USING btree (type, should_display_on_index);


--
-- Name: telescope_entries_tags telescope_entries_tags_entry_uuid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.telescope_entries_tags
    ADD CONSTRAINT telescope_entries_tags_entry_uuid_foreign FOREIGN KEY (entry_uuid) REFERENCES public.telescope_entries(uuid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

