--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)

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

--
-- Name: accounts_loggedinuser; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.accounts_loggedinuser (
    id bigint NOT NULL,
    session_key character varying(32),
    user_id integer NOT NULL
);


ALTER TABLE public.accounts_loggedinuser OWNER TO netitest;

--
-- Name: accounts_loggedinuser_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.accounts_loggedinuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_loggedinuser_id_seq OWNER TO netitest;

--
-- Name: accounts_loggedinuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.accounts_loggedinuser_id_seq OWNED BY public.accounts_loggedinuser.id;


--
-- Name: auditlog_logentry; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auditlog_logentry (
    id integer NOT NULL,
    object_pk character varying(255) NOT NULL,
    object_id bigint,
    object_repr text NOT NULL,
    action smallint NOT NULL,
    changes text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    actor_id integer,
    content_type_id integer NOT NULL,
    remote_addr inet,
    additional_data jsonb,
    CONSTRAINT auditlog_logentry_action_check CHECK ((action >= 0))
);


ALTER TABLE public.auditlog_logentry OWNER TO netitest;

--
-- Name: auditlog_logentry_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auditlog_logentry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditlog_logentry_id_seq OWNER TO netitest;

--
-- Name: auditlog_logentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auditlog_logentry_id_seq OWNED BY public.auditlog_logentry.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO netitest;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO netitest;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO netitest;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO netitest;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO netitest;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO netitest;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO netitest;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO netitest;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO netitest;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO netitest;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO netitest;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO netitest;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: company_company; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.company_company (
    id bigint NOT NULL,
    name character varying(51) NOT NULL,
    tally_name character varying(51) NOT NULL,
    ledger_name character varying(51) NOT NULL,
    ipaddress character varying(100) NOT NULL,
    dis_addtype character varying(100) NOT NULL,
    dis_name character varying(100) NOT NULL,
    dis_add1 character varying(100) NOT NULL,
    dis_add2 character varying(100) NOT NULL,
    dis_add3 character varying(100) NOT NULL,
    dis_country character varying(100) NOT NULL,
    dis_state character varying(100) NOT NULL,
    dis_city character varying(100) NOT NULL,
    dis_pincode character varying(100) NOT NULL,
    dis_gstin character varying(100) NOT NULL,
    pan_no character varying(10) NOT NULL,
    so_series character varying(10) NOT NULL,
    dn_series character varying(10) NOT NULL,
    inv_series character varying(10) NOT NULL,
    debitnote_series character varying(10) NOT NULL,
    sales_qdn_series character varying(10) NOT NULL,
    rso_series character varying(10) NOT NULL,
    po_series character varying(10) NOT NULL,
    ict_series character varying(10) NOT NULL,
    grn_series character varying(10) NOT NULL,
    pi_series character varying(10) NOT NULL,
    creditnote_series character varying(10) NOT NULL,
    purchase_qdn_series character varying(10) NOT NULL,
    purchase_return_series character varying(10) NOT NULL,
    joborder_series character varying(10) NOT NULL,
    job_series character varying(10) NOT NULL,
    rm_series character varying(10) NOT NULL,
    cms_series character varying(10) NOT NULL,
    pds_series character varying(10) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    pinv_series character varying(10) NOT NULL
);


ALTER TABLE public.company_company OWNER TO netitest;

--
-- Name: company_company_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.company_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_company_id_seq OWNER TO netitest;

--
-- Name: company_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.company_company_id_seq OWNED BY public.company_company.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO netitest;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO netitest;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO netitest;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO netitest;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO netitest;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO netitest;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO netitest;

--
-- Name: inventory_brand; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_brand (
    id bigint NOT NULL,
    under character varying(151) NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_brand OWNER TO netitest;

--
-- Name: inventory_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_brand_id_seq OWNER TO netitest;

--
-- Name: inventory_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_brand_id_seq OWNED BY public.inventory_brand.id;


--
-- Name: inventory_category; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_category (
    id bigint NOT NULL,
    under character varying(151) NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151),
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_category OWNER TO netitest;

--
-- Name: inventory_category_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_category_id_seq OWNER TO netitest;

--
-- Name: inventory_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_category_id_seq OWNED BY public.inventory_category.id;


--
-- Name: inventory_class; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_class (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151),
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_class OWNER TO netitest;

--
-- Name: inventory_class_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_class_id_seq OWNER TO netitest;

--
-- Name: inventory_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_class_id_seq OWNED BY public.inventory_class.id;


--
-- Name: inventory_currency; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_currency (
    id bigint NOT NULL,
    name character varying(20) NOT NULL,
    code character varying(3) NOT NULL,
    symbol character varying(10) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_currency OWNER TO netitest;

--
-- Name: inventory_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_currency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_currency_id_seq OWNER TO netitest;

--
-- Name: inventory_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_currency_id_seq OWNED BY public.inventory_currency.id;


--
-- Name: inventory_godown; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_godown (
    id bigint NOT NULL,
    godown_type boolean NOT NULL,
    name character varying(151) NOT NULL,
    parent_id bigint,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_godown OWNER TO netitest;

--
-- Name: inventory_godown_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_godown_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_godown_id_seq OWNER TO netitest;

--
-- Name: inventory_godown_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_godown_id_seq OWNED BY public.inventory_godown.id;


--
-- Name: inventory_gst_list; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_gst_list (
    id bigint NOT NULL,
    applicable_from date NOT NULL,
    discription character varying(151),
    hsncode character varying(151),
    "is_Non_gst" boolean NOT NULL,
    calc_type character varying(151) NOT NULL,
    taxability character varying(151) NOT NULL,
    reverse_charge boolean NOT NULL,
    input_credit_ineligible boolean NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    suply_type character varying(151) NOT NULL,
    product_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_gst_list OWNER TO netitest;

--
-- Name: inventory_gst_list_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_gst_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_gst_list_id_seq OWNER TO netitest;

--
-- Name: inventory_gst_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_gst_list_id_seq OWNED BY public.inventory_gst_list.id;


--
-- Name: inventory_product_master; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_product_master (
    id bigint NOT NULL,
    product_name character varying(151) NOT NULL,
    product_code character varying(151) NOT NULL,
    description character varying(255),
    notes character varying(151),
    is_saleable boolean NOT NULL,
    is_batch boolean NOT NULL,
    track_dom boolean NOT NULL,
    exp_date boolean NOT NULL,
    bill_of_material boolean NOT NULL,
    set_std_rate boolean NOT NULL,
    costing_method character varying(151) NOT NULL,
    valuation_method character varying(151) NOT NULL,
    article_code character varying(151) NOT NULL,
    ean_code character varying(151),
    old_product_code character varying(151),
    mrp numeric(15,2),
    gst numeric(15,2),
    hsn character varying(10),
    opening_balance character varying(151),
    shape_code character varying(151),
    size character varying(151),
    style_shape character varying(151),
    series character varying(151),
    pattern character varying(151),
    country_of_origin character varying(151),
    color_shade_theme character varying(151),
    inner_qty numeric(15,2),
    outer_qty numeric(15,2),
    imported_by character varying(151),
    mfd_by character varying(151),
    mkt_by character varying(151),
    product_portfolio character varying(151),
    isgstapplicable boolean NOT NULL,
    behaviour boolean NOT NULL,
    ipd boolean NOT NULL,
    ins boolean NOT NULL,
    tsm boolean NOT NULL,
    tpc boolean NOT NULL,
    trs boolean NOT NULL,
    additional_units_id bigint,
    brand_id bigint NOT NULL,
    category_id bigint NOT NULL,
    dl_purchase_id bigint,
    dl_sales_id bigint,
    product_class_id bigint NOT NULL,
    product_type_id bigint NOT NULL,
    sub_brand_id bigint NOT NULL,
    sub_class_id bigint NOT NULL,
    units_of_measure_id bigint NOT NULL,
    created date,
    updated date NOT NULL
);


ALTER TABLE public.inventory_product_master OWNER TO netitest;

--
-- Name: inventory_product_master_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_product_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_product_master_id_seq OWNER TO netitest;

--
-- Name: inventory_product_master_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_product_master_id_seq OWNED BY public.inventory_product_master.id;


--
-- Name: inventory_producttype; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_producttype (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151),
    created date NOT NULL,
    updated date NOT NULL,
    dl_purchase_id bigint NOT NULL,
    dl_sales_id bigint NOT NULL
);


ALTER TABLE public.inventory_producttype OWNER TO netitest;

--
-- Name: inventory_producttype_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_producttype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_producttype_id_seq OWNER TO netitest;

--
-- Name: inventory_producttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_producttype_id_seq OWNED BY public.inventory_producttype.id;


--
-- Name: inventory_scheme; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_scheme (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_scheme OWNER TO netitest;

--
-- Name: inventory_scheme_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_scheme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_scheme_id_seq OWNER TO netitest;

--
-- Name: inventory_scheme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_scheme_id_seq OWNED BY public.inventory_scheme.id;


--
-- Name: inventory_std_rate; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_std_rate (
    id bigint NOT NULL,
    rate_type character varying(20) NOT NULL,
    applicable_from date NOT NULL,
    rate numeric(15,2) NOT NULL,
    uom character varying(151),
    product_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_std_rate OWNER TO netitest;

--
-- Name: inventory_std_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_std_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_std_rate_id_seq OWNER TO netitest;

--
-- Name: inventory_std_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_std_rate_id_seq OWNED BY public.inventory_std_rate.id;


--
-- Name: inventory_subbrand; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_subbrand (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151),
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_subbrand OWNER TO netitest;

--
-- Name: inventory_subbrand_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_subbrand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_subbrand_id_seq OWNER TO netitest;

--
-- Name: inventory_subbrand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_subbrand_id_seq OWNED BY public.inventory_subbrand.id;


--
-- Name: inventory_subclass; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_subclass (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151),
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_subclass OWNER TO netitest;

--
-- Name: inventory_subclass_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_subclass_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_subclass_id_seq OWNER TO netitest;

--
-- Name: inventory_subclass_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_subclass_id_seq OWNED BY public.inventory_subclass.id;


--
-- Name: inventory_unitofmeasure; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_unitofmeasure (
    id bigint NOT NULL,
    uom_type character varying(151),
    symbol character varying(151) NOT NULL,
    name character varying(151) NOT NULL,
    decimal_places numeric(1,0) NOT NULL,
    uqc_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_unitofmeasure OWNER TO netitest;

--
-- Name: inventory_unitofmeasure_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_unitofmeasure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_unitofmeasure_id_seq OWNER TO netitest;

--
-- Name: inventory_unitofmeasure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_unitofmeasure_id_seq OWNED BY public.inventory_unitofmeasure.id;


--
-- Name: inventory_uqc; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.inventory_uqc (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.inventory_uqc OWNER TO netitest;

--
-- Name: inventory_uqc_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.inventory_uqc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_uqc_id_seq OWNER TO netitest;

--
-- Name: inventory_uqc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.inventory_uqc_id_seq OWNED BY public.inventory_uqc.id;


--
-- Name: ledgers_asm; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_asm (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    region_id bigint NOT NULL,
    rsm_id bigint NOT NULL,
    zone_id bigint NOT NULL,
    zsm_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_asm OWNER TO netitest;

--
-- Name: ledgers_asm_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_asm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_asm_id_seq OWNER TO netitest;

--
-- Name: ledgers_asm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_asm_id_seq OWNED BY public.ledgers_asm.id;


--
-- Name: ledgers_city; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_city (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    name character varying(151) NOT NULL,
    state_id bigint NOT NULL
);


ALTER TABLE public.ledgers_city OWNER TO netitest;

--
-- Name: ledgers_city_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_city_id_seq OWNER TO netitest;

--
-- Name: ledgers_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_city_id_seq OWNED BY public.ledgers_city.id;


--
-- Name: ledgers_country; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_country (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    name character varying(151) NOT NULL
);


ALTER TABLE public.ledgers_country OWNER TO netitest;

--
-- Name: ledgers_country_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_country_id_seq OWNER TO netitest;

--
-- Name: ledgers_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_country_id_seq OWNED BY public.ledgers_country.id;


--
-- Name: ledgers_currency; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_currency (
    id bigint NOT NULL,
    code character varying(3) NOT NULL,
    name character varying(25) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_currency OWNER TO netitest;

--
-- Name: ledgers_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_currency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_currency_id_seq OWNER TO netitest;

--
-- Name: ledgers_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_currency_id_seq OWNED BY public.ledgers_currency.id;


--
-- Name: ledgers_division; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_division (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.ledgers_division OWNER TO netitest;

--
-- Name: ledgers_division_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_division_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_division_id_seq OWNER TO netitest;

--
-- Name: ledgers_division_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_division_id_seq OWNED BY public.ledgers_division.id;


--
-- Name: ledgers_group; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_group (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_group OWNER TO netitest;

--
-- Name: ledgers_group_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_group_id_seq OWNER TO netitest;

--
-- Name: ledgers_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_group_id_seq OWNED BY public.ledgers_group.id;


--
-- Name: ledgers_ledgerstype; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_ledgerstype (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    gst_applicable character varying(151) NOT NULL,
    type_of_supply character varying(151) NOT NULL,
    under_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_ledgerstype OWNER TO netitest;

--
-- Name: ledgers_ledgerstype_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_ledgerstype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_ledgerstype_id_seq OWNER TO netitest;

--
-- Name: ledgers_ledgerstype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_ledgerstype_id_seq OWNED BY public.ledgers_ledgerstype.id;


--
-- Name: ledgers_party_contact_details; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_party_contact_details (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    address_type character varying(151) NOT NULL,
    mailing_name character varying(151),
    addressline1 character varying(151),
    addressline2 character varying(151),
    addressline3 character varying(151),
    country_id bigint NOT NULL,
    state_id bigint NOT NULL,
    city_id bigint NOT NULL,
    pin_code character varying(12),
    contact_person character varying(151),
    phone_no character varying(12),
    mobile_no character varying(12),
    fax_no character varying(12),
    email_id character varying(250),
    pan_no character varying(250),
    gst_registration_type character varying(151),
    gstin character varying(151),
    party_id bigint NOT NULL
);


ALTER TABLE public.ledgers_party_contact_details OWNER TO netitest;

--
-- Name: ledgers_party_contact_details_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_party_contact_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_party_contact_details_id_seq OWNER TO netitest;

--
-- Name: ledgers_party_contact_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_party_contact_details_id_seq OWNED BY public.ledgers_party_contact_details.id;


--
-- Name: ledgers_party_master; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_party_master (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    name character varying(151) NOT NULL,
    maintain_bill_by_bill boolean NOT NULL,
    dafault_credit_period character varying(151),
    check_credit_days boolean NOT NULL,
    credit_limit character varying(151),
    closing_balance character varying(151),
    override_credit_limit boolean NOT NULL,
    payment_terms character varying(151),
    allow_loose_packing boolean NOT NULL,
    istcsapplicable boolean NOT NULL,
    vendor_code character varying(151),
    mailing_name character varying(151) NOT NULL,
    addressline1 character varying(151),
    addressline2 character varying(151),
    addressline3 character varying(151),
    pin_code character varying(6),
    mobile_no character varying(12),
    contact_details boolean NOT NULL,
    contact_person character varying(151),
    phone_no character varying(12),
    fax_no character varying(12),
    email_id character varying(250),
    cc_email text,
    website character varying(151),
    multiple_address_list boolean NOT NULL,
    gst_registration_type character varying(151) NOT NULL,
    gstin character varying(151),
    pan_no character varying(151),
    transation_type character varying(151),
    bank character varying(151),
    ifsc_code character varying(151),
    account_no character varying(151),
    account_name character varying(151),
    asm_id bigint,
    city_id bigint NOT NULL,
    country_id bigint NOT NULL,
    devision_id bigint NOT NULL,
    group_id bigint NOT NULL,
    party_type_id bigint NOT NULL,
    price_level_id bigint NOT NULL,
    region_id bigint,
    rsm_id bigint,
    se_id bigint,
    state_id bigint NOT NULL,
    zone_id bigint,
    zsm_id bigint,
    is_transporter boolean NOT NULL
);


ALTER TABLE public.ledgers_party_master OWNER TO netitest;

--
-- Name: ledgers_party_master_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_party_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_party_master_id_seq OWNER TO netitest;

--
-- Name: ledgers_party_master_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_party_master_id_seq OWNED BY public.ledgers_party_master.id;


--
-- Name: ledgers_party_master_products; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_party_master_products (
    id bigint NOT NULL,
    party_master_id bigint NOT NULL,
    product_master_id bigint NOT NULL
);


ALTER TABLE public.ledgers_party_master_products OWNER TO netitest;

--
-- Name: ledgers_party_master_products_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_party_master_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_party_master_products_id_seq OWNER TO netitest;

--
-- Name: ledgers_party_master_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_party_master_products_id_seq OWNED BY public.ledgers_party_master_products.id;


--
-- Name: ledgers_partytype; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_partytype (
    id bigint NOT NULL,
    code character varying(151),
    name character varying(151) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_partytype OWNER TO netitest;

--
-- Name: ledgers_partytype_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_partytype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_partytype_id_seq OWNER TO netitest;

--
-- Name: ledgers_partytype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_partytype_id_seq OWNED BY public.ledgers_partytype.id;


--
-- Name: ledgers_price_level; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_price_level (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    name character varying(151) NOT NULL,
    code character varying(151)
);


ALTER TABLE public.ledgers_price_level OWNER TO netitest;

--
-- Name: ledgers_price_level_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_price_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_price_level_id_seq OWNER TO netitest;

--
-- Name: ledgers_price_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_price_level_id_seq OWNED BY public.ledgers_price_level.id;


--
-- Name: ledgers_price_list; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_price_list (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    applicable_from date NOT NULL,
    rate numeric(15,2) NOT NULL,
    price_level_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.ledgers_price_list OWNER TO netitest;

--
-- Name: ledgers_price_list_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_price_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_price_list_id_seq OWNER TO netitest;

--
-- Name: ledgers_price_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_price_list_id_seq OWNED BY public.ledgers_price_list.id;


--
-- Name: ledgers_region; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_region (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    zone_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_region OWNER TO netitest;

--
-- Name: ledgers_region_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_region_id_seq OWNER TO netitest;

--
-- Name: ledgers_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_region_id_seq OWNED BY public.ledgers_region.id;


--
-- Name: ledgers_rsm; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_rsm (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    region_id bigint NOT NULL,
    zone_id bigint NOT NULL,
    zsm_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_rsm OWNER TO netitest;

--
-- Name: ledgers_rsm_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_rsm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_rsm_id_seq OWNER TO netitest;

--
-- Name: ledgers_rsm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_rsm_id_seq OWNED BY public.ledgers_rsm.id;


--
-- Name: ledgers_se; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_se (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    asm_id bigint NOT NULL,
    region_id bigint NOT NULL,
    rsm_id bigint NOT NULL,
    zone_id bigint NOT NULL,
    zsm_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_se OWNER TO netitest;

--
-- Name: ledgers_se_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_se_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_se_id_seq OWNER TO netitest;

--
-- Name: ledgers_se_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_se_id_seq OWNED BY public.ledgers_se.id;


--
-- Name: ledgers_state; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_state (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    name character varying(151) NOT NULL,
    country_id bigint NOT NULL
);


ALTER TABLE public.ledgers_state OWNER TO netitest;

--
-- Name: ledgers_state_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_state_id_seq OWNER TO netitest;

--
-- Name: ledgers_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_state_id_seq OWNED BY public.ledgers_state.id;


--
-- Name: ledgers_zone; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_zone (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_zone OWNER TO netitest;

--
-- Name: ledgers_zone_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_zone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_zone_id_seq OWNER TO netitest;

--
-- Name: ledgers_zone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_zone_id_seq OWNED BY public.ledgers_zone.id;


--
-- Name: ledgers_zsm; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.ledgers_zsm (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    zone_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.ledgers_zsm OWNER TO netitest;

--
-- Name: ledgers_zsm_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.ledgers_zsm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ledgers_zsm_id_seq OWNER TO netitest;

--
-- Name: ledgers_zsm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.ledgers_zsm_id_seq OWNED BY public.ledgers_zsm.id;


--
-- Name: planning_bom; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.planning_bom (
    id bigint NOT NULL,
    name character varying(151) NOT NULL,
    description text NOT NULL,
    last_date date,
    product_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.planning_bom OWNER TO netitest;

--
-- Name: planning_bom_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.planning_bom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planning_bom_id_seq OWNER TO netitest;

--
-- Name: planning_bom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.planning_bom_id_seq OWNED BY public.planning_bom.id;


--
-- Name: planning_bomitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.planning_bomitems (
    id bigint NOT NULL,
    qty numeric(24,4) NOT NULL,
    bom_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.planning_bomitems OWNER TO netitest;

--
-- Name: planning_bomitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.planning_bomitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planning_bomitems_id_seq OWNER TO netitest;

--
-- Name: planning_bomitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.planning_bomitems_id_seq OWNED BY public.planning_bomitems.id;


--
-- Name: planning_joborder; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.planning_joborder (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    no character varying(150) NOT NULL,
    name character varying(100) NOT NULL,
    qty numeric(25,4) NOT NULL,
    remain_qty numeric(25,4) NOT NULL,
    date date NOT NULL,
    due_date date NOT NULL,
    ref character varying(150) NOT NULL,
    details character varying(150) NOT NULL,
    category character varying(150) NOT NULL,
    issuedby character varying(151) NOT NULL,
    remarks text NOT NULL,
    status character varying(1) NOT NULL,
    bom_id bigint NOT NULL,
    company_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.planning_joborder OWNER TO netitest;

--
-- Name: planning_joborder_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.planning_joborder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planning_joborder_id_seq OWNER TO netitest;

--
-- Name: planning_joborder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.planning_joborder_id_seq OWNED BY public.planning_joborder.id;


--
-- Name: planning_salesprojection; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.planning_salesprojection (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    p_qty numeric(15,4) NOT NULL,
    a_qty numeric(15,4) NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    division_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.planning_salesprojection OWNER TO netitest;

--
-- Name: planning_salesprojection_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.planning_salesprojection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planning_salesprojection_id_seq OWNER TO netitest;

--
-- Name: planning_salesprojection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.planning_salesprojection_id_seq OWNED BY public.planning_salesprojection.id;


--
-- Name: production_consitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_consitems (
    id bigint NOT NULL,
    qty numeric(15,4) NOT NULL,
    con_qty numeric(15,4) NOT NULL,
    indent_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.production_consitems OWNER TO netitest;

--
-- Name: production_consitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_consitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_consitems_id_seq OWNER TO netitest;

--
-- Name: production_consitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_consitems_id_seq OWNED BY public.production_consitems.id;


--
-- Name: production_consumableindent; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_consumableindent (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    no character varying(10) NOT NULL,
    qty numeric(15,4) NOT NULL,
    company_id bigint NOT NULL,
    drawn_by_id integer NOT NULL,
    issuer_id integer NOT NULL
);


ALTER TABLE public.production_consumableindent OWNER TO netitest;

--
-- Name: production_consumableindent_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_consumableindent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_consumableindent_id_seq OWNER TO netitest;

--
-- Name: production_consumableindent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_consumableindent_id_seq OWNED BY public.production_consumableindent.id;


--
-- Name: production_consumption; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_consumption (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    no character varying(20) NOT NULL,
    date date NOT NULL,
    company_id bigint NOT NULL,
    jobcard_id bigint NOT NULL,
    qty numeric(15,4) NOT NULL
);


ALTER TABLE public.production_consumption OWNER TO netitest;

--
-- Name: production_consumption_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_consumption_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_consumption_id_seq OWNER TO netitest;

--
-- Name: production_consumption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_consumption_id_seq OWNED BY public.production_consumption.id;


--
-- Name: production_consumptionitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_consumptionitems (
    id bigint NOT NULL,
    rate numeric(15,2) NOT NULL,
    mrp character varying(51) NOT NULL,
    batch character varying(51) NOT NULL,
    qty numeric(15,4) NOT NULL,
    consumption_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.production_consumptionitems OWNER TO netitest;

--
-- Name: production_consumptionitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_consumptionitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_consumptionitems_id_seq OWNER TO netitest;

--
-- Name: production_consumptionitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_consumptionitems_id_seq OWNED BY public.production_consumptionitems.id;


--
-- Name: production_jobcard; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_jobcard (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    no character varying(50) NOT NULL,
    qty numeric(15,4) NOT NULL,
    start date NOT NULL,
    company_id bigint NOT NULL,
    joborder_id bigint NOT NULL,
    product_id bigint NOT NULL,
    rqty numeric(15,4) NOT NULL,
    status character varying(1) NOT NULL
);


ALTER TABLE public.production_jobcard OWNER TO netitest;

--
-- Name: production_jobcard_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_jobcard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_jobcard_id_seq OWNER TO netitest;

--
-- Name: production_jobcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_jobcard_id_seq OWNED BY public.production_jobcard.id;


--
-- Name: production_rmindent; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_rmindent (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    no character varying(20) NOT NULL,
    status character varying(1) NOT NULL,
    company_id bigint NOT NULL,
    jobcard_id bigint NOT NULL
);


ALTER TABLE public.production_rmindent OWNER TO netitest;

--
-- Name: production_rmindent_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_rmindent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_rmindent_id_seq OWNER TO netitest;

--
-- Name: production_rmindent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_rmindent_id_seq OWNED BY public.production_rmindent.id;


--
-- Name: production_rmindentitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_rmindentitems (
    id bigint NOT NULL,
    qty numeric(15,4) NOT NULL,
    bom_id bigint NOT NULL,
    item_id bigint NOT NULL,
    rmindent_id bigint NOT NULL
);


ALTER TABLE public.production_rmindentitems OWNER TO netitest;

--
-- Name: production_rmindentitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_rmindentitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_rmindentitems_id_seq OWNER TO netitest;

--
-- Name: production_rmindentitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_rmindentitems_id_seq OWNED BY public.production_rmindentitems.id;


--
-- Name: production_rmitemgodown; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.production_rmitemgodown (
    id bigint NOT NULL,
    rate numeric(15,2) NOT NULL,
    mrp character varying(51) NOT NULL,
    batch character varying(51) NOT NULL,
    godown character varying(51) NOT NULL,
    qty numeric(15,2) NOT NULL,
    rmitem_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.production_rmitemgodown OWNER TO netitest;

--
-- Name: production_rmitemgodown_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.production_rmitemgodown_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.production_rmitemgodown_id_seq OWNER TO netitest;

--
-- Name: production_rmitemgodown_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.production_rmitemgodown_id_seq OWNED BY public.production_rmitemgodown.id;


--
-- Name: purchase_debitnote; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_debitnote (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    db_no character varying(151) NOT NULL,
    db_date date NOT NULL,
    seller_address_type character varying(151) NOT NULL,
    seller_gst_reg_type character varying(151) NOT NULL,
    seller_state character varying(151) NOT NULL,
    seller_country character varying(151) NOT NULL,
    seller_city character varying(151) NOT NULL,
    seller_mailingname character varying(151) NOT NULL,
    seller_address1 character varying(151) NOT NULL,
    seller_address2 character varying(151) NOT NULL,
    seller_address3 character varying(151) NOT NULL,
    seller_pincode character varying(151) NOT NULL,
    seller_gstin character varying(151),
    shipto_address_type character varying(151) NOT NULL,
    shipto_country character varying(151) NOT NULL,
    shipto_state character varying(151) NOT NULL,
    shipto_city character varying(151) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_pincode character varying(151) NOT NULL,
    shipto_gstin character varying(151),
    shipto_pan_no character varying(151) NOT NULL,
    mode_of_payment character varying(151),
    other_reference character varying(151),
    terms_of_delivery character varying(151),
    dispatch_through character varying(151),
    destination character varying(151),
    narration text,
    ammount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    company_id bigint NOT NULL,
    pi_no_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    shipto_id bigint NOT NULL,
    currency character varying(20) NOT NULL,
    ex_rate numeric(7,2) NOT NULL
);


ALTER TABLE public.purchase_debitnote OWNER TO netitest;

--
-- Name: purchase_debitnote_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_debitnote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_debitnote_id_seq OWNER TO netitest;

--
-- Name: purchase_debitnote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_debitnote_id_seq OWNED BY public.purchase_debitnote.id;


--
-- Name: purchase_debitnoteitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_debitnoteitems (
    id bigint NOT NULL,
    product_code character varying(151) NOT NULL,
    batch character varying(151) NOT NULL,
    pack character varying(151) NOT NULL,
    mrp character varying(151) NOT NULL,
    actual_qty numeric(15,2) NOT NULL,
    actual_rate numeric(15,2) NOT NULL,
    rate_diff numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    "debitNote_id" bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.purchase_debitnoteitems OWNER TO netitest;

--
-- Name: purchase_debitnoteitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_debitnoteitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_debitnoteitems_id_seq OWNER TO netitest;

--
-- Name: purchase_debitnoteitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_debitnoteitems_id_seq OWNED BY public.purchase_debitnoteitems.id;


--
-- Name: purchase_grn; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_grn (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    grn_no character varying(151) NOT NULL,
    grn_date date NOT NULL,
    seller_address_type character varying(151) NOT NULL,
    seller_gst_reg_type character varying(151) NOT NULL,
    seller_state character varying(151) NOT NULL,
    seller_country character varying(151) NOT NULL,
    seller_city character varying(151) NOT NULL,
    seller_mailingname character varying(151) NOT NULL,
    seller_address1 character varying(151) NOT NULL,
    seller_address2 character varying(151),
    seller_address3 character varying(151),
    seller_pincode character varying(151) NOT NULL,
    seller_gstin character varying(151),
    shipto_address_type character varying(151) NOT NULL,
    shipto_country character varying(151) NOT NULL,
    shipto_state character varying(151) NOT NULL,
    shipto_city character varying(151) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151),
    shipto_address3 character varying(151),
    shipto_pincode character varying(151) NOT NULL,
    shipto_gstin character varying(151) NOT NULL,
    shipto_pan_no character varying(151),
    ammount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    narration text,
    mode_of_payment character varying(151),
    other_reference character varying(151),
    terms_of_delivery character varying(151),
    dispatch_through character varying(151),
    destintaion character varying(151),
    company_id bigint NOT NULL,
    other_ledger_id bigint,
    pi_id bigint,
    po_id bigint,
    seller_id bigint NOT NULL,
    shipto_id bigint NOT NULL,
    currency character varying(20) NOT NULL,
    ex_rate numeric(7,2) NOT NULL
);


ALTER TABLE public.purchase_grn OWNER TO netitest;

--
-- Name: purchase_grn_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_grn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_grn_id_seq OWNER TO netitest;

--
-- Name: purchase_grn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_grn_id_seq OWNED BY public.purchase_grn.id;


--
-- Name: purchase_grnitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_grnitems (
    id bigint NOT NULL,
    product_code character varying(151) NOT NULL,
    batch character varying(151) NOT NULL,
    pack character varying(151) NOT NULL,
    mrp character varying(151) NOT NULL,
    actual_qty numeric(15,2) NOT NULL,
    recd_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    grn_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.purchase_grnitems OWNER TO netitest;

--
-- Name: purchase_grnitems_godown; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_grnitems_godown (
    id bigint NOT NULL,
    grnitems_id bigint NOT NULL,
    godown_id bigint NOT NULL
);


ALTER TABLE public.purchase_grnitems_godown OWNER TO netitest;

--
-- Name: purchase_grnitems_godown_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_grnitems_godown_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_grnitems_godown_id_seq OWNER TO netitest;

--
-- Name: purchase_grnitems_godown_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_grnitems_godown_id_seq OWNED BY public.purchase_grnitems_godown.id;


--
-- Name: purchase_grnitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_grnitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_grnitems_id_seq OWNER TO netitest;

--
-- Name: purchase_grnitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_grnitems_id_seq OWNED BY public.purchase_grnitems.id;


--
-- Name: purchase_piitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_piitems (
    id bigint NOT NULL,
    product_code character varying(151) NOT NULL,
    batch character varying(151) NOT NULL,
    pack character varying(151) NOT NULL,
    mrp character varying(151) NOT NULL,
    basic_qty numeric(15,2) NOT NULL,
    recd_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    grn_id bigint,
    item_id bigint NOT NULL,
    pi_id bigint NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public.purchase_piitems OWNER TO netitest;

--
-- Name: purchase_piitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_piitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_piitems_id_seq OWNER TO netitest;

--
-- Name: purchase_piitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_piitems_id_seq OWNED BY public.purchase_piitems.id;


--
-- Name: purchase_poitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_poitems (
    id bigint NOT NULL,
    product_code character varying(151) NOT NULL,
    pack character varying(151) NOT NULL,
    basic_qty numeric(15,2) NOT NULL,
    actual_qty numeric(15,2) NOT NULL,
    amend_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    item_id bigint NOT NULL,
    po_id bigint NOT NULL
);


ALTER TABLE public.purchase_poitems OWNER TO netitest;

--
-- Name: purchase_poitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_poitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_poitems_id_seq OWNER TO netitest;

--
-- Name: purchase_poitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_poitems_id_seq OWNED BY public.purchase_poitems.id;


--
-- Name: purchase_purchase; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_purchase (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    pi_no character varying(151) NOT NULL,
    pi_date date NOT NULL,
    seller_address_type character varying(151) NOT NULL,
    seller_gst_reg_type character varying(151) NOT NULL,
    seller_state character varying(151) NOT NULL,
    seller_country character varying(151) NOT NULL,
    seller_city character varying(151) NOT NULL,
    seller_mailingname character varying(151) NOT NULL,
    seller_address1 character varying(151) NOT NULL,
    seller_address2 character varying(151) NOT NULL,
    seller_address3 character varying(151) NOT NULL,
    seller_pincode character varying(151) NOT NULL,
    seller_gstin character varying(151),
    shipto_address_type character varying(151) NOT NULL,
    shipto_country character varying(151) NOT NULL,
    shipto_state character varying(151) NOT NULL,
    shipto_city character varying(151) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_pincode character varying(151) NOT NULL,
    shipto_gstin character varying(151) NOT NULL,
    shipto_pan_no character varying(151),
    mode_of_payment character varying(151),
    other_reference character varying(151),
    terms_of_delivery character varying(151),
    dispatch_through character varying(151),
    destination character varying(151),
    supplier_invoice character varying(51) NOT NULL,
    supplier_date date NOT NULL,
    ammount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    narration text,
    is_ict boolean NOT NULL,
    company_id bigint NOT NULL,
    other_ledger_id bigint,
    seller_id bigint NOT NULL,
    shipto_id bigint NOT NULL,
    currency character varying(20) NOT NULL,
    ex_rate numeric(7,2) NOT NULL
);


ALTER TABLE public.purchase_purchase OWNER TO netitest;

--
-- Name: purchase_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_purchase_id_seq OWNER TO netitest;

--
-- Name: purchase_purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_purchase_id_seq OWNED BY public.purchase_purchase.id;


--
-- Name: purchase_purchase_order; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_purchase_order (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    status character varying(20) NOT NULL,
    po_no character varying(151) NOT NULL,
    ref_no character varying(151),
    po_date date NOT NULL,
    po_due_date date,
    seller_address_type character varying(151) NOT NULL,
    seller_mailingname character varying(151) NOT NULL,
    seller_address1 character varying(151),
    seller_address2 character varying(151),
    seller_address3 character varying(151),
    seller_state character varying(151) NOT NULL,
    seller_city character varying(151) NOT NULL,
    seller_country character varying(151) NOT NULL,
    seller_pincode character varying(151) NOT NULL,
    seller_gst_reg_type character varying(151) NOT NULL,
    seller_gstin character varying(151),
    shipto_address_type character varying(151) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_city character varying(151) NOT NULL,
    shipto_state character varying(151) NOT NULL,
    shipto_country character varying(151) NOT NULL,
    shipto_pincode character varying(151) NOT NULL,
    shipto_gstin character varying(151),
    mode_of_payment character varying(151),
    other_reference character varying(151),
    terms_of_delivery character varying(151),
    ammount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    dispatch_through character varying(151),
    destintaion character varying(151),
    narration text,
    company_id bigint NOT NULL,
    other_ledger_id bigint,
    seller_id bigint NOT NULL,
    shipto_id bigint NOT NULL,
    currency character varying(20) NOT NULL,
    ex_rate numeric(7,2) NOT NULL
);


ALTER TABLE public.purchase_purchase_order OWNER TO netitest;

--
-- Name: purchase_purchase_order_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_purchase_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_purchase_order_id_seq OWNER TO netitest;

--
-- Name: purchase_purchase_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_purchase_order_id_seq OWNED BY public.purchase_purchase_order.id;


--
-- Name: purchase_purchasereturn; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_purchasereturn (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    pr_no character varying(151) NOT NULL,
    pr_date date NOT NULL,
    seller_address_type character varying(151) NOT NULL,
    seller_gst_reg_type character varying(151) NOT NULL,
    seller_state character varying(151) NOT NULL,
    seller_country character varying(151) NOT NULL,
    seller_city character varying(151) NOT NULL,
    seller_mailingname character varying(151) NOT NULL,
    seller_address1 character varying(151) NOT NULL,
    seller_address2 character varying(151) NOT NULL,
    seller_address3 character varying(151) NOT NULL,
    seller_pincode character varying(151) NOT NULL,
    seller_gstin character varying(151),
    shipto_address_type character varying(151) NOT NULL,
    shipto_country character varying(151) NOT NULL,
    shipto_state character varying(151) NOT NULL,
    shipto_city character varying(151) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_pincode character varying(151) NOT NULL,
    shipto_gstin character varying(151),
    shipto_pan_no character varying(151) NOT NULL,
    mode_of_payment character varying(151),
    other_reference character varying(151),
    terms_of_delivery character varying(151),
    dispatch_through character varying(151),
    destination character varying(151),
    narration text,
    ammount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    company_id bigint NOT NULL,
    pi_no_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    shipto_id bigint NOT NULL
);


ALTER TABLE public.purchase_purchasereturn OWNER TO netitest;

--
-- Name: purchase_purchasereturn_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_purchasereturn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_purchasereturn_id_seq OWNER TO netitest;

--
-- Name: purchase_purchasereturn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_purchasereturn_id_seq OWNED BY public.purchase_purchasereturn.id;


--
-- Name: purchase_purchasereturnitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_purchasereturnitems (
    id bigint NOT NULL,
    product_code character varying(151) NOT NULL,
    batch character varying(151) NOT NULL,
    pack character varying(151) NOT NULL,
    mrp character varying(151) NOT NULL,
    actual_qty numeric(15,2) NOT NULL,
    return_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    item_id bigint NOT NULL,
    pr_id bigint NOT NULL
);


ALTER TABLE public.purchase_purchasereturnitems OWNER TO netitest;

--
-- Name: purchase_purchasereturnitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_purchasereturnitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_purchasereturnitems_id_seq OWNER TO netitest;

--
-- Name: purchase_purchasereturnitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_purchasereturnitems_id_seq OWNED BY public.purchase_purchasereturnitems.id;


--
-- Name: purchase_qdn; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_qdn (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    qdn_no character varying(151) NOT NULL,
    qdn_date date NOT NULL,
    seller_address_type character varying(151) NOT NULL,
    seller_gst_reg_type character varying(151) NOT NULL,
    seller_state character varying(151) NOT NULL,
    seller_country character varying(151) NOT NULL,
    seller_city character varying(151) NOT NULL,
    seller_mailingname character varying(151) NOT NULL,
    seller_address1 character varying(151) NOT NULL,
    seller_address2 character varying(151) NOT NULL,
    seller_address3 character varying(151) NOT NULL,
    seller_pincode character varying(151) NOT NULL,
    seller_gstin character varying(151),
    shipto_address_type character varying(151) NOT NULL,
    shipto_country character varying(151) NOT NULL,
    shipto_state character varying(151) NOT NULL,
    shipto_city character varying(151) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_pincode character varying(151) NOT NULL,
    shipto_gstin character varying(151),
    shipto_pan_no character varying(151) NOT NULL,
    mode_of_payment character varying(151),
    other_reference character varying(151),
    terms_of_delivery character varying(151),
    dispatch_through character varying(151),
    destination character varying(151),
    narration text,
    ammount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    company_id bigint NOT NULL,
    pi_no_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    shipto_id bigint NOT NULL
);


ALTER TABLE public.purchase_qdn OWNER TO netitest;

--
-- Name: purchase_qdn_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_qdn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_qdn_id_seq OWNER TO netitest;

--
-- Name: purchase_qdn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_qdn_id_seq OWNED BY public.purchase_qdn.id;


--
-- Name: purchase_qdnitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.purchase_qdnitems (
    id bigint NOT NULL,
    product_code character varying(151) NOT NULL,
    batch character varying(151) NOT NULL,
    pack character varying(151) NOT NULL,
    mrp character varying(151) NOT NULL,
    actual_qty numeric(15,2) NOT NULL,
    qdn_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    item_id bigint NOT NULL,
    qdn_id bigint NOT NULL
);


ALTER TABLE public.purchase_qdnitems OWNER TO netitest;

--
-- Name: purchase_qdnitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.purchase_qdnitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_qdnitems_id_seq OWNER TO netitest;

--
-- Name: purchase_qdnitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.purchase_qdnitems_id_seq OWNED BY public.purchase_qdnitems.id;


--
-- Name: sales_creditnote; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_creditnote (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    status character varying(20) NOT NULL,
    cn_no character varying(51) NOT NULL,
    cn_date date NOT NULL,
    other numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    scheme character varying(51),
    narration text,
    company_id bigint NOT NULL,
    inv_id bigint,
    other_ledger_id bigint,
    mrpvalue numeric(15,2) NOT NULL,
    omrpvalue numeric(15,2) NOT NULL,
    buyer_id bigint NOT NULL,
    buyer_address1 character varying(151) NOT NULL,
    buyer_address2 character varying(151) NOT NULL,
    buyer_address3 character varying(151) NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51) NOT NULL,
    buyer_gstin character varying(51),
    buyer_mailingname character varying(151) NOT NULL,
    buyer_pincode character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    channel character varying(51) NOT NULL,
    division character varying(51) NOT NULL
);


ALTER TABLE public.sales_creditnote OWNER TO netitest;

--
-- Name: sales_creditnote_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_creditnote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_creditnote_id_seq OWNER TO netitest;

--
-- Name: sales_creditnote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_creditnote_id_seq OWNED BY public.sales_creditnote.id;


--
-- Name: sales_creditnoteitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_creditnoteitems (
    id bigint NOT NULL,
    billed_qty numeric(15,2) NOT NULL,
    rates numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    inv_id bigint NOT NULL,
    item_id bigint NOT NULL,
    mrp numeric(15,2) NOT NULL
);


ALTER TABLE public.sales_creditnoteitems OWNER TO netitest;

--
-- Name: sales_creditnoteitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_creditnoteitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_creditnoteitems_id_seq OWNER TO netitest;

--
-- Name: sales_creditnoteitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_creditnoteitems_id_seq OWNED BY public.sales_creditnoteitems.id;


--
-- Name: sales_delivery_note; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_delivery_note (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    dn_no character varying(51) NOT NULL,
    dn_date date NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_mailingname character varying(151) NOT NULL,
    buyer_address1 character varying(151),
    buyer_address2 character varying(151),
    buyer_address3 character varying(151),
    buyer_pincode character varying(51) NOT NULL,
    buyer_gstin character varying(51),
    shipto_address_type character varying(51) NOT NULL,
    shipto_country character varying(51) NOT NULL,
    shipto_state character varying(51) NOT NULL,
    shipto_city character varying(51) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151),
    shipto_address2 character varying(151),
    shipto_address3 character varying(151),
    shipto_pincode character varying(51) NOT NULL,
    shipto_gstin character varying(51),
    shipto_pan_no character varying(51),
    bill_qty numeric(15,2) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    scheme character varying(51),
    price_list character varying(51),
    narration text,
    mode_of_payment character varying(51),
    other_reference character varying(51),
    terms_of_delivery character varying(51),
    order_no character varying(51),
    dispatch_doc_no character varying(51),
    dispatch_through character varying(51),
    destintaion character varying(51),
    carrier_agent character varying(51),
    carrier_agent_id character varying(51),
    lr_no character varying(51),
    lr_date date,
    vehical_no character varying(51),
    vehical_type character varying(51),
    ls_status boolean NOT NULL,
    ps_status boolean NOT NULL,
    buyer_id bigint NOT NULL,
    company_id bigint NOT NULL,
    other_ledger_id bigint,
    sales_order_id bigint,
    shipto_id bigint NOT NULL
);


ALTER TABLE public.sales_delivery_note OWNER TO netitest;

--
-- Name: sales_delivery_note_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_delivery_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_delivery_note_id_seq OWNER TO netitest;

--
-- Name: sales_delivery_note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_delivery_note_id_seq OWNED BY public.sales_delivery_note.id;


--
-- Name: sales_dnitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_dnitems (
    id bigint NOT NULL,
    mrp numeric(15,2) NOT NULL,
    offer_mrp numeric(15,2) NOT NULL,
    pack numeric(15,2) NOT NULL,
    available_qty numeric(15,2) NOT NULL,
    actual_qty numeric(15,3) NOT NULL,
    billed_qty numeric(15,3) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    prate numeric(15,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    dn_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.sales_dnitems OWNER TO netitest;

--
-- Name: sales_dnitems_godown; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_dnitems_godown (
    id bigint NOT NULL,
    dnitems_id bigint NOT NULL,
    godown_id bigint NOT NULL
);


ALTER TABLE public.sales_dnitems_godown OWNER TO netitest;

--
-- Name: sales_dnitems_godown_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_dnitems_godown_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_dnitems_godown_id_seq OWNER TO netitest;

--
-- Name: sales_dnitems_godown_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_dnitems_godown_id_seq OWNED BY public.sales_dnitems_godown.id;


--
-- Name: sales_dnitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_dnitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_dnitems_id_seq OWNER TO netitest;

--
-- Name: sales_dnitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_dnitems_id_seq OWNED BY public.sales_dnitems.id;


--
-- Name: sales_invitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_invitems (
    id bigint NOT NULL,
    mrp numeric(15,2) NOT NULL,
    offer_mrp numeric(15,2) NOT NULL,
    pack numeric(15,2) NOT NULL,
    available_qty numeric(15,2) NOT NULL,
    actual_qty numeric(15,3) NOT NULL,
    billed_qty numeric(15,3) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    nb_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    new_rate numeric(15,2) NOT NULL,
    prate numeric(15,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    inv_id bigint NOT NULL,
    item_id bigint NOT NULL,
    nf_qty numeric(15,2) NOT NULL
);


ALTER TABLE public.sales_invitems OWNER TO netitest;

--
-- Name: sales_invitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_invitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_invitems_id_seq OWNER TO netitest;

--
-- Name: sales_invitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_invitems_id_seq OWNED BY public.sales_invitems.id;


--
-- Name: sales_invoice; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_invoice (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    inv_no character varying(51) NOT NULL,
    inv_date date NOT NULL,
    status character varying(20) NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_mailingname character varying(151) NOT NULL,
    buyer_address1 character varying(151) NOT NULL,
    buyer_address2 character varying(151) NOT NULL,
    buyer_address3 character varying(151) NOT NULL,
    buyer_pincode character varying(51) NOT NULL,
    buyer_gstin character varying(51),
    shipto_address_type character varying(51) NOT NULL,
    shipto_country character varying(51) NOT NULL,
    shipto_state character varying(51) NOT NULL,
    shipto_city character varying(51) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_pincode character varying(51) NOT NULL,
    shipto_gstin character varying(51),
    shipto_pan_no character varying(51),
    bill_qty numeric(15,2) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    mrpvalue numeric(15,2) NOT NULL,
    omrpvalue numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    scheme character varying(51),
    narration text,
    price_list character varying(51),
    mode_of_payment character varying(100),
    other_reference character varying(100),
    terms_of_delivery character varying(100),
    order_no character varying(100),
    dispatch_doc_no character varying(51),
    dispatch_through character varying(51),
    destination character varying(51),
    carrier_agent character varying(100),
    carrier_agent_id character varying(100),
    lr_no character varying(51),
    lr_date date,
    vehical_type character varying(51),
    vehical_no character varying(51),
    is_ict boolean NOT NULL,
    is_ivt boolean NOT NULL,
    buyer_id bigint NOT NULL,
    company_id bigint NOT NULL,
    dn_id bigint,
    other_ledger_id bigint,
    shipto_id bigint NOT NULL,
    channel character varying(51) NOT NULL,
    division character varying(51) NOT NULL
);


ALTER TABLE public.sales_invoice OWNER TO netitest;

--
-- Name: sales_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_invoice_id_seq OWNER TO netitest;

--
-- Name: sales_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_invoice_id_seq OWNED BY public.sales_invoice.id;


--
-- Name: sales_loadingsheet; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_loadingsheet (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    prate numeric(15,2) NOT NULL,
    mrp character varying(51) NOT NULL,
    batch character varying(51) NOT NULL,
    offermrp character varying(51) NOT NULL,
    godown character varying(51) NOT NULL,
    qty numeric(15,2) NOT NULL,
    company_id bigint NOT NULL,
    dn_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.sales_loadingsheet OWNER TO netitest;

--
-- Name: sales_loadingsheet_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_loadingsheet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_loadingsheet_id_seq OWNER TO netitest;

--
-- Name: sales_loadingsheet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_loadingsheet_id_seq OWNED BY public.sales_loadingsheet.id;


--
-- Name: sales_packingsheet; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_packingsheet (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    mrp character varying(51) NOT NULL,
    offermrp character varying(51) NOT NULL,
    qty numeric(15,2) NOT NULL,
    from_box integer NOT NULL,
    to_box integer NOT NULL,
    total_box integer,
    status boolean NOT NULL,
    company_id bigint NOT NULL,
    dn_id bigint NOT NULL,
    item_id bigint NOT NULL,
    remarks character varying(51)
);


ALTER TABLE public.sales_packingsheet OWNER TO netitest;

--
-- Name: sales_packingsheet_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_packingsheet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_packingsheet_id_seq OWNER TO netitest;

--
-- Name: sales_packingsheet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_packingsheet_id_seq OWNED BY public.sales_packingsheet.id;


--
-- Name: sales_proformainvitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_proformainvitems (
    id bigint NOT NULL,
    mrp numeric(15,2) NOT NULL,
    offer_mrp numeric(15,2) NOT NULL,
    pack numeric(15,2) NOT NULL,
    available_qty numeric(15,2) NOT NULL,
    actual_qty numeric(15,3) NOT NULL,
    billed_qty numeric(15,3) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    nb_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    new_rate numeric(15,2) NOT NULL,
    prate numeric(15,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    inv_id bigint NOT NULL,
    item_id bigint NOT NULL,
    nf_qty numeric(15,2) NOT NULL
);


ALTER TABLE public.sales_proformainvitems OWNER TO netitest;

--
-- Name: sales_proformainvitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_proformainvitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_proformainvitems_id_seq OWNER TO netitest;

--
-- Name: sales_proformainvitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_proformainvitems_id_seq OWNED BY public.sales_proformainvitems.id;


--
-- Name: sales_proformainvoice; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_proformainvoice (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    inv_no character varying(51) NOT NULL,
    inv_date date NOT NULL,
    status character varying(20) NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51) NOT NULL,
    division character varying(51) NOT NULL,
    channel character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_mailingname character varying(151) NOT NULL,
    buyer_address1 character varying(151) NOT NULL,
    buyer_address2 character varying(151) NOT NULL,
    buyer_address3 character varying(151) NOT NULL,
    buyer_pincode character varying(51) NOT NULL,
    buyer_gstin character varying(51),
    shipto_address_type character varying(51) NOT NULL,
    shipto_country character varying(51) NOT NULL,
    shipto_state character varying(51) NOT NULL,
    shipto_city character varying(51) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151) NOT NULL,
    shipto_address2 character varying(151) NOT NULL,
    shipto_address3 character varying(151) NOT NULL,
    shipto_pincode character varying(51) NOT NULL,
    shipto_gstin character varying(51),
    shipto_pan_no character varying(51),
    bill_qty numeric(15,2) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    mrpvalue numeric(15,2) NOT NULL,
    omrpvalue numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    scheme character varying(51),
    narration text,
    price_list character varying(51),
    mode_of_payment character varying(51),
    other_reference character varying(51),
    terms_of_delivery character varying(51),
    order_no character varying(51),
    dispatch_doc_no character varying(51),
    dispatch_through character varying(51),
    destintaion character varying(51),
    carrier_agent character varying(51),
    carrier_agent_id character varying(51),
    lr_no character varying(51),
    lr_date date,
    vehical_type character varying(51),
    vehical_no character varying(51),
    is_ict boolean NOT NULL,
    is_ivt boolean NOT NULL,
    buyer_id bigint NOT NULL,
    company_id bigint NOT NULL,
    dn_id bigint,
    other_ledger_id bigint,
    shipto_id bigint NOT NULL
);


ALTER TABLE public.sales_proformainvoice OWNER TO netitest;

--
-- Name: sales_proformainvoice_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_proformainvoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_proformainvoice_id_seq OWNER TO netitest;

--
-- Name: sales_proformainvoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_proformainvoice_id_seq OWNED BY public.sales_proformainvoice.id;


--
-- Name: sales_qdn; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_qdn (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    status character varying(20) NOT NULL,
    qdn_no character varying(51) NOT NULL,
    qdn_date date NOT NULL,
    bill_qty numeric(15,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    narration text,
    company_id bigint NOT NULL,
    inv_id bigint,
    free_qty numeric(15,2) NOT NULL,
    mrpvalue numeric(15,2) NOT NULL,
    omrpvalue numeric(15,2) NOT NULL,
    buyer_id bigint NOT NULL,
    buyer_address1 character varying(151) NOT NULL,
    buyer_address2 character varying(151) NOT NULL,
    buyer_address3 character varying(151) NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51) NOT NULL,
    buyer_gstin character varying(51),
    buyer_mailingname character varying(151) NOT NULL,
    buyer_pincode character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    channel character varying(51) NOT NULL,
    division character varying(51) NOT NULL
);


ALTER TABLE public.sales_qdn OWNER TO netitest;

--
-- Name: sales_qdn_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_qdn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_qdn_id_seq OWNER TO netitest;

--
-- Name: sales_qdn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_qdn_id_seq OWNED BY public.sales_qdn.id;


--
-- Name: sales_qdnitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_qdnitems (
    id bigint NOT NULL,
    billed numeric(15,2) NOT NULL,
    billed_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    item_id bigint NOT NULL,
    inv_id bigint NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    mrp numeric(15,2) NOT NULL
);


ALTER TABLE public.sales_qdnitems OWNER TO netitest;

--
-- Name: sales_qdnitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_qdnitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_qdnitems_id_seq OWNER TO netitest;

--
-- Name: sales_qdnitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_qdnitems_id_seq OWNED BY public.sales_qdnitems.id;


--
-- Name: sales_rso; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_rso (
    id bigint NOT NULL,
    status character varying(20) NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    rso_no character varying(51) NOT NULL,
    rso_date date NOT NULL,
    bill_qty numeric(15,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    is_ivt boolean NOT NULL,
    narration text,
    company_id bigint NOT NULL,
    inv_id bigint,
    buyer_id bigint NOT NULL,
    buyer_address1 character varying(100) NOT NULL,
    buyer_address2 character varying(100) NOT NULL,
    buyer_address3 character varying(100) NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51),
    buyer_gstin character varying(51),
    buyer_mailingname character varying(51) NOT NULL,
    buyer_pincode character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    is_cm boolean NOT NULL,
    rso_ref character varying(51),
    ref_date date,
    free_qty numeric(15,2) NOT NULL,
    mrpvalue numeric(15,2) NOT NULL,
    omrpvalue numeric(15,2) NOT NULL,
    channel character varying(51) NOT NULL,
    division character varying(51) NOT NULL
);


ALTER TABLE public.sales_rso OWNER TO netitest;

--
-- Name: sales_rso_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_rso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_rso_id_seq OWNER TO netitest;

--
-- Name: sales_rso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_rso_id_seq OWNED BY public.sales_rso.id;


--
-- Name: sales_rsoitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_rsoitems (
    id bigint NOT NULL,
    billed numeric(15,2) NOT NULL,
    billed_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    item_id bigint NOT NULL,
    inv_id bigint NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    mrp numeric(15,2) NOT NULL
);


ALTER TABLE public.sales_rsoitems OWNER TO netitest;

--
-- Name: sales_rsoitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_rsoitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_rsoitems_id_seq OWNER TO netitest;

--
-- Name: sales_rsoitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_rsoitems_id_seq OWNED BY public.sales_rsoitems.id;


--
-- Name: sales_saleqty; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_saleqty (
    id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL,
    qty numeric(15,2) NOT NULL,
    company_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.sales_saleqty OWNER TO netitest;

--
-- Name: sales_saleqty_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_saleqty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_saleqty_id_seq OWNER TO netitest;

--
-- Name: sales_saleqty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_saleqty_id_seq OWNED BY public.sales_saleqty.id;


--
-- Name: sales_salesorder; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_salesorder (
    id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    status character varying(20) NOT NULL,
    so_no character varying(51) NOT NULL,
    ref_no character varying(51),
    so_date date NOT NULL,
    so_due_date date,
    price_list character varying(51),
    isscheme boolean NOT NULL,
    buyer_address_type character varying(51) NOT NULL,
    buyer_gst_reg_type character varying(51) NOT NULL,
    buyer_state character varying(51) NOT NULL,
    buyer_country character varying(51) NOT NULL,
    buyer_city character varying(51) NOT NULL,
    buyer_mailingname character varying(151) NOT NULL,
    buyer_address1 character varying(151),
    buyer_address2 character varying(151),
    buyer_address3 character varying(151),
    buyer_pincode character varying(51) NOT NULL,
    buyer_gstin character varying(51),
    shipto_address_type character varying(51) NOT NULL,
    shipto_country character varying(51) NOT NULL,
    shipto_state character varying(51) NOT NULL,
    shipto_city character varying(51) NOT NULL,
    shipto_mailingname character varying(151) NOT NULL,
    shipto_address1 character varying(151),
    shipto_address2 character varying(151),
    shipto_address3 character varying(151),
    shipto_pincode character varying(51) NOT NULL,
    shipto_gstin character varying(51),
    mode_of_payment character varying(51),
    other_reference character varying(51),
    order_no character varying(51),
    terms_of_delivery character varying(51),
    scheme character varying(51),
    bill_qty numeric(15,2) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    ammount numeric(15,2) NOT NULL,
    other numeric(15,2) NOT NULL,
    ol_rate numeric(4,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    tcs numeric(15,2) NOT NULL,
    round_off numeric(3,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    narration text,
    buyer_id bigint NOT NULL,
    company_id bigint NOT NULL,
    other_ledger_id bigint,
    shipto_id bigint NOT NULL,
    shipto_pan_no character varying(51)
);


ALTER TABLE public.sales_salesorder OWNER TO netitest;

--
-- Name: sales_salesorder_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_salesorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_salesorder_id_seq OWNER TO netitest;

--
-- Name: sales_salesorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_salesorder_id_seq OWNED BY public.sales_salesorder.id;


--
-- Name: sales_salestarget; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_salestarget (
    id bigint NOT NULL,
    target numeric(20,2) NOT NULL,
    months date NOT NULL,
    asm_id bigint NOT NULL,
    buyer_id bigint NOT NULL,
    region_id bigint NOT NULL,
    rsm_id bigint NOT NULL,
    se_id bigint NOT NULL,
    zone_id bigint NOT NULL,
    zsm_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.sales_salestarget OWNER TO netitest;

--
-- Name: sales_salestarget_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_salestarget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_salestarget_id_seq OWNER TO netitest;

--
-- Name: sales_salestarget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_salestarget_id_seq OWNED BY public.sales_salestarget.id;


--
-- Name: sales_soitems; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.sales_soitems (
    id bigint NOT NULL,
    mrp numeric(15,2) NOT NULL,
    pack numeric(15,2) NOT NULL,
    available_qty numeric(15,2) NOT NULL,
    offer_mrp numeric(15,2),
    actual_qty numeric(15,2) NOT NULL,
    billed_qty numeric(15,2) NOT NULL,
    free_qty numeric(15,2) NOT NULL,
    rate numeric(15,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    igstrate numeric(4,2) NOT NULL,
    sgstrate numeric(4,2) NOT NULL,
    cgstrate numeric(4,2) NOT NULL,
    igst numeric(15,2) NOT NULL,
    sgst numeric(15,2) NOT NULL,
    cgst numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    item_id bigint NOT NULL,
    so_id bigint NOT NULL
);


ALTER TABLE public.sales_soitems OWNER TO netitest;

--
-- Name: sales_soitems_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.sales_soitems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_soitems_id_seq OWNER TO netitest;

--
-- Name: sales_soitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.sales_soitems_id_seq OWNED BY public.sales_soitems.id;


--
-- Name: todo_todo; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.todo_todo (
    id bigint NOT NULL,
    todo text NOT NULL
);


ALTER TABLE public.todo_todo OWNER TO netitest;

--
-- Name: todo_todo_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.todo_todo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todo_todo_id_seq OWNER TO netitest;

--
-- Name: todo_todo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.todo_todo_id_seq OWNED BY public.todo_todo.id;


--
-- Name: warehouse_materialtransferred; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.warehouse_materialtransferred (
    id bigint NOT NULL,
    qty numeric(15,4) NOT NULL,
    rate numeric(15,2) NOT NULL,
    godown_id bigint NOT NULL,
    indent_id bigint NOT NULL,
    item_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.warehouse_materialtransferred OWNER TO netitest;

--
-- Name: warehouse_materialtransferred_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.warehouse_materialtransferred_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouse_materialtransferred_id_seq OWNER TO netitest;

--
-- Name: warehouse_materialtransferred_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.warehouse_materialtransferred_id_seq OWNED BY public.warehouse_materialtransferred.id;


--
-- Name: warehouse_pallettransferentry; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.warehouse_pallettransferentry (
    id bigint NOT NULL,
    fgodown character varying(30) NOT NULL,
    tgodown character varying(30) NOT NULL,
    qty numeric(15,4) NOT NULL,
    created date NOT NULL,
    createdby character varying(15) NOT NULL,
    item_id bigint NOT NULL,
    company_id bigint NOT NULL
);


ALTER TABLE public.warehouse_pallettransferentry OWNER TO netitest;

--
-- Name: warehouse_pallettransferentry_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.warehouse_pallettransferentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouse_pallettransferentry_id_seq OWNER TO netitest;

--
-- Name: warehouse_pallettransferentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.warehouse_pallettransferentry_id_seq OWNED BY public.warehouse_pallettransferentry.id;


--
-- Name: warehouse_shortagedamageentry; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.warehouse_shortagedamageentry (
    id bigint NOT NULL,
    shoratage character varying(2) NOT NULL,
    sqty numeric(15,4) NOT NULL,
    dqty numeric(15,4) NOT NULL,
    rate numeric(15,2) NOT NULL,
    sremarks text NOT NULL,
    dremarks text NOT NULL,
    godown_id bigint NOT NULL,
    item_id bigint NOT NULL,
    jobwork_id bigint,
    purchase_id bigint,
    created date NOT NULL,
    updated date NOT NULL,
    company_id bigint NOT NULL,
    createdby character varying(15) NOT NULL
);


ALTER TABLE public.warehouse_shortagedamageentry OWNER TO netitest;

--
-- Name: warehouse_shortagedamageentry_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.warehouse_shortagedamageentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouse_shortagedamageentry_id_seq OWNER TO netitest;

--
-- Name: warehouse_shortagedamageentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.warehouse_shortagedamageentry_id_seq OWNED BY public.warehouse_shortagedamageentry.id;


--
-- Name: warehouse_stock_summary; Type: TABLE; Schema: public; Owner: netitest
--

CREATE TABLE public.warehouse_stock_summary (
    id bigint NOT NULL,
    mrp character varying(51) NOT NULL,
    batch character varying(51),
    rate numeric(15,2) NOT NULL,
    closing_balance numeric(15,4),
    company_id bigint NOT NULL,
    godown_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created date NOT NULL,
    updated date NOT NULL
);


ALTER TABLE public.warehouse_stock_summary OWNER TO netitest;

--
-- Name: warehouse_stock_summary_id_seq; Type: SEQUENCE; Schema: public; Owner: netitest
--

CREATE SEQUENCE public.warehouse_stock_summary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouse_stock_summary_id_seq OWNER TO netitest;

--
-- Name: warehouse_stock_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netitest
--

ALTER SEQUENCE public.warehouse_stock_summary_id_seq OWNED BY public.warehouse_stock_summary.id;


--
-- Name: accounts_loggedinuser id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.accounts_loggedinuser ALTER COLUMN id SET DEFAULT nextval('public.accounts_loggedinuser_id_seq'::regclass);


--
-- Name: auditlog_logentry id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auditlog_logentry ALTER COLUMN id SET DEFAULT nextval('public.auditlog_logentry_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: company_company id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.company_company ALTER COLUMN id SET DEFAULT nextval('public.company_company_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: inventory_brand id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_brand ALTER COLUMN id SET DEFAULT nextval('public.inventory_brand_id_seq'::regclass);


--
-- Name: inventory_category id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_category ALTER COLUMN id SET DEFAULT nextval('public.inventory_category_id_seq'::regclass);


--
-- Name: inventory_class id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_class ALTER COLUMN id SET DEFAULT nextval('public.inventory_class_id_seq'::regclass);


--
-- Name: inventory_currency id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_currency ALTER COLUMN id SET DEFAULT nextval('public.inventory_currency_id_seq'::regclass);


--
-- Name: inventory_godown id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_godown ALTER COLUMN id SET DEFAULT nextval('public.inventory_godown_id_seq'::regclass);


--
-- Name: inventory_gst_list id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_gst_list ALTER COLUMN id SET DEFAULT nextval('public.inventory_gst_list_id_seq'::regclass);


--
-- Name: inventory_product_master id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master ALTER COLUMN id SET DEFAULT nextval('public.inventory_product_master_id_seq'::regclass);


--
-- Name: inventory_producttype id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_producttype ALTER COLUMN id SET DEFAULT nextval('public.inventory_producttype_id_seq'::regclass);


--
-- Name: inventory_scheme id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_scheme ALTER COLUMN id SET DEFAULT nextval('public.inventory_scheme_id_seq'::regclass);


--
-- Name: inventory_std_rate id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_std_rate ALTER COLUMN id SET DEFAULT nextval('public.inventory_std_rate_id_seq'::regclass);


--
-- Name: inventory_subbrand id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_subbrand ALTER COLUMN id SET DEFAULT nextval('public.inventory_subbrand_id_seq'::regclass);


--
-- Name: inventory_subclass id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_subclass ALTER COLUMN id SET DEFAULT nextval('public.inventory_subclass_id_seq'::regclass);


--
-- Name: inventory_unitofmeasure id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_unitofmeasure ALTER COLUMN id SET DEFAULT nextval('public.inventory_unitofmeasure_id_seq'::regclass);


--
-- Name: inventory_uqc id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_uqc ALTER COLUMN id SET DEFAULT nextval('public.inventory_uqc_id_seq'::regclass);


--
-- Name: ledgers_asm id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm ALTER COLUMN id SET DEFAULT nextval('public.ledgers_asm_id_seq'::regclass);


--
-- Name: ledgers_city id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_city ALTER COLUMN id SET DEFAULT nextval('public.ledgers_city_id_seq'::regclass);


--
-- Name: ledgers_country id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_country ALTER COLUMN id SET DEFAULT nextval('public.ledgers_country_id_seq'::regclass);


--
-- Name: ledgers_currency id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_currency ALTER COLUMN id SET DEFAULT nextval('public.ledgers_currency_id_seq'::regclass);


--
-- Name: ledgers_division id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_division ALTER COLUMN id SET DEFAULT nextval('public.ledgers_division_id_seq'::regclass);


--
-- Name: ledgers_group id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_group ALTER COLUMN id SET DEFAULT nextval('public.ledgers_group_id_seq'::regclass);


--
-- Name: ledgers_ledgerstype id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_ledgerstype ALTER COLUMN id SET DEFAULT nextval('public.ledgers_ledgerstype_id_seq'::regclass);


--
-- Name: ledgers_party_contact_details id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_contact_details ALTER COLUMN id SET DEFAULT nextval('public.ledgers_party_contact_details_id_seq'::regclass);


--
-- Name: ledgers_party_master id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master ALTER COLUMN id SET DEFAULT nextval('public.ledgers_party_master_id_seq'::regclass);


--
-- Name: ledgers_party_master_products id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master_products ALTER COLUMN id SET DEFAULT nextval('public.ledgers_party_master_products_id_seq'::regclass);


--
-- Name: ledgers_partytype id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_partytype ALTER COLUMN id SET DEFAULT nextval('public.ledgers_partytype_id_seq'::regclass);


--
-- Name: ledgers_price_level id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_level ALTER COLUMN id SET DEFAULT nextval('public.ledgers_price_level_id_seq'::regclass);


--
-- Name: ledgers_price_list id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_list ALTER COLUMN id SET DEFAULT nextval('public.ledgers_price_list_id_seq'::regclass);


--
-- Name: ledgers_region id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_region ALTER COLUMN id SET DEFAULT nextval('public.ledgers_region_id_seq'::regclass);


--
-- Name: ledgers_rsm id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_rsm ALTER COLUMN id SET DEFAULT nextval('public.ledgers_rsm_id_seq'::regclass);


--
-- Name: ledgers_se id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se ALTER COLUMN id SET DEFAULT nextval('public.ledgers_se_id_seq'::regclass);


--
-- Name: ledgers_state id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_state ALTER COLUMN id SET DEFAULT nextval('public.ledgers_state_id_seq'::regclass);


--
-- Name: ledgers_zone id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zone ALTER COLUMN id SET DEFAULT nextval('public.ledgers_zone_id_seq'::regclass);


--
-- Name: ledgers_zsm id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zsm ALTER COLUMN id SET DEFAULT nextval('public.ledgers_zsm_id_seq'::regclass);


--
-- Name: planning_bom id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bom ALTER COLUMN id SET DEFAULT nextval('public.planning_bom_id_seq'::regclass);


--
-- Name: planning_bomitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bomitems ALTER COLUMN id SET DEFAULT nextval('public.planning_bomitems_id_seq'::regclass);


--
-- Name: planning_joborder id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_joborder ALTER COLUMN id SET DEFAULT nextval('public.planning_joborder_id_seq'::regclass);


--
-- Name: planning_salesprojection id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_salesprojection ALTER COLUMN id SET DEFAULT nextval('public.planning_salesprojection_id_seq'::regclass);


--
-- Name: production_consitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consitems ALTER COLUMN id SET DEFAULT nextval('public.production_consitems_id_seq'::regclass);


--
-- Name: production_consumableindent id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumableindent ALTER COLUMN id SET DEFAULT nextval('public.production_consumableindent_id_seq'::regclass);


--
-- Name: production_consumption id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumption ALTER COLUMN id SET DEFAULT nextval('public.production_consumption_id_seq'::regclass);


--
-- Name: production_consumptionitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumptionitems ALTER COLUMN id SET DEFAULT nextval('public.production_consumptionitems_id_seq'::regclass);


--
-- Name: production_jobcard id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_jobcard ALTER COLUMN id SET DEFAULT nextval('public.production_jobcard_id_seq'::regclass);


--
-- Name: production_rmindent id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindent ALTER COLUMN id SET DEFAULT nextval('public.production_rmindent_id_seq'::regclass);


--
-- Name: production_rmindentitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindentitems ALTER COLUMN id SET DEFAULT nextval('public.production_rmindentitems_id_seq'::regclass);


--
-- Name: production_rmitemgodown id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmitemgodown ALTER COLUMN id SET DEFAULT nextval('public.production_rmitemgodown_id_seq'::regclass);


--
-- Name: purchase_debitnote id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnote ALTER COLUMN id SET DEFAULT nextval('public.purchase_debitnote_id_seq'::regclass);


--
-- Name: purchase_debitnoteitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnoteitems ALTER COLUMN id SET DEFAULT nextval('public.purchase_debitnoteitems_id_seq'::regclass);


--
-- Name: purchase_grn id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn ALTER COLUMN id SET DEFAULT nextval('public.purchase_grn_id_seq'::regclass);


--
-- Name: purchase_grnitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems ALTER COLUMN id SET DEFAULT nextval('public.purchase_grnitems_id_seq'::regclass);


--
-- Name: purchase_grnitems_godown id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems_godown ALTER COLUMN id SET DEFAULT nextval('public.purchase_grnitems_godown_id_seq'::regclass);


--
-- Name: purchase_piitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_piitems ALTER COLUMN id SET DEFAULT nextval('public.purchase_piitems_id_seq'::regclass);


--
-- Name: purchase_poitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_poitems ALTER COLUMN id SET DEFAULT nextval('public.purchase_poitems_id_seq'::regclass);


--
-- Name: purchase_purchase id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_purchase_id_seq'::regclass);


--
-- Name: purchase_purchase_order id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order ALTER COLUMN id SET DEFAULT nextval('public.purchase_purchase_order_id_seq'::regclass);


--
-- Name: purchase_purchasereturn id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturn ALTER COLUMN id SET DEFAULT nextval('public.purchase_purchasereturn_id_seq'::regclass);


--
-- Name: purchase_purchasereturnitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturnitems ALTER COLUMN id SET DEFAULT nextval('public.purchase_purchasereturnitems_id_seq'::regclass);


--
-- Name: purchase_qdn id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdn ALTER COLUMN id SET DEFAULT nextval('public.purchase_qdn_id_seq'::regclass);


--
-- Name: purchase_qdnitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdnitems ALTER COLUMN id SET DEFAULT nextval('public.purchase_qdnitems_id_seq'::regclass);


--
-- Name: sales_creditnote id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnote ALTER COLUMN id SET DEFAULT nextval('public.sales_creditnote_id_seq'::regclass);


--
-- Name: sales_creditnoteitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnoteitems ALTER COLUMN id SET DEFAULT nextval('public.sales_creditnoteitems_id_seq'::regclass);


--
-- Name: sales_delivery_note id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note ALTER COLUMN id SET DEFAULT nextval('public.sales_delivery_note_id_seq'::regclass);


--
-- Name: sales_dnitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems ALTER COLUMN id SET DEFAULT nextval('public.sales_dnitems_id_seq'::regclass);


--
-- Name: sales_dnitems_godown id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems_godown ALTER COLUMN id SET DEFAULT nextval('public.sales_dnitems_godown_id_seq'::regclass);


--
-- Name: sales_invitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invitems ALTER COLUMN id SET DEFAULT nextval('public.sales_invitems_id_seq'::regclass);


--
-- Name: sales_invoice id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice ALTER COLUMN id SET DEFAULT nextval('public.sales_invoice_id_seq'::regclass);


--
-- Name: sales_loadingsheet id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_loadingsheet ALTER COLUMN id SET DEFAULT nextval('public.sales_loadingsheet_id_seq'::regclass);


--
-- Name: sales_packingsheet id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_packingsheet ALTER COLUMN id SET DEFAULT nextval('public.sales_packingsheet_id_seq'::regclass);


--
-- Name: sales_proformainvitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvitems ALTER COLUMN id SET DEFAULT nextval('public.sales_proformainvitems_id_seq'::regclass);


--
-- Name: sales_proformainvoice id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice ALTER COLUMN id SET DEFAULT nextval('public.sales_proformainvoice_id_seq'::regclass);


--
-- Name: sales_qdn id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdn ALTER COLUMN id SET DEFAULT nextval('public.sales_qdn_id_seq'::regclass);


--
-- Name: sales_qdnitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdnitems ALTER COLUMN id SET DEFAULT nextval('public.sales_qdnitems_id_seq'::regclass);


--
-- Name: sales_rso id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rso ALTER COLUMN id SET DEFAULT nextval('public.sales_rso_id_seq'::regclass);


--
-- Name: sales_rsoitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rsoitems ALTER COLUMN id SET DEFAULT nextval('public.sales_rsoitems_id_seq'::regclass);


--
-- Name: sales_saleqty id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_saleqty ALTER COLUMN id SET DEFAULT nextval('public.sales_saleqty_id_seq'::regclass);


--
-- Name: sales_salesorder id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder ALTER COLUMN id SET DEFAULT nextval('public.sales_salesorder_id_seq'::regclass);


--
-- Name: sales_salestarget id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget ALTER COLUMN id SET DEFAULT nextval('public.sales_salestarget_id_seq'::regclass);


--
-- Name: sales_soitems id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_soitems ALTER COLUMN id SET DEFAULT nextval('public.sales_soitems_id_seq'::regclass);


--
-- Name: todo_todo id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.todo_todo ALTER COLUMN id SET DEFAULT nextval('public.todo_todo_id_seq'::regclass);


--
-- Name: warehouse_materialtransferred id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_materialtransferred ALTER COLUMN id SET DEFAULT nextval('public.warehouse_materialtransferred_id_seq'::regclass);


--
-- Name: warehouse_pallettransferentry id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_pallettransferentry ALTER COLUMN id SET DEFAULT nextval('public.warehouse_pallettransferentry_id_seq'::regclass);


--
-- Name: warehouse_shortagedamageentry id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry ALTER COLUMN id SET DEFAULT nextval('public.warehouse_shortagedamageentry_id_seq'::regclass);


--
-- Name: warehouse_stock_summary id; Type: DEFAULT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_stock_summary ALTER COLUMN id SET DEFAULT nextval('public.warehouse_stock_summary_id_seq'::regclass);


--
-- Data for Name: accounts_loggedinuser; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.accounts_loggedinuser (id, session_key, user_id) FROM stdin;
2	vfxkv6ps5zp2uutsv1ivaq7bnvhoil5l	2
\.


--
-- Data for Name: auditlog_logentry; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auditlog_logentry (id, object_pk, object_id, object_repr, action, changes, "timestamp", actor_id, content_type_id, remote_addr, additional_data) FROM stdin;
867	9	9	2223RSO00006	0	{"free_qty": ["None", "0"], "status": ["None", "1"], "ref_date": ["None", "2023-09-15"], "total": ["None", "0"], "company": ["None", "ABC"], "channel": ["None", "Channel 1"], "buyer_mailingname": ["None", "Customer Name"], "ammount": ["None", "0"], "is_cm": ["None", "True"], "buyer_state": ["None", "Gujarat-1"], "cgst": ["None", "0"], "narration": ["None", ""], "buyer_country": ["None", "India"], "rso_ref": ["None", "2223SQ00001"], "buyer_city": ["None", "Vadodara"], "updated": ["None", "2023-09-14"], "omrpvalue": ["None", "0"], "division": ["None", "ECOM"], "bill_qty": ["None", "0"], "buyer": ["None", "Customer Name"], "buyer_pincode": ["None", "390001"], "buyer_gstin": ["None", ""], "is_ivt": ["None", "False"], "rso_no": ["None", "2223RSO00006"], "igst": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "mrpvalue": ["None", "0"], "tcs": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "rso_date": ["None", "2023-09-14 07:18:19.260243+00:00"], "sgst": ["None", "0"], "round_off": ["None", "0"], "id": ["None", "9"], "created": ["None", "2023-09-14"], "buyer_address2": ["None", "Address Line2"], "discount": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "buyer_address_type": ["None", "Default"]}	2023-09-14 12:48:19.285185+05:30	2	78	127.0.0.1	\N
868	7	7	XYZ	0	{"credit_limit": ["None", "50000"], "po": ["None", "purchase.Purchase_order.None"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "invoice_buyer": ["None", "sales.Invoice.None"], "pin_code": ["None", "390002"], "account_no": ["None", ""], "check_credit_days": ["None", "True"], "devision": ["None", "division"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "party_type": ["None", "IB"], "mobile_no": ["None", "8541457856"], "price_level": ["None", ""], "override_credit_limit": ["None", "False"], "invoice_shipto": ["None", "sales.Invoice.None"], "contact_person": ["None", ""], "maintain_bill_by_bill": ["None", "False"], "salesorder_shipto": ["None", "sales.Salesorder.None"], "rsm": ["None", "RSM 1"], "istcsapplicable": ["None", "False"], "dafault_credit_period": ["None", "30"], "country": ["None", "India"], "created": ["None", "2023-09-15"], "state": ["None", "Gujarat-1"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "gst_registration_type": ["None", "Unknown"], "debitnote_seller": ["None", "purchase.DebitNote.None"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "multiple_address_list": ["None", "False"], "se": ["None", "Sales person 1"], "city": ["None", "Vadodara"], "name": ["None", "XYZ"], "gstin": ["None", "AVIIADV125L"], "is_transporter": ["None", "False"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "mailing_name": ["None", "XYZ"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "pan_no": ["None", "IIADV125L"], "qdn_buyer": ["None", "sales.Qdn.None"], "addressline1": ["None", "XYZ"], "email_id": ["None", "XYZ@XYZ.com"], "group": ["None", "Sundry Debtors"], "zsm": ["None", "ZSM 1"], "addressline2": ["None", "XYZ"], "rso_buyer": ["None", "sales.Rso.None"], "region": ["None", "Chhattisgarh"], "website": ["None", ""], "grn": ["None", "purchase.Grn.None"], "asm": ["None", "Sales Executive 1"], "account_name": ["None", ""], "allow_loose_packing": ["None", "True"], "addressline3": ["None", "XYZ"], "payment_terms": ["None", "30"], "cn_buyer": ["None", "sales.CreditNote.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "pi": ["None", "purchase.Purchase.None"], "updated": ["None", "2023-09-15"], "bank": ["None", ""], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "vendor_code": ["None", "200006"], "zone": ["None", "Central Zone"], "id": ["None", "7"], "ifsc_code": ["None", ""]}	2023-09-15 12:09:17.566018+05:30	2	39	127.0.0.1	\N
85	3	3	Madhya Pradesh	1	{"name": ["Madhya Pradesh1", "Madhya Pradesh"]}	2023-07-28 11:18:27.921+05:30	2	27	127.0.0.1	\N
869	9	9	XYZ	0	{"po": ["None", "purchase.Purchase_order.None"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "invoice_buyer": ["None", "sales.Invoice.None"], "pin_code": ["None", "390002"], "account_no": ["None", ""], "check_credit_days": ["None", "True"], "devision": ["None", "division"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "party_type": ["None", "IB"], "mobile_no": ["None", "8541457856"], "price_level": ["None", "Manual"], "override_credit_limit": ["None", "False"], "invoice_shipto": ["None", "sales.Invoice.None"], "contact_person": ["None", ""], "maintain_bill_by_bill": ["None", "True"], "salesorder_shipto": ["None", "sales.Salesorder.None"], "istcsapplicable": ["None", "False"], "dafault_credit_period": ["None", "30"], "country": ["None", "India"], "created": ["None", "2023-09-15"], "state": ["None", "Gujarat-1"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "gst_registration_type": ["None", "Unknown"], "debitnote_seller": ["None", "purchase.DebitNote.None"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "multiple_address_list": ["None", "False"], "city": ["None", "Vadodara"], "name": ["None", "XYZ"], "gstin": ["None", "AVIIADV125L"], "is_transporter": ["None", "False"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "mailing_name": ["None", "XYZ"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "pan_no": ["None", "IIADV125L"], "qdn_buyer": ["None", "sales.Qdn.None"], "addressline1": ["None", "XYZ"], "email_id": ["None", "XYZ@XYZ.com"], "group": ["None", "Sundry Creditors"], "addressline2": ["None", "XYZ"], "rso_buyer": ["None", "sales.Rso.None"], "website": ["None", ""], "grn": ["None", "purchase.Grn.None"], "account_name": ["None", ""], "allow_loose_packing": ["None", "True"], "addressline3": ["None", "XYZ"], "cn_buyer": ["None", "sales.CreditNote.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "pi": ["None", "purchase.Purchase.None"], "updated": ["None", "2023-09-15"], "bank": ["None", ""], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "vendor_code": ["None", "400003"], "zone": ["None", "Central Zone"], "id": ["None", "9"], "ifsc_code": ["None", ""]}	2023-09-15 12:11:32.221795+05:30	2	39	127.0.0.1	\N
251	1	1	2223PO00001	1	{"status": ["5", "4"]}	2023-08-09 10:20:36.256+05:30	2	54	127.0.0.1	\N
870	11	11	ABC	0	{"credit_limit": ["None", "100000"], "po": ["None", "purchase.Purchase_order.None"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "invoice_buyer": ["None", "sales.Invoice.None"], "pin_code": ["None", "154782"], "account_no": ["None", ""], "check_credit_days": ["None", "True"], "devision": ["None", "division"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "party_type": ["None", "Channel 1"], "mobile_no": ["None", "5689784512"], "price_level": ["None", ""], "override_credit_limit": ["None", "False"], "invoice_shipto": ["None", "sales.Invoice.None"], "contact_person": ["None", ""], "maintain_bill_by_bill": ["None", "False"], "salesorder_shipto": ["None", "sales.Salesorder.None"], "rsm": ["None", "RSM 2"], "istcsapplicable": ["None", "False"], "dafault_credit_period": ["None", "30"], "country": ["None", "India"], "created": ["None", "2023-09-15"], "state": ["None", "Maharashtra"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "gst_registration_type": ["None", "Unknown"], "debitnote_seller": ["None", "purchase.DebitNote.None"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "multiple_address_list": ["None", "False"], "se": ["None", "Sales person 14"], "city": ["None", "Pune"], "name": ["None", "ABC"], "gstin": ["None", "AAAAAAA123A"], "is_transporter": ["None", "False"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "mailing_name": ["None", "ABC"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "pan_no": ["None", "AAAAA123A"], "qdn_buyer": ["None", "sales.Qdn.None"], "addressline1": ["None", "ABC"], "email_id": ["None", "ABC@ABC.com"], "group": ["None", "Sundry Debtors"], "zsm": ["None", "ZSM 6"], "addressline2": ["None", "ABC"], "rso_buyer": ["None", "sales.Rso.None"], "region": ["None", "Mumbai"], "website": ["None", ""], "grn": ["None", "purchase.Grn.None"], "asm": ["None", "Sales Executive 8"], "account_name": ["None", ""], "allow_loose_packing": ["None", "True"], "addressline3": ["None", "ABC"], "payment_terms": ["None", "30"], "cn_buyer": ["None", "sales.CreditNote.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "pi": ["None", "purchase.Purchase.None"], "updated": ["None", "2023-09-15"], "bank": ["None", ""], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "vendor_code": ["None", "200007"], "zone": ["None", "West Zone"], "id": ["None", "11"], "ifsc_code": ["None", ""]}	2023-09-15 12:13:20.652924+05:30	2	39	127.0.0.1	\N
871	12	12	ABC	0	{"po": ["None", "purchase.Purchase_order.None"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "invoice_buyer": ["None", "sales.Invoice.None"], "pin_code": ["None", "154782"], "account_no": ["None", ""], "check_credit_days": ["None", "True"], "devision": ["None", "division"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "party_type": ["None", "IB"], "mobile_no": ["None", "5689784512"], "price_level": ["None", "Manual"], "override_credit_limit": ["None", "False"], "invoice_shipto": ["None", "sales.Invoice.None"], "contact_person": ["None", ""], "maintain_bill_by_bill": ["None", "True"], "salesorder_shipto": ["None", "sales.Salesorder.None"], "istcsapplicable": ["None", "False"], "dafault_credit_period": ["None", "30"], "country": ["None", "India"], "created": ["None", "2023-09-15"], "state": ["None", "Maharashtra"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "gst_registration_type": ["None", "Unknown"], "debitnote_seller": ["None", "purchase.DebitNote.None"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "multiple_address_list": ["None", "False"], "city": ["None", "Pune"], "name": ["None", "ABC"], "gstin": ["None", "AAAAAAA123A"], "is_transporter": ["None", "False"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "mailing_name": ["None", "ABC"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "pan_no": ["None", "AAAAA123A"], "qdn_buyer": ["None", "sales.Qdn.None"], "addressline1": ["None", "ABC"], "email_id": ["None", "ABC@ABC.com"], "group": ["None", "Sundry Creditors"], "addressline2": ["None", "ABC"], "rso_buyer": ["None", "sales.Rso.None"], "website": ["None", ""], "grn": ["None", "purchase.Grn.None"], "account_name": ["None", ""], "allow_loose_packing": ["None", "True"], "addressline3": ["None", "ABC"], "cn_buyer": ["None", "sales.CreditNote.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "pi": ["None", "purchase.Purchase.None"], "updated": ["None", "2023-09-15"], "bank": ["None", ""], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "vendor_code": ["None", "400004"], "zone": ["None", "West Zone"], "id": ["None", "12"], "ifsc_code": ["None", ""]}	2023-09-15 12:14:43.152026+05:30	2	39	127.0.0.1	\N
21	17	17	GMS-GRAMMES	0	{"id": ["None", "17"], "created": ["None", "2023-03-03"], "name": ["None", "GMS-GRAMMES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.685+05:30	2	17	127.0.0.1	\N
872	10	10	2223ICT00001	0	{"buyer_state": ["None", "Gujarat-1"], "shipto_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-15"], "mrpvalue": ["None", "0"], "shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0"], "buyer_address3": ["None", "XYZ"], "omrpvalue": ["None", "0"], "is_ict": ["None", "True"], "round_off": ["None", "0"], "buyer_address_type": ["None", "Default"], "buyer_city": ["None", "Vadodara"], "narration": ["None", ""], "shipto": ["None", "XYZ"], "bill_qty": ["None", "0"], "channel": ["None", "IB"], "buyer_gst_reg_type": ["None", "Unknown"], "other": ["None", "0"], "buyer_gstin": ["None", "AVIIADV125L"], "shipto_mailingname": ["None", "XYZ"], "shipto_country": ["None", "India"], "inv_date": ["None", "2023-09-15 06:50:05.469196+00:00"], "buyer_address2": ["None", "XYZ"], "buyer": ["None", "XYZ"], "division": ["None", "division"], "shipto_address_type": ["None", "Default"], "shipto_address3": ["None", "XYZ"], "shipto_pincode": ["None", "390002"], "tcs": ["None", "0"], "buyer_country": ["None", "India"], "buyer_pincode": ["None", "390002"], "igst": ["None", "0"], "sgst": ["None", "0"], "shipto_pan_no": ["None", "IIADV125L"], "total": ["None", "0"], "inv_no": ["None", "2223ICT00001"], "discount": ["None", "0"], "shipto_gstin": ["None", "AVIIADV125L"], "updated": ["None", "2023-09-15"], "ammount": ["None", "0"], "buyer_address1": ["None", "XYZ"], "shipto_address2": ["None", "XYZ"], "status": ["None", "1"], "is_ivt": ["None", "False"], "cgst": ["None", "0"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "XYZ"], "shipto_address1": ["None", "XYZ"], "id": ["None", "10"], "free_qty": ["None", "0"]}	2023-09-15 12:20:05.489787+05:30	2	70	127.0.0.1	\N
873	6	6	2223ICT00001	0	{"shipto_pincode": ["None", "391775"], "seller_state": ["None", "Maharashtra"], "shipto_state": ["None", "GUJARAT"], "seller_city": ["None", "Pune"], "cgst": ["None", "0"], "shipto_city": ["None", "VADODARA"], "id": ["None", "6"], "status": ["None", "1"], "seller_mailingname": ["None", "ABCD"], "seller": ["None", "ABCD"], "shipto_mailingname": ["None", "ABCD"], "total": ["None", "0"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "ABCD"], "seller_gst_reg_type": ["None", "Regular"], "supplier_date": ["None", "2023-09-15"], "shipto": ["None", "ABC"], "tcs": ["None", "0"], "igst": ["None", "0"], "shipto_country": ["None", "INDIA"], "other": ["None", "0"], "pi_no": ["None", "2223ICT00001"], "ammount": ["None", "0"], "pi_date": ["None", "2023-09-15"], "seller_gstin": ["None", "AAAAAAA0258A"], "seller_pincode": ["None", "392220"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "ex_rate": ["None", "1"], "supplier_invoice": ["None", "2223ICT00001"], "seller_address_type": ["None", "Default"], "seller_address1": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "sgst": ["None", "0"], "created": ["None", "2023-09-15 06:50:05.492892"], "updated": ["None", "2023-09-15 06:50:05.492905"], "grn": ["None", "purchase.Grn.None"], "seller_address2": ["None", "ABC"], "round_off": ["None", "0"], "shipto_address2": ["None", "ABCD"], "currency": ["None", "INR"], "company": ["None", "XYZ"], "seller_address3": ["None", "ABC"], "is_ict": ["None", "True"], "shipto_address3": ["None", "ABCD"], "seller_country": ["None", "India"], "narration": ["None", ""]}	2023-09-15 12:20:05.50293+05:30	2	56	127.0.0.1	\N
874	10	10	InvItems object (10)	0	{"rate": ["None", "300"], "id": ["None", "10"], "available_qty": ["None", "661"], "cgstrate": ["None", "0.00"], "actual_qty": ["None", "61"], "discount": ["None", "0"], "pack": ["None", "1.00"], "item": ["None", "RAW1"], "billed_qty": ["None", "61"], "prate": ["None", "120.00"], "sgst": ["None", "0.00"], "offer_mrp": ["None", "345.00"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "nf_qty": ["None", "0"], "inv": ["None", "2223ICT00001"], "new_rate": ["None", "0"], "mrp": ["None", "345.00"], "nb_qty": ["None", "0"], "free_qty": ["None", "0"], "cgst": ["None", "0.00"], "igst": ["None", "0.00"], "amount": ["None", "18300"]}	2023-09-15 12:20:05.51611+05:30	2	71	127.0.0.1	\N
875	52	52	SHORTAGE	1	{"rate": ["120.00", "300"], "company": ["ABC", "XYZ"]}	2023-09-15 12:20:05.524032+05:30	2	84	127.0.0.1	\N
876	46	46	SHORTAGE	1	{"rate": ["120.00", "300"], "company": ["ABC", "XYZ"]}	2023-09-15 12:20:05.533869+05:30	2	84	127.0.0.1	\N
877	48	48	SHORTAGE	1	{"rate": ["120.00", "300"], "company": ["ABC", "XYZ"]}	2023-09-15 12:20:05.542059+05:30	2	84	127.0.0.1	\N
878	50	50	SHORTAGE	1	{"rate": ["120.00", "300"], "company": ["ABC", "XYZ"]}	2023-09-15 12:20:05.550731+05:30	2	84	127.0.0.1	\N
879	26	26	PRODUCTION	1	{"closing_balance": ["642.0000", "585.0000"]}	2023-09-15 12:20:05.558851+05:30	2	84	127.0.0.1	\N
880	54	54	PRODUCTION	0	{"product": ["None", "RAW1"], "rate": ["None", "1.00"], "godown": ["None", "PRODUCTION"], "batch": ["None", "20230912003001"], "mrp": ["None", "345.00"], "id": ["None", "54"], "updated": ["None", "2023-09-15"], "created": ["None", "2023-09-15"], "company": ["None", "XYZ"]}	2023-09-15 12:20:05.565785+05:30	2	84	127.0.0.1	\N
881	54	54	PRODUCTION	1	{"rate": ["1.00", "300"], "closing_balance": ["None", "57.0000"]}	2023-09-15 12:20:05.571386+05:30	2	84	127.0.0.1	\N
882	10	10	2223ICT00001	1	{"mrpvalue": ["0.00", "0"], "ol_rate": ["0.00", "0"], "omrpvalue": ["0.00", "0"], "bill_qty": ["0.00", "61"], "other": ["0.00", "0"], "inv_date": ["2023-09-15", "2023-09-15 06:50:05.469196+00:00"], "total": ["0.00", "18300"], "discount": ["0.00", "0"], "ammount": ["0.00", "18300"], "free_qty": ["0.00", "0"]}	2023-09-15 12:20:05.58304+05:30	2	70	127.0.0.1	\N
883	6	6	2223ICT00001	1	{"total": ["0.00", "18300"], "ol_rate": ["0.00", "0"], "other": ["0.00", "0"], "ammount": ["0.00", "18300"], "ex_rate": ["1.00", "1"]}	2023-09-15 12:20:05.589806+05:30	2	56	127.0.0.1	\N
364	6	6	2223JC00006	1	{"rqty": ["12.0000", "0.0000"]}	2023-09-05 17:12:13.083+05:30	2	46	127.0.0.1	\N
884	11	11	2223ICT00002	0	{"ol_rate": ["None", "0"], "narration": ["None", ""], "shipto": ["None", "XYZ"], "buyer_gst_reg_type": ["None", "Unknown"], "buyer_gstin": ["None", "AVIIADV125L"], "division": ["None", "division"], "bill_qty": ["None", "0"], "tcs": ["None", "0"], "channel": ["None", "IB"], "shipto_country": ["None", "India"], "inv_date": ["None", "2023-09-15 07:06:33.732983+00:00"], "buyer_address2": ["None", "XYZ"], "shipto_address_type": ["None", "Default"], "discount": ["None", "0"], "buyer_pincode": ["None", "390002"], "total": ["None", "0"], "shipto_address3": ["None", "XYZ"], "buyer": ["None", "XYZ"], "created": ["None", "2023-09-15"], "shipto_pincode": ["None", "390002"], "sgst": ["None", "0"], "is_ivt": ["None", "False"], "shipto_gstin": ["None", "AVIIADV125L"], "cgst": ["None", "0"], "buyer_country": ["None", "India"], "updated": ["None", "2023-09-15"], "buyer_mailingname": ["None", "XYZ"], "shipto_pan_no": ["None", "IIADV125L"], "ammount": ["None", "0"], "inv_no": ["None", "2223ICT00002"], "buyer_address1": ["None", "XYZ"], "igst": ["None", "0"], "shipto_address1": ["None", "XYZ"], "mrpvalue": ["None", "0"], "shipto_address2": ["None", "XYZ"], "status": ["None", "1"], "id": ["None", "11"], "buyer_address3": ["None", "XYZ"], "omrpvalue": ["None", "0"], "shipto_mailingname": ["None", "XYZ"], "free_qty": ["None", "0"], "company": ["None", "ABC"], "buyer_state": ["None", "Gujarat-1"], "shipto_city": ["None", "Vadodara"], "is_ict": ["None", "True"], "other": ["None", "0"], "buyer_city": ["None", "Vadodara"], "round_off": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "buyer_address_type": ["None", "Default"]}	2023-09-15 12:36:33.74962+05:30	2	70	127.0.0.1	\N
885	7	7	2223ICT00002	0	{"supplier_invoice": ["None", "2223ICT00002"], "grn": ["None", "purchase.Grn.None"], "company": ["None", "XYZ"], "shipto_address3": ["None", "ABCD"], "ex_rate": ["None", "1"], "updated": ["None", "2023-09-15 07:06:33.752305"], "round_off": ["None", "0"], "seller_country": ["None", "India"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "seller_address3": ["None", "ABC"], "currency": ["None", "INR"], "is_ict": ["None", "True"], "status": ["None", "1"], "seller_mailingname": ["None", "ABCD"], "shipto_city": ["None", "VADODARA"], "narration": ["None", ""], "id": ["None", "7"], "seller": ["None", "ABCD"], "shipto_state": ["None", "GUJARAT"], "seller_city": ["None", "Pune"], "shipto_pincode": ["None", "391775"], "cgst": ["None", "0"], "shipto": ["None", "ABC"], "seller_gst_reg_type": ["None", "Regular"], "shipto_mailingname": ["None", "ABCD"], "tcs": ["None", "0"], "shipto_address1": ["None", "ABCD"], "supplier_date": ["None", "2023-09-15"], "total": ["None", "0"], "ol_rate": ["None", "0"], "ammount": ["None", "0"], "seller_gstin": ["None", "AAAAAAA0258A"], "igst": ["None", "0"], "pi_date": ["None", "2023-09-15"], "shipto_country": ["None", "INDIA"], "pi_no": ["None", "2223ICT00002"], "other": ["None", "0"], "seller_address_type": ["None", "Default"], "created": ["None", "2023-09-15 07:06:33.752292"], "seller_address1": ["None", "ABC"], "seller_pincode": ["None", "392220"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller_address2": ["None", "ABC"], "sgst": ["None", "0"], "shipto_address_type": ["None", "Default"]}	2023-09-15 12:36:33.758096+05:30	2	56	127.0.0.1	\N
886	11	11	InvItems object (11)	0	{"item": ["None", "RAW2"], "actual_qty": ["None", "38"], "discount": ["None", "0"], "sgst": ["None", "0.00"], "prate": ["None", "132.00"], "offer_mrp": ["None", "0.00"], "pack": ["None", "123.00"], "sgstrate": ["None", "0.00"], "inv": ["None", "2223ICT00002"], "new_rate": ["None", "0"], "nf_qty": ["None", "0"], "igstrate": ["None", "0.00"], "mrp": ["None", "0.00"], "igst": ["None", "0.00"], "free_qty": ["None", "0"], "nb_qty": ["None", "0"], "amount": ["None", "4560"], "available_qty": ["None", "638"], "rate": ["None", "120"], "id": ["None", "11"], "cgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "38"]}	2023-09-15 12:36:33.767391+05:30	2	71	127.0.0.1	\N
887	4	4	New1231	1	{"closing_balance": ["558.0000", "520.0000"]}	2023-09-15 12:36:33.776691+05:30	2	84	127.0.0.1	\N
888	55	55	New1231	0	{"product": ["None", "RAW2"], "batch": ["None", "20230905003002"], "created": ["None", "2023-09-15"], "id": ["None", "55"], "updated": ["None", "2023-09-15"], "rate": ["None", "132.00"], "godown": ["None", "New1231"], "mrp": ["None", "0.00"], "company": ["None", "XYZ"]}	2023-09-15 12:36:33.784406+05:30	2	84	127.0.0.1	\N
889	55	55	New1231	1	{"rate": ["132.00", "120"], "closing_balance": ["None", "38"]}	2023-09-15 12:36:33.78939+05:30	2	84	127.0.0.1	\N
890	11	11	2223ICT00002	1	{"ol_rate": ["0.00", "0"], "bill_qty": ["0.00", "38"], "inv_date": ["2023-09-15", "2023-09-15 07:06:33.732983+00:00"], "discount": ["0.00", "0"], "total": ["0.00", "4560"], "ammount": ["0.00", "4560"], "mrpvalue": ["0.00", "0"], "omrpvalue": ["0.00", "0"], "free_qty": ["0.00", "0"], "other": ["0.00", "0"]}	2023-09-15 12:36:33.798332+05:30	2	70	127.0.0.1	\N
891	7	7	2223ICT00002	1	{"ex_rate": ["1.00", "1"], "total": ["0.00", "4560"], "ol_rate": ["0.00", "0"], "ammount": ["0.00", "4560"], "other": ["0.00", "0"]}	2023-09-15 12:36:33.806466+05:30	2	56	127.0.0.1	\N
303	3	3	Production123	1	{"parent": ["New123", "Alkapuri"], "name": ["New123", "Production123"]}	2023-09-05 16:55:10.891+05:30	2	10	127.0.0.1	\N
665	1	1	DAMAGE & SCRAP	1	{"name": ["Alkapuri", "DAMAGE & SCRAP"]}	2023-09-13 09:35:50.804+05:30	2	10	127.0.0.1	\N
837	42	42	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230912003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "42"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "1.00"]}	2023-09-14 12:45:51.908304+05:30	\N	84	\N	\N
696	32	32	2223SO00018	1	{"status": ["1", "2"]}	2023-09-13 10:54:30.18+05:30	2	66	127.0.0.1	\N
838	43	43	DAMAGE & SCRAP	0	{"godown": ["None", "DAMAGE & SCRAP"], "mrp": ["None", ""], "batch": ["None", "20230912003001"], "closing_balance": ["None", "2.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "43"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "1.00"]}	2023-09-14 12:45:51.913745+05:30	\N	84	\N	\N
699	29	29	2223SO00015	1	{"status": ["1", "2"]}	2023-09-13 10:55:28.771+05:30	2	66	127.0.0.1	\N
22	18	18	GRS-GROSS	0	{"id": ["None", "18"], "created": ["None", "2023-03-03"], "name": ["None", "GRS-GROSS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.69+05:30	2	17	127.0.0.1	\N
839	44	44	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", "0.00"], "batch": ["None", "20230912005001"], "closing_balance": ["None", "10.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "44"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW2"], "rate": ["None", "1.00"]}	2023-09-14 12:45:51.918921+05:30	\N	84	\N	\N
840	45	45	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230912003001"], "closing_balance": ["None", "9.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "45"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "1.00"]}	2023-09-14 12:45:51.923765+05:30	\N	84	\N	\N
23	19	19	GYD-GROSS YARDS	0	{"id": ["None", "19"], "created": ["None", "2023-03-03"], "name": ["None", "GYD-GROSS YARDS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.696+05:30	2	17	127.0.0.1	\N
841	46	46	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230905003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "46"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "120.00"]}	2023-09-14 12:45:51.928784+05:30	\N	84	\N	\N
842	48	48	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230905003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "48"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "120.00"]}	2023-09-14 12:45:51.934276+05:30	\N	84	\N	\N
843	50	50	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230905003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "50"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "120.00"]}	2023-09-14 12:45:51.940068+05:30	\N	84	\N	\N
24	20	20	KGS-KILOGRAMS	0	{"id": ["None", "20"], "created": ["None", "2023-03-03"], "name": ["None", "KGS-KILOGRAMS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.702+05:30	2	17	127.0.0.1	\N
861	5	5	PalletTransferEntry object (5)	0	{"company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "item": ["None", "RAW1"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "5"], "qty": ["None", "1500.0000"], "created": ["None", "2023-09-12"]}	2023-09-14 12:45:52.053138+05:30	\N	87	\N	\N
753	4	4	2223INV00004	1	{"lr_no": ["None", ""]}	2023-09-13 11:50:56.683+05:30	2	70	127.0.0.1	\N
763	6	6	2223DN00006	1	{"ls_status": ["False", "True"]}	2023-09-13 12:03:18.271+05:30	2	68	127.0.0.1	\N
780	1	1	DAMAGE & SCRAP	1	{"parent": ["ALLOCATED", "DAMAGE & SCRAP"]}	2023-09-13 13:57:15.263+05:30	2	10	127.0.0.1	\N
25	21	21	KLR-KILOLITRE	0	{"id": ["None", "21"], "created": ["None", "2023-03-03"], "name": ["None", "KLR-KILOLITRE"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.708+05:30	2	17	127.0.0.1	\N
26	22	22	KME-KILOMETRE	0	{"id": ["None", "22"], "created": ["None", "2023-03-03"], "name": ["None", "KME-KILOMETRE"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.714+05:30	2	17	127.0.0.1	\N
834	38	38	UN ALLOCATED	0	{"godown": ["None", "UN ALLOCATED"], "mrp": ["None", "100.00"], "batch": ["None", "20230905000995"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "38"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "FG1"], "rate": ["None", "0.00"]}	2023-09-14 12:45:51.893218+05:30	\N	84	\N	\N
27	23	23	MLT-MILILITRE	0	{"id": ["None", "23"], "created": ["None", "2023-03-03"], "name": ["None", "MLT-MILILITRE"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.72+05:30	2	17	127.0.0.1	\N
835	40	40	DAMAGE & SCRAP	0	{"godown": ["None", "DAMAGE & SCRAP"], "mrp": ["None", "0.00"], "batch": ["None", "20230905003002"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "40"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW2"], "rate": ["None", "132.00"]}	2023-09-14 12:45:51.898328+05:30	\N	84	\N	\N
836	41	41	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230912003001"], "closing_balance": ["None", "5.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "41"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "1.00"]}	2023-09-14 12:45:51.903336+05:30	\N	84	\N	\N
862	6	6	PalletTransferEntry object (6)	0	{"company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "item": ["None", "NFG2"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "6"], "qty": ["None", "1500.0000"], "created": ["None", "2023-09-12"]}	2023-09-14 12:45:52.057882+05:30	\N	87	\N	\N
28	24	24	MTR-METERS	0	{"id": ["None", "24"], "created": ["None", "2023-03-03"], "name": ["None", "MTR-METERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.726+05:30	2	17	127.0.0.1	\N
844	51	51	DAMAGE & SCRAP	0	{"godown": ["None", "DAMAGE & SCRAP"], "mrp": ["None", ""], "batch": ["None", "20230905003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "51"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "120.00"]}	2023-09-14 12:45:51.949325+05:30	\N	84	\N	\N
845	52	52	SHORTAGE	0	{"godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "batch": ["None", "20230905003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "52"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "120.00"]}	2023-09-14 12:45:51.9552+05:30	\N	84	\N	\N
846	53	53	DAMAGE & SCRAP	0	{"godown": ["None", "DAMAGE & SCRAP"], "mrp": ["None", ""], "batch": ["None", "20230905003001"], "closing_balance": ["None", "1.0000"], "updated": ["None", "2023-09-13"], "id": ["None", "53"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "rate": ["None", "120.00"]}	2023-09-14 12:45:51.961042+05:30	\N	84	\N	\N
847	1	1	ShortageDamageEntry object (1)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "item": ["None", "FG1"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-13"], "sqty": ["None", "1.0000"], "dremarks": ["None", "ABC"], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "rate": ["None", "0.00"], "id": ["None", "1"], "dqty": ["None", "1.0000"]}	2023-09-14 12:45:51.967278+05:30	\N	86	\N	\N
848	2	2	ShortageDamageEntry object (2)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "item": ["None", "RAW2"], "shoratage": ["None", ""], "godown": ["None", "New1231"], "updated": ["None", "2023-09-13"], "sqty": ["None", "1.0000"], "dremarks": ["None", "ABC"], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "rate": ["None", "132.00"], "id": ["None", "2"], "dqty": ["None", "1.0000"]}	2023-09-14 12:45:51.973403+05:30	\N	86	\N	\N
849	3	3	ShortageDamageEntry object (3)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "item": ["None", "RAW2"], "shoratage": ["None", ""], "godown": ["None", "SHORTAGE"], "updated": ["None", "2023-09-13"], "sqty": ["None", "1.0000"], "dremarks": ["None", "ABC"], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "rate": ["None", "132.00"], "id": ["None", "3"], "dqty": ["None", "1.0000"]}	2023-09-14 12:45:51.979408+05:30	\N	86	\N	\N
850	4	4	ShortageDamageEntry object (4)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00003"], "item": ["None", "RAW1"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-13"], "sqty": ["None", "5.0000"], "dremarks": ["None", "Nothing"], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "rate": ["None", "1.00"], "id": ["None", "4"], "dqty": ["None", "0.0000"]}	2023-09-14 12:45:51.986156+05:30	\N	86	\N	\N
851	5	5	ShortageDamageEntry object (5)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00003"], "item": ["None", "RAW1"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-13"], "sqty": ["None", "1.0000"], "dremarks": ["None", "No Damage"], "sremarks": ["None", "Short product"], "company": ["None", "ABC"], "rate": ["None", "1.00"], "id": ["None", "5"], "dqty": ["None", "0.0000"]}	2023-09-14 12:45:51.992958+05:30	\N	86	\N	\N
852	6	6	ShortageDamageEntry object (6)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00003"], "item": ["None", "RAW1"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-13"], "sqty": ["None", "0.0000"], "dremarks": ["None", "Damage"], "sremarks": ["None", "NA"], "company": ["None", "ABC"], "rate": ["None", "1.00"], "id": ["None", "6"], "dqty": ["None", "2.0000"]}	2023-09-14 12:45:51.99968+05:30	\N	86	\N	\N
853	7	7	ShortageDamageEntry object (7)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00005"], "item": ["None", "RAW2"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-13"], "sqty": ["None", "10.0000"], "dremarks": ["None", "ABC"], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "rate": ["None", "1.00"], "id": ["None", "7"], "dqty": ["None", "0.0000"]}	2023-09-14 12:45:52.006442+05:30	\N	86	\N	\N
854	8	8	ShortageDamageEntry object (8)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00003"], "item": ["None", "RAW1"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-13"], "sqty": ["None", "9.0000"], "dremarks": ["None", ""], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "rate": ["None", "1.00"], "id": ["None", "8"], "dqty": ["None", "0.0000"]}	2023-09-14 12:45:52.013604+05:30	\N	86	\N	\N
855	9	9	ShortageDamageEntry object (9)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00003"], "item": ["None", "RAW1"], "shoratage": ["None", ""], "godown": ["None", "DAMAGE & SCRAP"], "updated": ["None", "2023-09-13"], "sqty": ["None", "1.0000"], "dremarks": ["None", "NA"], "sremarks": ["None", "1"], "company": ["None", "ABC"], "rate": ["None", "120.00"], "id": ["None", "9"], "dqty": ["None", "0.0000"]}	2023-09-14 12:45:52.02034+05:30	\N	86	\N	\N
856	10	10	ShortageDamageEntry object (10)	0	{"createdby": ["None", "admin"], "created": ["None", "2023-09-13"], "purchase": ["None", "2223PINV00003"], "item": ["None", "RAW1"], "shoratage": ["None", "1"], "godown": ["None", "DAMAGE & SCRAP"], "updated": ["None", "2023-09-13"], "sqty": ["None", "0.0000"], "dremarks": ["None", "1"], "jobwork": ["None", "2223JC00005"], "sremarks": ["None", "NA"], "company": ["None", "ABC"], "rate": ["None", "120.00"], "id": ["None", "10"], "dqty": ["None", "1.0000"]}	2023-09-14 12:45:52.027523+05:30	\N	86	\N	\N
857	1	1	PalletTransferEntry object (1)	0	{"company": ["None", "ABC"], "tgodown": ["None", "New1231"], "item": ["None", "RAW1"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "1"], "qty": ["None", "500.0000"], "created": ["None", "2023-09-05"]}	2023-09-14 12:45:52.033058+05:30	\N	87	\N	\N
858	2	2	PalletTransferEntry object (2)	0	{"company": ["None", "ABC"], "tgodown": ["None", "New1231"], "item": ["None", "RAW2"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "2"], "qty": ["None", "1000.0000"], "created": ["None", "2023-09-05"]}	2023-09-14 12:45:52.037625+05:30	\N	87	\N	\N
859	3	3	PalletTransferEntry object (3)	0	{"company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "item": ["None", "NFG2"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "3"], "qty": ["None", "100.0000"], "created": ["None", "2023-09-12"]}	2023-09-14 12:45:52.042457+05:30	\N	87	\N	\N
860	4	4	PalletTransferEntry object (4)	0	{"company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "item": ["None", "RAW1"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "4"], "qty": ["None", "100.0000"], "created": ["None", "2023-09-12"]}	2023-09-14 12:45:52.047891+05:30	\N	87	\N	\N
20	16	16	GGK-GREAT GROSS	0	{"id": ["None", "16"], "created": ["None", "2023-03-03"], "name": ["None", "GGK-GREAT GROSS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.68+05:30	2	17	127.0.0.1	\N
863	7	7	PalletTransferEntry object (7)	0	{"company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "item": ["None", "NFG2"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "7"], "qty": ["None", "500.0000"], "created": ["None", "2023-09-12"]}	2023-09-14 12:45:52.0631+05:30	\N	87	\N	\N
864	8	8	PalletTransferEntry object (8)	0	{"company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "item": ["None", "RAW2"], "createdby": ["None", "admin"], "fgodown": ["None", "UN ALLOCATED"], "id": ["None", "8"], "qty": ["None", "100.0000"], "created": ["None", "2023-09-12"]}	2023-09-14 12:45:52.068374+05:30	\N	87	\N	\N
865	9	9	PalletTransferEntry object (9)	0	{"company": ["None", "ABC"], "tgodown": ["None", "UN ALLOCATED"], "item": ["None", "FG1"], "createdby": ["None", "admin"], "fgodown": ["None", "DAMAGE & SCRAP"], "id": ["None", "9"], "qty": ["None", "1.0000"], "created": ["None", "2023-09-13"]}	2023-09-14 12:45:52.073384+05:30	\N	87	\N	\N
1	1	1	STONE SAPPHIRE (INDIA) PRIVATE LIMITED	0	{"pallet": ["None", "warehouse.PalletTransferEntry.None"], "job_series": ["None", "2223JC"], "dis_add3": ["None", "MANJUSAR"], "sales_qdn_series": ["None", "2223SQ"], "pinv_series": ["None", "2223PI"], "ledger_name": ["None", "STONE SAPPHIRE (INDIA) PRIVATE LIMITED"], "rm_series": ["None", "2223RM"], "id": ["None", "1"], "grnshipped": ["None", "purchase.Grn.None"], "cms_series": ["None", "2223CSM"], "pan_no": ["None", "AAKCS5015L"], "dis_addtype": ["None", "Default"], "dn_series": ["None", "2223DN"], "stock": ["None", "warehouse.Stock_summary.None"], "purchase_qdn_series": ["None", "2223PQ"], "dis_name": ["None", "STONE SAPPHIRE (INDIA) PRIVATE LIMITED"], "inv_series": ["None", "2223INV"], "pds_series": ["None", "2223PRD"], "purchase_return_series": ["None", "2223PR"], "pishipped": ["None", "purchase.Purchase.None"], "joborder_series": ["None", "2223JO"], "updated": ["None", "2023-03-03"], "dis_add2": ["None", "SAVLI GIDC ROAD"], "poshipped": ["None", "purchase.Purchase_order.None"], "dis_gstin": ["None", "24AAKCS5015L1Z8"], "debitnote_series": ["None", "2223DB"], "debitnote_shipto": ["None", "purchase.DebitNote.None"], "tally_name": ["None", "STONE SAPPHIRE (INDIA) PRIVATE LIMITED"], "ict_series": ["None", "2223ICT"], "creditnote_series": ["None", "2223CN"], "pi_series": ["None", "2223PINV"], "ipaddress": ["None", "http://localhost:9001"], "so_series": ["None", "2223SO"], "dis_country": ["None", "INDIA"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "dis_state": ["None", "GUJARAT"], "name": ["None", "STONE SAPPHIRE (INDIA) PRIVATE LIMITED"], "po_series": ["None", "2223PO"], "rso_series": ["None", "2223RSO"], "dis_city": ["None", "VADODARA"], "created": ["None", "2023-03-03"], "dis_pincode": ["None", "391775"], "grn_series": ["None", "2223GRN"], "pr_shipto": ["None", "purchase.PurchaseReturn.None"], "purchase_qdn_shipto": ["None", "purchase.Qdn.None"], "dis_add1": ["None", "627,GIDC"]}	2023-03-03 12:08:52.891+05:30	2	8	127.0.0.1	\N
2	2	2	REDRIDGE INDIA PVT LTD	0	{"pallet": ["None", "warehouse.PalletTransferEntry.None"], "job_series": ["None", "2223JC"], "dis_add3": ["None", "MANJUSAR"], "sales_qdn_series": ["None", "2223SQ"], "pinv_series": ["None", "2223PI"], "ledger_name": ["None", "REDRIDGE INDIA PVT LTD"], "rm_series": ["None", "2223RM"], "id": ["None", "2"], "grnshipped": ["None", "purchase.Grn.None"], "cms_series": ["None", "2223CSM"], "pan_no": ["None", "AAJCR4497G"], "dis_addtype": ["None", "Default"], "dn_series": ["None", "2223DN"], "stock": ["None", "warehouse.Stock_summary.None"], "purchase_qdn_series": ["None", "2223PQ"], "dis_name": ["None", "REDRIDGE INDIA PVT LTD"], "inv_series": ["None", "2223INV"], "pds_series": ["None", "2223PRD"], "purchase_return_series": ["None", "2223PR"], "pishipped": ["None", "purchase.Purchase.None"], "joborder_series": ["None", "2223JO"], "updated": ["None", "2023-03-03"], "dis_add2": ["None", "SAVLI GIDC ROAD"], "poshipped": ["None", "purchase.Purchase_order.None"], "dis_gstin": ["None", "24AAJCR4497G1Z1"], "debitnote_series": ["None", "2223DB"], "debitnote_shipto": ["None", "purchase.DebitNote.None"], "tally_name": ["None", "REDRIDGE INDIA PVT LTD"], "ict_series": ["None", "2223ICT"], "creditnote_series": ["None", "2223CN"], "pi_series": ["None", "2223PINV"], "ipaddress": ["None", "http://localhost:9001"], "so_series": ["None", "2223SO"], "dis_country": ["None", "INDIA"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "dis_state": ["None", "GUJARAT"], "name": ["None", "REDRIDGE INDIA PVT LTD"], "po_series": ["None", "2223PO"], "rso_series": ["None", "2223RSO"], "dis_city": ["None", "VADODARA"], "created": ["None", "2023-03-03"], "dis_pincode": ["None", "391775"], "grn_series": ["None", "2223GRN"], "pr_shipto": ["None", "purchase.PurchaseReturn.None"], "purchase_qdn_shipto": ["None", "purchase.Qdn.None"], "dis_add1": ["None", "627,GIDC"]}	2023-03-03 12:12:08.959+05:30	2	8	127.0.0.1	\N
3	1	1	ABCD	1	{"dis_add3": ["MANJUSAR", "ABCD"], "ledger_name": ["STONE SAPPHIRE (INDIA) PRIVATE LIMITED", "ABCD"], "dis_name": ["STONE SAPPHIRE (INDIA) PRIVATE LIMITED", "ABCD"], "dis_add2": ["SAVLI GIDC ROAD", "ABCD"], "tally_name": ["STONE SAPPHIRE (INDIA) PRIVATE LIMITED", "ABCD"], "name": ["STONE SAPPHIRE (INDIA) PRIVATE LIMITED", "ABCD"], "dis_add1": ["627,GIDC", "ABCD"]}	2023-03-03 12:13:45.139+05:30	2	8	127.0.0.1	\N
4	2	2	XYZ	1	{"dis_add3": ["MANJUSAR", "XYZ"], "ledger_name": ["REDRIDGE INDIA PVT LTD", "XYZ"], "dis_name": ["REDRIDGE INDIA PVT LTD", "XYZ"], "dis_add2": ["SAVLI GIDC ROAD", "XYZ"], "tally_name": ["REDRIDGE INDIA PVT LTD", "XYZ"], "name": ["REDRIDGE INDIA PVT LTD", "XYZ"], "dis_add1": ["627,GIDC", "XYZ"]}	2023-03-03 12:14:09.147+05:30	2	8	127.0.0.1	\N
5	1	1	BAG-BAGS	0	{"id": ["None", "1"], "created": ["None", "2023-03-03"], "name": ["None", "BAG-BAGS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.593+05:30	2	17	127.0.0.1	\N
6	2	2	BAL-BALE	0	{"id": ["None", "2"], "created": ["None", "2023-03-03"], "name": ["None", "BAL-BALE"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.6+05:30	2	17	127.0.0.1	\N
7	3	3	BDL-BUNDLES	0	{"id": ["None", "3"], "created": ["None", "2023-03-03"], "name": ["None", "BDL-BUNDLES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.606+05:30	2	17	127.0.0.1	\N
8	4	4	BKL-BUCKLES	0	{"id": ["None", "4"], "created": ["None", "2023-03-03"], "name": ["None", "BKL-BUCKLES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.612+05:30	2	17	127.0.0.1	\N
9	5	5	BOU-BILLION OF UNITS	0	{"id": ["None", "5"], "created": ["None", "2023-03-03"], "name": ["None", "BOU-BILLION OF UNITS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.618+05:30	2	17	127.0.0.1	\N
10	6	6	BOX-BOX	0	{"id": ["None", "6"], "created": ["None", "2023-03-03"], "name": ["None", "BOX-BOX"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.623+05:30	2	17	127.0.0.1	\N
11	7	7	BTL-BOTTLES	0	{"id": ["None", "7"], "created": ["None", "2023-03-03"], "name": ["None", "BTL-BOTTLES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.629+05:30	2	17	127.0.0.1	\N
12	8	8	BUN-BUNCHES	0	{"id": ["None", "8"], "created": ["None", "2023-03-03"], "name": ["None", "BUN-BUNCHES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.634+05:30	2	17	127.0.0.1	\N
13	9	9	CAN-CANS	0	{"id": ["None", "9"], "created": ["None", "2023-03-03"], "name": ["None", "CAN-CANS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.639+05:30	2	17	127.0.0.1	\N
14	10	10	CBM-CUBIC METERS	0	{"id": ["None", "10"], "created": ["None", "2023-03-03"], "name": ["None", "CBM-CUBIC METERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.646+05:30	2	17	127.0.0.1	\N
15	11	11	CCM-CUBIC CENTIMETERS	0	{"id": ["None", "11"], "created": ["None", "2023-03-03"], "name": ["None", "CCM-CUBIC CENTIMETERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.651+05:30	2	17	127.0.0.1	\N
16	12	12	CMS-CENTIMETERS	0	{"id": ["None", "12"], "created": ["None", "2023-03-03"], "name": ["None", "CMS-CENTIMETERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.656+05:30	2	17	127.0.0.1	\N
17	13	13	CTN-CARTONS	0	{"id": ["None", "13"], "created": ["None", "2023-03-03"], "name": ["None", "CTN-CARTONS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.662+05:30	2	17	127.0.0.1	\N
18	14	14	DOZ-DOZENS	0	{"id": ["None", "14"], "created": ["None", "2023-03-03"], "name": ["None", "DOZ-DOZENS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.668+05:30	2	17	127.0.0.1	\N
19	15	15	DRM-DRUMS	0	{"id": ["None", "15"], "created": ["None", "2023-03-03"], "name": ["None", "DRM-DRUMS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.674+05:30	2	17	127.0.0.1	\N
29	25	25	MTS-METRIC TON	0	{"id": ["None", "25"], "created": ["None", "2023-03-03"], "name": ["None", "MTS-METRIC TON"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.732+05:30	2	17	127.0.0.1	\N
30	26	26	NOS-NUMBERS	0	{"id": ["None", "26"], "created": ["None", "2023-03-03"], "name": ["None", "NOS-NUMBERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.737+05:30	2	17	127.0.0.1	\N
31	44	44	OTH-OTHERS	0	{"id": ["None", "44"], "created": ["None", "2023-03-03"], "name": ["None", "OTH-OTHERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.743+05:30	2	17	127.0.0.1	\N
32	27	27	PAC-PACKS	0	{"id": ["None", "27"], "created": ["None", "2023-03-03"], "name": ["None", "PAC-PACKS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.748+05:30	2	17	127.0.0.1	\N
33	28	28	PCS-PIECES	0	{"id": ["None", "28"], "created": ["None", "2023-03-03"], "name": ["None", "PCS-PIECES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.753+05:30	2	17	127.0.0.1	\N
34	29	29	PRS-PAIRS	0	{"id": ["None", "29"], "created": ["None", "2023-03-03"], "name": ["None", "PRS-PAIRS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.758+05:30	2	17	127.0.0.1	\N
35	30	30	QTL-QUINTAL	0	{"id": ["None", "30"], "created": ["None", "2023-03-03"], "name": ["None", "QTL-QUINTAL"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.764+05:30	2	17	127.0.0.1	\N
36	31	31	ROL-ROLLS	0	{"id": ["None", "31"], "created": ["None", "2023-03-03"], "name": ["None", "ROL-ROLLS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.77+05:30	2	17	127.0.0.1	\N
37	32	32	SET-SETS	0	{"id": ["None", "32"], "created": ["None", "2023-03-03"], "name": ["None", "SET-SETS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.775+05:30	2	17	127.0.0.1	\N
38	33	33	SQF-SQUARE FEET	0	{"id": ["None", "33"], "created": ["None", "2023-03-03"], "name": ["None", "SQF-SQUARE FEET"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.781+05:30	2	17	127.0.0.1	\N
39	34	34	SQM-SQUARE METERS	0	{"id": ["None", "34"], "created": ["None", "2023-03-03"], "name": ["None", "SQM-SQUARE METERS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.788+05:30	2	17	127.0.0.1	\N
40	35	35	SQY-SQUARE YARDS	0	{"id": ["None", "35"], "created": ["None", "2023-03-03"], "name": ["None", "SQY-SQUARE YARDS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.797+05:30	2	17	127.0.0.1	\N
41	36	36	TBS-TABLETS	0	{"id": ["None", "36"], "created": ["None", "2023-03-03"], "name": ["None", "TBS-TABLETS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.804+05:30	2	17	127.0.0.1	\N
42	37	37	TGM-TEN GROSS	0	{"id": ["None", "37"], "created": ["None", "2023-03-03"], "name": ["None", "TGM-TEN GROSS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.81+05:30	2	17	127.0.0.1	\N
43	38	38	THD-THOUSANDS	0	{"id": ["None", "38"], "created": ["None", "2023-03-03"], "name": ["None", "THD-THOUSANDS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.816+05:30	2	17	127.0.0.1	\N
44	39	39	TON-TONNES	0	{"id": ["None", "39"], "created": ["None", "2023-03-03"], "name": ["None", "TON-TONNES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.821+05:30	2	17	127.0.0.1	\N
45	40	40	TUB-TUBES	0	{"id": ["None", "40"], "created": ["None", "2023-03-03"], "name": ["None", "TUB-TUBES"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.828+05:30	2	17	127.0.0.1	\N
46	41	41	UGS-US GALLONS	0	{"id": ["None", "41"], "created": ["None", "2023-03-03"], "name": ["None", "UGS-US GALLONS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.833+05:30	2	17	127.0.0.1	\N
47	42	42	UNT-UNITS	0	{"id": ["None", "42"], "created": ["None", "2023-03-03"], "name": ["None", "UNT-UNITS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.839+05:30	2	17	127.0.0.1	\N
48	43	43	YDS-YARDS	0	{"id": ["None", "43"], "created": ["None", "2023-03-03"], "name": ["None", "YDS-YARDS"], "updated": ["None", "2023-03-03"]}	2023-03-03 12:43:21.845+05:30	2	17	127.0.0.1	\N
49	1	1	Sundry Debtors	0	{"created": ["None", "2023-03-03"], "updated": ["None", "2023-03-03"], "id": ["None", "1"], "name": ["None", "Sundry Debtors"]}	2023-03-03 12:45:52.589+05:30	2	24	127.0.0.1	\N
50	2	2	Sundry Creditors	0	{"created": ["None", "2023-03-03"], "updated": ["None", "2023-03-03"], "id": ["None", "2"], "name": ["None", "Sundry Creditors"]}	2023-03-03 12:46:06.829+05:30	2	24	127.0.0.1	\N
51	3	3	Sales Accounts	0	{"created": ["None", "2023-03-03"], "updated": ["None", "2023-03-03"], "id": ["None", "3"], "name": ["None", "Sales Accounts"]}	2023-03-03 12:46:16.241+05:30	2	24	127.0.0.1	\N
52	4	4	Purchase Accounts	0	{"created": ["None", "2023-03-03"], "updated": ["None", "2023-03-03"], "id": ["None", "4"], "name": ["None", "Purchase Accounts"]}	2023-03-03 12:46:26.335+05:30	2	24	127.0.0.1	\N
53	5	5	Direct Income	0	{"created": ["None", "2023-03-03"], "updated": ["None", "2023-03-03"], "id": ["None", "5"], "name": ["None", "Direct Income"]}	2023-03-03 12:46:37.989+05:30	2	24	127.0.0.1	\N
54	6	6	Direct Expense	0	{"created": ["None", "2023-03-03"], "updated": ["None", "2023-03-03"], "id": ["None", "6"], "name": ["None", "Direct Expense"]}	2023-03-03 12:46:48.412+05:30	2	24	127.0.0.1	\N
55	8	8	FIXED ASSETS PURCHASE A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Purchase Accounts"], "id": ["None", "8"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "FIXED ASSETS PURCHASE A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.651+05:30	2	25	127.0.0.1	\N
56	2	2	FIXED ASSETS SALES A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Sales Accounts"], "id": ["None", "2"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "FIXED ASSETS SALES A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.66+05:30	2	25	127.0.0.1	\N
57	7	7	GST PURCHASE A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Purchase Accounts"], "id": ["None", "7"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "GST PURCHASE A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.666+05:30	2	25	127.0.0.1	\N
83	2	2	Jharkhand	1	{"name": ["Jharkhand1", "Jharkhand"]}	2023-07-28 11:17:31.587+05:30	2	27	127.0.0.1	\N
84	3	3	Madhya Pradesh1	0	{"id": ["None", "3"], "created": ["None", "2023-07-28"], "name": ["None", "Madhya Pradesh1"], "zone": ["None", "Central Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:18:22.502+05:30	2	27	127.0.0.1	\N
58	1	1	GST SALES A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Sales Accounts"], "id": ["None", "1"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "GST SALES A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.674+05:30	2	25	127.0.0.1	\N
59	13	13	Inward Freight	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Direct Expense"], "id": ["None", "13"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "Inward Freight"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "2"]}	2023-03-03 12:47:09.681+05:30	2	25	127.0.0.1	\N
60	9	9	MISC PURCHASE A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Purchase Accounts"], "id": ["None", "9"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "MISC PURCHASE A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.689+05:30	2	25	127.0.0.1	\N
61	3	3	MISC SALES A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Sales Accounts"], "id": ["None", "3"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "MISC SALES A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.705+05:30	2	25	127.0.0.1	\N
62	10	10	PM PURCHASE A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Purchase Accounts"], "id": ["None", "10"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "PM PURCHASE A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.727+05:30	2	25	127.0.0.1	\N
63	4	4	PM SALES A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Sales Accounts"], "id": ["None", "4"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "PM SALES A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.736+05:30	2	25	127.0.0.1	\N
64	12	12	RM PURCHASE A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Purchase Accounts"], "id": ["None", "12"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "RM PURCHASE A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.745+05:30	2	25	127.0.0.1	\N
65	6	6	RM SALES A/C	0	{"product_type_purchase_ledger": ["None", "inventory.ProductType.None"], "under": ["None", "Sales Accounts"], "id": ["None", "6"], "sales_ledger": ["None", "inventory.Product_master.None"], "created": ["None", "2023-03-03"], "product_type_sales_ledger": ["None", "inventory.ProductType.None"], "purchase_ledger": ["None", "inventory.Product_master.None"], "name": ["None", "RM SALES A/C"], "gst_applicable": ["None", "1"], "updated": ["None", "2023-03-03"], "type_of_supply": ["None", "1"]}	2023-03-03 12:47:09.753+05:30	2	25	127.0.0.1	\N
66	1	1	INDIA	0	{"updated": ["None", "2023-07-28"], "name": ["None", "INDIA"], "id": ["None", "1"], "created": ["None", "2023-07-28"]}	2023-07-28 10:53:16.91+05:30	2	33	127.0.0.1	\N
67	2	2	UNITED KINGDOM	0	{"updated": ["None", "2023-07-28"], "name": ["None", "UNITED KINGDOM"], "id": ["None", "2"], "created": ["None", "2023-07-28"]}	2023-07-28 10:53:37.303+05:30	2	33	127.0.0.1	\N
68	2	2	England	1	{"name": ["UNITED KINGDOM", "England"]}	2023-07-28 11:04:20.806+05:30	2	33	127.0.0.1	\N
69	1	1	India	1	{"name": ["INDIA", "India"]}	2023-07-28 11:05:45.726+05:30	2	33	127.0.0.1	\N
70	3	3	USA	0	{"name": ["None", "USA"], "id": ["None", "3"], "updated": ["None", "2023-07-28"], "created": ["None", "2023-07-28"]}	2023-07-28 11:05:52.626+05:30	2	33	127.0.0.1	\N
71	4	4	Australia	0	{"name": ["None", "Australia"], "id": ["None", "4"], "updated": ["None", "2023-07-28"], "created": ["None", "2023-07-28"]}	2023-07-28 11:06:11.7+05:30	2	33	127.0.0.1	\N
72	1	1	North Zone	0	{"name": ["None", "North Zone"], "id": ["None", "1"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:13:30.481+05:30	2	26	127.0.0.1	\N
73	2	2	South Zone	0	{"name": ["None", "South Zone"], "id": ["None", "2"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:13:41.543+05:30	2	26	127.0.0.1	\N
74	3	3	East Zone	0	{"name": ["None", "East Zone"], "id": ["None", "3"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:13:52.218+05:30	2	26	127.0.0.1	\N
75	2	2	South Zone 1	1	{"name": ["South Zone", "South Zone 1"]}	2023-07-28 11:13:57.978+05:30	2	26	127.0.0.1	\N
76	2	2	South Zone	1	{"name": ["South Zone 1", "South Zone"]}	2023-07-28 11:14:04.476+05:30	2	26	127.0.0.1	\N
77	4	4	West Zone	0	{"name": ["None", "West Zone"], "id": ["None", "4"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:14:14.227+05:30	2	26	127.0.0.1	\N
78	5	5	Central Zone	0	{"name": ["None", "Central Zone"], "id": ["None", "5"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:14:21.893+05:30	2	26	127.0.0.1	\N
79	6	6	North East Zone	0	{"name": ["None", "North East Zone"], "id": ["None", "6"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:14:32.89+05:30	2	26	127.0.0.1	\N
80	1	1	Arunachal Pradesh	0	{"id": ["None", "1"], "created": ["None", "2023-07-28"], "name": ["None", "Arunachal Pradesh"], "zone": ["None", "North East Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:17:02.629+05:30	2	27	127.0.0.1	\N
81	2	2	Jharkhand	0	{"id": ["None", "2"], "created": ["None", "2023-07-28"], "name": ["None", "Jharkhand"], "zone": ["None", "North East Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:17:21.609+05:30	2	27	127.0.0.1	\N
82	2	2	Jharkhand1	1	{"name": ["Jharkhand", "Jharkhand1"]}	2023-07-28 11:17:26.029+05:30	2	27	127.0.0.1	\N
86	4	4	Chhattisgarh	0	{"id": ["None", "4"], "created": ["None", "2023-07-28"], "name": ["None", "Chhattisgarh"], "zone": ["None", "Central Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:18:54.657+05:30	2	27	127.0.0.1	\N
87	5	5	West Bengal	0	{"id": ["None", "5"], "created": ["None", "2023-07-28"], "name": ["None", "West Bengal"], "zone": ["None", "East Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:20:11.548+05:30	2	27	127.0.0.1	\N
88	6	6	Bihar	0	{"id": ["None", "6"], "created": ["None", "2023-07-28"], "name": ["None", "Bihar"], "zone": ["None", "East Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:20:23.138+05:30	2	27	127.0.0.1	\N
89	7	7	Awadh	0	{"id": ["None", "7"], "created": ["None", "2023-07-28"], "name": ["None", "Awadh"], "zone": ["None", "North Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:20:58.757+05:30	2	27	127.0.0.1	\N
90	8	8	Ladakh	0	{"id": ["None", "8"], "created": ["None", "2023-07-28"], "name": ["None", "Ladakh"], "zone": ["None", "North Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:21:06.474+05:30	2	27	127.0.0.1	\N
91	9	9	Bangalore	0	{"id": ["None", "9"], "created": ["None", "2023-07-28"], "name": ["None", "Bangalore"], "zone": ["None", "South Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:21:49.289+05:30	2	27	127.0.0.1	\N
92	10	10	Chennai	0	{"id": ["None", "10"], "created": ["None", "2023-07-28"], "name": ["None", "Chennai"], "zone": ["None", "South Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:21:59.472+05:30	2	27	127.0.0.1	\N
93	11	11	Gujarat	0	{"id": ["None", "11"], "created": ["None", "2023-07-28"], "name": ["None", "Gujarat"], "zone": ["None", "West Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:22:22.775+05:30	2	27	127.0.0.1	\N
94	12	12	Mumbai	0	{"id": ["None", "12"], "created": ["None", "2023-07-28"], "name": ["None", "Mumbai"], "zone": ["None", "West Zone"], "updated": ["None", "2023-07-28"]}	2023-07-28 11:22:31.833+05:30	2	27	127.0.0.1	\N
95	1	1	Gujarat-1	0	{"created": ["None", "2023-07-28"], "country": ["None", "India"], "id": ["None", "1"], "updated": ["None", "2023-07-28"], "name": ["None", "Gujarat-1"]}	2023-07-28 11:24:33.939+05:30	2	34	127.0.0.1	\N
96	2	2	Mumbai-1	0	{"created": ["None", "2023-07-28"], "country": ["None", "India"], "id": ["None", "2"], "updated": ["None", "2023-07-28"], "name": ["None", "Mumbai-1"]}	2023-07-28 11:24:59.024+05:30	2	34	127.0.0.1	\N
97	3	3	London	0	{"created": ["None", "2023-07-28"], "country": ["None", "England"], "id": ["None", "3"], "updated": ["None", "2023-07-28"], "name": ["None", "London"]}	2023-07-28 11:25:09.504+05:30	2	34	127.0.0.1	\N
98	4	4	Amsterdam	0	{"created": ["None", "2023-07-28"], "country": ["None", "England"], "id": ["None", "4"], "updated": ["None", "2023-07-28"], "name": ["None", "Amsterdam"]}	2023-07-28 11:25:21.235+05:30	2	34	127.0.0.1	\N
99	5	5	New York	0	{"created": ["None", "2023-07-28"], "country": ["None", "USA"], "id": ["None", "5"], "updated": ["None", "2023-07-28"], "name": ["None", "New York"]}	2023-07-28 11:25:35.303+05:30	2	34	127.0.0.1	\N
100	6	6	New Jersey	0	{"created": ["None", "2023-07-28"], "country": ["None", "USA"], "id": ["None", "6"], "updated": ["None", "2023-07-28"], "name": ["None", "New Jersey"]}	2023-07-28 11:25:47.813+05:30	2	34	127.0.0.1	\N
101	7	7	Sydney	0	{"created": ["None", "2023-07-28"], "country": ["None", "Australia"], "id": ["None", "7"], "updated": ["None", "2023-07-28"], "name": ["None", "Sydney"]}	2023-07-28 11:25:59.722+05:30	2	34	127.0.0.1	\N
102	8	8	Victoria	0	{"created": ["None", "2023-07-28"], "country": ["None", "Australia"], "id": ["None", "8"], "updated": ["None", "2023-07-28"], "name": ["None", "Victoria"]}	2023-07-28 11:26:44.532+05:30	2	34	127.0.0.1	\N
103	1	1	Vadodara	0	{"name": ["None", "Vadodara"], "created": ["None", "2023-07-28"], "id": ["None", "1"], "updated": ["None", "2023-07-28"], "state": ["None", "Gujarat-1"]}	2023-07-28 11:26:57.991+05:30	2	35	127.0.0.1	\N
104	2	2	New York City	0	{"name": ["None", "New York City"], "created": ["None", "2023-07-28"], "id": ["None", "2"], "updated": ["None", "2023-07-28"], "state": ["None", "New York"]}	2023-07-28 11:27:17.848+05:30	2	35	127.0.0.1	\N
105	3	3	Ahmedabad	0	{"name": ["None", "Ahmedabad"], "created": ["None", "2023-07-28"], "id": ["None", "3"], "updated": ["None", "2023-07-28"], "state": ["None", "Gujarat-1"]}	2023-07-28 11:27:27.853+05:30	2	35	127.0.0.1	\N
106	4	4	Mumbai	0	{"name": ["None", "Mumbai"], "created": ["None", "2023-07-28"], "id": ["None", "4"], "updated": ["None", "2023-07-28"], "state": ["None", "Mumbai-1"]}	2023-07-28 11:27:52.968+05:30	2	35	127.0.0.1	\N
107	2	2	Maharashtra	1	{"name": ["Mumbai-1", "Maharashtra"]}	2023-07-28 11:28:05.393+05:30	2	34	127.0.0.1	\N
108	5	5	Pune	0	{"name": ["None", "Pune"], "created": ["None", "2023-07-28"], "id": ["None", "5"], "updated": ["None", "2023-07-28"], "state": ["None", "Maharashtra"]}	2023-07-28 11:28:21.513+05:30	2	35	127.0.0.1	\N
109	6	6	NYC1	0	{"name": ["None", "NYC1"], "created": ["None", "2023-07-28"], "id": ["None", "6"], "updated": ["None", "2023-07-28"], "state": ["None", "New York"]}	2023-07-28 11:28:39.092+05:30	2	35	127.0.0.1	\N
110	7	7	NJC	0	{"name": ["None", "NJC"], "created": ["None", "2023-07-28"], "id": ["None", "7"], "updated": ["None", "2023-07-28"], "state": ["None", "New Jersey"]}	2023-07-28 11:28:49.602+05:30	2	35	127.0.0.1	\N
111	8	8	Melburn	0	{"name": ["None", "Melburn"], "created": ["None", "2023-07-28"], "id": ["None", "8"], "updated": ["None", "2023-07-28"], "state": ["None", "Sydney"]}	2023-07-28 11:29:00.773+05:30	2	35	127.0.0.1	\N
112	9	9	Victencia	0	{"name": ["None", "Victencia"], "created": ["None", "2023-07-28"], "id": ["None", "9"], "updated": ["None", "2023-07-28"], "state": ["None", "Victoria"]}	2023-07-28 11:29:21.574+05:30	2	35	127.0.0.1	\N
113	10	10	London	0	{"name": ["None", "London"], "created": ["None", "2023-07-28"], "id": ["None", "10"], "updated": ["None", "2023-07-28"], "state": ["None", "London"]}	2023-07-28 11:44:06.447+05:30	2	35	127.0.0.1	\N
114	11	11	Amsterdam	0	{"name": ["None", "Amsterdam"], "created": ["None", "2023-07-28"], "id": ["None", "11"], "updated": ["None", "2023-07-28"], "state": ["None", "Amsterdam"]}	2023-07-28 11:44:23.164+05:30	2	35	127.0.0.1	\N
115	1	1	ZSM 1	0	{"created": ["None", "2023-07-28"], "zone": ["None", "Central Zone"], "id": ["None", "1"], "updated": ["None", "2023-07-28"], "name": ["None", "ZSM 1"]}	2023-07-28 11:44:48.311+05:30	2	28	127.0.0.1	\N
116	2	2	ZSM 2	0	{"created": ["None", "2023-07-28"], "zone": ["None", "East Zone"], "id": ["None", "2"], "updated": ["None", "2023-07-28"], "name": ["None", "ZSM 2"]}	2023-07-28 11:45:06.541+05:30	2	28	127.0.0.1	\N
117	3	3	ZSM 3	0	{"created": ["None", "2023-07-28"], "zone": ["None", "North East Zone"], "id": ["None", "3"], "updated": ["None", "2023-07-28"], "name": ["None", "ZSM 3"]}	2023-07-28 11:45:12.5+05:30	2	28	127.0.0.1	\N
118	4	4	ZSM 4	0	{"created": ["None", "2023-07-28"], "zone": ["None", "North Zone"], "id": ["None", "4"], "updated": ["None", "2023-07-28"], "name": ["None", "ZSM 4"]}	2023-07-28 11:45:18.934+05:30	2	28	127.0.0.1	\N
119	5	5	ZSM 5	0	{"created": ["None", "2023-07-28"], "zone": ["None", "South Zone"], "id": ["None", "5"], "updated": ["None", "2023-07-28"], "name": ["None", "ZSM 5"]}	2023-07-28 11:45:25.191+05:30	2	28	127.0.0.1	\N
120	6	6	ZSM 6	0	{"created": ["None", "2023-07-28"], "zone": ["None", "West Zone"], "id": ["None", "6"], "updated": ["None", "2023-07-28"], "name": ["None", "ZSM 6"]}	2023-07-28 11:45:31.459+05:30	2	28	127.0.0.1	\N
121	1	1	Sales Executive 1	0	{"zone": ["None", "Central Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 1"], "name": ["None", "Sales Executive 1"], "region": ["None", "Chhattisgarh"], "created": ["None", "2023-07-28"], "id": ["None", "1"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:48:43.152+05:30	2	30	127.0.0.1	\N
122	2	2	Sales Executive 2	0	{"zone": ["None", "Central Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 1"], "name": ["None", "Sales Executive 2"], "region": ["None", "Madhya Pradesh"], "created": ["None", "2023-07-28"], "id": ["None", "2"], "rsm": ["None", "RSM 2"]}	2023-07-28 11:48:51.916+05:30	2	30	127.0.0.1	\N
123	3	3	Sales Executive 1	0	{"zone": ["None", "East Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 2"], "name": ["None", "Sales Executive 1"], "region": ["None", "Bihar"], "created": ["None", "2023-07-28"], "id": ["None", "3"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:49:01.017+05:30	2	30	127.0.0.1	\N
124	4	4	Sales Executive 3	0	{"zone": ["None", "East Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 2"], "name": ["None", "Sales Executive 3"], "region": ["None", "West Bengal"], "created": ["None", "2023-07-28"], "id": ["None", "4"], "rsm": ["None", "RSM 3"]}	2023-07-28 11:49:14.897+05:30	2	30	127.0.0.1	\N
125	5	5	Sales Executive 4	0	{"zone": ["None", "North East Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 3"], "name": ["None", "Sales Executive 4"], "region": ["None", "Arunachal Pradesh"], "created": ["None", "2023-07-28"], "id": ["None", "5"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:49:45.117+05:30	2	30	127.0.0.1	\N
126	6	6	Sales Executive 5	0	{"zone": ["None", "North East Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 3"], "name": ["None", "Sales Executive 5"], "region": ["None", "Jharkhand"], "created": ["None", "2023-07-28"], "id": ["None", "6"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:49:54.308+05:30	2	30	127.0.0.1	\N
127	7	7	Sales Executive 6	0	{"zone": ["None", "South Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 5"], "name": ["None", "Sales Executive 6"], "region": ["None", "Bangalore"], "created": ["None", "2023-07-28"], "id": ["None", "7"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:50:12.364+05:30	2	30	127.0.0.1	\N
128	8	8	Sales Executive 7	0	{"zone": ["None", "South Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 5"], "name": ["None", "Sales Executive 7"], "region": ["None", "Chennai"], "created": ["None", "2023-07-28"], "id": ["None", "8"], "rsm": ["None", "RSM 2"]}	2023-07-28 11:50:21.985+05:30	2	30	127.0.0.1	\N
129	9	9	Sales Executive 7	0	{"zone": ["None", "West Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 6"], "name": ["None", "Sales Executive 7"], "region": ["None", "Gujarat"], "created": ["None", "2023-07-28"], "id": ["None", "9"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:50:34.603+05:30	2	30	127.0.0.1	\N
130	10	10	Sales Executive 8	0	{"zone": ["None", "West Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 6"], "name": ["None", "Sales Executive 8"], "region": ["None", "Mumbai"], "created": ["None", "2023-07-28"], "id": ["None", "10"], "rsm": ["None", "RSM 2"]}	2023-07-28 11:50:45.18+05:30	2	30	127.0.0.1	\N
131	1	1	Sales person 1	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 1"], "region": ["None", "Chhattisgarh"], "name": ["None", "Sales person 1"], "updated": ["None", "2023-07-28"], "id": ["None", "1"], "zsm": ["None", "ZSM 1"], "created": ["None", "2023-07-28"], "zone": ["None", "Central Zone"]}	2023-07-28 11:51:53.36+05:30	2	31	127.0.0.1	\N
132	2	2	Sales person 2	0	{"rsm": ["None", "RSM 2"], "asm": ["None", "Sales Executive 2"], "region": ["None", "Madhya Pradesh"], "name": ["None", "Sales person 2"], "updated": ["None", "2023-07-28"], "id": ["None", "2"], "zsm": ["None", "ZSM 1"], "created": ["None", "2023-07-28"], "zone": ["None", "Central Zone"]}	2023-07-28 11:52:04.106+05:30	2	31	127.0.0.1	\N
133	3	3	Sales person 3	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 1"], "region": ["None", "Bihar"], "name": ["None", "Sales person 3"], "updated": ["None", "2023-07-28"], "id": ["None", "3"], "zsm": ["None", "ZSM 2"], "created": ["None", "2023-07-28"], "zone": ["None", "East Zone"]}	2023-07-28 11:52:13.995+05:30	2	31	127.0.0.1	\N
134	4	4	Sales person 4	0	{"rsm": ["None", "RSM 3"], "asm": ["None", "Sales Executive 3"], "region": ["None", "West Bengal"], "name": ["None", "Sales person 4"], "updated": ["None", "2023-07-28"], "id": ["None", "4"], "zsm": ["None", "ZSM 2"], "created": ["None", "2023-07-28"], "zone": ["None", "East Zone"]}	2023-07-28 11:52:33.52+05:30	2	31	127.0.0.1	\N
135	11	11	Sales Executive 9	0	{"zone": ["None", "East Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 2"], "name": ["None", "Sales Executive 9"], "region": ["None", "West Bengal"], "created": ["None", "2023-07-28"], "id": ["None", "11"], "rsm": ["None", "RSM 2"]}	2023-07-28 11:52:50.195+05:30	2	30	127.0.0.1	\N
136	5	5	Sales person 5	0	{"rsm": ["None", "RSM 2"], "asm": ["None", "Sales Executive 9"], "region": ["None", "West Bengal"], "name": ["None", "Sales person 5"], "updated": ["None", "2023-07-28"], "id": ["None", "5"], "zsm": ["None", "ZSM 2"], "created": ["None", "2023-07-28"], "zone": ["None", "East Zone"]}	2023-07-28 11:53:05.315+05:30	2	31	127.0.0.1	\N
137	6	6	Sales person 6	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 4"], "region": ["None", "Arunachal Pradesh"], "name": ["None", "Sales person 6"], "updated": ["None", "2023-07-28"], "id": ["None", "6"], "zsm": ["None", "ZSM 3"], "created": ["None", "2023-07-28"], "zone": ["None", "North East Zone"]}	2023-07-28 11:53:15.928+05:30	2	31	127.0.0.1	\N
138	7	7	Sales person 7	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 5"], "region": ["None", "Jharkhand"], "name": ["None", "Sales person 7"], "updated": ["None", "2023-07-28"], "id": ["None", "7"], "zsm": ["None", "ZSM 3"], "created": ["None", "2023-07-28"], "zone": ["None", "North East Zone"]}	2023-07-28 11:53:28.041+05:30	2	31	127.0.0.1	\N
139	12	12	Sales Executive 10	0	{"zone": ["None", "North Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 4"], "name": ["None", "Sales Executive 10"], "region": ["None", "Awadh"], "created": ["None", "2023-07-28"], "id": ["None", "12"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:54:19.056+05:30	2	30	127.0.0.1	\N
140	13	13	Sales Executive 11	0	{"zone": ["None", "North Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 4"], "name": ["None", "Sales Executive 11"], "region": ["None", "Awadh"], "created": ["None", "2023-07-28"], "id": ["None", "13"], "rsm": ["None", "RSM 1"]}	2023-07-28 11:59:55.075+05:30	2	30	127.0.0.1	\N
141	14	14	Sales Executive 12	0	{"zone": ["None", "North Zone"], "updated": ["None", "2023-07-28"], "zsm": ["None", "ZSM 4"], "name": ["None", "Sales Executive 12"], "region": ["None", "Ladakh"], "created": ["None", "2023-07-28"], "id": ["None", "14"], "rsm": ["None", "RSM 2"]}	2023-07-28 12:00:06.152+05:30	2	30	127.0.0.1	\N
142	8	8	Sales person 7	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 10"], "region": ["None", "Awadh"], "name": ["None", "Sales person 7"], "updated": ["None", "2023-07-28"], "id": ["None", "8"], "zsm": ["None", "ZSM 4"], "created": ["None", "2023-07-28"], "zone": ["None", "North Zone"]}	2023-07-28 12:00:56.717+05:30	2	31	127.0.0.1	\N
143	9	9	Sales person 8	0	{"rsm": ["None", "RSM 2"], "asm": ["None", "Sales Executive 12"], "region": ["None", "Ladakh"], "name": ["None", "Sales person 8"], "updated": ["None", "2023-07-28"], "id": ["None", "9"], "zsm": ["None", "ZSM 4"], "created": ["None", "2023-07-28"], "zone": ["None", "North Zone"]}	2023-07-28 12:01:20.953+05:30	2	31	127.0.0.1	\N
144	10	10	Sales person 9	0	{"rsm": ["None", "RSM 2"], "asm": ["None", "Sales Executive 12"], "region": ["None", "Ladakh"], "name": ["None", "Sales person 9"], "updated": ["None", "2023-07-28"], "id": ["None", "10"], "zsm": ["None", "ZSM 4"], "created": ["None", "2023-07-28"], "zone": ["None", "North Zone"]}	2023-07-28 12:01:34.801+05:30	2	31	127.0.0.1	\N
145	11	11	Sales person 10	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 6"], "region": ["None", "Bangalore"], "name": ["None", "Sales person 10"], "updated": ["None", "2023-07-28"], "id": ["None", "11"], "zsm": ["None", "ZSM 5"], "created": ["None", "2023-07-28"], "zone": ["None", "South Zone"]}	2023-07-28 12:01:48.686+05:30	2	31	127.0.0.1	\N
146	12	12	Sales person 11	0	{"rsm": ["None", "RSM 2"], "asm": ["None", "Sales Executive 7"], "region": ["None", "Chennai"], "name": ["None", "Sales person 11"], "updated": ["None", "2023-07-28"], "id": ["None", "12"], "zsm": ["None", "ZSM 5"], "created": ["None", "2023-07-28"], "zone": ["None", "South Zone"]}	2023-07-28 12:02:00.29+05:30	2	31	127.0.0.1	\N
147	13	13	Sales person 13	0	{"rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 7"], "region": ["None", "Gujarat"], "name": ["None", "Sales person 13"], "updated": ["None", "2023-07-28"], "id": ["None", "13"], "zsm": ["None", "ZSM 6"], "created": ["None", "2023-07-28"], "zone": ["None", "West Zone"]}	2023-07-28 12:02:52.262+05:30	2	31	127.0.0.1	\N
148	14	14	Sales person 14	0	{"rsm": ["None", "RSM 2"], "asm": ["None", "Sales Executive 8"], "region": ["None", "Mumbai"], "name": ["None", "Sales person 14"], "updated": ["None", "2023-07-28"], "id": ["None", "14"], "zsm": ["None", "ZSM 6"], "created": ["None", "2023-07-28"], "zone": ["None", "West Zone"]}	2023-07-28 12:03:05.441+05:30	2	31	127.0.0.1	\N
149	1	1	Division 1	0	{"id": ["None", "1"], "name": ["None", "Division 1"], "updated": ["None", "2023-07-28"], "created": ["None", "2023-07-28"]}	2023-07-28 12:04:00.022+05:30	2	37	127.0.0.1	\N
150	2	2	Division 2	0	{"id": ["None", "2"], "name": ["None", "Division 2"], "updated": ["None", "2023-07-28"], "created": ["None", "2023-07-28"]}	2023-07-28 12:04:06.208+05:30	2	37	127.0.0.1	\N
151	1	1	Channel 1	0	{"id": ["None", "1"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"], "name": ["None", "Channel 1"]}	2023-07-28 12:04:18.951+05:30	2	32	127.0.0.1	\N
152	2	2	Channel 2	0	{"id": ["None", "2"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"], "name": ["None", "Channel 2"]}	2023-07-28 12:04:34.477+05:30	2	32	127.0.0.1	\N
153	1	1	Price Level 1	0	{"created": ["None", "2023-07-28"], "id": ["None", "1"], "name": ["None", "Price Level 1"], "updated": ["None", "2023-07-28"]}	2023-07-28 12:04:46.85+05:30	2	36	127.0.0.1	\N
154	2	2	Price Level	0	{"created": ["None", "2023-07-28"], "id": ["None", "2"], "name": ["None", "Price Level"], "updated": ["None", "2023-07-28"]}	2023-07-28 12:04:55.201+05:30	2	36	127.0.0.1	\N
155	3	3	10	0	{"created": ["None", "2023-07-28"], "id": ["None", "3"], "name": ["None", "10"], "updated": ["None", "2023-07-28"]}	2023-07-28 12:04:59.248+05:30	2	36	127.0.0.1	\N
156	2	2	Price Level 2	1	{"name": ["Price Level", "Price Level 2"]}	2023-07-28 12:08:21.207+05:30	2	36	127.0.0.1	\N
157	4	4	Test	0	{"id": ["None", "4"], "name": ["None", "Test"], "updated": ["None", "2023-07-28"], "created": ["None", "2023-07-28"]}	2023-07-28 12:08:34.301+05:30	2	36	127.0.0.1	\N
158	1	1	5%	1	{"name": ["Price Level 1", "5%"]}	2023-07-28 12:21:35.316+05:30	2	36	127.0.0.1	\N
159	3	3	10%	1	{"name": ["10", "10%"]}	2023-07-28 12:22:11.952+05:30	2	36	127.0.0.1	\N
160	2	2	15%	1	{"name": ["Price Level 2", "15%"]}	2023-07-28 12:22:18.608+05:30	2	36	127.0.0.1	\N
161	4	4	20%	1	{"name": ["Test", "20%"]}	2023-07-28 12:22:26.57+05:30	2	36	127.0.0.1	\N
162	1	1	Customer Name	0	{"maintain_bill_by_bill": ["None", "False"], "created": ["None", "2023-07-28"], "rso_buyer": ["None", "sales.Rso.None"], "country": ["None", "India"], "pi": ["None", "purchase.Purchase.None"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "se": ["None", "Sales person 1"], "city": ["None", "Vadodara"], "multiple_address_list": ["None", "False"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "is_transporter": ["None", "False"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "zsm": ["None", "ZSM 1"], "debitnote_seller": ["None", "purchase.DebitNote.None"], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "qdn_buyer": ["None", "sales.Qdn.None"], "gstin": ["None", ""], "region": ["None", "Chhattisgarh"], "addressline2": ["None", "Address Line2"], "mailing_name": ["None", "CUSTOMER NAME"], "pan_no": ["None", "AAPOS1478Q"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "name": ["None", "Customer Name"], "cn_buyer": ["None", "sales.CreditNote.None"], "addressline3": ["None", "Address Line3"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "email_id": ["None", "Demo@neti.com"], "allow_loose_packing": ["None", "True"], "cc_email": ["None", ""], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "ifsc_code": ["None", ""], "website": ["None", ""], "updated": ["None", "2023-07-28"], "asm": ["None", "Sales Executive 1"], "po": ["None", "purchase.Purchase_order.None"], "invoice_shipto": ["None", "sales.Invoice.None"], "contact_details": ["None", "False"], "bank": ["None", ""], "payment_terms": ["None", "30"], "vendor_code": ["None", "200001"], "id": ["None", "1"], "party_type": ["None", "Channel 1"], "override_credit_limit": ["None", "False"], "credit_limit": ["None", "300000"], "account_no": ["None", ""], "zone": ["None", "Central Zone"], "devision": ["None", "Division 1"], "account_name": ["None", ""], "check_credit_days": ["None", "True"], "invoice_buyer": ["None", "sales.Invoice.None"], "mobile_no": ["None", "7698552641"], "salesorder_shipto": ["None", "sales.Salesorder.None"], "grn": ["None", "purchase.Grn.None"], "price_level": ["None", ""], "pin_code": ["None", "390001"], "state": ["None", "Gujarat-1"], "istcsapplicable": ["None", "False"], "contact_person": ["None", "Contact Person"], "rsm": ["None", "RSM 1"], "dafault_credit_period": ["None", "30"], "gst_registration_type": ["None", "Consumer"], "addressline1": ["None", "Address Line1"], "group": ["None", "Sundry Debtors"]}	2023-07-28 12:26:49.27+05:30	2	39	127.0.0.1	\N
163	2	2	Customer Name 2	0	{"ifsc_code": ["None", ""], "po": ["None", "purchase.Purchase_order.None"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "credit_limit": ["None", "500000"], "pi": ["None", "purchase.Purchase.None"], "zone": ["None", "West Zone"], "account_no": ["None", ""], "debitnote_seller": ["None", "purchase.DebitNote.None"], "salesorder_shipto": ["None", "sales.Salesorder.None"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "id": ["None", "2"], "check_credit_days": ["None", "True"], "devision": ["None", "Division 2"], "account_name": ["None", ""], "party_type": ["None", "Channel 2"], "mobile_no": ["None", "7565412581"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "override_credit_limit": ["None", "False"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "pin_code": ["None", "493320"], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "invoice_buyer": ["None", "sales.Invoice.None"], "istcsapplicable": ["None", "False"], "country": ["None", "India"], "dafault_credit_period": ["None", "30"], "contact_person": ["None", "Contact Person 2"], "created": ["None", "2023-07-28"], "price_level": ["None", ""], "rsm": ["None", "RSM 1"], "maintain_bill_by_bill": ["None", "False"], "state": ["None", "Maharashtra"], "multiple_address_list": ["None", "False"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "se": ["None", "Sales person 13"], "city": ["None", "Mumbai"], "is_transporter": ["None", "False"], "mailing_name": ["None", "CUSTOMER NAME 2"], "name": ["None", "Customer Name 2"], "pan_no": ["None", "AAPOD1234Z"], "grn": ["None", "purchase.Grn.None"], "gst_registration_type": ["None", "Unknown"], "addressline1": ["None", "Address Line1"], "group": ["None", "Sundry Debtors"], "qdn_buyer": ["None", "sales.Qdn.None"], "gstin": ["None", "XXAAPOD1234Z"], "region": ["None", "Gujarat"], "addressline2": ["None", "Address Line1"], "email_id": ["None", "Email@neti.com"], "zsm": ["None", "ZSM 6"], "addressline3": ["None", "Address Line1"], "asm": ["None", "Sales Executive 7"], "website": ["None", ""], "allow_loose_packing": ["None", "True"], "invoice_shipto": ["None", "sales.Invoice.None"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "bank": ["None", ""], "rso_buyer": ["None", "sales.Rso.None"], "vendor_code": ["None", "200003"], "updated": ["None", "2023-07-28"], "contact_details": ["None", "False"], "payment_terms": ["None", "30"], "cc_email": ["None", ""], "cn_buyer": ["None", "sales.CreditNote.None"]}	2023-07-28 13:32:27.764+05:30	2	39	127.0.0.1	\N
164	1	1	ABC	1	{"name": ["ABCD", "ABC"]}	2023-07-28 13:41:19.364+05:30	2	8	127.0.0.1	\N
165	1	1	IB	0	{"dl_sales": ["None", "GST SALES A/C"], "id": ["None", "1"], "name": ["None", "IB"], "dl_purchase": ["None", "GST SALES A/C"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 13:41:51.998+05:30	2	16	127.0.0.1	\N
166	2	2	Product Type 1	0	{"dl_sales": ["None", "GST SALES A/C"], "id": ["None", "2"], "name": ["None", "Product Type 1"], "dl_purchase": ["None", "GST SALES A/C"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"]}	2023-07-28 13:42:02.3+05:30	2	16	127.0.0.1	\N
167	1	1	Neti	0	{"created": ["None", "2023-07-28"], "under": ["None", "Primary"], "code": ["None", "1122"], "id": ["None", "1"], "name": ["None", "Neti"], "updated": ["None", "2023-07-28"]}	2023-07-28 13:42:28.24+05:30	2	11	127.0.0.1	\N
168	1	1	Neti - Sub	0	{"id": ["None", "1"], "created": ["None", "2023-07-28"], "name": ["None", "Neti - Sub"], "updated": ["None", "2023-07-28"]}	2023-07-28 13:42:41.283+05:30	2	12	127.0.0.1	\N
169	1	1	IT	0	{"under": ["None", "Primary"], "id": ["None", "1"], "created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"], "name": ["None", "IT"]}	2023-07-28 13:42:53.571+05:30	2	13	127.0.0.1	\N
170	1	1	Class 1	0	{"updated": ["None", "2023-07-28"], "name": ["None", "Class 1"], "id": ["None", "1"], "created": ["None", "2023-07-28"]}	2023-07-28 13:43:11.346+05:30	2	14	127.0.0.1	\N
171	1	1	Sub Class 1	0	{"updated": ["None", "2023-07-28"], "id": ["None", "1"], "created": ["None", "2023-07-28"], "name": ["None", "Sub Class 1"]}	2023-07-28 13:43:20.729+05:30	2	15	127.0.0.1	\N
172	1	1	Godown1	0	{"name": ["None", "Godown1"], "created": ["None", "2023-07-28"], "godown_type": ["None", "True"], "id": ["None", "1"], "updated": ["None", "2023-07-28"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"]}	2023-07-28 13:43:43.557+05:30	2	10	127.0.0.1	\N
173	1	1	Godown1	1	{"parent": ["None", "Godown1"]}	2023-07-28 13:43:54.771+05:30	2	10	127.0.0.1	\N
174	1	1	Godown2	1	{"name": ["Godown1", "Godown2"]}	2023-07-28 13:44:08.808+05:30	2	10	127.0.0.1	\N
175	1	1	Godown1	1	{"name": ["Godown2", "Godown1"]}	2023-07-28 13:44:16.857+05:30	2	10	127.0.0.1	\N
176	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 13:49:55.865+05:30	2	10	127.0.0.1	\N
177	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 13:50:03.888+05:30	2	10	127.0.0.1	\N
178	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 13:56:31.942+05:30	2	10	127.0.0.1	\N
179	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 13:58:21.21+05:30	2	10	127.0.0.1	\N
180	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 13:58:38.577+05:30	2	10	127.0.0.1	\N
181	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 13:59:11.946+05:30	2	10	127.0.0.1	\N
182	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 14:00:10.121+05:30	2	10	127.0.0.1	\N
183	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 14:01:21.553+05:30	2	10	127.0.0.1	\N
184	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 14:15:15.456+05:30	2	10	127.0.0.1	\N
185	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 14:15:24.059+05:30	2	10	127.0.0.1	\N
186	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 14:39:51.004+05:30	2	10	127.0.0.1	\N
187	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 14:40:00.719+05:30	2	10	127.0.0.1	\N
188	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 14:44:16.543+05:30	2	10	127.0.0.1	\N
189	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 14:44:24.032+05:30	2	10	127.0.0.1	\N
190	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 14:53:38.557+05:30	2	10	127.0.0.1	\N
191	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 14:53:43.607+05:30	2	10	127.0.0.1	\N
192	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 15:00:35.652+05:30	2	10	127.0.0.1	\N
193	1	1	Godown1	1	{"godown_type": ["False", "True"]}	2023-07-28 15:01:41.405+05:30	2	10	127.0.0.1	\N
194	1	1	Godown1	1	{"godown_type": ["True", "False"]}	2023-07-28 15:01:44.727+05:30	2	10	127.0.0.1	\N
195	1	1	Vadodara	1	{"name": ["Godown1", "Vadodara"]}	2023-07-28 15:12:21.623+05:30	2	10	127.0.0.1	\N
196	2	2	Akota	0	{"id": ["None", "2"], "updated": ["None", "2023-07-28"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "name": ["None", "Akota"], "created": ["None", "2023-07-28"], "parent": ["None", "Vadodara"], "godown_type": ["None", "False"]}	2023-07-28 15:12:29.385+05:30	2	10	127.0.0.1	\N
197	1	1	Alkapuri	1	{"name": ["Vadodara", "Alkapuri"]}	2023-07-28 15:12:59.008+05:30	2	10	127.0.0.1	\N
198	3	3	New123	0	{"id": ["None", "3"], "updated": ["None", "2023-07-28"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "name": ["None", "New123"], "created": ["None", "2023-07-28"], "godown_type": ["None", "False"]}	2023-07-28 15:20:59.355+05:30	2	10	127.0.0.1	\N
199	3	3	New123	1	{"parent": ["None", "New123"]}	2023-07-28 15:22:06.99+05:30	2	10	127.0.0.1	\N
200	1	1	Demo	0	{"created": ["None", "2023-07-28"], "symbol": ["None", "Demo"], "id": ["None", "1"], "uqc": ["None", "BAG-BAGS"], "updated": ["None", "2023-07-28"], "adduom": ["None", "inventory.Product_master.None"], "name": ["None", "Demo"], "uom": ["None", "inventory.Product_master.None"], "decimal_places": ["None", "2"]}	2023-07-28 16:08:07.19+05:30	2	18	127.0.0.1	\N
201	1	1	Indian Rupees	0	{"created": ["None", "2023-07-28"], "updated": ["None", "2023-07-28"], "code": ["None", "001"], "symbol": ["None", "INR"], "id": ["None", "1"], "name": ["None", "Indian Rupees"]}	2023-07-28 16:09:14.973+05:30	2	23	127.0.0.1	\N
202	1	1	01	0	{"ins": ["None", "False"], "color_shade_theme": ["None", ""], "exp_date": ["None", "False"], "size": ["None", ""], "pricelist": ["None", "ledgers.Price_list.None"], "behaviour": ["None", "False"], "style_shape": ["None", ""], "imported_by": ["None", ""], "ipd": ["None", "False"], "gstdetail": ["None", "inventory.Gst_list.None"], "is_saleable": ["None", "False"], "mfd_by": ["None", ""], "outer_qty": ["None", "5"], "valuation_method": ["None", "1"], "country_of_origin": ["None", ""], "sub_class": ["None", "Sub Class 1"], "trs": ["None", "False"], "category": ["None", "IT"], "costing_method": ["None", "1"], "description": ["None", "Demo SKU "], "sub_brand": ["None", "Neti - Sub"], "updated": ["None", "2023-07-28"], "bill_of_material": ["None", "False"], "product_name": ["None", "Demo SKU"], "dl_purchase": ["None", "GST SALES A/C"], "id": ["None", "1"], "inner_qty": ["None", "10"], "created": ["None", "2023-07-28"], "consumableitem": ["None", "production.ConsItems.None"], "product_type": ["None", "IB"], "product_code": ["None", "01"], "jobwork": ["None", "production.JobCard.None"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "tpc": ["None", "False"], "set_std_rate": ["None", "False"], "jobcard": ["None", "planning.JobOrder.None"], "isgstapplicable": ["None", "True"], "gst": ["None", "0"], "series": ["None", ""], "purchase_qdn_item": ["None", "purchase.QdnItems.None"], "mkt_by": ["None", ""], "units_of_measure": ["None", "Demo"], "dl_sales": ["None", "GST SALES A/C"], "mrp": ["None", "0"], "pattern": ["None", ""], "ean_code": ["None", ""], "tsm": ["None", "False"], "product_class": ["None", "Class 1"], "sales_qdn_item": ["None", "sales.QdnItems.None"], "track_dom": ["None", "False"], "article_code": ["None", "5112210001"], "brand": ["None", "Neti"], "consumption_item": ["None", "production.ConsumptionItems.None"], "shape_code": ["None", ""], "is_batch": ["None", "False"]}	2023-07-28 16:10:00.456+05:30	2	20	127.0.0.1	\N
203	1	1	01	1	{"gst": ["0.00", "0"], "additional_units": ["None", "Demo"], "mrp": ["0.00", "0"], "inner_qty": ["10.00", "10"], "outer_qty": ["5.00", "5"]}	2023-07-28 16:10:00.467+05:30	2	20	127.0.0.1	\N
204	1	1	01	1	{"mrp": ["0.00", "100"]}	2023-07-28 16:16:59.925+05:30	2	20	127.0.0.1	\N
205	1	1	01	1	{"mrp": ["100.00", "100"]}	2023-07-28 16:17:03.502+05:30	2	20	127.0.0.1	\N
206	1	1	BOM Name	0	{"description": ["None", " Description"], "product": ["None", "01"], "created": ["None", "2023-07-28"], "jobcard": ["None", "planning.JobOrder.None"], "name": ["None", "BOM Name"], "id": ["None", "1"], "updated": ["None", "2023-07-28"]}	2023-07-28 16:18:00.301+05:30	2	42	127.0.0.1	\N
207	1	1	BOM Name	0	{"bom": ["None", "BOM Name"], "id": ["None", "1"], "qty": ["None", "100"], "item": ["None", "01"]}	2023-07-28 16:18:00.311+05:30	2	43	127.0.0.1	\N
208	1	1	Job Name	0	{"company": ["None", "ABC"], "remain_qty": ["None", "50.0000"], "issuedby": ["None", "admin"], "date": ["None", "2023-07-28 10:48:28.352018"], "jobwork": ["None", "production.JobCard.None"], "due_date": ["None", "2023-07-31"], "ref": ["None", ""], "updated": ["None", "2023-07-28 10:48:28.352285"], "product": ["None", "01"], "qty": ["None", "50.0000"], "no": ["None", "2223JO00001"], "remarks": ["None", "Special Instructions"], "status": ["None", "1"], "bom": ["None", "BOM Name"], "name": ["None", "Job Name"], "id": ["None", "1"], "created": ["None", "2023-07-28 10:48:28.352261"], "details": ["None", "Job Details"], "category": ["None", "Job Category"]}	2023-07-28 16:18:28.366+05:30	2	44	127.0.0.1	\N
209	1	1	2223JC00001	0	{"updated": ["None", "2023-07-28 10:50:59.841837"], "start": ["None", "2023-07-31"], "created": ["None", "2023-07-28 10:50:59.841815"], "company": ["None", "ABC"], "consumption": ["None", "production.Consumption.None"], "qty": ["None", "10"], "id": ["None", "1"], "rqty": ["None", "10"], "joborder": ["None", "Job Name"], "product": ["None", "01"], "status": ["None", "1"], "no": ["None", "2223JC00001"], "rmindent": ["None", "production.RMIndent.None"]}	2023-07-28 16:20:59.847+05:30	2	46	127.0.0.1	\N
210	1	1	2223JC00001	0	{"created": ["None", "2023-07-28 10:50:59.854221"], "company": ["None", "ABC"], "updated": ["None", "2023-07-28 10:50:59.854246"], "jobcard": ["None", "2223JC00001"], "no": ["None", "2223JC00001"], "status": ["None", "1"], "id": ["None", "1"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"]}	2023-07-28 16:20:59.86+05:30	2	47	127.0.0.1	\N
211	1	1	2223JC00001 01	0	{"bom": ["None", "BOM Name"], "rmindent": ["None", "2223JC00001"], "id": ["None", "1"], "qty": ["None", "1000.0000"], "item": ["None", "01"]}	2023-07-28 16:20:59.873+05:30	2	48	127.0.0.1	\N
212	1	1	Job Name	1	{"remain_qty": ["50.0000", "40.0000"], "status": ["1", "2"]}	2023-07-28 16:20:59.882+05:30	2	44	127.0.0.1	\N
213	1	1	2223JC00001	1	{"status": ["1", "2"]}	2023-07-28 16:21:09.058+05:30	2	47	127.0.0.1	\N
214	2	2	Production	1	{"name": ["Akota", "Production"]}	2023-07-28 16:22:33.612+05:30	2	10	127.0.0.1	\N
215	2	2	Production	1	{"parent": ["Alkapuri", "Production"]}	2023-07-28 16:22:44.737+05:30	2	10	127.0.0.1	\N
216	1	1	2223JC00001	1	{"status": ["2", "3"]}	2023-08-02 11:47:13.918+05:30	2	47	127.0.0.1	\N
217	2	2	2223JC00002	0	{"start": ["None", "2023-08-31"], "updated": ["None", "2023-08-02 06:21:49.535068"], "created": ["None", "2023-08-02 06:21:49.535042"], "joborder": ["None", "Job Name"], "no": ["None", "2223JC00002"], "consumption": ["None", "production.Consumption.None"], "company": ["None", "ABC"], "rqty": ["None", "1"], "id": ["None", "2"], "rmindent": ["None", "production.RMIndent.None"], "qty": ["None", "1"], "product": ["None", "01"], "status": ["None", "1"]}	2023-08-02 11:51:49.541+05:30	2	46	127.0.0.1	\N
218	2	2	2223JC00002	0	{"id": ["None", "2"], "updated": ["None", "2023-08-02 06:21:49.546178"], "no": ["None", "2223JC00002"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "jobcard": ["None", "2223JC00002"], "status": ["None", "1"], "company": ["None", "ABC"], "created": ["None", "2023-08-02 06:21:49.546139"]}	2023-08-02 11:51:49.551+05:30	2	47	127.0.0.1	\N
219	2	2	2223JC00002 01	0	{"id": ["None", "2"], "item": ["None", "01"], "qty": ["None", "100.0000"], "rmindent": ["None", "2223JC00002"], "bom": ["None", "BOM Name"]}	2023-08-02 11:51:49.562+05:30	2	48	127.0.0.1	\N
220	1	1	Job Name	1	{"remain_qty": ["40.0000", "39.0000"]}	2023-08-02 11:51:49.569+05:30	2	44	127.0.0.1	\N
221	2	2	2223JC00002	1	{"status": ["1", "2"]}	2023-08-02 11:51:58.162+05:30	2	47	127.0.0.1	\N
222	2	2	2223JC00002	1	{"status": ["2", "3"]}	2023-08-02 11:52:05.059+05:30	2	47	127.0.0.1	\N
223	4	4	New1231	0	{"id": ["None", "4"], "updated": ["None", "2023-08-02"], "name": ["None", "New1231"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "created": ["None", "2023-08-02"], "parent": ["None", "Production"], "godown_type": ["None", "True"]}	2023-08-02 11:54:16.888+05:30	2	10	127.0.0.1	\N
224	2	2	Production	1	{"godown_type": ["False", "True"]}	2023-08-02 11:55:13.894+05:30	2	10	127.0.0.1	\N
225	3	3	New123	1	{"godown_type": ["False", "True"]}	2023-08-02 11:55:17.977+05:30	2	10	127.0.0.1	\N
226	1	1	Demo SKU	0	{"updated": ["None", "2023-08-02"], "rate": ["None", "1"], "rate_type": ["None", "1"], "uom": ["None", "Demo"], "product": ["None", "01"], "created": ["None", "2023-08-02"], "id": ["None", "1"], "applicable_from": ["None", "2023-08-02"]}	2023-08-02 11:59:07.519+05:30	2	21	127.0.0.1	\N
227	3	3	IB	0	{"updated": ["None", "2023-08-02"], "name": ["None", "IB"], "id": ["None", "3"], "created": ["None", "2023-08-02"]}	2023-08-02 12:05:28.011+05:30	2	32	127.0.0.1	\N
228	3	3	Manual	0	{"updated": ["None", "2023-08-02"], "id": ["None", "3"], "name": ["None", "Manual"], "created": ["None", "2023-08-02"]}	2023-08-02 12:10:55.029+05:30	2	37	127.0.0.1	\N
229	5	5	Manual	0	{"created": ["None", "2023-08-02"], "id": ["None", "5"], "updated": ["None", "2023-08-02"], "name": ["None", "Manual"]}	2023-08-02 12:11:11.466+05:30	2	36	127.0.0.1	\N
230	3	3	Demo	0	{"account_no": ["None", ""], "salesorder_buyer": ["None", "sales.Salesorder.None"], "price_level": ["None", "Manual"], "pin_code": ["None", "392154"], "devision": ["None", "Division 1"], "country": ["None", "India"], "dafault_credit_period": ["None", "30"], "state": ["None", "Gujarat-1"], "gst_registration_type": ["None", "Regular"], "contact_person": ["None", "Demo"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "maintain_bill_by_bill": ["None", "True"], "created": ["None", "2023-08-02"], "multiple_address_list": ["None", "False"], "qdn_buyer": ["None", "sales.Qdn.None"], "name": ["None", "Demo"], "rso_buyer": ["None", "sales.Rso.None"], "is_transporter": ["None", "False"], "email_id": ["None", "Demo@neti.com"], "pan_no": ["None", "Demos1234D"], "addressline1": ["None", "Demo"], "group": ["None", "Sundry Creditors"], "city": ["None", "Ahmedabad"], "gstin": ["None", "XXDemos1234D"], "invoice_buyer": ["None", "sales.Invoice.None"], "invoice_shipto": ["None", "sales.Invoice.None"], "mailing_name": ["None", "Demo"], "cn_buyer": ["None", "sales.CreditNote.None"], "addressline3": ["None", "Demo"], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "allow_loose_packing": ["None", "True"], "istcsapplicable": ["None", "False"], "addressline2": ["None", "Demo"], "grn": ["None", "purchase.Grn.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "ifsc_code": ["None", ""], "salesorder_shipto": ["None", "sales.Salesorder.None"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "website": ["None", ""], "updated": ["None", "2023-08-02"], "po": ["None", "purchase.Purchase_order.None"], "pi": ["None", "purchase.Purchase.None"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "check_credit_days": ["None", "True"], "id": ["None", "3"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "account_name": ["None", ""], "party_type": ["None", "IB"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "bank": ["None", ""], "vendor_code": ["None", "400001"], "zone": ["None", "West Zone"], "mobile_no": ["None", "1236547897"], "override_credit_limit": ["None", "False"], "debitnote_seller": ["None", "purchase.DebitNote.None"]}	2023-08-02 12:11:15.845+05:30	2	39	127.0.0.1	\N
252	1	1	2223GRN00001	1	{"other": ["10.00", "0"], "sgst": ["0.25", "0.00"], "igst": ["0.50", "0.00"], "ex_rate": ["1.00", "1"], "ammount": ["0.00", "0"], "cgst": ["0.25", "0.00"], "round_off": ["-0.50", "0.00"], "total": ["10.00", "0"]}	2023-08-09 10:20:36.281+05:30	2	57	127.0.0.1	\N
231	4	4	ABC	0	{"account_no": ["None", ""], "salesorder_buyer": ["None", "sales.Salesorder.None"], "price_level": ["None", "Manual"], "pin_code": ["None", "392220"], "devision": ["None", "Manual"], "country": ["None", "India"], "dafault_credit_period": ["None", "30"], "state": ["None", "Maharashtra"], "gst_registration_type": ["None", "Regular"], "contact_person": ["None", "Vendor"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "maintain_bill_by_bill": ["None", "True"], "created": ["None", "2023-08-02"], "multiple_address_list": ["None", "False"], "qdn_buyer": ["None", "sales.Qdn.None"], "name": ["None", "ABC"], "rso_buyer": ["None", "sales.Rso.None"], "is_transporter": ["None", "False"], "email_id": ["None", "Vendor@domain.com"], "pan_no": ["None", "AAAAA0258A"], "addressline1": ["None", "ABC"], "group": ["None", "Sundry Creditors"], "city": ["None", "Pune"], "gstin": ["None", "AAAAAAA0258A"], "invoice_buyer": ["None", "sales.Invoice.None"], "invoice_shipto": ["None", "sales.Invoice.None"], "mailing_name": ["None", "ABC"], "cn_buyer": ["None", "sales.CreditNote.None"], "addressline3": ["None", "ABC"], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "allow_loose_packing": ["None", "True"], "istcsapplicable": ["None", "False"], "addressline2": ["None", "ABC"], "grn": ["None", "purchase.Grn.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "ifsc_code": ["None", ""], "salesorder_shipto": ["None", "sales.Salesorder.None"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "website": ["None", ""], "updated": ["None", "2023-08-02"], "po": ["None", "purchase.Purchase_order.None"], "pi": ["None", "purchase.Purchase.None"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "check_credit_days": ["None", "True"], "id": ["None", "4"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "account_name": ["None", ""], "party_type": ["None", "IB"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "bank": ["None", ""], "vendor_code": ["None", "400002"], "zone": ["None", "West Zone"], "mobile_no": ["None", "3216547892"], "override_credit_limit": ["None", "False"], "debitnote_seller": ["None", "purchase.DebitNote.None"]}	2023-08-02 12:15:54.509+05:30	2	39	127.0.0.1	\N
232	5	5	Cm3	0	{"account_no": ["None", ""], "salesorder_buyer": ["None", "sales.Salesorder.None"], "price_level": ["None", ""], "pin_code": ["None", "321456"], "devision": ["None", "Manual"], "rsm": ["None", "RSM 1"], "country": ["None", "England"], "dafault_credit_period": ["None", "30"], "state": ["None", "Amsterdam"], "gst_registration_type": ["None", "Consumer"], "contact_person": ["None", "Cm3"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "maintain_bill_by_bill": ["None", "False"], "created": ["None", "2023-08-02"], "multiple_address_list": ["None", "False"], "qdn_buyer": ["None", "sales.Qdn.None"], "se": ["None", "Sales person 7"], "name": ["None", "Cm3"], "rso_buyer": ["None", "sales.Rso.None"], "is_transporter": ["None", "False"], "email_id": ["None", "Cm3@g.com"], "zsm": ["None", "ZSM 3"], "pan_no": ["None", "asdsas1a"], "addressline1": ["None", "Cm3"], "group": ["None", "Sundry Debtors"], "city": ["None", "Amsterdam"], "gstin": ["None", "asdsasda152ad"], "region": ["None", "Jharkhand"], "invoice_buyer": ["None", "sales.Invoice.None"], "invoice_shipto": ["None", "sales.Invoice.None"], "mailing_name": ["None", "CM3"], "cn_buyer": ["None", "sales.CreditNote.None"], "addressline3": ["None", "Cm3"], "asm": ["None", "Sales Executive 5"], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "allow_loose_packing": ["None", "True"], "istcsapplicable": ["None", "False"], "payment_terms": ["None", "30"], "addressline2": ["None", "Cm3"], "grn": ["None", "purchase.Grn.None"], "contact_details": ["None", "False"], "cc_email": ["None", ""], "ifsc_code": ["None", ""], "salesorder_shipto": ["None", "sales.Salesorder.None"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "website": ["None", ""], "updated": ["None", "2023-08-02"], "po": ["None", "purchase.Purchase_order.None"], "pi": ["None", "purchase.Purchase.None"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "check_credit_days": ["None", "True"], "id": ["None", "5"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "account_name": ["None", ""], "party_type": ["None", "Channel 2"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "bank": ["None", ""], "credit_limit": ["None", "500000"], "vendor_code": ["None", "200004"], "zone": ["None", "North East Zone"], "mobile_no": ["None", "3652147895"], "override_credit_limit": ["None", "False"], "debitnote_seller": ["None", "purchase.DebitNote.None"]}	2023-08-02 12:22:41.869+05:30	2	39	127.0.0.1	\N
233	1	1	2223PO00001	0	{"shipto_state": ["None", "GUJARAT"], "other": ["None", "0"], "grn": ["None", "purchase.Grn.None"], "seller_address1": ["None", "ABC"], "seller_country": ["None", "India"], "seller_pincode": ["None", "392220"], "shipto_address2": ["None", "ABCD"], "total": ["None", "0"], "shipto_address1": ["None", "ABCD"], "shipto_pincode": ["None", "391775"], "seller_address3": ["None", "ABC"], "updated": ["None", "2023-08-02 06:54:10.275354"], "narration": ["None", ""], "seller_state": ["None", "Maharashtra"], "shipto_city": ["None", "VADODARA"], "ex_rate": ["None", "1"], "sgst": ["None", "0"], "seller_address_type": ["None", "Default"], "ol_rate": ["None", "5"], "other_reference": ["None", ""], "round_off": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "created": ["None", "2023-08-02 06:54:10.275328"], "shipto_address3": ["None", "ABCD"], "ammount": ["None", "0"], "id": ["None", "1"], "shipto_country": ["None", "INDIA"], "currency": ["None", "001"], "po_date": ["None", "2023-08-02"], "seller_address2": ["None", "ABC"], "seller_gst_reg_type": ["None", "Regular"], "cgst": ["None", "0"], "seller_gstin": ["None", "AAAAAAA0258A"], "shipto_address_type": ["None", "Default"], "po_due_date": ["None", "2023-08-31"], "dispatch_through": ["None", ""], "seller": ["None", "ABC"], "mode_of_payment": ["None", ""], "tcs": ["None", "0"], "status": ["None", "1"], "terms_of_delivery": ["None", ""], "company": ["None", "ABC"], "seller_city": ["None", "Pune"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "shipto": ["None", "ABC"], "igst": ["None", "0"], "po_no": ["None", "2223PO00001"]}	2023-08-02 12:24:10.283+05:30	2	54	127.0.0.1	\N
234	1	1	2223PO00001	0	{"id": ["None", "1"], "basic_qty": ["None", "10"], "sgstrate": ["None", "0"], "item": ["None", "01"], "sgst": ["None", "0.00"], "cgstrate": ["None", "0"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "rate": ["None", "1"], "cgst": ["None", "0.00"], "amount": ["None", "10.00"], "po": ["None", "2223PO00001"], "product_code": ["None", "01"], "amend_qty": ["None", "0"], "pack": ["None", "5.00"], "actual_qty": ["None", "10"]}	2023-08-02 12:24:10.295+05:30	2	55	127.0.0.1	\N
235	1	1	2223PO00001	1	{"other": ["0.00", "10"], "total": ["0.00", "20"], "ex_rate": ["1.00", "1"], "sgst": ["0.00", "0"], "ol_rate": ["5.00", "5"], "ammount": ["0.00", "10.00"], "cgst": ["0.00", "0"], "igst": ["0.00", "0"]}	2023-08-02 12:24:10.303+05:30	2	54	127.0.0.1	\N
236	1	1	Price_list object (1)	0	{"product": ["None", "01"], "id": ["None", "1"], "created": ["None", "2023-08-02"], "price_level": ["None", "Manual"], "updated": ["None", "2023-08-02"], "applicable_from": ["None", "2023-08-02"], "rate": ["None", "1"]}	2023-08-02 13:35:15.992+05:30	2	38	127.0.0.1	\N
237	1	1	2223GRN00001	0	{"id": ["None", "1"], "updated": ["None", "2023-08-09 04:45:52.855400"], "seller_address1": ["None", "ABC"], "currency": ["None", "001"], "tcs": ["None", "0"], "seller_address2": ["None", "ABC"], "mode_of_payment": ["None", ""], "shipto_address1": ["None", "ABCD"], "po": ["None", "2223PO00001"], "shipto_address3": ["None", "ABCD"], "other": ["None", "0"], "grn_no": ["None", "2223GRN00001"], "seller_pincode": ["None", "392220"], "status": ["None", "1"], "seller_country": ["None", "India"], "seller_city": ["None", "Pune"], "shipto_mailingname": ["None", "ABCD"], "shipto_city": ["None", "VADODARA"], "sgst": ["None", "0"], "seller_mailingname": ["None", "ABC"], "created": ["None", "2023-08-09 04:45:52.855377"], "igst": ["None", "0"], "shipto_address_type": ["None", "Default"], "shipto_address2": ["None", "ABCD"], "seller_address_type": ["None", "Default"], "seller_gst_reg_type": ["None", "Regular"], "ex_rate": ["None", "100"], "seller_state": ["None", "Maharashtra"], "shipto_state": ["None", "GUJARAT"], "company": ["None", "ABC"], "other_reference": ["None", ""], "terms_of_delivery": ["None", ""], "shipto_country": ["None", "INDIA"], "ammount": ["None", "0"], "cgst": ["None", "0"], "dispatch_through": ["None", "1"], "seller_address3": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "grn_date": ["None", "2023-08-09"], "seller_gstin": ["None", "AAAAAAA0258A"], "round_off": ["None", "0"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "total": ["None", "0"], "seller": ["None", "ABC"], "shipto": ["None", "ABC"], "narration": ["None", ""]}	2023-08-09 10:15:52.864+05:30	2	57	127.0.0.1	\N
238	1	1	2223PO00001	1	{"status": ["1", "4"]}	2023-08-09 10:17:21.861+05:30	2	54	127.0.0.1	\N
239	1	1	2223GRN00001	1	{"other": ["0.00", "0"], "ex_rate": ["100.00", "1"], "ammount": ["0.00", "0"], "total": ["0.00", "0"]}	2023-08-09 10:17:21.879+05:30	2	57	127.0.0.1	\N
240	1	1	2223GRN00001	1	{"other": ["0.00", "10"], "sgst": ["0.00", "0.25"], "igst": ["0.00", "0.50"], "ex_rate": ["1.00", "1"], "ammount": ["0.00", "0"], "cgst": ["0.00", "0.25"], "round_off": ["0.00", "-0.50"], "total": ["0.00", "10"]}	2023-08-09 10:17:40.218+05:30	2	57	127.0.0.1	\N
253	1	1	Price_list object (1)	1	{"rate": ["1.00", "100"], "applicable_from": ["2023-08-02", "2023-08-09"]}	2023-08-09 10:22:36.356+05:30	2	38	127.0.0.1	\N
254	1	1	2223GRN00001	1	{"other": ["0.00", "100"], "sgst": ["0.00", "2.50"], "igst": ["0.00", "5.00"], "ex_rate": ["1.00", "1"], "ammount": ["0.00", "0"], "cgst": ["0.00", "2.50"], "total": ["0.00", "105"]}	2023-08-09 14:02:11.03+05:30	2	57	127.0.0.1	\N
304	6	6	Primary	0	{"created": ["None", "2023-09-05"], "parent": ["None", "Alkapuri"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "updated": ["None", "2023-09-05"], "godown_type": ["None", "False"], "name": ["None", "Primary"], "id": ["None", "6"]}	2023-09-05 16:56:05.754+05:30	2	10	127.0.0.1	\N
305	5	5	UN ALLOCATED	1	{"parent": ["None", "Primary"]}	2023-09-05 16:56:11.657+05:30	2	10	127.0.0.1	\N
241	1	1	2223PINV00001	0	{"ex_rate": ["None", "1.00"], "is_ict": ["None", "False"], "currency": ["None", "001"], "shipto_address3": ["None", "ABCD"], "seller_country": ["None", "India"], "narration": ["None", ""], "shipto_pincode": ["None", "391775"], "seller_state": ["None", "Maharashtra"], "shipto_state": ["None", "GUJARAT"], "seller_city": ["None", "Pune"], "cgst": ["None", "0"], "seller_address3": ["None", "ABC"], "shipto_city": ["None", "VADODARA"], "id": ["None", "1"], "status": ["None", "1"], "seller_mailingname": ["None", "ABC"], "seller": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "total": ["None", "0"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "ABCD"], "mode_of_payment": ["None", ""], "seller_gst_reg_type": ["None", "Regular"], "supplier_date": ["None", "2023-08-09"], "shipto": ["None", "ABC"], "tcs": ["None", "0"], "igst": ["None", "0"], "shipto_country": ["None", "INDIA"], "terms_of_delivery": ["None", ""], "dispatch_through": ["None", "1"], "other": ["None", "0"], "pi_no": ["None", "2223PINV00001"], "ammount": ["None", "0"], "pi_date": ["None", "2023-08-09"], "seller_gstin": ["None", "AAAAAAA0258A"], "seller_pincode": ["None", "392220"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "supplier_invoice": ["None", "111"], "grn": ["None", "purchase.Grn.None"], "seller_address_type": ["None", "Default"], "seller_address1": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "sgst": ["None", "0"], "created": ["None", "2023-08-09 04:48:34.537171"], "updated": ["None", "2023-08-09 04:48:34.537192"], "seller_address2": ["None", "ABC"], "round_off": ["None", "0"], "shipto_address2": ["None", "ABCD"], "company": ["None", "ABC"]}	2023-08-09 10:18:34.544+05:30	2	56	127.0.0.1	\N
242	1	1	2223GRN00001	1	{"status": ["1", "3"], "pi": ["None", "2223PINV00001"]}	2023-08-09 10:18:34.553+05:30	2	57	127.0.0.1	\N
243	1	1	2223PO00001	1	{"status": ["4", "5"]}	2023-08-09 10:18:34.569+05:30	2	54	127.0.0.1	\N
244	1	1	2223PINV00001	1	{"cgst": ["0.00", "0"], "total": ["0.00", "10"], "ol_rate": ["0.00", "0"], "igst": ["0.00", "0"], "other": ["0.00", "10.00"], "ammount": ["0.00", "0"], "sgst": ["0.00", "0"]}	2023-08-09 10:18:34.582+05:30	2	56	127.0.0.1	\N
245	1	1	2223DB00001	0	{"shipto": ["None", "ABC"], "ol_rate": ["None", "0"], "seller_state": ["None", "Maharashtra"], "shipto_state": ["None", "GUJARAT"], "currency": ["None", "INR"], "shipto_country": ["None", "INDIA"], "seller_country": ["None", "India"], "total": ["None", "0"], "shipto_mailingname": ["None", "ABCD"], "dispatch_through": ["None", "1"], "cgst": ["None", "0"], "seller_city": ["None", "Pune"], "db_date": ["None", "2023-08-09"], "seller_gstin": ["None", "AAAAAAA0258A"], "terms_of_delivery": ["None", ""], "round_off": ["None", "0"], "company": ["None", "ABC"], "shipto_pan_no": ["None", ""], "igst": ["None", "0"], "seller_address_type": ["None", "Default"], "seller_address1": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "mode_of_payment": ["None", ""], "tcs": ["None", "0"], "updated": ["None", "2023-08-09 04:48:49.366036"], "seller": ["None", "ABC"], "seller_address2": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "pi_no": ["None", "2223PINV00001"], "seller_address3": ["None", "ABC"], "id": ["None", "1"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "shipto_address3": ["None", "ABCD"], "ammount": ["None", "0"], "db_no": ["None", "2223DB00001"], "seller_pincode": ["None", "392220"], "ex_rate": ["None", "1"], "sgst": ["None", "0"], "status": ["None", "1"], "shipto_city": ["None", "VADODARA"], "created": ["None", "2023-08-09 04:48:49.366015"], "seller_mailingname": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "narration": ["None", ""], "shipto_address1": ["None", "ABCD"], "seller_gst_reg_type": ["None", "Regular"]}	2023-08-09 10:18:49.374+05:30	2	60	127.0.0.1	\N
246	1	1	2223DB00001	1	{"ol_rate": ["0.00", "0"], "total": ["0.00", "0"], "cgst": ["0.00", "0"], "round_off": ["0.00", "0"], "igst": ["0.00", "0"], "tcs": ["0.00", "0"], "ammount": ["0.00", "0"], "ex_rate": ["1.00", "1"], "sgst": ["0.00", "0"]}	2023-08-09 10:18:49.382+05:30	2	60	127.0.0.1	\N
247	1	1	2223PQ00001	0	{"seller_pincode": ["None", "392220"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "created": ["None", "2023-08-09 04:49:07.216106"], "seller": ["None", "ABC"], "shipto_pan_no": ["None", ""], "ol_rate": ["None", "0"], "pi_no": ["None", "2223PINV00001"], "sgst": ["None", "0"], "company": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_address3": ["None", "ABC"], "cgst": ["None", "0"], "seller_state": ["None", "Maharashtra"], "seller_address2": ["None", "ABC"], "shipto_city": ["None", "VADODARA"], "seller_mailingname": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "igst": ["None", "0"], "shipto_state": ["None", "GUJARAT"], "id": ["None", "1"], "seller_city": ["None", "Pune"], "status": ["None", "1"], "dispatch_through": ["None", "1"], "shipto_address1": ["None", "ABCD"], "seller_gst_reg_type": ["None", "Regular"], "narration": ["None", ""], "total": ["None", "0"], "shipto_mailingname": ["None", "ABCD"], "seller_address_type": ["None", "Default"], "mode_of_payment": ["None", ""], "ammount": ["None", "0"], "shipto_address_type": ["None", "Default"], "round_off": ["None", "0"], "qdn_date": ["None", "2023-08-09"], "seller_gstin": ["None", "AAAAAAA0258A"], "shipto_country": ["None", "INDIA"], "seller_country": ["None", "India"], "terms_of_delivery": ["None", ""], "updated": ["None", "2023-08-09 04:49:07.216128"], "shipto_address3": ["None", "ABCD"], "qdn_no": ["None", "2223PQ00001"], "seller_address1": ["None", "ABC"], "tcs": ["None", "0"], "shipto": ["None", "ABC"]}	2023-08-09 10:19:07.224+05:30	2	62	127.0.0.1	\N
248	1	1	2223PQ00001	1	{"ol_rate": ["0.00", "0"], "sgst": ["0.00", "0"], "cgst": ["0.00", "0"], "igst": ["0.00", "0"], "total": ["0.00", "10"], "ammount": ["0.00", "0"], "round_off": ["0.00", "0"], "tcs": ["0.00", "0"]}	2023-08-09 10:19:07.233+05:30	2	62	127.0.0.1	\N
249	1	1	2223PR00001	0	{"seller": ["None", "ABC"], "seller_gstin": ["None", "AAAAAAA0258A"], "shipto_pan_no": ["None", ""], "mode_of_payment": ["None", ""], "round_off": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "shipto_country": ["None", "INDIA"], "tcs": ["None", "0"], "shipto": ["None", "ABC"], "company": ["None", "ABC"], "pi_no": ["None", "2223PINV00001"], "seller_address3": ["None", "ABC"], "seller_pincode": ["None", "392220"], "ammount": ["None", "0"], "seller_address2": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "pr_no": ["None", "2223PR00001"], "sgst": ["None", "0"], "shipto_pincode": ["None", "391775"], "igst": ["None", "0"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller_city": ["None", "Pune"], "id": ["None", "1"], "seller_country": ["None", "India"], "created": ["None", "2023-08-09 04:49:24.449531"], "narration": ["None", ""], "ol_rate": ["None", "5"], "seller_address1": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "updated": ["None", "2023-08-09 04:49:24.449554"], "seller_address_type": ["None", "Default"], "seller_mailingname": ["None", "ABC"], "shipto_address1": ["None", "ABCD"], "shipto_address2": ["None", "ABCD"], "cgst": ["None", "0"], "shipto_address_type": ["None", "Default"], "seller_state": ["None", "Maharashtra"], "terms_of_delivery": ["None", ""], "shipto_city": ["None", "VADODARA"], "dispatch_through": ["None", "1"], "total": ["None", "0"], "shipto_state": ["None", "GUJARAT"], "status": ["None", "1"], "pr_date": ["None", "2023-08-09"]}	2023-08-09 10:19:24.457+05:30	2	64	127.0.0.1	\N
250	1	1	2223PR00001	1	{"round_off": ["0.00", "0.5"], "tcs": ["0.00", "0"], "ammount": ["0.00", "0"], "sgst": ["0.00", "0.5"], "igst": ["0.00", "0.5"], "ol_rate": ["5.00", "5"], "cgst": ["0.00", "0.5"], "total": ["0.00", "11"]}	2023-08-09 10:19:24.466+05:30	2	64	127.0.0.1	\N
255	2	2	raw1	0	{"ean_code": ["None", "EAB123"], "style_shape": ["None", "34"], "imported_by": ["None", "34"], "ipd": ["None", "False"], "gst": ["None", "0"], "pricelist": ["None", "ledgers.Price_list.None"], "brand": ["None", "Neti"], "consumption_item": ["None", "production.ConsumptionItems.None"], "outer_qty": ["None", "1"], "sub_class": ["None", "Sub Class 1"], "ins": ["None", "False"], "product_class": ["None", "Class 1"], "color_shade_theme": ["None", "234"], "exp_date": ["None", "False"], "category": ["None", "IT"], "trs": ["None", "False"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "size": ["None", "123"], "costing_method": ["None", "1"], "bill_of_material": ["None", "False"], "product_name": ["None", "RAW1"], "shape_code": ["None", "123"], "inner_qty": ["None", "12"], "sales_qdn_item": ["None", "sales.QdnItems.None"], "product_type": ["None", "Product Type 1"], "jobwork": ["None", "production.JobCard.None"], "tpc": ["None", "False"], "isgstapplicable": ["None", "True"], "sub_brand": ["None", "Neti - Sub"], "behaviour": ["None", "False"], "purchase_qdn_item": ["None", "purchase.QdnItems.None"], "updated": ["None", "2023-09-05"], "mkt_by": ["None", "Sk"], "jobcard": ["None", "planning.JobOrder.None"], "id": ["None", "2"], "created": ["None", "2023-09-05"], "pattern": ["None", "56"], "mfd_by": ["None", "435"], "valuation_method": ["None", "1"], "tsm": ["None", "False"], "country_of_origin": ["None", "34"], "consumableitem": ["None", "production.ConsItems.None"], "product_code": ["None", "raw1"], "set_std_rate": ["None", "False"], "series": ["None", "45"], "track_dom": ["None", "False"], "article_code": ["None", "5112210002"], "description": ["None", "raw material"], "gstdetail": ["None", "inventory.Gst_list.None"], "dl_purchase": ["None", "GST SALES A/C"], "is_saleable": ["None", "False"], "units_of_measure": ["None", "Demo"], "dl_sales": ["None", "GST SALES A/C"], "mrp": ["None", "345"], "is_batch": ["None", "False"]}	2023-09-05 16:31:18.829+05:30	2	20	127.0.0.1	\N
256	2	2	raw1	1	{"gst": ["0.00", "0"], "additional_units": ["None", "Demo"], "inner_qty": ["12.00", "12"], "mrp": ["345.00", "345"], "outer_qty": ["1.00", "1"]}	2023-09-05 16:31:18.841+05:30	2	20	127.0.0.1	\N
257	3	3	raw2	0	{"ean_code": ["None", "EAZN12"], "style_shape": ["None", ""], "imported_by": ["None", ""], "ipd": ["None", "False"], "gst": ["None", "0"], "pricelist": ["None", "ledgers.Price_list.None"], "brand": ["None", "Neti"], "consumption_item": ["None", "production.ConsumptionItems.None"], "outer_qty": ["None", "123"], "sub_class": ["None", "Sub Class 1"], "ins": ["None", "False"], "product_class": ["None", "Class 1"], "color_shade_theme": ["None", ""], "exp_date": ["None", "False"], "category": ["None", "IT"], "trs": ["None", "False"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "size": ["None", ""], "costing_method": ["None", "1"], "bill_of_material": ["None", "False"], "product_name": ["None", "RAW2"], "shape_code": ["None", ""], "inner_qty": ["None", "123"], "sales_qdn_item": ["None", "sales.QdnItems.None"], "product_type": ["None", "Product Type 1"], "jobwork": ["None", "production.JobCard.None"], "tpc": ["None", "False"], "isgstapplicable": ["None", "True"], "sub_brand": ["None", "Neti - Sub"], "behaviour": ["None", "False"], "purchase_qdn_item": ["None", "purchase.QdnItems.None"], "updated": ["None", "2023-09-05"], "mkt_by": ["None", ""], "jobcard": ["None", "planning.JobOrder.None"], "id": ["None", "3"], "created": ["None", "2023-09-05"], "pattern": ["None", ""], "mfd_by": ["None", ""], "valuation_method": ["None", "1"], "tsm": ["None", "False"], "country_of_origin": ["None", ""], "consumableitem": ["None", "production.ConsItems.None"], "product_code": ["None", "raw2"], "set_std_rate": ["None", "False"], "series": ["None", ""], "track_dom": ["None", "False"], "article_code": ["None", "5112210003"], "description": ["None", "asdsad"], "gstdetail": ["None", "inventory.Gst_list.None"], "dl_purchase": ["None", "GST SALES A/C"], "is_saleable": ["None", "False"], "units_of_measure": ["None", "Demo"], "dl_sales": ["None", "GST SALES A/C"], "mrp": ["None", "0"], "is_batch": ["None", "False"]}	2023-09-05 16:32:21.72+05:30	2	20	127.0.0.1	\N
258	1	1	BOM Name	2	{"item": ["01", "None"], "qty": ["100.0000", "None"], "id": ["1", "None"], "bom": ["BOM Name", "None"]}	2023-09-05 16:33:14.203+05:30	2	43	127.0.0.1	\N
259	2	2	BOM Name	0	{"item": ["None", "raw1"], "qty": ["None", "10"], "id": ["None", "2"], "bom": ["None", "BOM Name"]}	2023-09-05 16:33:14.21+05:30	2	43	127.0.0.1	\N
260	3	3	BOM Name	0	{"item": ["None", "raw2"], "qty": ["None", "20"], "id": ["None", "3"], "bom": ["None", "BOM Name"]}	2023-09-05 16:33:14.221+05:30	2	43	127.0.0.1	\N
261	1	1	FG1	1	{"product_code": ["01", "FG1"], "description": ["Demo SKU ", "Finished Good"], "product_name": ["Demo SKU", "Finished Good"]}	2023-09-05 16:33:48.236+05:30	2	20	127.0.0.1	\N
262	1	1	BOM FG1	1	{"name": ["BOM Name", "BOM FG1"]}	2023-09-05 16:34:48.72+05:30	2	42	127.0.0.1	\N
263	3	3	BOM FG1	2	{"item": ["raw2", "None"], "qty": ["20.0000", "None"], "id": ["3", "None"], "bom": ["BOM FG1", "None"]}	2023-09-05 16:34:48.733+05:30	2	43	127.0.0.1	\N
264	2	2	BOM FG1	2	{"item": ["raw1", "None"], "qty": ["10.0000", "None"], "id": ["2", "None"], "bom": ["BOM FG1", "None"]}	2023-09-05 16:34:48.734+05:30	2	43	127.0.0.1	\N
265	4	4	BOM FG1	0	{"item": ["None", "raw1"], "qty": ["None", "10.0000"], "id": ["None", "4"], "bom": ["None", "BOM FG1"]}	2023-09-05 16:34:48.741+05:30	2	43	127.0.0.1	\N
266	5	5	BOM FG1	0	{"item": ["None", "raw2"], "qty": ["None", "20.0000"], "id": ["None", "5"], "bom": ["None", "BOM FG1"]}	2023-09-05 16:34:48.75+05:30	2	43	127.0.0.1	\N
267	2	2	job fg1	0	{"product": ["None", "FG1"], "ref": ["None", ""], "updated": ["None", "2023-09-05 11:06:16.296189"], "qty": ["None", "10"], "jobwork": ["None", "production.JobCard.None"], "remarks": ["None", "fg1"], "no": ["None", "2223JO00002"], "name": ["None", "job fg1"], "status": ["None", "1"], "bom": ["None", "BOM FG1"], "created": ["None", "2023-09-05 11:06:16.296167"], "details": ["None", "job fg1"], "id": ["None", "2"], "category": ["None", "fg1"], "company": ["None", "ABC"], "issuedby": ["None", "admin"], "remain_qty": ["None", "10"], "date": ["None", "2023-09-05 11:06:16.295931"], "due_date": ["None", "2023-09-12"]}	2023-09-05 16:36:16.303+05:30	2	44	127.0.0.1	\N
268	3	3	2223JC00003	0	{"rqty": ["None", "10"], "created": ["None", "2023-09-05 11:07:05.477710"], "id": ["None", "3"], "consumption": ["None", "production.Consumption.None"], "start": ["None", "2023-09-05"], "product": ["None", "FG1"], "company": ["None", "ABC"], "qty": ["None", "10"], "updated": ["None", "2023-09-05 11:07:05.477734"], "no": ["None", "2223JC00003"], "status": ["None", "1"], "rmindent": ["None", "production.RMIndent.None"], "joborder": ["None", "job fg1"]}	2023-09-05 16:37:05.485+05:30	2	46	127.0.0.1	\N
269	3	3	2223JC00003	0	{"no": ["None", "2223JC00003"], "jobcard": ["None", "2223JC00003"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "updated": ["None", "2023-09-05 11:07:05.490659"], "id": ["None", "3"], "status": ["None", "1"], "company": ["None", "ABC"], "created": ["None", "2023-09-05 11:07:05.490634"]}	2023-09-05 16:37:05.495+05:30	2	47	127.0.0.1	\N
270	3	3	2223JC00003 raw1	0	{"qty": ["None", "100.0000"], "rmindent": ["None", "2223JC00003"], "bom": ["None", "BOM FG1"], "id": ["None", "3"], "item": ["None", "raw1"]}	2023-09-05 16:37:05.506+05:30	2	48	127.0.0.1	\N
271	4	4	2223JC00003 raw2	0	{"qty": ["None", "200.0000"], "rmindent": ["None", "2223JC00003"], "bom": ["None", "BOM FG1"], "id": ["None", "4"], "item": ["None", "raw2"]}	2023-09-05 16:37:05.519+05:30	2	48	127.0.0.1	\N
272	2	2	job fg1	1	{"status": ["1", "3"], "remain_qty": ["10.0000", "0.0000"]}	2023-09-05 16:37:05.525+05:30	2	44	127.0.0.1	\N
273	3	3	2223JC00003	1	{"status": ["1", "4"]}	2023-09-05 16:37:05.539+05:30	2	46	127.0.0.1	\N
274	3	3	job 2	0	{"product": ["None", "FG1"], "ref": ["None", ""], "updated": ["None", "2023-09-05 11:08:24.960382"], "qty": ["None", "10"], "jobwork": ["None", "production.JobCard.None"], "remarks": ["None", "sad"], "no": ["None", "2223JO00003"], "name": ["None", "job 2"], "status": ["None", "1"], "bom": ["None", "BOM FG1"], "created": ["None", "2023-09-05 11:08:24.960359"], "details": ["None", "job 1"], "id": ["None", "3"], "category": ["None", "job"], "company": ["None", "ABC"], "issuedby": ["None", "admin"], "remain_qty": ["None", "10"], "date": ["None", "2023-09-05 11:08:24.960163"], "due_date": ["None", "2023-09-09"]}	2023-09-05 16:38:24.966+05:30	2	44	127.0.0.1	\N
275	4	4	2223JC00004	0	{"rqty": ["None", "10"], "created": ["None", "2023-09-05 11:11:42.863996"], "id": ["None", "4"], "consumption": ["None", "production.Consumption.None"], "start": ["None", "2023-09-01"], "product": ["None", "FG1"], "company": ["None", "ABC"], "qty": ["None", "10"], "updated": ["None", "2023-09-05 11:11:42.864020"], "no": ["None", "2223JC00004"], "status": ["None", "1"], "rmindent": ["None", "production.RMIndent.None"], "joborder": ["None", "job 2"]}	2023-09-05 16:41:42.871+05:30	2	46	127.0.0.1	\N
276	4	4	2223JC00004	0	{"no": ["None", "2223JC00004"], "jobcard": ["None", "2223JC00004"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "updated": ["None", "2023-09-05 11:11:42.876274"], "id": ["None", "4"], "status": ["None", "1"], "company": ["None", "ABC"], "created": ["None", "2023-09-05 11:11:42.876251"]}	2023-09-05 16:41:42.88+05:30	2	47	127.0.0.1	\N
277	5	5	2223JC00004 raw1	0	{"qty": ["None", "100.0000"], "rmindent": ["None", "2223JC00004"], "bom": ["None", "BOM FG1"], "id": ["None", "5"], "item": ["None", "raw1"]}	2023-09-05 16:41:42.892+05:30	2	48	127.0.0.1	\N
278	6	6	2223JC00004 raw2	0	{"qty": ["None", "200.0000"], "rmindent": ["None", "2223JC00004"], "bom": ["None", "BOM FG1"], "id": ["None", "6"], "item": ["None", "raw2"]}	2023-09-05 16:41:42.905+05:30	2	48	127.0.0.1	\N
279	3	3	job 2	1	{"status": ["1", "3"], "remain_qty": ["10.0000", "0.0000"]}	2023-09-05 16:41:42.912+05:30	2	44	127.0.0.1	\N
280	4	4	2223JC00004	1	{"status": ["1", "4"]}	2023-09-05 16:41:42.925+05:30	2	46	127.0.0.1	\N
281	4	4	asd	0	{"product": ["None", "FG1"], "ref": ["None", ""], "updated": ["None", "2023-09-05 11:12:10.474840"], "qty": ["None", "10"], "jobwork": ["None", "production.JobCard.None"], "remarks": ["None", "sad"], "no": ["None", "2223JO00004"], "name": ["None", "asd"], "status": ["None", "1"], "bom": ["None", "BOM FG1"], "created": ["None", "2023-09-05 11:12:10.474804"], "details": ["None", "asd"], "id": ["None", "4"], "category": ["None", "asd"], "company": ["None", "ABC"], "issuedby": ["None", "admin"], "remain_qty": ["None", "10"], "date": ["None", "2023-09-05 11:12:10.474476"], "due_date": ["None", "2023-09-02"]}	2023-09-05 16:42:10.48+05:30	2	44	127.0.0.1	\N
282	2	2	RAW1	0	{"rate_type": ["None", "1"], "product": ["None", "raw1"], "id": ["None", "2"], "uom": ["None", "Demo"], "rate": ["None", "10"], "created": ["None", "2023-09-05"], "applicable_from": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"]}	2023-09-05 16:50:28.83+05:30	2	21	127.0.0.1	\N
283	3	3	RAW2	0	{"rate_type": ["None", "1"], "product": ["None", "raw2"], "id": ["None", "3"], "uom": ["None", "Demo"], "rate": ["None", "12"], "created": ["None", "2023-09-05"], "applicable_from": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"]}	2023-09-05 16:50:35.662+05:30	2	21	127.0.0.1	\N
284	2	2	2223PO00002	0	{"mode_of_payment": ["None", ""], "company": ["None", "ABC"], "igst": ["None", "0"], "shipto": ["None", "ABC"], "terms_of_delivery": ["None", ""], "total": ["None", "0"], "po_no": ["None", "2223PO00002"], "seller_city": ["None", "Ahmedabad"], "shipto_state": ["None", "GUJARAT"], "seller_pincode": ["None", "392154"], "other": ["None", "0"], "seller_country": ["None", "India"], "sgst": ["None", "0"], "shipto_address1": ["None", "ABCD"], "shipto_pincode": ["None", "391775"], "updated": ["None", "2023-09-05 11:20:56.612120"], "seller_address3": ["None", "Demo"], "ex_rate": ["None", "1"], "seller_address1": ["None", "Demo"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Gujarat-1"], "shipto_address3": ["None", "ABCD"], "ammount": ["None", "0"], "id": ["None", "2"], "ol_rate": ["None", "0"], "seller_address_type": ["None", "Default"], "narration": ["None", ""], "shipto_city": ["None", "VADODARA"], "other_reference": ["None", ""], "seller_mailingname": ["None", "Demo"], "shipto_address_type": ["None", "Default"], "round_off": ["None", "0"], "shipto_mailingname": ["None", "ABCD"], "shipto_country": ["None", "INDIA"], "created": ["None", "2023-09-05 11:20:56.612096"], "po_date": ["None", "2023-09-05"], "seller_address2": ["None", "Demo"], "currency": ["None", "001"], "po_due_date": ["None", "2023-09-08"], "seller_gstin": ["None", "XXDemos1234D"], "cgst": ["None", "0"], "dispatch_through": ["None", ""], "seller_gst_reg_type": ["None", "Regular"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "grn": ["None", "purchase.Grn.None"], "seller": ["None", "Demo"], "tcs": ["None", "0"], "status": ["None", "1"]}	2023-09-05 16:50:56.618+05:30	2	54	127.0.0.1	\N
285	2	2	2223PO00002	2	{"mode_of_payment": ["", "None"], "company": ["ABC", "None"], "igst": ["0", "None"], "shipto": ["ABC", "None"], "terms_of_delivery": ["", "None"], "total": ["0", "None"], "po_no": ["2223PO00002", "None"], "seller_city": ["Ahmedabad", "None"], "shipto_state": ["GUJARAT", "None"], "seller_pincode": ["392154", "None"], "other": ["0", "None"], "seller_country": ["India", "None"], "sgst": ["0", "None"], "shipto_address1": ["ABCD", "None"], "shipto_pincode": ["391775", "None"], "updated": ["2023-09-05 11:20:56.612120", "None"], "seller_address3": ["Demo", "None"], "ex_rate": ["1", "None"], "seller_address1": ["Demo", "None"], "shipto_address2": ["ABCD", "None"], "seller_state": ["Gujarat-1", "None"], "shipto_address3": ["ABCD", "None"], "ammount": ["0", "None"], "id": ["2", "None"], "ol_rate": ["0", "None"], "seller_address_type": ["Default", "None"], "narration": ["", "None"], "shipto_city": ["VADODARA", "None"], "other_reference": ["", "None"], "seller_mailingname": ["Demo", "None"], "shipto_address_type": ["Default", "None"], "round_off": ["0", "None"], "shipto_mailingname": ["ABCD", "None"], "shipto_country": ["INDIA", "None"], "created": ["2023-09-05 11:20:56.612096", "None"], "po_date": ["2023-09-05", "None"], "seller_address2": ["Demo", "None"], "currency": ["001", "None"], "po_due_date": ["2023-09-08", "None"], "seller_gstin": ["XXDemos1234D", "None"], "cgst": ["0", "None"], "dispatch_through": ["", "None"], "seller_gst_reg_type": ["Regular", "None"], "shipto_gstin": ["24AAKCS5015L1Z8", "None"], "grn": ["purchase.Grn.None", "None"], "seller": ["Demo", "None"], "tcs": ["0", "None"], "status": ["1", "None"]}	2023-09-05 16:50:56.629+05:30	2	54	127.0.0.1	\N
286	2	2	RAW1	1	{"product_code": ["raw1", "RAW1"]}	2023-09-05 16:51:48.109+05:30	2	20	127.0.0.1	\N
287	3	3	RAW2	1	{"product_code": ["raw2", "RAW2"]}	2023-09-05 16:52:06.784+05:30	2	20	127.0.0.1	\N
299	2	2	UN ALLOCATED	0	{"closing_balance": ["None", "1000"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "product": ["None", "RAW2"], "rate": ["None", "132.00"], "batch": ["None", "20230905003002"], "mrp": ["None", "0.00"], "id": ["None", "2"], "company": ["None", "ABC"], "godown": ["None", "UN ALLOCATED"]}	2023-09-05 16:54:18.94+05:30	2	84	127.0.0.1	\N
300	2	2	grnItems object (2)	0	{"item": ["None", "RAW2"], "recd_qty": ["None", "1000"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "cgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "rate": ["None", "11.00"], "mrp": ["None", "0.00"], "product_code": ["None", "RAW2"], "igstrate": ["None", "0.00"], "batch": ["None", "20230905003002"], "amount": ["None", "11000.00"], "grn": ["None", "2223GRN00003"], "id": ["None", "2"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "pack": ["None", "123.00"]}	2023-09-05 16:54:18.949+05:30	2	58	127.0.0.1	\N
301	3	3	2223GRN00003	1	{"tcs": ["0.00", "0"], "total": ["0.00", "16000"], "other": ["0.00", "0"], "ammount": ["0.00", "16000.00"], "ex_rate": ["12.00", "12"]}	2023-09-05 16:54:18.957+05:30	2	57	127.0.0.1	\N
302	3	3	2223PO00002	1	{"status": ["1", "4"]}	2023-09-05 16:54:18.97+05:30	2	54	127.0.0.1	\N
288	3	3	2223PO00002	0	{"mode_of_payment": ["None", ""], "company": ["None", "ABC"], "igst": ["None", "0"], "shipto": ["None", "ABC"], "terms_of_delivery": ["None", ""], "total": ["None", "0"], "po_no": ["None", "2223PO00002"], "seller_city": ["None", "Pune"], "shipto_state": ["None", "GUJARAT"], "seller_pincode": ["None", "392220"], "other": ["None", "0"], "seller_country": ["None", "India"], "sgst": ["None", "0"], "shipto_address1": ["None", "ABCD"], "shipto_pincode": ["None", "391775"], "updated": ["None", "2023-09-05 11:23:04.437440"], "seller_address3": ["None", "ABC"], "ex_rate": ["None", "1"], "seller_address1": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "shipto_address3": ["None", "ABCD"], "ammount": ["None", "0"], "id": ["None", "3"], "ol_rate": ["None", "0"], "seller_address_type": ["None", "Default"], "narration": ["None", ""], "shipto_city": ["None", "VADODARA"], "other_reference": ["None", ""], "seller_mailingname": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "round_off": ["None", "0"], "shipto_mailingname": ["None", "ABCD"], "shipto_country": ["None", "INDIA"], "created": ["None", "2023-09-05 11:23:04.437417"], "po_date": ["None", "2023-09-05"], "seller_address2": ["None", "ABC"], "currency": ["None", "001"], "po_due_date": ["None", "2023-09-09"], "seller_gstin": ["None", "AAAAAAA0258A"], "cgst": ["None", "0"], "dispatch_through": ["None", ""], "seller_gst_reg_type": ["None", "Regular"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "grn": ["None", "purchase.Grn.None"], "seller": ["None", "ABC"], "tcs": ["None", "0"], "status": ["None", "1"]}	2023-09-05 16:53:04.444+05:30	2	54	127.0.0.1	\N
289	2	2	2223PO00002	0	{"amend_qty": ["None", "0"], "sgst": ["None", "0.00"], "pack": ["None", "1.00"], "igstrate": ["None", "0"], "cgstrate": ["None", "0"], "amount": ["None", "5000.00"], "po": ["None", "2223PO00002"], "actual_qty": ["None", "500"], "rate": ["None", "10"], "id": ["None", "2"], "basic_qty": ["None", "500"], "cgst": ["None", "0.00"], "sgstrate": ["None", "0"], "product_code": ["None", "RAW1"], "igst": ["None", "0.00"], "item": ["None", "RAW1"]}	2023-09-05 16:53:04.455+05:30	2	55	127.0.0.1	\N
290	3	3	2223PO00002	0	{"amend_qty": ["None", "0"], "sgst": ["None", "0.00"], "pack": ["None", "123.00"], "igstrate": ["None", "0"], "cgstrate": ["None", "0"], "amount": ["None", "11000.00"], "po": ["None", "2223PO00002"], "actual_qty": ["None", "1000"], "rate": ["None", "11"], "id": ["None", "3"], "basic_qty": ["None", "1000"], "cgst": ["None", "0.00"], "sgstrate": ["None", "0"], "product_code": ["None", "RAW2"], "igst": ["None", "0.00"], "item": ["None", "RAW2"]}	2023-09-05 16:53:04.467+05:30	2	55	127.0.0.1	\N
291	3	3	2223PO00002	1	{"igst": ["0.00", "0"], "total": ["0.00", "16000"], "other": ["0.00", "0"], "sgst": ["0.00", "0"], "ex_rate": ["1.00", "1"], "ammount": ["0.00", "16000.00"], "ol_rate": ["0.00", "0"], "cgst": ["0.00", "0"]}	2023-09-05 16:53:04.476+05:30	2	54	127.0.0.1	\N
292	2	2	2223GRN00002	0	{"shipto": ["None", "ABC"], "round_off": ["None", "0"], "seller_gstin": ["None", "AAAAAAA0258A"], "id": ["None", "2"], "mode_of_payment": ["None", ""], "updated": ["None", "2023-09-05 11:23:37.966546"], "shipto_address1": ["None", "ABCD"], "currency": ["None", "001"], "po": ["None", "2223PO00002"], "seller_address2": ["None", "ABC"], "tcs": ["None", "0"], "narration": ["None", ""], "seller_address1": ["None", "ABC"], "total": ["None", "0"], "seller_city": ["None", "Pune"], "shipto_address3": ["None", "ABCD"], "other": ["None", "0"], "grn_no": ["None", "2223GRN00002"], "seller_pincode": ["None", "392220"], "status": ["None", "1"], "shipto_city": ["None", "VADODARA"], "sgst": ["None", "0"], "seller_mailingname": ["None", "ABC"], "created": ["None", "2023-09-05 11:23:37.966524"], "seller_country": ["None", "India"], "shipto_mailingname": ["None", "ABCD"], "igst": ["None", "0"], "seller_address_type": ["None", "Default"], "ammount": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "shipto_address_type": ["None", "Default"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "ex_rate": ["None", "12"], "terms_of_delivery": ["None", ""], "shipto_country": ["None", "INDIA"], "other_reference": ["None", ""], "seller": ["None", "ABC"], "shipto_state": ["None", "GUJARAT"], "shipto_pincode": ["None", "391775"], "company": ["None", "ABC"], "grn_date": ["None", "2023-09-05"], "cgst": ["None", "0"], "dispatch_through": ["None", "0"], "seller_address3": ["None", "ABC"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"]}	2023-09-05 16:53:37.973+05:30	2	57	127.0.0.1	\N
293	5	5	UN ALLOCATED	0	{"created": ["None", "2023-09-05"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "updated": ["None", "2023-09-05"], "godown_type": ["None", "False"], "name": ["None", "UN ALLOCATED"], "id": ["None", "5"]}	2023-09-05 16:54:10.452+05:30	2	10	127.0.0.1	\N
294	3	3	2223GRN00003	0	{"shipto": ["None", "ABC"], "round_off": ["None", "0"], "seller_gstin": ["None", "AAAAAAA0258A"], "id": ["None", "3"], "mode_of_payment": ["None", ""], "updated": ["None", "2023-09-05 11:24:18.877504"], "shipto_address1": ["None", "ABCD"], "currency": ["None", "001"], "po": ["None", "2223PO00002"], "seller_address2": ["None", "ABC"], "tcs": ["None", "0"], "narration": ["None", ""], "seller_address1": ["None", "ABC"], "total": ["None", "0"], "seller_city": ["None", "Pune"], "shipto_address3": ["None", "ABCD"], "other": ["None", "0"], "grn_no": ["None", "2223GRN00003"], "seller_pincode": ["None", "392220"], "status": ["None", "1"], "shipto_city": ["None", "VADODARA"], "sgst": ["None", "0"], "seller_mailingname": ["None", "ABC"], "created": ["None", "2023-09-05 11:24:18.877482"], "seller_country": ["None", "India"], "shipto_mailingname": ["None", "ABCD"], "igst": ["None", "0"], "seller_address_type": ["None", "Default"], "ammount": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "shipto_address_type": ["None", "Default"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "ex_rate": ["None", "12"], "terms_of_delivery": ["None", ""], "shipto_country": ["None", "INDIA"], "other_reference": ["None", ""], "seller": ["None", "ABC"], "shipto_state": ["None", "GUJARAT"], "shipto_pincode": ["None", "391775"], "company": ["None", "ABC"], "grn_date": ["None", "2023-09-05"], "cgst": ["None", "0"], "dispatch_through": ["None", "0"], "seller_address3": ["None", "ABC"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"]}	2023-09-05 16:54:18.884+05:30	2	57	127.0.0.1	\N
295	2	2	2223PO00002	1	{"actual_qty": ["500.00", "0.00"]}	2023-09-05 16:54:18.894+05:30	2	55	127.0.0.1	\N
296	1	1	UN ALLOCATED	0	{"closing_balance": ["None", "500"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "product": ["None", "RAW1"], "rate": ["None", "120.00"], "batch": ["None", "20230905003001"], "mrp": ["None", "345.00"], "id": ["None", "1"], "company": ["None", "ABC"], "godown": ["None", "UN ALLOCATED"]}	2023-09-05 16:54:18.909+05:30	2	84	127.0.0.1	\N
297	1	1	grnItems object (1)	0	{"item": ["None", "RAW1"], "recd_qty": ["None", "500"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "cgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "rate": ["None", "10.00"], "mrp": ["None", "345.00"], "product_code": ["None", "RAW1"], "igstrate": ["None", "0.00"], "batch": ["None", "20230905003001"], "amount": ["None", "5000.00"], "grn": ["None", "2223GRN00003"], "id": ["None", "1"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "pack": ["None", "1.00"]}	2023-09-05 16:54:18.919+05:30	2	58	127.0.0.1	\N
298	3	3	2223PO00002	1	{"actual_qty": ["1000.00", "0.00"]}	2023-09-05 16:54:18.926+05:30	2	55	127.0.0.1	\N
306	1	1	PalletTransferEntry object (1)	0	{"fgodown": ["None", "UN ALLOCATED"], "tgodown": ["None", "New1231"], "company": ["None", "ABC"], "createdby": ["None", "admin"], "qty": ["None", "500"], "item": ["None", "RAW1"], "id": ["None", "1"], "created": ["None", "2023-09-05"]}	2023-09-05 16:57:01.754+05:30	2	87	127.0.0.1	\N
307	3	3	New1231	0	{"created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "product": ["None", "RAW1"], "rate": ["None", "120.00"], "batch": ["None", "20230905003001"], "mrp": ["None", "345.00"], "id": ["None", "3"], "company": ["None", "ABC"], "godown": ["None", "New1231"]}	2023-09-05 16:57:01.766+05:30	2	84	127.0.0.1	\N
308	1	1	UN ALLOCATED	2	{"closing_balance": ["500.0000", "None"], "created": ["2023-09-05", "None"], "updated": ["2023-09-05", "None"], "product": ["RAW1", "None"], "rate": ["120.00", "None"], "batch": ["20230905003001", "None"], "mrp": ["345.00", "None"], "id": ["1", "None"], "company": ["ABC", "None"], "godown": ["UN ALLOCATED", "None"]}	2023-09-05 16:57:01.774+05:30	2	84	127.0.0.1	\N
309	3	3	New1231	1	{"closing_balance": ["None", "500.0000"]}	2023-09-05 16:57:01.78+05:30	2	84	127.0.0.1	\N
310	2	2	PalletTransferEntry object (2)	0	{"fgodown": ["None", "UN ALLOCATED"], "tgodown": ["None", "New1231"], "company": ["None", "ABC"], "createdby": ["None", "admin"], "qty": ["None", "1000"], "item": ["None", "RAW2"], "id": ["None", "2"], "created": ["None", "2023-09-05"]}	2023-09-05 16:57:10.571+05:30	2	87	127.0.0.1	\N
311	4	4	New1231	0	{"created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "product": ["None", "RAW2"], "rate": ["None", "132.00"], "batch": ["None", "20230905003002"], "mrp": ["None", "0.00"], "id": ["None", "4"], "company": ["None", "ABC"], "godown": ["None", "New1231"]}	2023-09-05 16:57:10.581+05:30	2	84	127.0.0.1	\N
312	2	2	UN ALLOCATED	2	{"closing_balance": ["1000.0000", "None"], "created": ["2023-09-05", "None"], "updated": ["2023-09-05", "None"], "product": ["RAW2", "None"], "rate": ["132.00", "None"], "batch": ["20230905003002", "None"], "mrp": ["0.00", "None"], "id": ["2", "None"], "company": ["ABC", "None"], "godown": ["UN ALLOCATED", "None"]}	2023-09-05 16:57:10.589+05:30	2	84	127.0.0.1	\N
313	4	4	New1231	1	{"closing_balance": ["None", "1000.0000"]}	2023-09-05 16:57:10.595+05:30	2	84	127.0.0.1	\N
314	2	2	Finished Goods	1	{"name": ["Product Type 1", "Finished Goods"]}	2023-09-05 16:58:23.749+05:30	2	16	127.0.0.1	\N
315	5	5	2223JC00005	0	{"start": ["None", "2023-09-09"], "consumption": ["None", "production.Consumption.None"], "id": ["None", "5"], "product": ["None", "FG1"], "status": ["None", "1"], "rmindent": ["None", "production.RMIndent.None"], "updated": ["None", "2023-09-05 11:30:22.620221"], "created": ["None", "2023-09-05 11:30:22.620198"], "company": ["None", "ABC"], "joborder": ["None", "asd"], "qty": ["None", "10"], "no": ["None", "2223JC00005"], "rqty": ["None", "10"]}	2023-09-05 17:00:22.628+05:30	2	46	127.0.0.1	\N
316	5	5	2223JC00005	0	{"no": ["None", "2223JC00005"], "created": ["None", "2023-09-05 11:30:22.633448"], "id": ["None", "5"], "updated": ["None", "2023-09-05 11:30:22.633490"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "status": ["None", "1"], "jobcard": ["None", "2223JC00005"], "company": ["None", "ABC"]}	2023-09-05 17:00:22.638+05:30	2	47	127.0.0.1	\N
317	7	7	2223JC00005 RAW1	0	{"id": ["None", "7"], "qty": ["None", "100.0000"], "rmindent": ["None", "2223JC00005"], "item": ["None", "RAW1"], "bom": ["None", "BOM FG1"]}	2023-09-05 17:00:22.65+05:30	2	48	127.0.0.1	\N
318	8	8	2223JC00005 RAW2	0	{"id": ["None", "8"], "qty": ["None", "200.0000"], "rmindent": ["None", "2223JC00005"], "item": ["None", "RAW2"], "bom": ["None", "BOM FG1"]}	2023-09-05 17:00:22.662+05:30	2	48	127.0.0.1	\N
319	4	4	asd	1	{"status": ["1", "3"], "remain_qty": ["10.0000", "0.0000"]}	2023-09-05 17:00:22.67+05:30	2	44	127.0.0.1	\N
320	5	5	2223JC00005	1	{"status": ["1", "4"]}	2023-09-05 17:00:22.685+05:30	2	46	127.0.0.1	\N
321	3	3	New1231	1	{"closing_balance": ["500.0000", "400.0000"]}	2023-09-05 17:02:06.001+05:30	2	84	127.0.0.1	\N
322	1	1	RMItemGodown object (1)	0	{"rate": ["None", "120.00"], "id": ["None", "1"], "godown": ["None", "New1231"], "batch": ["None", "20230905003001"], "qty": ["None", "100.0000"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "rmitem": ["None", "2223JC00005 RAW1"], "mrp": ["None", ""]}	2023-09-05 17:02:06.016+05:30	2	49	127.0.0.1	\N
323	4	4	New1231	1	{"closing_balance": ["1000.0000", "800.0000"]}	2023-09-05 17:02:06.027+05:30	2	84	127.0.0.1	\N
324	2	2	RMItemGodown object (2)	0	{"rate": ["None", "132.00"], "id": ["None", "2"], "godown": ["None", "New1231"], "batch": ["None", "20230905003002"], "qty": ["None", "200.0000"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "rmitem": ["None", "2223JC00005 RAW2"], "mrp": ["None", ""]}	2023-09-05 17:02:06.042+05:30	2	49	127.0.0.1	\N
325	5	5	2223JC00005	1	{"status": ["1", "2"]}	2023-09-05 17:02:06.048+05:30	2	47	127.0.0.1	\N
326	5	5	Production	0	{"closing_balance": ["None", "100.00"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "product": ["None", "RAW1"], "rate": ["None", "120.00"], "batch": ["None", "20230905003001"], "mrp": ["None", ""], "id": ["None", "5"], "company": ["None", "ABC"], "godown": ["None", "Production"]}	2023-09-05 17:03:13.467+05:30	2	84	127.0.0.1	\N
327	6	6	Production	0	{"closing_balance": ["None", "200.00"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "product": ["None", "RAW2"], "rate": ["None", "132.00"], "batch": ["None", "20230905003002"], "mrp": ["None", ""], "id": ["None", "6"], "company": ["None", "ABC"], "godown": ["None", "Production"]}	2023-09-05 17:03:13.478+05:30	2	84	127.0.0.1	\N
328	5	5	2223JC00005	1	{"status": ["2", "3"]}	2023-09-05 17:03:13.485+05:30	2	47	127.0.0.1	\N
329	2	2	PRODUCTION	1	{"name": ["Production", "PRODUCTION"]}	2023-09-05 17:05:21.925+05:30	2	10	127.0.0.1	\N
330	5	5	2223JC00005	1	{"rqty": ["10.0000", "5.0000"]}	2023-09-05 17:05:34.791+05:30	2	46	127.0.0.1	\N
331	1	1	PRD00001	0	{"qty": ["None", "5"], "created": ["None", "2023-09-05 11:35:34.801078"], "jobcard": ["None", "2223JC00005"], "consumption": ["None", "production.ConsumptionItems.None"], "id": ["None", "1"], "no": ["None", "PRD00001"], "updated": ["None", "2023-09-05 11:35:34.801098"], "date": ["None", "2023-09-05 11:35:34.800899+00:00"], "company": ["None", "ABC"]}	2023-09-05 17:05:34.806+05:30	2	52	127.0.0.1	\N
332	1	1	PRD00001	0	{"consumption": ["None", "PRD00001"], "rate": ["None", "120.00"], "id": ["None", "1"], "batch": ["None", "20230905003001"], "item": ["None", "RAW1"], "qty": ["None", "50.0000"], "mrp": ["None", ""]}	2023-09-05 17:05:34.821+05:30	2	53	127.0.0.1	\N
333	5	5	PRODUCTION	1	{"closing_balance": ["100.0000", "50.0000"]}	2023-09-05 17:05:34.833+05:30	2	84	127.0.0.1	\N
334	2	2	PRD00001	0	{"consumption": ["None", "PRD00001"], "rate": ["None", "132.00"], "id": ["None", "2"], "batch": ["None", "20230905003002"], "item": ["None", "RAW2"], "qty": ["None", "100.0000"], "mrp": ["None", ""]}	2023-09-05 17:05:34.849+05:30	2	53	127.0.0.1	\N
335	6	6	PRODUCTION	1	{"closing_balance": ["200.0000", "100.0000"]}	2023-09-05 17:05:34.857+05:30	2	84	127.0.0.1	\N
336	7	7	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "0"], "closing_balance": ["None", "5"], "mrp": ["None", "100.00"], "company": ["None", "ABC"], "product": ["None", "FG1"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905000998"], "id": ["None", "7"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:05:34.873+05:30	2	84	127.0.0.1	\N
337	5	5	2223JC00005	1	{"rqty": ["5.0000", "2.0000"]}	2023-09-05 17:06:27.002+05:30	2	46	127.0.0.1	\N
338	2	2	PRD00002	0	{"qty": ["None", "3"], "created": ["None", "2023-09-05 11:36:27.011687"], "jobcard": ["None", "2223JC00005"], "consumption": ["None", "production.ConsumptionItems.None"], "id": ["None", "2"], "no": ["None", "PRD00002"], "updated": ["None", "2023-09-05 11:36:27.011710"], "date": ["None", "2023-09-05 11:36:27.011459+00:00"], "company": ["None", "ABC"]}	2023-09-05 17:06:27.016+05:30	2	52	127.0.0.1	\N
339	3	3	PRD00002	0	{"consumption": ["None", "PRD00002"], "rate": ["None", "120.00"], "id": ["None", "3"], "batch": ["None", "20230905003001"], "item": ["None", "RAW1"], "qty": ["None", "30.0000"], "mrp": ["None", ""]}	2023-09-05 17:06:27.03+05:30	2	53	127.0.0.1	\N
340	5	5	PRODUCTION	1	{"closing_balance": ["50.0000", "20.0000"]}	2023-09-05 17:06:27.038+05:30	2	84	127.0.0.1	\N
341	4	4	PRD00002	0	{"consumption": ["None", "PRD00002"], "rate": ["None", "132.00"], "id": ["None", "4"], "batch": ["None", "20230905003002"], "item": ["None", "RAW2"], "qty": ["None", "60.0000"], "mrp": ["None", ""]}	2023-09-05 17:06:27.055+05:30	2	53	127.0.0.1	\N
342	6	6	PRODUCTION	1	{"closing_balance": ["100.0000", "40.0000"]}	2023-09-05 17:06:27.064+05:30	2	84	127.0.0.1	\N
343	8	8	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "0"], "closing_balance": ["None", "3"], "mrp": ["None", "100.00"], "company": ["None", "ABC"], "product": ["None", "FG1"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905000997"], "id": ["None", "8"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:06:27.079+05:30	2	84	127.0.0.1	\N
344	5	5	final job	0	{"no": ["None", "2223JO00005"], "name": ["None", "final job"], "remarks": ["None", "sp inst"], "status": ["None", "1"], "created": ["None", "2023-09-05 11:37:37.697171"], "bom": ["None", "BOM FG1"], "id": ["None", "5"], "category": ["None", "final job"], "jobwork": ["None", "production.JobCard.None"], "details": ["None", "final jopob"], "company": ["None", "ABC"], "date": ["None", "2023-09-05 11:37:37.696942"], "issuedby": ["None", "admin"], "remain_qty": ["None", "15"], "ref": ["None", ""], "due_date": ["None", "2023-09-07"], "updated": ["None", "2023-09-05 11:37:37.697194"], "qty": ["None", "15"], "product": ["None", "FG1"]}	2023-09-05 17:07:37.702+05:30	2	44	127.0.0.1	\N
345	6	6	2223JC00006	0	{"start": ["None", "2023-09-08"], "product": ["None", "FG1"], "company": ["None", "ABC"], "status": ["None", "1"], "qty": ["None", "12"], "rmindent": ["None", "production.RMIndent.None"], "id": ["None", "6"], "no": ["None", "2223JC00006"], "created": ["None", "2023-09-05 11:38:04.883790"], "consumption": ["None", "production.Consumption.None"], "rqty": ["None", "12"], "updated": ["None", "2023-09-05 11:38:04.883814"], "joborder": ["None", "final job"]}	2023-09-05 17:08:04.889+05:30	2	46	127.0.0.1	\N
346	6	6	2223JC00006	0	{"id": ["None", "6"], "updated": ["None", "2023-09-05 11:38:04.895134"], "status": ["None", "1"], "company": ["None", "ABC"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "no": ["None", "2223JC00006"], "created": ["None", "2023-09-05 11:38:04.895109"], "jobcard": ["None", "2223JC00006"]}	2023-09-05 17:08:04.9+05:30	2	47	127.0.0.1	\N
347	9	9	2223JC00006 RAW1	0	{"id": ["None", "9"], "item": ["None", "RAW1"], "bom": ["None", "BOM FG1"], "rmindent": ["None", "2223JC00006"], "qty": ["None", "120.0000"]}	2023-09-05 17:08:04.913+05:30	2	48	127.0.0.1	\N
348	10	10	2223JC00006 RAW2	0	{"id": ["None", "10"], "item": ["None", "RAW2"], "bom": ["None", "BOM FG1"], "rmindent": ["None", "2223JC00006"], "qty": ["None", "240.0000"]}	2023-09-05 17:08:04.922+05:30	2	48	127.0.0.1	\N
349	5	5	final job	1	{"status": ["1", "2"], "remain_qty": ["15.0000", "3.0000"]}	2023-09-05 17:08:04.93+05:30	2	44	127.0.0.1	\N
350	3	3	New1231	1	{"closing_balance": ["400.0000", "280.0000"]}	2023-09-05 17:08:44.67+05:30	2	84	127.0.0.1	\N
351	3	3	RMItemGodown object (3)	0	{"created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "godown": ["None", "New1231"], "mrp": ["None", ""], "rate": ["None", "120.00"], "qty": ["None", "120.0000"], "id": ["None", "3"], "batch": ["None", "20230905003001"], "rmitem": ["None", "2223JC00006 RAW1"]}	2023-09-05 17:08:44.686+05:30	2	49	127.0.0.1	\N
352	4	4	New1231	1	{"closing_balance": ["800.0000", "560.0000"]}	2023-09-05 17:08:44.696+05:30	2	84	127.0.0.1	\N
353	4	4	RMItemGodown object (4)	0	{"created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "godown": ["None", "New1231"], "mrp": ["None", ""], "rate": ["None", "132.00"], "qty": ["None", "240.0000"], "id": ["None", "4"], "batch": ["None", "20230905003002"], "rmitem": ["None", "2223JC00006 RAW2"]}	2023-09-05 17:08:44.71+05:30	2	49	127.0.0.1	\N
354	6	6	2223JC00006	1	{"status": ["1", "2"]}	2023-09-05 17:08:44.72+05:30	2	47	127.0.0.1	\N
355	9	9	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "120.00"], "closing_balance": ["None", "120.00"], "mrp": ["None", ""], "company": ["None", "ABC"], "product": ["None", "RAW1"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905003001"], "id": ["None", "9"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:09:31.902+05:30	2	84	127.0.0.1	\N
356	10	10	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "132.00"], "closing_balance": ["None", "240.00"], "mrp": ["None", ""], "company": ["None", "ABC"], "product": ["None", "RAW2"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905003002"], "id": ["None", "10"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:09:31.913+05:30	2	84	127.0.0.1	\N
357	6	6	2223JC00006	1	{"status": ["2", "3"]}	2023-09-05 17:09:31.919+05:30	2	47	127.0.0.1	\N
359	1	1	ConsItems object (1)	0	{"indent": ["None", "CSM00001"], "con_qty": ["None", "80"], "id": ["None", "1"], "item": ["None", "RAW1"], "qty": ["None", "80"]}	2023-09-05 17:10:37.451+05:30	2	51	127.0.0.1	\N
360	3	3	New1231	1	{"closing_balance": ["280.0000", "200.0000"]}	2023-09-05 17:10:37.46+05:30	2	84	127.0.0.1	\N
361	11	11	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "120.00"], "mrp": ["None", "345.00"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905003001"], "id": ["None", "11"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:10:37.472+05:30	2	84	127.0.0.1	\N
362	11	11	PRODUCTION	1	{"closing_balance": ["None", "80"]}	2023-09-05 17:10:37.481+05:30	2	84	127.0.0.1	\N
365	3	3	PRD00003	0	{"qty": ["None", "12"], "created": ["None", "2023-09-05 11:42:13.092347"], "jobcard": ["None", "2223JC00006"], "consumption": ["None", "production.ConsumptionItems.None"], "id": ["None", "3"], "no": ["None", "PRD00003"], "updated": ["None", "2023-09-05 11:42:13.092375"], "date": ["None", "2023-09-05 11:42:13.092173+00:00"], "company": ["None", "ABC"]}	2023-09-05 17:12:13.097+05:30	2	52	127.0.0.1	\N
366	5	5	PRODUCTION	2	{"updated": ["2023-09-05", "None"], "rate": ["120.00", "None"], "closing_balance": ["20.0000", "None"], "mrp": ["", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "created": ["2023-09-05", "None"], "batch": ["20230905003001", "None"], "id": ["5", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-05 17:12:13.107+05:30	2	84	127.0.0.1	\N
367	9	9	PRODUCTION	1	{"closing_balance": ["120.0000", "60.0000"]}	2023-09-05 17:12:13.115+05:30	2	84	127.0.0.1	\N
368	5	5	PRD00003	0	{"consumption": ["None", "PRD00003"], "rate": ["None", "120.00"], "id": ["None", "5"], "batch": ["None", "20230905003001"], "item": ["None", "RAW1"], "qty": ["None", "60.0000"], "mrp": ["None", ""]}	2023-09-05 17:12:13.128+05:30	2	53	127.0.0.1	\N
369	6	6	PRD00003	0	{"consumption": ["None", "PRD00003"], "rate": ["None", "120.00"], "id": ["None", "6"], "batch": ["None", "20230905003001"], "item": ["None", "RAW1"], "qty": ["None", "120.0000"], "mrp": ["None", ""]}	2023-09-05 17:12:13.149+05:30	2	53	127.0.0.1	\N
370	9	9	PRODUCTION	2	{"updated": ["2023-09-05", "None"], "rate": ["120.00", "None"], "closing_balance": ["60.0000", "None"], "mrp": ["", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "created": ["2023-09-05", "None"], "batch": ["20230905003001", "None"], "id": ["9", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-05 17:12:13.159+05:30	2	84	127.0.0.1	\N
371	11	11	PRODUCTION	1	{"closing_balance": ["80.0000", "20.0000"]}	2023-09-05 17:12:13.167+05:30	2	84	127.0.0.1	\N
372	7	7	PRD00003	0	{"consumption": ["None", "PRD00003"], "rate": ["None", "132.00"], "id": ["None", "7"], "batch": ["None", "20230905003002"], "item": ["None", "RAW2"], "qty": ["None", "240.0000"], "mrp": ["None", ""]}	2023-09-05 17:12:13.183+05:30	2	53	127.0.0.1	\N
373	6	6	PRODUCTION	2	{"updated": ["2023-09-05", "None"], "rate": ["132.00", "None"], "closing_balance": ["40.0000", "None"], "mrp": ["", "None"], "company": ["ABC", "None"], "product": ["RAW2", "None"], "created": ["2023-09-05", "None"], "batch": ["20230905003002", "None"], "id": ["6", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-05 17:12:13.19+05:30	2	84	127.0.0.1	\N
374	10	10	PRODUCTION	1	{"closing_balance": ["240.0000", "40.0000"]}	2023-09-05 17:12:13.199+05:30	2	84	127.0.0.1	\N
375	12	12	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "0"], "closing_balance": ["None", "12"], "mrp": ["None", "100.00"], "company": ["None", "ABC"], "product": ["None", "FG1"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905000996"], "id": ["None", "12"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:12:13.214+05:30	2	84	127.0.0.1	\N
376	5	5	2223JC00005	1	{"rqty": ["2.0000", "0.0000"]}	2023-09-05 17:12:52.263+05:30	2	46	127.0.0.1	\N
377	4	4	PRD00004	0	{"qty": ["None", "2"], "created": ["None", "2023-09-05 11:42:52.278821"], "jobcard": ["None", "2223JC00005"], "consumption": ["None", "production.ConsumptionItems.None"], "id": ["None", "4"], "no": ["None", "PRD00004"], "updated": ["None", "2023-09-05 11:42:52.278862"], "date": ["None", "2023-09-05 11:42:52.278530+00:00"], "company": ["None", "ABC"]}	2023-09-05 17:12:52.287+05:30	2	52	127.0.0.1	\N
378	8	8	PRD00004	0	{"consumption": ["None", "PRD00004"], "rate": ["None", "120.00"], "id": ["None", "8"], "batch": ["None", "20230905003001"], "item": ["None", "RAW1"], "qty": ["None", "20.0000"], "mrp": ["None", "345.00"]}	2023-09-05 17:12:52.302+05:30	2	53	127.0.0.1	\N
379	11	11	PRODUCTION	2	{"updated": ["2023-09-05", "None"], "rate": ["120.00", "None"], "closing_balance": ["20.0000", "None"], "mrp": ["345.00", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "created": ["2023-09-05", "None"], "batch": ["20230905003001", "None"], "id": ["11", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-05 17:12:52.309+05:30	2	84	127.0.0.1	\N
380	9	9	PRD00004	0	{"consumption": ["None", "PRD00004"], "rate": ["None", "132.00"], "id": ["None", "9"], "batch": ["None", "20230905003002"], "item": ["None", "RAW2"], "qty": ["None", "40.0000"], "mrp": ["None", ""]}	2023-09-05 17:12:52.322+05:30	2	53	127.0.0.1	\N
381	10	10	PRODUCTION	2	{"updated": ["2023-09-05", "None"], "rate": ["132.00", "None"], "closing_balance": ["40.0000", "None"], "mrp": ["", "None"], "company": ["ABC", "None"], "product": ["RAW2", "None"], "created": ["2023-09-05", "None"], "batch": ["20230905003002", "None"], "id": ["10", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-05 17:12:52.33+05:30	2	84	127.0.0.1	\N
382	13	13	PRODUCTION	0	{"updated": ["None", "2023-09-05"], "rate": ["None", "0"], "closing_balance": ["None", "2"], "mrp": ["None", "100.00"], "company": ["None", "ABC"], "product": ["None", "FG1"], "created": ["None", "2023-09-05"], "batch": ["None", "20230905000995"], "id": ["None", "13"], "godown": ["None", "PRODUCTION"]}	2023-09-05 17:12:52.34+05:30	2	84	127.0.0.1	\N
383	1	1	2223SO00001	0	{"buyer_country": ["None", "India"], "shipto_city": ["None", "Mumbai"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "company": ["None", "ABC"], "buyer_gstin": ["None", "XXAAPOD1234Z"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Unknown"], "created": ["None", "2023-09-05 11:48:32.233805"], "shipto_country": ["None", "India"], "bill_qty": ["None", "0"], "cgst": ["None", "0"], "id": ["None", "1"], "shipto_address_type": ["None", "Default"], "order_no": ["None", "ABC123"], "buyer_pincode": ["None", "493320"], "igst": ["None", "0"], "buyer_address2": ["None", "Address Line1"], "shipto_address3": ["None", "Address Line1"], "price_list": ["None", "10%"], "other_reference": ["None", ""], "other": ["None", "0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Customer Name 2"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00001"], "round_off": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CUSTOMER NAME 2"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-05 11:48:32.229271+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-06"], "buyer_address3": ["None", "Address Line1"], "updated": ["None", "2023-09-05 11:48:32.233853"], "buyer_state": ["None", "Maharashtra"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_pincode": ["None", "493320"], "terms_of_delivery": ["None", "30"], "buyer_city": ["None", "Mumbai"], "sgst": ["None", "0"], "shipto_state": ["None", "Maharashtra"], "isscheme": ["None", "False"]}	2023-09-05 17:18:32.242+05:30	2	66	127.0.0.1	\N
444	15	15	UN ALLOCATED	0	{"godown": ["None", "UN ALLOCATED"], "updated": ["None", "2023-09-12"], "rate": ["None", "2.00"], "closing_balance": ["None", "100"], "created": ["None", "2023-09-12"], "mrp": ["None", "345.00"], "id": ["None", "15"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230912002002"]}	2023-09-12 11:53:52.555+05:30	2	84	127.0.0.1	\N
384	1	1	2223SO00001	2	{"buyer_country": ["India", "None"], "shipto_city": ["Mumbai", "None"], "tcs": ["0", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "company": ["ABC", "None"], "buyer_gstin": ["XXAAPOD1234Z", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "narration": ["", "None"], "shipto": ["Customer Name 2", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "created": ["2023-09-05 11:48:32.233805", "None"], "shipto_country": ["India", "None"], "bill_qty": ["0", "None"], "cgst": ["0", "None"], "id": ["1", "None"], "shipto_address_type": ["Default", "None"], "order_no": ["ABC123", "None"], "buyer_pincode": ["493320", "None"], "igst": ["0", "None"], "buyer_address2": ["Address Line1", "None"], "shipto_address3": ["Address Line1", "None"], "price_list": ["10%", "None"], "other_reference": ["", "None"], "other": ["0", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "buyer": ["Customer Name 2", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00001", "None"], "round_off": ["0", "None"], "buyer_address1": ["Address Line1", "None"], "ol_rate": ["0", "None"], "buyer_mailingname": ["CUSTOMER NAME 2", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-05 11:48:32.229271+00:00", "None"], "total": ["0", "None"], "shipto_address2": ["Address Line1", "None"], "ammount": ["0", "None"], "so_due_date": ["2023-09-06", "None"], "buyer_address3": ["Address Line1", "None"], "updated": ["2023-09-05 11:48:32.233853", "None"], "buyer_state": ["Maharashtra", "None"], "free_qty": ["0", "None"], "status": ["1", "None"], "shipto_pincode": ["493320", "None"], "terms_of_delivery": ["30", "None"], "buyer_city": ["Mumbai", "None"], "sgst": ["0", "None"], "shipto_state": ["Maharashtra", "None"], "isscheme": ["False", "None"]}	2023-09-05 17:18:32.254+05:30	2	66	127.0.0.1	\N
385	2	2	Price_list object (2)	0	{"id": ["None", "2"], "product": ["None", "FG1"], "rate": ["None", "100"], "created": ["None", "2023-09-05"], "updated": ["None", "2023-09-05"], "price_level": ["None", "5%"], "applicable_from": ["None", "2023-09-05"]}	2023-09-05 17:20:04.207+05:30	2	38	127.0.0.1	\N
386	2	2	2223SO00001	0	{"buyer_country": ["None", "India"], "shipto_city": ["None", "Vadodara"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "company": ["None", "ABC"], "buyer_gstin": ["None", ""], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-05 11:51:01.033610"], "shipto_country": ["None", "India"], "bill_qty": ["None", "0"], "cgst": ["None", "0"], "id": ["None", "2"], "shipto_address_type": ["None", "Default"], "order_no": ["None", ""], "buyer_pincode": ["None", "390001"], "igst": ["None", "0"], "buyer_address2": ["None", "Address Line2"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "5%"], "other_reference": ["None", ""], "other": ["None", "0"], "shipto_gstin": ["None", ""], "buyer": ["None", "Customer Name"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00001"], "round_off": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-05 11:51:01.030807+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line2"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-06"], "buyer_address3": ["None", "Address Line3"], "updated": ["None", "2023-09-05 11:51:01.033636"], "buyer_state": ["None", "Gujarat-1"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_pincode": ["None", "390001"], "terms_of_delivery": ["None", "30"], "buyer_city": ["None", "Vadodara"], "sgst": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "isscheme": ["None", "False"]}	2023-09-05 17:21:01.042+05:30	2	66	127.0.0.1	\N
387	1	1	FG1	0	{"so": ["None", "2223SO00001"], "actual_qty": ["None", "2"], "sgstrate": ["None", "0.00"], "rate": ["None", "100.00"], "sgst": ["None", "0.00"], "free_qty": ["None", "0"], "id": ["None", "1"], "offer_mrp": ["None", "0"], "amount": ["None", "200.00"], "item": ["None", "FG1"], "igst": ["None", "0.00"], "available_qty": ["None", "22"], "mrp": ["None", "100.00"], "billed_qty": ["None", "2"], "cgstrate": ["None", "0.00"], "cgst": ["None", "0.00"], "discount": ["None", "0"], "pack": ["None", "5.00"], "igstrate": ["None", "0.00"]}	2023-09-05 17:21:01.056+05:30	2	67	127.0.0.1	\N
388	2	2	2223SO00001	1	{"bill_qty": ["0.00", "2"], "other": ["0.00", "0"], "discount": ["0.00", "0.0"], "ol_rate": ["0.00", "0"], "so_date": ["2023-09-05", "2023-09-05 11:51:01.030807+00:00"], "total": ["0.00", "200"], "ammount": ["0.00", "200.00"], "free_qty": ["0.00", "0"]}	2023-09-05 17:21:01.065+05:30	2	66	127.0.0.1	\N
389	1	1	2223DN00001	0	{"buyer_address1": ["None", "Address Line1"], "shipto_state": ["None", "Gujarat-1"], "terms_of_delivery": ["None", "30"], "status": ["None", "1"], "buyer_city": ["None", "Vadodara"], "shipto_address3": ["None", "Address Line3"], "sgst": ["None", "0.00"], "discount": ["None", "0.00"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_address2": ["None", "Address Line2"], "shipto_country": ["None", "India"], "order_no": ["None", ""], "ps_status": ["None", "False"], "shipto_address1": ["None", "Address Line1"], "id": ["None", "1"], "buyer_gstin": ["None", ""], "ammount": ["None", "200.00"], "buyer_country": ["None", "India"], "shipto_city": ["None", "Vadodara"], "narration": ["None", ""], "shipto_mailingname": ["None", "CUSTOMER NAME"], "other": ["None", "0.00"], "buyer_address_type": ["None", "Default"], "ol_rate": ["None", "0.00"], "total": ["None", "200.00"], "other_reference": ["None", ""], "dn_no": ["None", "2223DN00001"], "buyer": ["None", "Customer Name"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Gujarat-1"], "ls_status": ["None", "False"], "shipto_pan_no": ["None", "AAPOS1478Q"], "round_off": ["None", "0.00"], "shipto_address_type": ["None", "Default"], "buyer_pincode": ["None", "390001"], "company": ["None", "ABC"], "sales_order": ["None", "2223SO00001"], "buyer_address3": ["None", "Address Line3"], "dn_date": ["None", "2023-09-05 11:51:48.435545+00:00"], "shipto_pincode": ["None", "390001"], "price_list": ["None", "5%"], "shipto_gstin": ["None", ""], "updated": ["None", "2023-09-05"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "igst": ["None", "0.00"], "created": ["None", "2023-09-05"], "shipto_address2": ["None", "Address Line2"], "cgst": ["None", "0.00"], "tcs": ["None", "0.00"], "shipto": ["None", "Customer Name"], "bill_qty": ["None", "2.00"], "mode_of_payment": ["None", "30"]}	2023-09-05 17:21:48.45+05:30	2	68	127.0.0.1	\N
390	7	7	PRODUCTION	1	{"closing_balance": ["5.0000", "3.0000"]}	2023-09-05 17:21:48.461+05:30	2	84	127.0.0.1	\N
391	1	1	LoadingSheet object (1)	0	{"dn": ["None", "2223DN00001"], "batch": ["None", "20230905000995"], "qty": ["None", "2.0000"], "item": ["None", "FG1"], "created": ["None", "2023-09-05"], "offermrp": ["None", "0.00"], "prate": ["None", "0.00"], "updated": ["None", "2023-09-05"], "id": ["None", "1"], "company": ["None", "ABC"], "godown": ["None", "PRODUCTION"], "mrp": ["None", "100.00"]}	2023-09-05 17:21:48.475+05:30	2	80	127.0.0.1	\N
479	5	5	PalletTransferEntry object (5)	0	{"createdby": ["None", "admin"], "company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "id": ["None", "5"], "qty": ["None", "1500"], "item": ["None", "RAW1"], "fgodown": ["None", "UN ALLOCATED"], "created": ["None", "2023-09-12"]}	2023-09-12 12:01:04.084+05:30	2	87	127.0.0.1	\N
392	1	1	DnItems object (1)	0	{"free_qty": ["None", "0.00"], "pack": ["None", "5.00"], "id": ["None", "1"], "sgst": ["None", "0.00"], "mrp": ["None", "100.00"], "billed_qty": ["None", "2.00"], "available_qty": ["None", "22.00"], "cgst": ["None", "0.00"], "sgstrate": ["None", "0.00"], "item": ["None", "FG1"], "offer_mrp": ["None", "0.00"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "prate": ["None", "0.00"], "dn": ["None", "2223DN00001"], "discount": ["None", "0.00"], "actual_qty": ["None", "2.00"], "igstrate": ["None", "0.00"], "amount": ["None", "200.00"], "rate": ["None", "100.00"]}	2023-09-05 17:21:48.485+05:30	2	69	127.0.0.1	\N
393	1	1	2223DN00001	1	{"dn_date": ["2023-09-05", "2023-09-05 11:51:48.435545+00:00"]}	2023-09-05 17:21:48.5+05:30	2	68	127.0.0.1	\N
394	2	2	2223SO00001	1	{"status": ["1", "3"]}	2023-09-05 17:21:48.514+05:30	2	66	127.0.0.1	\N
395	1	1	2223INV00001	0	{"dn": ["None", "2223DN00001"], "is_ict": ["None", "False"], "free_qty": ["None", "0.00"], "round_off": ["None", "0.00"], "buyer_state": ["None", "Gujarat-1"], "shipto_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-05"], "shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0.00"], "buyer_gst_reg_type": ["None", "Consumer"], "other": ["None", "0.00"], "buyer_city": ["None", "Vadodara"], "buyer_gstin": ["None", ""], "shipto_mailingname": ["None", "CUSTOMER NAME"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "shipto": ["None", "Customer Name"], "bill_qty": ["None", "2.00"], "channel": ["None", "Channel 1"], "division": ["None", "Division 1"], "shipto_address_type": ["None", "Default"], "tcs": ["None", "0.00"], "buyer_address2": ["None", "Address Line2"], "shipto_country": ["None", "India"], "buyer": ["None", "Customer Name"], "shipto_address3": ["None", "Address Line3"], "inv_date": ["None", "2023-09-05 11:55:46.262048+00:00"], "shipto_pincode": ["None", "390001"], "total": ["None", "200.00"], "discount": ["None", "0.00"], "terms_of_delivery": ["None", "30"], "buyer_pincode": ["None", "390001"], "shipto_gstin": ["None", ""], "updated": ["None", "2023-09-05"], "sgst": ["None", "0.00"], "order_no": ["None", ""], "buyer_country": ["None", "India"], "igst": ["None", "0.00"], "inv_no": ["None", "2223INV00001"], "is_ivt": ["None", "False"], "cgst": ["None", "0.00"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "shipto_address1": ["None", "Address Line1"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "id": ["None", "1"], "ammount": ["None", "200.00"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line2"], "company": ["None", "ABC"], "status": ["None", "1"], "mrpvalue": ["None", "0"], "price_list": ["None", "5%"], "mode_of_payment": ["None", "30"], "other_reference": ["None", ""]}	2023-09-05 17:25:46.274+05:30	2	70	127.0.0.1	\N
396	1	1	InvItems object (1)	0	{"free_qty": ["None", "0.00"], "cgst": ["None", "0.00"], "amount": ["None", "200.00"], "rate": ["None", "100.00"], "nb_qty": ["None", "2.000"], "id": ["None", "1"], "available_qty": ["None", "22.00"], "cgstrate": ["None", "0.00"], "actual_qty": ["None", "2.000"], "sgst": ["None", "0.00"], "prate": ["None", "0.00"], "billed_qty": ["None", "2.000"], "item": ["None", "FG1"], "pack": ["None", "5.00"], "discount": ["None", "0.00"], "offer_mrp": ["None", "0.00"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "nf_qty": ["None", "0.00"], "inv": ["None", "2223INV00001"], "mrp": ["None", "100.00"], "new_rate": ["None", "100.00"], "igst": ["None", "0.00"]}	2023-09-05 17:25:46.285+05:30	2	71	127.0.0.1	\N
397	1	1	2223DN00001	1	{"status": ["1", "3"]}	2023-09-05 17:25:46.308+05:30	2	68	127.0.0.1	\N
398	1	1	2223INV00001	1	{"inv_date": ["2023-09-05", "2023-09-05 11:55:46.262048+00:00"], "omrpvalue": ["0.00", "0.00000"], "mrpvalue": ["0.00", "200.00000"]}	2023-09-05 17:25:46.32+05:30	2	70	127.0.0.1	\N
399	1	1	2223CN00001	0	{"omrpvalue": ["None", "0"], "channel": ["None", "Channel 1"], "created": ["None", "2023-09-05"], "buyer_address_type": ["None", "Default"], "ol_rate": ["None", "0"], "buyer": ["None", "Customer Name"], "mrpvalue": ["None", "0"], "division": ["None", "Division 1"], "buyer_gstin": ["None", ""], "narration": ["None", ""], "buyer_country": ["None", "India"], "buyer_pincode": ["None", "390001"], "other": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "status": ["None", "1"], "cn_date": ["None", "2023-09-05"], "buyer_gst_reg_type": ["None", "Consumer"], "id": ["None", "1"], "igst": ["None", "0"], "total": ["None", "0"], "tcs": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "updated": ["None", "2023-09-05"], "company": ["None", "ABC"], "cn_no": ["None", "2223CN00001"], "buyer_address2": ["None", "Address Line2"], "discount": ["None", "0.00"], "inv": ["None", "2223INV00001"], "buyer_address3": ["None", "Address Line3"], "ammount": ["None", "0"], "round_off": ["None", "0"], "sgst": ["None", "0"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "buyer_city": ["None", "Vadodara"], "cgst": ["None", "0"]}	2023-09-05 17:28:36.65+05:30	2	74	127.0.0.1	\N
400	1	1	InvItems object (1)	1	{"new_rate": ["100.00", "90.00"]}	2023-09-05 17:28:36.663+05:30	2	71	127.0.0.1	\N
401	1	1	CreditNoteItems object (1)	0	{"rates": ["None", "100.00"], "sgstrate": ["None", "0.00"], "igstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "id": ["None", "1"], "cgstrate": ["None", "0.00"], "inv": ["None", "2223CN00001"], "billed_qty": ["None", "2.00"], "item": ["None", "FG1"], "igst": ["None", "0.00"], "discount": ["None", "0.00"], "mrp": ["None", "100.00"], "cgst": ["None", "0.00"], "rate": ["None", "10"], "amount": ["None", "20.00"]}	2023-09-05 17:28:36.679+05:30	2	75	127.0.0.1	\N
402	1	1	2223CN00001	1	{"omrpvalue": ["0.00", "0"], "ol_rate": ["0.00", "0"], "mrpvalue": ["0.00", "0"], "other": ["0.00", "0"], "total": ["0.00", "20"], "tcs": ["0.00", "0"], "ammount": ["0.00", "20.00"]}	2023-09-05 17:28:36.687+05:30	2	74	127.0.0.1	\N
403	2	2	Description	0	{"created": ["None", "2023-09-12"], "id": ["None", "2"], "name": ["None", "Description"], "updated": ["None", "2023-09-12"], "description": ["None", " Description"], "jobcard": ["None", "planning.JobOrder.None"], "product": ["None", "FG1"]}	2023-09-12 10:21:25.695+05:30	2	42	127.0.0.1	\N
404	6	6	Description	0	{"id": ["None", "6"], "qty": ["None", "100"], "item": ["None", "FG1"], "bom": ["None", "Description"]}	2023-09-12 10:21:25.704+05:30	2	43	127.0.0.1	\N
405	7	7	Description	0	{"id": ["None", "7"], "qty": ["None", "200"], "item": ["None", "RAW1"], "bom": ["None", "Description"]}	2023-09-12 10:21:25.714+05:30	2	43	127.0.0.1	\N
406	6	6	Final Job RM FG1	0	{"qty": ["None", "10"], "remarks": ["None", "NA"], "no": ["None", "2223JO00006"], "status": ["None", "1"], "name": ["None", "Final Job RM FG1"], "bom": ["None", "BOM FG1"], "details": ["None", "Final Job RM FG1"], "created": ["None", "2023-09-12 04:52:22.003160"], "id": ["None", "6"], "category": ["None", "Final Job RM FG1"], "issuedby": ["None", "admin"], "company": ["None", "ABC"], "remain_qty": ["None", "10"], "date": ["None", "2023-09-12 04:52:22.002931"], "due_date": ["None", "2023-09-13"], "jobwork": ["None", "production.JobCard.None"], "ref": ["None", ""], "updated": ["None", "2023-09-12 04:52:22.003184"], "product": ["None", "FG1"]}	2023-09-12 10:22:22.009+05:30	2	44	127.0.0.1	\N
480	20	20	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "created": ["None", "2023-09-12"], "mrp": ["None", "345.00"], "id": ["None", "20"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230912003001"]}	2023-09-12 12:01:04.094+05:30	2	84	127.0.0.1	\N
407	7	7	2223JC00007	0	{"qty": ["None", "5"], "id": ["None", "7"], "consumption": ["None", "production.Consumption.None"], "start": ["None", "2023-09-13"], "product": ["None", "FG1"], "updated": ["None", "2023-09-12 04:56:21.106236"], "status": ["None", "1"], "rmindent": ["None", "production.RMIndent.None"], "no": ["None", "2223JC00007"], "joborder": ["None", "Final Job RM FG1"], "rqty": ["None", "5"], "created": ["None", "2023-09-12 04:56:21.106212"], "company": ["None", "ABC"]}	2023-09-12 10:26:21.113+05:30	2	46	127.0.0.1	\N
408	7	7	2223JC00007	0	{"jobcard": ["None", "2223JC00007"], "id": ["None", "7"], "updated": ["None", "2023-09-12 04:56:21.119854"], "no": ["None", "2223JC00007"], "status": ["None", "1"], "created": ["None", "2023-09-12 04:56:21.119830"], "company": ["None", "ABC"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"]}	2023-09-12 10:26:21.126+05:30	2	47	127.0.0.1	\N
409	11	11	2223JC00007 RAW1	0	{"item": ["None", "RAW1"], "bom": ["None", "BOM FG1"], "qty": ["None", "50.0000"], "rmindent": ["None", "2223JC00007"], "id": ["None", "11"]}	2023-09-12 10:26:21.139+05:30	2	48	127.0.0.1	\N
410	12	12	2223JC00007 RAW2	0	{"item": ["None", "RAW2"], "bom": ["None", "BOM FG1"], "qty": ["None", "100.0000"], "rmindent": ["None", "2223JC00007"], "id": ["None", "12"]}	2023-09-12 10:26:21.149+05:30	2	48	127.0.0.1	\N
411	6	6	Final Job RM FG1	1	{"remain_qty": ["10.0000", "5.0000"], "status": ["1", "2"]}	2023-09-12 10:26:21.155+05:30	2	44	127.0.0.1	\N
412	4	4	NFG	0	{"ipd": ["None", "False"], "gst": ["None", "0"], "track_dom": ["None", "False"], "behaviour": ["None", "False"], "shape_code": ["None", ""], "is_saleable": ["None", "False"], "sub_class": ["None", "Sub Class 1"], "color_shade_theme": ["None", ""], "exp_date": ["None", "False"], "trs": ["None", "False"], "category": ["None", "IT"], "size": ["None", ""], "costing_method": ["None", "1"], "sales_qdn_item": ["None", "sales.QdnItems.None"], "imported_by": ["None", ""], "bill_of_material": ["None", "False"], "product_name": ["None", "New FG "], "brand": ["None", "Neti"], "dl_purchase": ["None", "GST SALES A/C"], "id": ["None", "4"], "pricelist": ["None", "ledgers.Price_list.None"], "created": ["None", "2023-09-12"], "product_code": ["None", "NFG"], "tpc": ["None", "False"], "jobcard": ["None", "planning.JobOrder.None"], "gstdetail": ["None", "inventory.Gst_list.None"], "set_std_rate": ["None", "False"], "isgstapplicable": ["None", "True"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "sub_brand": ["None", "Neti - Sub"], "mkt_by": ["None", ""], "units_of_measure": ["None", "Demo"], "mrp": ["None", "0"], "mfd_by": ["None", ""], "ean_code": ["None", ""], "valuation_method": ["None", "1"], "product_type": ["None", "Finished Goods"], "country_of_origin": ["None", ""], "series": ["None", ""], "article_code": ["None", "5112210004"], "description": ["None", "New FG "], "updated": ["None", "2023-09-12"], "consumableitem": ["None", "production.ConsItems.None"], "consumption_item": ["None", "production.ConsumptionItems.None"], "dl_sales": ["None", "GST SALES A/C"], "is_batch": ["None", "False"], "ins": ["None", "False"], "purchase_qdn_item": ["None", "purchase.QdnItems.None"], "pattern": ["None", ""], "tsm": ["None", "False"], "jobwork": ["None", "production.JobCard.None"], "product_class": ["None", "Class 1"], "style_shape": ["None", ""]}	2023-09-12 11:09:56.144+05:30	2	20	127.0.0.1	\N
413	4	4	NFG	1	{"gst": ["0.00", "0"], "additional_units": ["None", "Demo"], "mrp": ["0.00", "0"]}	2023-09-12 11:09:56.154+05:30	2	20	127.0.0.1	\N
414	5	5	NFG2	0	{"gst": ["None", "0"], "track_dom": ["None", "False"], "jobwork": ["None", "production.JobCard.None"], "is_saleable": ["None", "False"], "sub_class": ["None", "Sub Class 1"], "product_class": ["None", "Class 1"], "color_shade_theme": ["None", ""], "exp_date": ["None", "False"], "ean_code": ["None", ""], "category": ["None", "IT"], "costing_method": ["None", "1"], "sales_qdn_item": ["None", "sales.QdnItems.None"], "imported_by": ["None", ""], "bill_of_material": ["None", "False"], "jobcard": ["None", "planning.JobOrder.None"], "product_name": ["None", "New FG 2"], "brand": ["None", "Neti"], "shape_code": ["None", ""], "tpc": ["None", "False"], "ins": ["None", "False"], "isgstapplicable": ["None", "True"], "trs": ["None", "False"], "size": ["None", ""], "sub_brand": ["None", "Neti - Sub"], "purchase_qdn_item": ["None", "purchase.QdnItems.None"], "behaviour": ["None", "False"], "mkt_by": ["None", ""], "pricelist": ["None", "ledgers.Price_list.None"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "id": ["None", "5"], "created": ["None", "2023-09-12"], "mfd_by": ["None", ""], "valuation_method": ["None", "1"], "product_type": ["None", "IB"], "country_of_origin": ["None", ""], "consumableitem": ["None", "production.ConsItems.None"], "set_std_rate": ["None", "False"], "series": ["None", ""], "article_code": ["None", "5112210005"], "consumption_item": ["None", "production.ConsumptionItems.None"], "description": ["None", "New FG 2"], "gstdetail": ["None", "inventory.Gst_list.None"], "updated": ["None", "2023-09-12"], "dl_purchase": ["None", "GST SALES A/C"], "units_of_measure": ["None", "Demo"], "dl_sales": ["None", "GST SALES A/C"], "mrp": ["None", "0"], "is_batch": ["None", "False"], "pattern": ["None", ""], "tsm": ["None", "False"], "product_code": ["None", "NFG2"], "style_shape": ["None", ""], "ipd": ["None", "False"]}	2023-09-12 11:11:54.575+05:30	2	20	127.0.0.1	\N
415	5	5	NFG2	1	{"gst": ["0.00", "0"], "additional_units": ["None", "Demo"], "mrp": ["0.00", "0"]}	2023-09-12 11:11:54.587+05:30	2	20	127.0.0.1	\N
416	3	3		0	{"description": ["None", " "], "name": ["None", ""], "updated": ["None", "2023-09-12"], "id": ["None", "3"], "product": ["None", "NFG"], "jobcard": ["None", "planning.JobOrder.None"], "created": ["None", "2023-09-12"]}	2023-09-12 11:33:59.379+05:30	2	42	127.0.0.1	\N
417	8	8		0	{"qty": ["None", "100"], "id": ["None", "8"], "bom": ["None", ""], "item": ["None", "RAW1"]}	2023-09-12 11:33:59.39+05:30	2	43	127.0.0.1	\N
418	9	9		0	{"qty": ["None", "200"], "id": ["None", "9"], "bom": ["None", ""], "item": ["None", "NFG2"]}	2023-09-12 11:33:59.399+05:30	2	43	127.0.0.1	\N
419	3	3	NFG	1	{"description": [" ", " NFG"], "name": ["", "NFG"]}	2023-09-12 11:34:08.909+05:30	2	42	127.0.0.1	\N
420	9	9	NFG	2	{"qty": ["200.0000", "None"], "id": ["9", "None"], "bom": ["NFG", "None"], "item": ["NFG2", "None"]}	2023-09-12 11:34:08.918+05:30	2	43	127.0.0.1	\N
421	8	8	NFG	2	{"qty": ["100.0000", "None"], "id": ["8", "None"], "bom": ["NFG", "None"], "item": ["RAW1", "None"]}	2023-09-12 11:34:08.92+05:30	2	43	127.0.0.1	\N
422	10	10	NFG	0	{"qty": ["None", "100.0000"], "id": ["None", "10"], "bom": ["None", "NFG"], "item": ["None", "RAW1"]}	2023-09-12 11:34:08.928+05:30	2	43	127.0.0.1	\N
423	11	11	NFG	0	{"qty": ["None", "200.0000"], "id": ["None", "11"], "bom": ["None", "NFG"], "item": ["None", "NFG2"]}	2023-09-12 11:34:08.934+05:30	2	43	127.0.0.1	\N
442	3	3	grnItems object (3)	0	{"id": ["None", "3"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "cgst": ["None", "0.00"], "mrp": ["None", "0.00"], "product_code": ["None", "NFG2"], "recd_qty": ["None", "100"], "igstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "grn": ["None", "2223GRN00004"], "amount": ["None", "100.00"], "pack": ["None", "1000.00"], "rate": ["None", "1.00"], "item": ["None", "NFG2"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "batch": ["None", "20230912002001"]}	2023-09-12 11:53:52.532+05:30	2	58	127.0.0.1	\N
424	7	7	NFG JO	0	{"product": ["None", "NFG"], "jobwork": ["None", "production.JobCard.None"], "ref": ["None", ""], "qty": ["None", "10"], "updated": ["None", "2023-09-12 06:04:41.611249"], "no": ["None", "2223JO00007"], "status": ["None", "1"], "name": ["None", "NFG JO"], "id": ["None", "7"], "remarks": ["None", "NFG JO"], "created": ["None", "2023-09-12 06:04:41.611226"], "bom": ["None", "NFG"], "category": ["None", "NFG JO"], "details": ["None", "NFG JO"], "company": ["None", "ABC"], "issuedby": ["None", "admin"], "date": ["None", "2023-09-12 06:04:41.610996"], "due_date": ["None", "2023-09-13"], "remain_qty": ["None", "10"]}	2023-09-12 11:34:41.62+05:30	2	44	127.0.0.1	\N
425	5	5	NFG2	1	{"inner_qty": ["None", "1000"], "outer_qty": ["None", "1000"]}	2023-09-12 11:35:41.649+05:30	2	20	127.0.0.1	\N
426	4	4	NFG	1	{"inner_qty": ["None", "1000"], "outer_qty": ["None", "1000"]}	2023-09-12 11:35:56.453+05:30	2	20	127.0.0.1	\N
427	4	4	NFG	1	{"inner_qty": ["1000.00", "1000"], "outer_qty": ["1000.00", "1000"]}	2023-09-12 11:35:59.743+05:30	2	20	127.0.0.1	\N
428	11	11	NFG	2	{"qty": ["200.0000", "None"], "id": ["11", "None"], "bom": ["NFG", "None"], "item": ["NFG2", "None"]}	2023-09-12 11:37:15.372+05:30	2	43	127.0.0.1	\N
429	10	10	NFG	2	{"qty": ["100.0000", "None"], "id": ["10", "None"], "bom": ["NFG", "None"], "item": ["RAW1", "None"]}	2023-09-12 11:37:15.375+05:30	2	43	127.0.0.1	\N
430	12	12	NFG	0	{"qty": ["None", "1000.0000"], "id": ["None", "12"], "bom": ["None", "NFG"], "item": ["None", "RAW1"]}	2023-09-12 11:37:15.381+05:30	2	43	127.0.0.1	\N
431	13	13	NFG	0	{"qty": ["None", "2000.0000"], "id": ["None", "13"], "bom": ["None", "NFG"], "item": ["None", "NFG2"]}	2023-09-12 11:37:15.39+05:30	2	43	127.0.0.1	\N
432	4	4	NFG	1	{"inner_qty": ["1000.00", "None"], "outer_qty": ["1000.00", "None"]}	2023-09-12 11:41:16.972+05:30	2	20	127.0.0.1	\N
433	7	7	NFG JO	1	{"qty": ["10.0000", "1"], "date": ["2023-09-12", "2023-09-12 06:12:49.016525"], "remain_qty": ["10.0000", "1"]}	2023-09-12 11:42:49.019+05:30	2	44	127.0.0.1	\N
434	4	4	New FG 2	0	{"created": ["None", "2023-09-12"], "id": ["None", "4"], "applicable_from": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "rate": ["None", "1"], "product": ["None", "NFG2"], "uom": ["None", "Demo"], "rate_type": ["None", "1"]}	2023-09-12 11:50:14.782+05:30	2	21	127.0.0.1	\N
435	4	4	2223PO00003	0	{"po_due_date": ["None", "2023-09-13"], "cgst": ["None", "0"], "dispatch_through": ["None", ""], "seller_gst_reg_type": ["None", "Regular"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "shipto_country": ["None", "INDIA"], "po_date": ["None", "2023-09-12"], "grn": ["None", "purchase.Grn.None"], "seller_gstin": ["None", "AAAAAAA0258A"], "mode_of_payment": ["None", ""], "company": ["None", "ABC"], "igst": ["None", "0"], "shipto": ["None", "ABC"], "status": ["None", "1"], "terms_of_delivery": ["None", ""], "total": ["None", "0"], "tcs": ["None", "0"], "seller_city": ["None", "Pune"], "shipto_state": ["None", "GUJARAT"], "po_no": ["None", "2223PO00003"], "seller_country": ["None", "India"], "other": ["None", "0"], "seller_pincode": ["None", "392220"], "shipto_address1": ["None", "ABCD"], "updated": ["None", "2023-09-12 06:20:53.133622"], "shipto_pincode": ["None", "391775"], "seller_address1": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "ex_rate": ["None", "1"], "sgst": ["None", "0"], "seller_address3": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "id": ["None", "4"], "ol_rate": ["None", "0"], "narration": ["None", ""], "shipto_city": ["None", "VADODARA"], "ammount": ["None", "0"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "round_off": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "created": ["None", "2023-09-12 06:20:53.133592"], "seller_address2": ["None", "ABC"], "currency": ["None", "001"]}	2023-09-12 11:50:53.14+05:30	2	54	127.0.0.1	\N
436	4	4	2223PO00003	0	{"id": ["None", "4"], "sgstrate": ["None", "0"], "amend_qty": ["None", "0"], "pack": ["None", "1000.00"], "cgstrate": ["None", "0"], "amount": ["None", "100.00"], "po": ["None", "2223PO00003"], "item": ["None", "NFG2"], "rate": ["None", "1"], "basic_qty": ["None", "100"], "cgst": ["None", "0.00"], "actual_qty": ["None", "100"], "product_code": ["None", "NFG2"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 11:50:53.152+05:30	2	55	127.0.0.1	\N
437	5	5	2223PO00003	0	{"id": ["None", "5"], "sgstrate": ["None", "0"], "amend_qty": ["None", "0"], "pack": ["None", "1.00"], "cgstrate": ["None", "0"], "amount": ["None", "100.00"], "po": ["None", "2223PO00003"], "item": ["None", "RAW1"], "rate": ["None", "1"], "basic_qty": ["None", "100"], "cgst": ["None", "0.00"], "actual_qty": ["None", "100"], "product_code": ["None", "RAW1"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 11:50:53.161+05:30	2	55	127.0.0.1	\N
438	4	4	2223PO00003	1	{"cgst": ["0.00", "0"], "igst": ["0.00", "0"], "total": ["0.00", "200"], "other": ["0.00", "0"], "ex_rate": ["1.00", "1"], "sgst": ["0.00", "0"], "ol_rate": ["0.00", "0"], "ammount": ["0.00", "200.00"]}	2023-09-12 11:50:53.17+05:30	2	54	127.0.0.1	\N
439	4	4	2223GRN00004	0	{"mode_of_payment": ["None", ""], "updated": ["None", "2023-09-12 06:23:52.490540"], "seller_address1": ["None", "ABC"], "dispatch_through": ["None", "0"], "tcs": ["None", "0"], "seller_address2": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "status": ["None", "1"], "grn_no": ["None", "2223GRN00004"], "narration": ["None", ""], "other": ["None", "0"], "seller_country": ["None", "India"], "seller_pincode": ["None", "392220"], "created": ["None", "2023-09-12 06:23:52.490516"], "shipto_city": ["None", "VADODARA"], "shipto_mailingname": ["None", "ABCD"], "igst": ["None", "0"], "seller_city": ["None", "Pune"], "seller_mailingname": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "sgst": ["None", "0"], "ammount": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "cgst": ["None", "0"], "ex_rate": ["None", "2"], "other_reference": ["None", ""], "seller_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "seller_address3": ["None", "ABC"], "shipto_state": ["None", "GUJARAT"], "terms_of_delivery": ["None", ""], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "shipto_country": ["None", "INDIA"], "shipto_pincode": ["None", "391775"], "grn_date": ["None", "2023-09-12"], "seller_gstin": ["None", "AAAAAAA0258A"], "total": ["None", "0"], "shipto": ["None", "ABC"], "currency": ["None", "001"], "shipto_address1": ["None", "ABCD"], "round_off": ["None", "0"], "po": ["None", "2223PO00003"], "id": ["None", "4"]}	2023-09-12 11:53:52.496+05:30	2	57	127.0.0.1	\N
440	4	4	2223PO00003	1	{"actual_qty": ["100.00", "0.00"]}	2023-09-12 11:53:52.508+05:30	2	55	127.0.0.1	\N
441	14	14	UN ALLOCATED	0	{"godown": ["None", "UN ALLOCATED"], "updated": ["None", "2023-09-12"], "rate": ["None", "2.00"], "closing_balance": ["None", "100"], "created": ["None", "2023-09-12"], "mrp": ["None", "0.00"], "id": ["None", "14"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912002001"]}	2023-09-12 11:53:52.523+05:30	2	84	127.0.0.1	\N
443	5	5	2223PO00003	1	{"actual_qty": ["100.00", "0.00"]}	2023-09-12 11:53:52.541+05:30	2	55	127.0.0.1	\N
445	4	4	grnItems object (4)	0	{"id": ["None", "4"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "cgst": ["None", "0.00"], "mrp": ["None", "345.00"], "product_code": ["None", "RAW1"], "recd_qty": ["None", "100"], "igstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "grn": ["None", "2223GRN00004"], "amount": ["None", "100.00"], "pack": ["None", "1.00"], "rate": ["None", "1.00"], "item": ["None", "RAW1"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "batch": ["None", "20230912002002"]}	2023-09-12 11:53:52.564+05:30	2	58	127.0.0.1	\N
446	4	4	2223GRN00004	1	{"tcs": ["0.00", "0"], "other": ["0.00", "0"], "ammount": ["0.00", "200.00"], "ex_rate": ["2.00", "2"], "total": ["0.00", "200"]}	2023-09-12 11:53:52.573+05:30	2	57	127.0.0.1	\N
447	4	4	2223PO00003	1	{"status": ["1", "4"]}	2023-09-12 11:53:52.588+05:30	2	54	127.0.0.1	\N
448	2	2	2223PINV00002	0	{"ol_rate": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto": ["None", "ABC"], "shipto_address1": ["None", "ABCD"], "seller": ["None", "ABC"], "total": ["None", "0"], "mode_of_payment": ["None", ""], "supplier_date": ["None", "2023-09-12"], "seller_gst_reg_type": ["None", "Regular"], "shipto_country": ["None", "INDIA"], "igst": ["None", "0"], "tcs": ["None", "0"], "dispatch_through": ["None", "0"], "terms_of_delivery": ["None", ""], "other": ["None", "0"], "pi_no": ["None", "2223PINV00002"], "seller_pincode": ["None", "392220"], "ammount": ["None", "0"], "pi_date": ["None", "2023-09-12"], "seller_gstin": ["None", "AAAAAAA0258A"], "seller_address_type": ["None", "Default"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "supplier_invoice": ["None", "777"], "sgst": ["None", "0"], "seller_address1": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "company": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "round_off": ["None", "0"], "created": ["None", "2023-09-12 06:24:35.072226"], "shipto_address3": ["None", "ABCD"], "updated": ["None", "2023-09-12 06:24:35.072248"], "seller_address2": ["None", "ABC"], "cgst": ["None", "0"], "currency": ["None", "001"], "narration": ["None", ""], "seller_address3": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "grn": ["None", "purchase.Grn.None"], "ex_rate": ["None", "2.00"], "seller_state": ["None", "Maharashtra"], "is_ict": ["None", "False"], "seller_country": ["None", "India"], "shipto_city": ["None", "VADODARA"], "id": ["None", "2"], "status": ["None", "1"], "seller_city": ["None", "Pune"], "shipto_mailingname": ["None", "ABCD"], "shipto_state": ["None", "GUJARAT"]}	2023-09-12 11:54:35.078+05:30	2	56	127.0.0.1	\N
449	4	4	2223GRN00004	1	{"status": ["1", "3"], "pi": ["None", "2223PINV00002"]}	2023-09-12 11:54:35.098+05:30	2	57	127.0.0.1	\N
450	14	14	UN ALLOCATED	1	{"rate": ["2.00", "1.00"]}	2023-09-12 11:54:35.119+05:30	2	84	127.0.0.1	\N
451	15	15	UN ALLOCATED	1	{"rate": ["2.00", "1.00"]}	2023-09-12 11:54:35.138+05:30	2	84	127.0.0.1	\N
452	4	4	2223PO00003	1	{"status": ["4", "5"]}	2023-09-12 11:54:35.154+05:30	2	54	127.0.0.1	\N
453	2	2	2223PINV00002	1	{"ol_rate": ["0.00", "0"], "total": ["0.00", "200"], "igst": ["0.00", "0"], "ammount": ["0.00", "200.00"], "sgst": ["0.00", "0"], "cgst": ["0.00", "0"]}	2023-09-12 11:54:35.168+05:30	2	56	127.0.0.1	\N
454	3	3	PalletTransferEntry object (3)	0	{"createdby": ["None", "admin"], "company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "id": ["None", "3"], "qty": ["None", "100"], "item": ["None", "NFG2"], "fgodown": ["None", "UN ALLOCATED"], "created": ["None", "2023-09-12"]}	2023-09-12 11:57:23.99+05:30	2	87	127.0.0.1	\N
455	16	16	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "created": ["None", "2023-09-12"], "mrp": ["None", "0.00"], "id": ["None", "16"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912002001"]}	2023-09-12 11:57:24+05:30	2	84	127.0.0.1	\N
456	14	14	UN ALLOCATED	2	{"godown": ["UN ALLOCATED", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["100.0000", "None"], "created": ["2023-09-12", "None"], "mrp": ["0.00", "None"], "id": ["14", "None"], "company": ["ABC", "None"], "product": ["NFG2", "None"], "batch": ["20230912002001", "None"]}	2023-09-12 11:57:24.006+05:30	2	84	127.0.0.1	\N
457	16	16	PRODUCTION	1	{"closing_balance": ["None", "100.0000"]}	2023-09-12 11:57:24.014+05:30	2	84	127.0.0.1	\N
458	4	4	PalletTransferEntry object (4)	0	{"createdby": ["None", "admin"], "company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "id": ["None", "4"], "qty": ["None", "100"], "item": ["None", "RAW1"], "fgodown": ["None", "UN ALLOCATED"], "created": ["None", "2023-09-12"]}	2023-09-12 11:58:46.092+05:30	2	87	127.0.0.1	\N
459	17	17	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "created": ["None", "2023-09-12"], "mrp": ["None", "345.00"], "id": ["None", "17"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230912002002"]}	2023-09-12 11:58:46.104+05:30	2	84	127.0.0.1	\N
460	15	15	UN ALLOCATED	2	{"godown": ["UN ALLOCATED", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["100.0000", "None"], "created": ["2023-09-12", "None"], "mrp": ["345.00", "None"], "id": ["15", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "batch": ["20230912002002", "None"]}	2023-09-12 11:58:46.111+05:30	2	84	127.0.0.1	\N
461	17	17	PRODUCTION	1	{"closing_balance": ["None", "100.0000"]}	2023-09-12 11:58:46.119+05:30	2	84	127.0.0.1	\N
462	5	5	2223PO00004	0	{"po_due_date": ["None", "2023-09-13"], "cgst": ["None", "0"], "dispatch_through": ["None", ""], "seller_gst_reg_type": ["None", "Regular"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "shipto_country": ["None", "INDIA"], "po_date": ["None", "2023-09-12"], "grn": ["None", "purchase.Grn.None"], "seller_gstin": ["None", "AAAAAAA0258A"], "mode_of_payment": ["None", ""], "company": ["None", "ABC"], "igst": ["None", "0"], "shipto": ["None", "ABC"], "status": ["None", "1"], "terms_of_delivery": ["None", ""], "total": ["None", "0"], "tcs": ["None", "0"], "seller_city": ["None", "Pune"], "shipto_state": ["None", "GUJARAT"], "po_no": ["None", "2223PO00004"], "seller_country": ["None", "India"], "other": ["None", "0"], "seller_pincode": ["None", "392220"], "shipto_address1": ["None", "ABCD"], "updated": ["None", "2023-09-12 06:30:05.191790"], "shipto_pincode": ["None", "391775"], "seller_address1": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "ex_rate": ["None", "1"], "sgst": ["None", "0"], "seller_address3": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "id": ["None", "5"], "ol_rate": ["None", "0"], "narration": ["None", ""], "shipto_city": ["None", "VADODARA"], "ammount": ["None", "0"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "round_off": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "created": ["None", "2023-09-12 06:30:05.191766"], "seller_address2": ["None", "ABC"], "currency": ["None", "001"]}	2023-09-12 12:00:05.199+05:30	2	54	127.0.0.1	\N
481	18	18	UN ALLOCATED	2	{"godown": ["UN ALLOCATED", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["1500.0000", "None"], "created": ["2023-09-12", "None"], "mrp": ["345.00", "None"], "id": ["18", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "batch": ["20230912003001", "None"]}	2023-09-12 12:01:04.1+05:30	2	84	127.0.0.1	\N
463	6	6	2223PO00004	0	{"id": ["None", "6"], "sgstrate": ["None", "0"], "amend_qty": ["None", "0"], "pack": ["None", "1.00"], "cgstrate": ["None", "0"], "amount": ["None", "1500.00"], "po": ["None", "2223PO00004"], "item": ["None", "RAW1"], "rate": ["None", "1"], "basic_qty": ["None", "1500"], "cgst": ["None", "0.00"], "actual_qty": ["None", "1500"], "product_code": ["None", "RAW1"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 12:00:05.21+05:30	2	55	127.0.0.1	\N
464	7	7	2223PO00004	0	{"id": ["None", "7"], "sgstrate": ["None", "0"], "amend_qty": ["None", "0"], "pack": ["None", "1000.00"], "cgstrate": ["None", "0"], "amount": ["None", "1500.00"], "po": ["None", "2223PO00004"], "item": ["None", "NFG2"], "rate": ["None", "1"], "basic_qty": ["None", "1500"], "cgst": ["None", "0.00"], "actual_qty": ["None", "1500"], "product_code": ["None", "NFG2"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 12:00:05.22+05:30	2	55	127.0.0.1	\N
465	5	5	2223PO00004	1	{"cgst": ["0.00", "0"], "igst": ["0.00", "0"], "total": ["0.00", "3000"], "other": ["0.00", "0"], "ex_rate": ["1.00", "1"], "sgst": ["0.00", "0"], "ol_rate": ["0.00", "0"], "ammount": ["0.00", "3000.00"]}	2023-09-12 12:00:05.227+05:30	2	54	127.0.0.1	\N
466	5	5	2223GRN00005	0	{"mode_of_payment": ["None", ""], "updated": ["None", "2023-09-12 06:30:28.542274"], "seller_address1": ["None", "ABC"], "dispatch_through": ["None", "0"], "tcs": ["None", "0"], "seller_address2": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "status": ["None", "1"], "grn_no": ["None", "2223GRN00005"], "narration": ["None", ""], "other": ["None", "0"], "seller_country": ["None", "India"], "seller_pincode": ["None", "392220"], "created": ["None", "2023-09-12 06:30:28.542231"], "shipto_city": ["None", "VADODARA"], "shipto_mailingname": ["None", "ABCD"], "igst": ["None", "0"], "seller_city": ["None", "Pune"], "seller_mailingname": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "sgst": ["None", "0"], "ammount": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "cgst": ["None", "0"], "ex_rate": ["None", "1"], "other_reference": ["None", ""], "seller_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "seller_address3": ["None", "ABC"], "shipto_state": ["None", "GUJARAT"], "terms_of_delivery": ["None", ""], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "shipto_country": ["None", "INDIA"], "shipto_pincode": ["None", "391775"], "grn_date": ["None", "2023-09-12"], "seller_gstin": ["None", "AAAAAAA0258A"], "total": ["None", "0"], "shipto": ["None", "ABC"], "currency": ["None", "001"], "shipto_address1": ["None", "ABCD"], "round_off": ["None", "0"], "po": ["None", "2223PO00004"], "id": ["None", "5"]}	2023-09-12 12:00:28.548+05:30	2	57	127.0.0.1	\N
467	6	6	2223PO00004	1	{"actual_qty": ["1500.00", "0.00"]}	2023-09-12 12:00:28.557+05:30	2	55	127.0.0.1	\N
468	18	18	UN ALLOCATED	0	{"godown": ["None", "UN ALLOCATED"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "1500"], "created": ["None", "2023-09-12"], "mrp": ["None", "345.00"], "id": ["None", "18"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230912003001"]}	2023-09-12 12:00:28.57+05:30	2	84	127.0.0.1	\N
469	5	5	grnItems object (5)	0	{"id": ["None", "5"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "cgst": ["None", "0.00"], "mrp": ["None", "345.00"], "product_code": ["None", "RAW1"], "recd_qty": ["None", "1500"], "igstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "grn": ["None", "2223GRN00005"], "amount": ["None", "1500.00"], "pack": ["None", "1.00"], "rate": ["None", "1.00"], "item": ["None", "RAW1"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "batch": ["None", "20230912003001"]}	2023-09-12 12:00:28.579+05:30	2	58	127.0.0.1	\N
470	7	7	2223PO00004	1	{"actual_qty": ["1500.00", "0.00"]}	2023-09-12 12:00:28.587+05:30	2	55	127.0.0.1	\N
471	19	19	UN ALLOCATED	0	{"godown": ["None", "UN ALLOCATED"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "1500"], "created": ["None", "2023-09-12"], "mrp": ["None", "0.00"], "id": ["None", "19"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912003002"]}	2023-09-12 12:00:28.6+05:30	2	84	127.0.0.1	\N
472	6	6	grnItems object (6)	0	{"id": ["None", "6"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "cgst": ["None", "0.00"], "mrp": ["None", "0.00"], "product_code": ["None", "NFG2"], "recd_qty": ["None", "1500"], "igstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "grn": ["None", "2223GRN00005"], "amount": ["None", "1500.00"], "pack": ["None", "1000.00"], "rate": ["None", "1.00"], "item": ["None", "NFG2"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "batch": ["None", "20230912003002"]}	2023-09-12 12:00:28.609+05:30	2	58	127.0.0.1	\N
473	5	5	2223GRN00005	1	{"tcs": ["0.00", "0"], "other": ["0.00", "0"], "ammount": ["0.00", "3000.00"], "ex_rate": ["1.00", "1"], "total": ["0.00", "3000"]}	2023-09-12 12:00:28.618+05:30	2	57	127.0.0.1	\N
474	5	5	2223PO00004	1	{"status": ["1", "4"]}	2023-09-12 12:00:28.631+05:30	2	54	127.0.0.1	\N
475	3	3	2223PINV00003	0	{"ol_rate": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto": ["None", "ABC"], "shipto_address1": ["None", "ABCD"], "seller": ["None", "ABC"], "total": ["None", "0"], "mode_of_payment": ["None", ""], "supplier_date": ["None", "2023-09-12"], "seller_gst_reg_type": ["None", "Regular"], "shipto_country": ["None", "INDIA"], "igst": ["None", "0"], "tcs": ["None", "0"], "dispatch_through": ["None", "0"], "terms_of_delivery": ["None", ""], "other": ["None", "0"], "pi_no": ["None", "2223PINV00003"], "seller_pincode": ["None", "392220"], "ammount": ["None", "0"], "pi_date": ["None", "2023-09-12"], "seller_gstin": ["None", "AAAAAAA0258A"], "seller_address_type": ["None", "Default"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "supplier_invoice": ["None", "888"], "sgst": ["None", "0"], "seller_address1": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "company": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "round_off": ["None", "0"], "created": ["None", "2023-09-12 06:30:48.256057"], "shipto_address3": ["None", "ABCD"], "updated": ["None", "2023-09-12 06:30:48.256078"], "seller_address2": ["None", "ABC"], "cgst": ["None", "0"], "currency": ["None", "001"], "narration": ["None", ""], "seller_address3": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "grn": ["None", "purchase.Grn.None"], "ex_rate": ["None", "1.00"], "seller_state": ["None", "Maharashtra"], "is_ict": ["None", "False"], "seller_country": ["None", "India"], "shipto_city": ["None", "VADODARA"], "id": ["None", "3"], "status": ["None", "1"], "seller_city": ["None", "Pune"], "shipto_mailingname": ["None", "ABCD"], "shipto_state": ["None", "GUJARAT"]}	2023-09-12 12:00:48.264+05:30	2	56	127.0.0.1	\N
476	5	5	2223GRN00005	1	{"status": ["1", "3"], "pi": ["None", "2223PINV00003"]}	2023-09-12 12:00:48.283+05:30	2	57	127.0.0.1	\N
477	5	5	2223PO00004	1	{"status": ["4", "5"]}	2023-09-12 12:00:48.333+05:30	2	54	127.0.0.1	\N
478	3	3	2223PINV00003	1	{"ol_rate": ["0.00", "0"], "total": ["0.00", "3000"], "igst": ["0.00", "0"], "ammount": ["0.00", "3000.00"], "sgst": ["0.00", "0"], "cgst": ["0.00", "0"]}	2023-09-12 12:00:48.345+05:30	2	56	127.0.0.1	\N
482	20	20	PRODUCTION	1	{"closing_balance": ["None", "1500.0000"]}	2023-09-12 12:01:04.106+05:30	2	84	127.0.0.1	\N
483	6	6	PalletTransferEntry object (6)	0	{"createdby": ["None", "admin"], "company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "id": ["None", "6"], "qty": ["None", "1500"], "item": ["None", "NFG2"], "fgodown": ["None", "UN ALLOCATED"], "created": ["None", "2023-09-12"]}	2023-09-12 12:01:13.669+05:30	2	87	127.0.0.1	\N
484	21	21	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "created": ["None", "2023-09-12"], "mrp": ["None", "0.00"], "id": ["None", "21"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912003002"]}	2023-09-12 12:01:13.68+05:30	2	84	127.0.0.1	\N
485	19	19	UN ALLOCATED	2	{"godown": ["UN ALLOCATED", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["1500.0000", "None"], "created": ["2023-09-12", "None"], "mrp": ["0.00", "None"], "id": ["19", "None"], "company": ["ABC", "None"], "product": ["NFG2", "None"], "batch": ["20230912003002", "None"]}	2023-09-12 12:01:13.686+05:30	2	84	127.0.0.1	\N
486	21	21	PRODUCTION	1	{"closing_balance": ["None", "1500.0000"]}	2023-09-12 12:01:13.694+05:30	2	84	127.0.0.1	\N
487	6	6	2223PO00005	0	{"po_due_date": ["None", "2023-09-13"], "cgst": ["None", "0"], "dispatch_through": ["None", ""], "seller_gst_reg_type": ["None", "Regular"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "shipto_country": ["None", "INDIA"], "po_date": ["None", "2023-09-12"], "grn": ["None", "purchase.Grn.None"], "seller_gstin": ["None", "AAAAAAA0258A"], "mode_of_payment": ["None", ""], "company": ["None", "ABC"], "igst": ["None", "0"], "shipto": ["None", "ABC"], "status": ["None", "1"], "terms_of_delivery": ["None", ""], "total": ["None", "0"], "tcs": ["None", "0"], "seller_city": ["None", "Pune"], "shipto_state": ["None", "GUJARAT"], "po_no": ["None", "2223PO00005"], "seller_country": ["None", "India"], "other": ["None", "0"], "seller_pincode": ["None", "392220"], "shipto_address1": ["None", "ABCD"], "updated": ["None", "2023-09-12 06:32:20.457811"], "shipto_pincode": ["None", "391775"], "seller_address1": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "ex_rate": ["None", "1"], "sgst": ["None", "0"], "seller_address3": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "id": ["None", "6"], "ol_rate": ["None", "0"], "narration": ["None", ""], "shipto_city": ["None", "VADODARA"], "ammount": ["None", "0"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "round_off": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "created": ["None", "2023-09-12 06:32:20.457784"], "seller_address2": ["None", "ABC"], "currency": ["None", "001"]}	2023-09-12 12:02:20.463+05:30	2	54	127.0.0.1	\N
488	8	8	2223PO00005	0	{"id": ["None", "8"], "sgstrate": ["None", "0"], "amend_qty": ["None", "0"], "pack": ["None", "1000.00"], "cgstrate": ["None", "0"], "amount": ["None", "500.00"], "po": ["None", "2223PO00005"], "item": ["None", "NFG2"], "rate": ["None", "1"], "basic_qty": ["None", "500"], "cgst": ["None", "0.00"], "actual_qty": ["None", "500"], "product_code": ["None", "NFG2"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 12:02:20.474+05:30	2	55	127.0.0.1	\N
489	6	6	2223PO00005	1	{"cgst": ["0.00", "0"], "igst": ["0.00", "0"], "total": ["0.00", "500"], "other": ["0.00", "0"], "ex_rate": ["1.00", "1"], "sgst": ["0.00", "0"], "ol_rate": ["0.00", "0"], "ammount": ["0.00", "500.00"]}	2023-09-12 12:02:20.481+05:30	2	54	127.0.0.1	\N
490	6	6	2223GRN00006	0	{"mode_of_payment": ["None", ""], "updated": ["None", "2023-09-12 06:32:37.946867"], "seller_address1": ["None", "ABC"], "dispatch_through": ["None", "0"], "tcs": ["None", "0"], "seller_address2": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "status": ["None", "1"], "grn_no": ["None", "2223GRN00006"], "narration": ["None", ""], "other": ["None", "0"], "seller_country": ["None", "India"], "seller_pincode": ["None", "392220"], "created": ["None", "2023-09-12 06:32:37.946846"], "shipto_city": ["None", "VADODARA"], "shipto_mailingname": ["None", "ABCD"], "igst": ["None", "0"], "seller_city": ["None", "Pune"], "seller_mailingname": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "sgst": ["None", "0"], "ammount": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "cgst": ["None", "0"], "ex_rate": ["None", "1"], "other_reference": ["None", ""], "seller_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "seller_address3": ["None", "ABC"], "shipto_state": ["None", "GUJARAT"], "terms_of_delivery": ["None", ""], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "shipto_country": ["None", "INDIA"], "shipto_pincode": ["None", "391775"], "grn_date": ["None", "2023-09-12"], "seller_gstin": ["None", "AAAAAAA0258A"], "total": ["None", "0"], "shipto": ["None", "ABC"], "currency": ["None", "001"], "shipto_address1": ["None", "ABCD"], "round_off": ["None", "0"], "po": ["None", "2223PO00005"], "id": ["None", "6"]}	2023-09-12 12:02:37.954+05:30	2	57	127.0.0.1	\N
491	8	8	2223PO00005	1	{"actual_qty": ["500.00", "0.00"]}	2023-09-12 12:02:37.963+05:30	2	55	127.0.0.1	\N
492	22	22	UN ALLOCATED	0	{"godown": ["None", "UN ALLOCATED"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "500"], "created": ["None", "2023-09-12"], "mrp": ["None", "0.00"], "id": ["None", "22"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912004001"]}	2023-09-12 12:02:37.976+05:30	2	84	127.0.0.1	\N
493	7	7	grnItems object (7)	0	{"id": ["None", "7"], "actual_qty": ["None", "0.00"], "igst": ["None", "0.00"], "cgst": ["None", "0.00"], "mrp": ["None", "0.00"], "product_code": ["None", "NFG2"], "recd_qty": ["None", "500"], "igstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "grn": ["None", "2223GRN00006"], "amount": ["None", "500.00"], "pack": ["None", "1000.00"], "rate": ["None", "1.00"], "item": ["None", "NFG2"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "batch": ["None", "20230912004001"]}	2023-09-12 12:02:37.987+05:30	2	58	127.0.0.1	\N
494	6	6	2223GRN00006	1	{"tcs": ["0.00", "0"], "other": ["0.00", "0"], "ammount": ["0.00", "500.00"], "ex_rate": ["1.00", "1"], "total": ["0.00", "500"]}	2023-09-12 12:02:37.994+05:30	2	57	127.0.0.1	\N
495	6	6	2223PO00005	1	{"status": ["1", "4"]}	2023-09-12 12:02:38.007+05:30	2	54	127.0.0.1	\N
518	21	21	PRODUCTION	2	{"godown": ["PRODUCTION", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["0", "None"], "created": ["2023-09-12", "None"], "mrp": ["0.00", "None"], "id": ["21", "None"], "company": ["ABC", "None"], "product": ["NFG2", "None"], "batch": ["20230912003002", "None"]}	2023-09-12 12:04:03.553+05:30	2	84	127.0.0.1	\N
519	9	9	RMItemGodown object (9)	0	{"mrp": ["None", ""], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "godown": ["None", "PRODUCTION"], "rate": ["None", "1.00"], "qty": ["None", "1500.0000"], "id": ["None", "9"], "batch": ["None", "20230912003002"], "rmitem": ["None", "2223JC00008 NFG2"]}	2023-09-12 12:04:03.571+05:30	2	49	127.0.0.1	\N
520	23	23	PRODUCTION	1	{"closing_balance": ["500.0000", "100.0000"]}	2023-09-12 12:04:03.582+05:30	2	84	127.0.0.1	\N
496	4	4	2223PINV00004	0	{"ol_rate": ["None", "0"], "seller_mailingname": ["None", "ABC"], "shipto": ["None", "ABC"], "shipto_address1": ["None", "ABCD"], "seller": ["None", "ABC"], "total": ["None", "0"], "mode_of_payment": ["None", ""], "supplier_date": ["None", "2023-09-12"], "seller_gst_reg_type": ["None", "Regular"], "shipto_country": ["None", "INDIA"], "igst": ["None", "0"], "tcs": ["None", "0"], "dispatch_through": ["None", "0"], "terms_of_delivery": ["None", ""], "other": ["None", "0"], "pi_no": ["None", "2223PINV00004"], "seller_pincode": ["None", "392220"], "ammount": ["None", "0"], "pi_date": ["None", "2023-09-12"], "seller_gstin": ["None", "AAAAAAA0258A"], "seller_address_type": ["None", "Default"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "supplier_invoice": ["None", "999"], "sgst": ["None", "0"], "seller_address1": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "company": ["None", "ABC"], "shipto_address2": ["None", "ABCD"], "round_off": ["None", "0"], "created": ["None", "2023-09-12 06:33:00.091853"], "shipto_address3": ["None", "ABCD"], "updated": ["None", "2023-09-12 06:33:00.091901"], "seller_address2": ["None", "ABC"], "cgst": ["None", "0"], "currency": ["None", "001"], "narration": ["None", ""], "seller_address3": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "grn": ["None", "purchase.Grn.None"], "ex_rate": ["None", "1.00"], "seller_state": ["None", "Maharashtra"], "is_ict": ["None", "False"], "seller_country": ["None", "India"], "shipto_city": ["None", "VADODARA"], "id": ["None", "4"], "status": ["None", "1"], "seller_city": ["None", "Pune"], "shipto_mailingname": ["None", "ABCD"], "shipto_state": ["None", "GUJARAT"]}	2023-09-12 12:03:00.098+05:30	2	56	127.0.0.1	\N
497	6	6	2223GRN00006	1	{"status": ["1", "3"], "pi": ["None", "2223PINV00004"]}	2023-09-12 12:03:00.113+05:30	2	57	127.0.0.1	\N
498	6	6	2223PO00005	1	{"status": ["4", "5"]}	2023-09-12 12:03:00.146+05:30	2	54	127.0.0.1	\N
499	4	4	2223PINV00004	1	{"ol_rate": ["0.00", "0"], "total": ["0.00", "500"], "igst": ["0.00", "0"], "ammount": ["0.00", "500.00"], "sgst": ["0.00", "0"], "cgst": ["0.00", "0"]}	2023-09-12 12:03:00.16+05:30	2	56	127.0.0.1	\N
500	7	7	PalletTransferEntry object (7)	0	{"createdby": ["None", "admin"], "company": ["None", "ABC"], "tgodown": ["None", "PRODUCTION"], "id": ["None", "7"], "qty": ["None", "500"], "item": ["None", "NFG2"], "fgodown": ["None", "UN ALLOCATED"], "created": ["None", "2023-09-12"]}	2023-09-12 12:03:15.139+05:30	2	87	127.0.0.1	\N
501	23	23	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "created": ["None", "2023-09-12"], "mrp": ["None", "0.00"], "id": ["None", "23"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912004001"]}	2023-09-12 12:03:15.149+05:30	2	84	127.0.0.1	\N
502	22	22	UN ALLOCATED	2	{"godown": ["UN ALLOCATED", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["500.0000", "None"], "created": ["2023-09-12", "None"], "mrp": ["0.00", "None"], "id": ["22", "None"], "company": ["ABC", "None"], "product": ["NFG2", "None"], "batch": ["20230912004001", "None"]}	2023-09-12 12:03:15.156+05:30	2	84	127.0.0.1	\N
503	23	23	PRODUCTION	1	{"closing_balance": ["None", "500.0000"]}	2023-09-12 12:03:15.162+05:30	2	84	127.0.0.1	\N
504	8	8	2223JC00008	0	{"start": ["None", "2023-09-13"], "product": ["None", "NFG"], "qty": ["None", "1"], "id": ["None", "8"], "no": ["None", "2223JC00008"], "created": ["None", "2023-09-12 06:33:36.437161"], "status": ["None", "1"], "rqty": ["None", "1"], "rmindent": ["None", "production.RMIndent.None"], "updated": ["None", "2023-09-12 06:33:36.437183"], "joborder": ["None", "NFG JO"], "company": ["None", "ABC"], "consumption": ["None", "production.Consumption.None"]}	2023-09-12 12:03:36.445+05:30	2	46	127.0.0.1	\N
505	8	8	2223JC00008	0	{"id": ["None", "8"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "status": ["None", "1"], "company": ["None", "ABC"], "created": ["None", "2023-09-12 06:33:36.450389"], "no": ["None", "2223JC00008"], "jobcard": ["None", "2223JC00008"], "updated": ["None", "2023-09-12 06:33:36.450411"]}	2023-09-12 12:03:36.455+05:30	2	47	127.0.0.1	\N
506	13	13	2223JC00008 RAW1	0	{"rmindent": ["None", "2223JC00008"], "item": ["None", "RAW1"], "qty": ["None", "1000.0000"], "id": ["None", "13"], "bom": ["None", "NFG"]}	2023-09-12 12:03:36.467+05:30	2	48	127.0.0.1	\N
507	14	14	2223JC00008 NFG2	0	{"rmindent": ["None", "2223JC00008"], "item": ["None", "NFG2"], "qty": ["None", "2000.0000"], "id": ["None", "14"], "bom": ["None", "NFG"]}	2023-09-12 12:03:36.478+05:30	2	48	127.0.0.1	\N
508	7	7	NFG JO	1	{"status": ["1", "3"], "remain_qty": ["1.0000", "0.0000"]}	2023-09-12 12:03:36.484+05:30	2	44	127.0.0.1	\N
509	8	8	2223JC00008	1	{"status": ["1", "4"]}	2023-09-12 12:03:36.499+05:30	2	46	127.0.0.1	\N
510	3	3	New1231	2	{"godown": ["New1231", "None"], "updated": ["2023-09-05", "None"], "rate": ["120.00", "None"], "closing_balance": ["0", "None"], "created": ["2023-09-05", "None"], "mrp": ["345.00", "None"], "id": ["3", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "batch": ["20230905003001", "None"]}	2023-09-12 12:04:03.462+05:30	2	84	127.0.0.1	\N
511	5	5	RMItemGodown object (5)	0	{"mrp": ["None", ""], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "godown": ["None", "New1231"], "rate": ["None", "120.00"], "qty": ["None", "200.0000"], "id": ["None", "5"], "batch": ["None", "20230905003001"], "rmitem": ["None", "2223JC00008 RAW1"]}	2023-09-12 12:04:03.472+05:30	2	49	127.0.0.1	\N
512	17	17	PRODUCTION	2	{"godown": ["PRODUCTION", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["0", "None"], "created": ["2023-09-12", "None"], "mrp": ["345.00", "None"], "id": ["17", "None"], "company": ["ABC", "None"], "product": ["RAW1", "None"], "batch": ["20230912002002", "None"]}	2023-09-12 12:04:03.481+05:30	2	84	127.0.0.1	\N
513	6	6	RMItemGodown object (6)	0	{"mrp": ["None", ""], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "godown": ["None", "PRODUCTION"], "rate": ["None", "1.00"], "qty": ["None", "100.0000"], "id": ["None", "6"], "batch": ["None", "20230912002002"], "rmitem": ["None", "2223JC00008 RAW1"]}	2023-09-12 12:04:03.498+05:30	2	49	127.0.0.1	\N
514	20	20	PRODUCTION	1	{"closing_balance": ["1500.0000", "800.0000"]}	2023-09-12 12:04:03.506+05:30	2	84	127.0.0.1	\N
515	7	7	RMItemGodown object (7)	0	{"mrp": ["None", ""], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "godown": ["None", "PRODUCTION"], "rate": ["None", "1.00"], "qty": ["None", "700.0000"], "id": ["None", "7"], "batch": ["None", "20230912003001"], "rmitem": ["None", "2223JC00008 RAW1"]}	2023-09-12 12:04:03.518+05:30	2	49	127.0.0.1	\N
516	16	16	PRODUCTION	2	{"godown": ["PRODUCTION", "None"], "updated": ["2023-09-12", "None"], "rate": ["1.00", "None"], "closing_balance": ["0", "None"], "created": ["2023-09-12", "None"], "mrp": ["0.00", "None"], "id": ["16", "None"], "company": ["ABC", "None"], "product": ["NFG2", "None"], "batch": ["20230912002001", "None"]}	2023-09-12 12:04:03.527+05:30	2	84	127.0.0.1	\N
517	8	8	RMItemGodown object (8)	0	{"mrp": ["None", ""], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "godown": ["None", "PRODUCTION"], "rate": ["None", "1.00"], "qty": ["None", "100.0000"], "id": ["None", "8"], "batch": ["None", "20230912002001"], "rmitem": ["None", "2223JC00008 NFG2"]}	2023-09-12 12:04:03.546+05:30	2	49	127.0.0.1	\N
521	10	10	RMItemGodown object (10)	0	{"mrp": ["None", ""], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"], "godown": ["None", "PRODUCTION"], "rate": ["None", "1.00"], "qty": ["None", "400.0000"], "id": ["None", "10"], "batch": ["None", "20230912004001"], "rmitem": ["None", "2223JC00008 NFG2"]}	2023-09-12 12:04:03.595+05:30	2	49	127.0.0.1	\N
522	8	8	2223JC00008	1	{"status": ["1", "2"]}	2023-09-12 12:04:03.601+05:30	2	47	127.0.0.1	\N
523	24	24	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "120.00"], "closing_balance": ["None", "200.00"], "created": ["None", "2023-09-12"], "mrp": ["None", ""], "id": ["None", "24"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230905003001"]}	2023-09-12 12:04:23.157+05:30	2	84	127.0.0.1	\N
524	25	25	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "100.00"], "created": ["None", "2023-09-12"], "mrp": ["None", ""], "id": ["None", "25"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230912002002"]}	2023-09-12 12:04:23.169+05:30	2	84	127.0.0.1	\N
525	26	26	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "700.00"], "created": ["None", "2023-09-12"], "mrp": ["None", ""], "id": ["None", "26"], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230912003001"]}	2023-09-12 12:04:23.181+05:30	2	84	127.0.0.1	\N
526	27	27	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "100.00"], "created": ["None", "2023-09-12"], "mrp": ["None", ""], "id": ["None", "27"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912002001"]}	2023-09-12 12:04:23.191+05:30	2	84	127.0.0.1	\N
527	28	28	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "1500.00"], "created": ["None", "2023-09-12"], "mrp": ["None", ""], "id": ["None", "28"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912003002"]}	2023-09-12 12:04:23.203+05:30	2	84	127.0.0.1	\N
528	29	29	PRODUCTION	0	{"godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "rate": ["None", "1.00"], "closing_balance": ["None", "400.00"], "created": ["None", "2023-09-12"], "mrp": ["None", ""], "id": ["None", "29"], "company": ["None", "ABC"], "product": ["None", "NFG2"], "batch": ["None", "20230912004001"]}	2023-09-12 12:04:23.214+05:30	2	84	127.0.0.1	\N
529	8	8	2223JC00008	1	{"status": ["2", "3"]}	2023-09-12 12:04:23.222+05:30	2	47	127.0.0.1	\N
530	8	8	2223JC00008	1	{"rqty": ["1.0000", "0.0000"]}	2023-09-12 14:04:05.995+05:30	2	46	127.0.0.1	\N
531	5	5	PRD00005	0	{"no": ["None", "PRD00005"], "consumption": ["None", "production.ConsumptionItems.None"], "date": ["None", "2023-09-12 08:34:06.005342+00:00"], "company": ["None", "ABC"], "created": ["None", "2023-09-12 08:34:06.005512"], "jobcard": ["None", "2223JC00008"], "qty": ["None", "1"], "id": ["None", "5"], "updated": ["None", "2023-09-12 08:34:06.005527"]}	2023-09-12 14:04:06.01+05:30	2	52	127.0.0.1	\N
532	27	27	PRODUCTION	2	{"closing_balance": ["100.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-12", "None"], "product": ["NFG2", "None"], "rate": ["1.00", "None"], "id": ["27", "None"], "batch": ["20230912002001", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.021+05:30	2	84	127.0.0.1	\N
533	24	24	PRODUCTION	1	{"closing_balance": ["200.0000", "100.0000"]}	2023-09-12 14:04:06.039+05:30	2	84	127.0.0.1	\N
534	10	10	PRD00005	0	{"rate": ["None", "120.00"], "qty": ["None", "100"], "mrp": ["None", ""], "consumption": ["None", "PRD00005"], "id": ["None", "10"], "batch": ["None", "20230905003001"], "item": ["None", "RAW1"]}	2023-09-12 14:04:06.052+05:30	2	53	127.0.0.1	\N
535	11	11	PRD00005	0	{"rate": ["None", "1.00"], "qty": ["None", "1000.0000"], "mrp": ["None", "345.00"], "consumption": ["None", "PRD00005"], "id": ["None", "11"], "batch": ["None", "20230912003001"], "item": ["None", "RAW1"]}	2023-09-12 14:04:06.067+05:30	2	53	127.0.0.1	\N
536	20	20	PRODUCTION	2	{"closing_balance": ["800.0000", "None"], "mrp": ["345.00", "None"], "created": ["2023-09-12", "None"], "product": ["RAW1", "None"], "rate": ["1.00", "None"], "id": ["20", "None"], "batch": ["20230912003001", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.074+05:30	2	84	127.0.0.1	\N
537	24	24	PRODUCTION	2	{"closing_balance": ["100.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-12", "None"], "product": ["RAW1", "None"], "rate": ["120.00", "None"], "id": ["24", "None"], "batch": ["20230905003001", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.08+05:30	2	84	127.0.0.1	\N
538	25	25	PRODUCTION	2	{"closing_balance": ["100.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-12", "None"], "product": ["RAW1", "None"], "rate": ["1.00", "None"], "id": ["25", "None"], "batch": ["20230912002002", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.091+05:30	2	84	127.0.0.1	\N
539	12	12	PRD00005	0	{"rate": ["None", "1.00"], "qty": ["None", "2000.0000"], "mrp": ["None", "0.00"], "consumption": ["None", "PRD00005"], "id": ["None", "12"], "batch": ["None", "20230912004001"], "item": ["None", "NFG2"]}	2023-09-12 14:04:06.112+05:30	2	53	127.0.0.1	\N
540	23	23	PRODUCTION	2	{"closing_balance": ["100.0000", "None"], "mrp": ["0.00", "None"], "created": ["2023-09-12", "None"], "product": ["NFG2", "None"], "rate": ["1.00", "None"], "id": ["23", "None"], "batch": ["20230912004001", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.12+05:30	2	84	127.0.0.1	\N
541	28	28	PRODUCTION	2	{"closing_balance": ["1500.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-12", "None"], "product": ["NFG2", "None"], "rate": ["1.00", "None"], "id": ["28", "None"], "batch": ["20230912003002", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.126+05:30	2	84	127.0.0.1	\N
542	29	29	PRODUCTION	2	{"closing_balance": ["400.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-12", "None"], "product": ["NFG2", "None"], "rate": ["1.00", "None"], "id": ["29", "None"], "batch": ["20230912004001", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["PRODUCTION", "None"]}	2023-09-12 14:04:06.134+05:30	2	84	127.0.0.1	\N
543	30	30	PRODUCTION	0	{"closing_balance": ["None", "1"], "mrp": ["None", "0.00"], "created": ["None", "2023-09-12"], "product": ["None", "NFG"], "rate": ["None", "0"], "id": ["None", "30"], "batch": ["None", "20230912000998"], "updated": ["None", "2023-09-12"], "company": ["None", "ABC"], "godown": ["None", "PRODUCTION"]}	2023-09-12 14:04:06.144+05:30	2	84	127.0.0.1	\N
544	7	7	2223PO00006	0	{"shipto_pincode": ["None", "391775"], "sgst": ["None", "0"], "seller_address1": ["None", "ABC"], "shipto_address1": ["None", "ABCD"], "updated": ["None", "2023-09-12 08:38:32.638324"], "seller_address3": ["None", "ABC"], "ex_rate": ["None", "1"], "shipto_address2": ["None", "ABCD"], "seller_state": ["None", "Maharashtra"], "ammount": ["None", "0"], "id": ["None", "7"], "shipto_address3": ["None", "ABCD"], "narration": ["None", ""], "shipto_city": ["None", "VADODARA"], "other_reference": ["None", ""], "seller_mailingname": ["None", "ABC"], "ol_rate": ["None", "0"], "seller_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "round_off": ["None", "0"], "shipto_mailingname": ["None", "ABCD"], "currency": ["None", "001"], "seller_address2": ["None", "ABC"], "created": ["None", "2023-09-12 08:38:32.638299"], "shipto_country": ["None", "INDIA"], "po_date": ["None", "2023-09-12"], "po_due_date": ["None", "2023-09-13"], "dispatch_through": ["None", ""], "cgst": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "seller": ["None", "ABC"], "grn": ["None", "purchase.Grn.None"], "status": ["None", "1"], "seller_gstin": ["None", "AAAAAAA0258A"], "mode_of_payment": ["None", ""], "tcs": ["None", "0"], "company": ["None", "ABC"], "igst": ["None", "0"], "shipto": ["None", "ABC"], "total": ["None", "0"], "po_no": ["None", "2223PO00006"], "shipto_state": ["None", "GUJARAT"], "terms_of_delivery": ["None", ""], "seller_pincode": ["None", "392220"], "other": ["None", "0"], "seller_city": ["None", "Pune"], "seller_country": ["None", "India"]}	2023-09-12 14:08:32.644+05:30	2	54	127.0.0.1	\N
545	9	9	2223PO00006	0	{"amount": ["None", "100.00"], "sgstrate": ["None", "0"], "po": ["None", "2223PO00006"], "sgst": ["None", "0.00"], "item": ["None", "RAW2"], "cgst": ["None", "0.00"], "id": ["None", "9"], "cgstrate": ["None", "0"], "rate": ["None", "1"], "basic_qty": ["None", "100"], "igst": ["None", "0.00"], "igstrate": ["None", "0"], "actual_qty": ["None", "100"], "product_code": ["None", "RAW2"], "amend_qty": ["None", "0"], "pack": ["None", "123.00"]}	2023-09-12 14:08:32.656+05:30	2	55	127.0.0.1	\N
546	7	7	2223PO00006	1	{"sgst": ["0.00", "0"], "ex_rate": ["1.00", "1"], "ammount": ["0.00", "100.00"], "ol_rate": ["0.00", "0"], "cgst": ["0.00", "0"], "igst": ["0.00", "0"], "total": ["0.00", "100"], "other": ["0.00", "0"]}	2023-09-12 14:08:32.667+05:30	2	54	127.0.0.1	\N
547	7	7	2223GRN00007	0	{"shipto_address3": ["None", "ABCD"], "grn_no": ["None", "2223GRN00007"], "seller_pincode": ["None", "392220"], "tcs": ["None", "0"], "seller_address2": ["None", "ABC"], "narration": ["None", ""], "status": ["None", "1"], "seller_city": ["None", "Pune"], "seller_address1": ["None", "ABC"], "other": ["None", "0"], "seller_country": ["None", "India"], "shipto_city": ["None", "VADODARA"], "created": ["None", "2023-09-12 08:39:17.527014"], "seller_mailingname": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "igst": ["None", "0"], "seller_address_type": ["None", "Default"], "sgst": ["None", "0"], "shipto_address2": ["None", "ABCD"], "ex_rate": ["None", "1"], "seller_state": ["None", "Maharashtra"], "shipto_address_type": ["None", "Default"], "ammount": ["None", "0"], "terms_of_delivery": ["None", ""], "shipto_state": ["None", "GUJARAT"], "company": ["None", "ABC"], "seller_address3": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "grn_date": ["None", "2023-09-12"], "shipto_country": ["None", "INDIA"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "total": ["None", "0"], "seller": ["None", "ABC"], "seller_gst_reg_type": ["None", "Regular"], "shipto": ["None", "ABC"], "cgst": ["None", "0"], "other_reference": ["None", ""], "seller_gstin": ["None", "AAAAAAA0258A"], "updated": ["None", "2023-09-12 08:39:17.527036"], "currency": ["None", "001"], "mode_of_payment": ["None", ""], "dispatch_through": ["None", "0"], "shipto_address1": ["None", "ABCD"], "round_off": ["None", "0"], "po": ["None", "2223PO00006"], "id": ["None", "7"]}	2023-09-12 14:09:17.536+05:30	2	57	127.0.0.1	\N
548	9	9	2223PO00006	1	{"actual_qty": ["100.00", "0.00"]}	2023-09-12 14:09:17.546+05:30	2	55	127.0.0.1	\N
549	31	31	UN ALLOCATED	0	{"closing_balance": ["None", "100"], "mrp": ["None", "0.00"], "created": ["None", "2023-09-12"], "product": ["None", "RAW2"], "rate": ["None", "1.00"], "id": ["None", "31"], "batch": ["None", "20230912005001"], "updated": ["None", "2023-09-12"], "company": ["None", "ABC"], "godown": ["None", "UN ALLOCATED"]}	2023-09-12 14:09:17.565+05:30	2	84	127.0.0.1	\N
550	8	8	grnItems object (8)	0	{"product_code": ["None", "RAW2"], "actual_qty": ["None", "0.00"], "recd_qty": ["None", "100"], "igstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "grn": ["None", "2223GRN00007"], "item": ["None", "RAW2"], "amount": ["None", "100.00"], "pack": ["None", "123.00"], "rate": ["None", "1.00"], "igst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "batch": ["None", "20230912005001"], "id": ["None", "8"], "cgst": ["None", "0.00"], "mrp": ["None", "0.00"]}	2023-09-12 14:09:17.575+05:30	2	58	127.0.0.1	\N
551	7	7	2223GRN00007	1	{"tcs": ["0.00", "0"], "other": ["0.00", "0"], "ex_rate": ["1.00", "1"], "ammount": ["0.00", "100.00"], "total": ["0.00", "100"]}	2023-09-12 14:09:17.585+05:30	2	57	127.0.0.1	\N
552	7	7	2223PO00006	1	{"status": ["1", "4"]}	2023-09-12 14:09:17.602+05:30	2	54	127.0.0.1	\N
553	5	5	2223PINV00005	0	{"seller_country": ["None", "India"], "shipto_city": ["None", "VADODARA"], "id": ["None", "5"], "status": ["None", "1"], "seller_mailingname": ["None", "ABC"], "shipto_mailingname": ["None", "ABCD"], "seller_city": ["None", "Pune"], "ol_rate": ["None", "0"], "grn": ["None", "purchase.Grn.None"], "shipto_address1": ["None", "ABCD"], "supplier_date": ["None", "2023-09-12"], "seller": ["None", "ABC"], "shipto": ["None", "ABC"], "cgst": ["None", "0"], "igst": ["None", "0"], "total": ["None", "0"], "seller_gst_reg_type": ["None", "Regular"], "shipto_country": ["None", "INDIA"], "terms_of_delivery": ["None", ""], "mode_of_payment": ["None", ""], "dispatch_through": ["None", "0"], "tcs": ["None", "0"], "pi_date": ["None", "2023-09-12"], "shipto_gstin": ["None", "24AAKCS5015L1Z8"], "other": ["None", "0"], "pi_no": ["None", "2223PINV00005"], "seller_pincode": ["None", "392220"], "ammount": ["None", "0"], "seller_gstin": ["None", "AAAAAAA0258A"], "seller_address_type": ["None", "Default"], "created": ["None", "2023-09-12 08:39:47.244135"], "updated": ["None", "2023-09-12 08:39:47.244176"], "sgst": ["None", "0"], "round_off": ["None", "0"], "shipto_address_type": ["None", "Default"], "shipto_address2": ["None", "ABCD"], "company": ["None", "ABC"], "shipto_state": ["None", "GUJARAT"], "supplier_invoice": ["None", "222"], "seller_address1": ["None", "ABC"], "ex_rate": ["None", "1.00"], "seller_address2": ["None", "ABC"], "shipto_address3": ["None", "ABCD"], "currency": ["None", "001"], "narration": ["None", ""], "seller_address3": ["None", "ABC"], "shipto_pincode": ["None", "391775"], "is_ict": ["None", "False"], "seller_state": ["None", "Maharashtra"]}	2023-09-12 14:09:47.25+05:30	2	56	127.0.0.1	\N
554	7	7	2223GRN00007	1	{"status": ["1", "3"], "pi": ["None", "2223PINV00005"]}	2023-09-12 14:09:47.265+05:30	2	57	127.0.0.1	\N
555	7	7	2223PO00006	1	{"status": ["4", "5"]}	2023-09-12 14:09:47.294+05:30	2	54	127.0.0.1	\N
556	5	5	2223PINV00005	1	{"ol_rate": ["0.00", "0"], "cgst": ["0.00", "0"], "igst": ["0.00", "0"], "total": ["0.00", "100"], "ammount": ["0.00", "100.00"], "sgst": ["0.00", "0"]}	2023-09-12 14:09:47.307+05:30	2	56	127.0.0.1	\N
557	8	8	PalletTransferEntry object (8)	0	{"fgodown": ["None", "UN ALLOCATED"], "item": ["None", "RAW2"], "createdby": ["None", "admin"], "company": ["None", "ABC"], "id": ["None", "8"], "qty": ["None", "100"], "tgodown": ["None", "PRODUCTION"], "created": ["None", "2023-09-12"]}	2023-09-12 14:10:07.267+05:30	2	87	127.0.0.1	\N
558	32	32	PRODUCTION	0	{"mrp": ["None", "0.00"], "created": ["None", "2023-09-12"], "product": ["None", "RAW2"], "rate": ["None", "1.00"], "id": ["None", "32"], "batch": ["None", "20230912005001"], "updated": ["None", "2023-09-12"], "company": ["None", "ABC"], "godown": ["None", "PRODUCTION"]}	2023-09-12 14:10:07.277+05:30	2	84	127.0.0.1	\N
559	31	31	UN ALLOCATED	2	{"closing_balance": ["100.0000", "None"], "mrp": ["0.00", "None"], "created": ["2023-09-12", "None"], "product": ["RAW2", "None"], "rate": ["1.00", "None"], "id": ["31", "None"], "batch": ["20230912005001", "None"], "updated": ["2023-09-12", "None"], "company": ["ABC", "None"], "godown": ["UN ALLOCATED", "None"]}	2023-09-12 14:10:07.285+05:30	2	84	127.0.0.1	\N
560	32	32	PRODUCTION	1	{"closing_balance": ["None", "100.0000"]}	2023-09-12 14:10:07.292+05:30	2	84	127.0.0.1	\N
561	2	2	2223JC00002	1	{"rqty": ["1.0000", "0.0000"]}	2023-09-12 14:11:58.076+05:30	2	46	127.0.0.1	\N
562	6	6	PRD00006	0	{"no": ["None", "PRD00006"], "consumption": ["None", "production.ConsumptionItems.None"], "date": ["None", "2023-09-12 08:41:58.084301+00:00"], "company": ["None", "ABC"], "created": ["None", "2023-09-12 08:41:58.084473"], "jobcard": ["None", "2223JC00002"], "qty": ["None", "1"], "id": ["None", "6"], "updated": ["None", "2023-09-12 08:41:58.084496"]}	2023-09-12 14:11:58.089+05:30	2	52	127.0.0.1	\N
563	26	26	PRODUCTION	1	{"closing_balance": ["700.0000", "690.0000"]}	2023-09-12 14:11:58.099+05:30	2	84	127.0.0.1	\N
564	13	13	PRD00006	0	{"rate": ["None", "1.00"], "qty": ["None", "10"], "mrp": ["None", ""], "consumption": ["None", "PRD00006"], "id": ["None", "13"], "batch": ["None", "20230912003001"], "item": ["None", "RAW1"]}	2023-09-12 14:11:58.111+05:30	2	53	127.0.0.1	\N
565	14	14	PRD00006	0	{"rate": ["None", "1.00"], "qty": ["None", "10.0000"], "mrp": ["None", ""], "consumption": ["None", "PRD00006"], "id": ["None", "14"], "batch": ["None", "20230912003001"], "item": ["None", "RAW1"]}	2023-09-12 14:11:58.124+05:30	2	53	127.0.0.1	\N
566	26	26	PRODUCTION	1	{"closing_balance": ["690.0000", "680.0000"]}	2023-09-12 14:11:58.135+05:30	2	84	127.0.0.1	\N
567	15	15	PRD00006	0	{"rate": ["None", "1.00"], "qty": ["None", "20.0000"], "mrp": ["None", "0.00"], "consumption": ["None", "PRD00006"], "id": ["None", "15"], "batch": ["None", "20230912005001"], "item": ["None", "RAW2"]}	2023-09-12 14:11:58.151+05:30	2	53	127.0.0.1	\N
568	32	32	PRODUCTION	1	{"closing_balance": ["100.0000", "80.0000"]}	2023-09-12 14:11:58.158+05:30	2	84	127.0.0.1	\N
569	33	33	PRODUCTION	0	{"closing_balance": ["None", "1"], "mrp": ["None", "100.00"], "created": ["None", "2023-09-12"], "product": ["None", "FG1"], "rate": ["None", "0"], "id": ["None", "33"], "batch": ["None", "20230912000997"], "updated": ["None", "2023-09-12"], "company": ["None", "ABC"], "godown": ["None", "PRODUCTION"]}	2023-09-12 14:11:58.172+05:30	2	84	127.0.0.1	\N
570	3	3	2223SO00002	0	{"buyer_country": ["None", "India"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Vadodara"], "buyer_gstin": ["None", ""], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "id": ["None", "3"], "created": ["None", "2023-09-12 08:48:34.799652"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "narration": ["None", ""], "order_no": ["None", ""], "cgst": ["None", "0"], "buyer_address2": ["None", "Address Line2"], "shipto_country": ["None", "India"], "price_list": ["None", "5%"], "shipto_address3": ["None", "Address Line1"], "igst": ["None", "0"], "buyer_pincode": ["None", "390001"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00002"], "buyer": ["None", "Customer Name"], "other": ["None", "0"], "discount": ["None", "0.0"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 08:48:34.796782+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "total": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "shipto_state": ["None", "Maharashtra"], "updated": ["None", "2023-09-12 08:48:34.799675"], "so_due_date": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line1"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "company": ["None", "ABC"], "shipto_city": ["None", "Mumbai"]}	2023-09-12 14:18:34.808+05:30	2	66	127.0.0.1	\N
571	3	3	2223SO00002	2	{"buyer_country": ["India", "None"], "bill_qty": ["0", "None"], "terms_of_delivery": ["30", "None"], "tcs": ["0", "None"], "buyer_city": ["Vadodara", "None"], "buyer_gstin": ["", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto": ["Customer Name 2", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "id": ["3", "None"], "created": ["2023-09-12 08:48:34.799652", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "shipto_address_type": ["Default", "None"], "other_reference": ["", "None"], "narration": ["", "None"], "order_no": ["", "None"], "cgst": ["0", "None"], "buyer_address2": ["Address Line2", "None"], "shipto_country": ["India", "None"], "price_list": ["5%", "None"], "shipto_address3": ["Address Line1", "None"], "igst": ["0", "None"], "buyer_pincode": ["390001", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "so_no": ["2223SO00002", "None"], "buyer": ["Customer Name", "None"], "other": ["0", "None"], "discount": ["0.0", "None"], "ol_rate": ["0", "None"], "buyer_mailingname": ["CUSTOMER NAME", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 08:48:34.796782+00:00", "None"], "ammount": ["0", "None"], "buyer_address3": ["Address Line3", "None"], "total": ["0", "None"], "buyer_address1": ["Address Line1", "None"], "shipto_state": ["Maharashtra", "None"], "updated": ["2023-09-12 08:48:34.799675", "None"], "so_due_date": ["2023-09-13", "None"], "shipto_address2": ["Address Line1", "None"], "free_qty": ["0", "None"], "shipto_pincode": ["493320", "None"], "status": ["1", "None"], "sgst": ["0", "None"], "buyer_state": ["Gujarat-1", "None"], "company": ["ABC", "None"], "shipto_city": ["Mumbai", "None"]}	2023-09-12 14:18:34.818+05:30	2	66	127.0.0.1	\N
572	3	3	Price_list object (3)	0	{"rate": ["None", "1000"], "applicable_from": ["None", "2023-09-12"], "id": ["None", "3"], "price_level": ["None", "5%"], "product": ["None", "NFG"], "created": ["None", "2023-09-12"], "updated": ["None", "2023-09-12"]}	2023-09-12 14:20:51.095+05:30	2	38	127.0.0.1	\N
776	39	39	SHORTAGE	0	{"created": ["None", "2023-09-13"], "rate": ["None", "132.00"], "godown": ["None", "SHORTAGE"], "batch": ["None", "20230905003002"], "closing_balance": ["None", "1"], "id": ["None", "39"], "company": ["None", "ABC"], "updated": ["None", "2023-09-13"], "product": ["None", "RAW2"], "mrp": ["None", "0.00"]}	2023-09-13 13:56:04.123+05:30	2	84	127.0.0.1	\N
573	4	4	2223SO00002	0	{"buyer_country": ["None", "England"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "id": ["None", "4"], "created": ["None", "2023-09-12 08:55:39.173573"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "narration": ["None", ""], "order_no": ["None", ""], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "price_list": ["None", "Manual"], "shipto_address3": ["None", "Address Line1"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00002"], "buyer": ["None", "Cm3"], "other": ["None", "0"], "discount": ["None", "0.0"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 08:55:39.168633+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_state": ["None", "Maharashtra"], "updated": ["None", "2023-09-12 08:55:39.173604"], "so_due_date": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line1"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "company": ["None", "ABC"], "shipto_city": ["None", "Mumbai"]}	2023-09-12 14:25:39.18+05:30	2	66	127.0.0.1	\N
574	4	4	2223SO00002	2	{"buyer_country": ["England", "None"], "bill_qty": ["0", "None"], "terms_of_delivery": ["30", "None"], "tcs": ["0", "None"], "buyer_city": ["Amsterdam", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto": ["Customer Name 2", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "id": ["4", "None"], "created": ["2023-09-12 08:55:39.173573", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "shipto_address_type": ["Default", "None"], "other_reference": ["", "None"], "narration": ["", "None"], "order_no": ["", "None"], "cgst": ["0", "None"], "buyer_address2": ["Cm3", "None"], "shipto_country": ["India", "None"], "price_list": ["Manual", "None"], "shipto_address3": ["Address Line1", "None"], "igst": ["0", "None"], "buyer_pincode": ["321456", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "so_no": ["2223SO00002", "None"], "buyer": ["Cm3", "None"], "other": ["0", "None"], "discount": ["0.0", "None"], "ol_rate": ["0", "None"], "buyer_mailingname": ["CM3", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 08:55:39.168633+00:00", "None"], "ammount": ["0", "None"], "buyer_address3": ["Cm3", "None"], "total": ["0", "None"], "buyer_address1": ["Cm3", "None"], "shipto_state": ["Maharashtra", "None"], "updated": ["2023-09-12 08:55:39.173604", "None"], "so_due_date": ["2023-09-13", "None"], "shipto_address2": ["Address Line1", "None"], "free_qty": ["0", "None"], "shipto_pincode": ["493320", "None"], "status": ["1", "None"], "sgst": ["0", "None"], "buyer_state": ["Amsterdam", "None"], "company": ["ABC", "None"], "shipto_city": ["Mumbai", "None"]}	2023-09-12 14:25:39.192+05:30	2	66	127.0.0.1	\N
575	5	5	2223SO00002	0	{"buyer_country": ["None", "England"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "id": ["None", "5"], "created": ["None", "2023-09-12 08:56:09.066582"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "narration": ["None", ""], "order_no": ["None", ""], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "price_list": ["None", "Manual"], "shipto_address3": ["None", "Address Line1"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00002"], "buyer": ["None", "Cm3"], "other": ["None", "0"], "discount": ["None", "0.0"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 08:56:09.063831+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_state": ["None", "Maharashtra"], "updated": ["None", "2023-09-12 08:56:09.066606"], "so_due_date": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line1"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "company": ["None", "ABC"], "shipto_city": ["None", "Mumbai"]}	2023-09-12 14:26:09.073+05:30	2	66	127.0.0.1	\N
576	5	5	2223SO00002	2	{"buyer_country": ["England", "None"], "bill_qty": ["0", "None"], "terms_of_delivery": ["30", "None"], "tcs": ["0", "None"], "buyer_city": ["Amsterdam", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto": ["Customer Name 2", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "id": ["5", "None"], "created": ["2023-09-12 08:56:09.066582", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "shipto_address_type": ["Default", "None"], "other_reference": ["", "None"], "narration": ["", "None"], "order_no": ["", "None"], "cgst": ["0", "None"], "buyer_address2": ["Cm3", "None"], "shipto_country": ["India", "None"], "price_list": ["Manual", "None"], "shipto_address3": ["Address Line1", "None"], "igst": ["0", "None"], "buyer_pincode": ["321456", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "so_no": ["2223SO00002", "None"], "buyer": ["Cm3", "None"], "other": ["0", "None"], "discount": ["0.0", "None"], "ol_rate": ["0", "None"], "buyer_mailingname": ["CM3", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 08:56:09.063831+00:00", "None"], "ammount": ["0", "None"], "buyer_address3": ["Cm3", "None"], "total": ["0", "None"], "buyer_address1": ["Cm3", "None"], "shipto_state": ["Maharashtra", "None"], "updated": ["2023-09-12 08:56:09.066606", "None"], "so_due_date": ["2023-09-13", "None"], "shipto_address2": ["Address Line1", "None"], "free_qty": ["0", "None"], "shipto_pincode": ["493320", "None"], "status": ["1", "None"], "sgst": ["0", "None"], "buyer_state": ["Amsterdam", "None"], "company": ["ABC", "None"], "shipto_city": ["Mumbai", "None"]}	2023-09-12 14:26:09.084+05:30	2	66	127.0.0.1	\N
643	2	2	CreditNoteItems object (2)	0	{"mrp": ["None", "1000.00"], "billed_qty": ["None", "1.00"], "discount": ["None", "0.00"], "sgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "inv": ["None", "2223CN00002"], "cgst": ["None", "0.00"], "amount": ["None", "50.00"], "rates": ["None", "150.00"], "sgstrate": ["None", "0.00"], "igstrate": ["None", "0.00"], "id": ["None", "2"], "rate": ["None", "50"], "item": ["None", "NFG"]}	2023-09-12 15:18:45.586+05:30	2	75	127.0.0.1	\N
577	6	6	2223SO00002	0	{"buyer_country": ["None", "England"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "id": ["None", "6"], "created": ["None", "2023-09-12 08:58:10.061296"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "narration": ["None", ""], "order_no": ["None", "ABC123"], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "price_list": ["None", "Manual"], "shipto_address3": ["None", "Address Line3"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", ""], "so_no": ["None", "2223SO00002"], "buyer": ["None", "Cm3"], "other": ["None", "0"], "discount": ["None", "0.0"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 08:58:10.057808+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_state": ["None", "Gujarat-1"], "updated": ["None", "2023-09-12 08:58:10.061324"], "so_due_date": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line2"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "390001"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "company": ["None", "ABC"], "shipto_city": ["None", "Vadodara"]}	2023-09-12 14:28:10.067+05:30	2	66	127.0.0.1	\N
578	6	6	2223SO00002	2	{"buyer_country": ["England", "None"], "bill_qty": ["0", "None"], "terms_of_delivery": ["30", "None"], "tcs": ["0", "None"], "buyer_city": ["Amsterdam", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "shipto_mailingname": ["CUSTOMER NAME", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto": ["Customer Name", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "id": ["6", "None"], "created": ["2023-09-12 08:58:10.061296", "None"], "shipto_pan_no": ["AAPOS1478Q", "None"], "buyer_address_type": ["Default", "None"], "shipto_address_type": ["Default", "None"], "other_reference": ["", "None"], "narration": ["", "None"], "order_no": ["ABC123", "None"], "cgst": ["0", "None"], "buyer_address2": ["Cm3", "None"], "shipto_country": ["India", "None"], "price_list": ["Manual", "None"], "shipto_address3": ["Address Line3", "None"], "igst": ["0", "None"], "buyer_pincode": ["321456", "None"], "shipto_gstin": ["", "None"], "so_no": ["2223SO00002", "None"], "buyer": ["Cm3", "None"], "other": ["0", "None"], "discount": ["0.0", "None"], "ol_rate": ["0", "None"], "buyer_mailingname": ["CM3", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 08:58:10.057808+00:00", "None"], "ammount": ["0", "None"], "buyer_address3": ["Cm3", "None"], "total": ["0", "None"], "buyer_address1": ["Cm3", "None"], "shipto_state": ["Gujarat-1", "None"], "updated": ["2023-09-12 08:58:10.061324", "None"], "so_due_date": ["2023-09-13", "None"], "shipto_address2": ["Address Line2", "None"], "free_qty": ["0", "None"], "shipto_pincode": ["390001", "None"], "status": ["1", "None"], "sgst": ["0", "None"], "buyer_state": ["Amsterdam", "None"], "company": ["ABC", "None"], "shipto_city": ["Vadodara", "None"]}	2023-09-12 14:28:10.079+05:30	2	66	127.0.0.1	\N
579	7	7	2223SO00002	0	{"shipto_state": ["None", "Maharashtra"], "shipto_pincode": ["None", "493320"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "buyer_state": ["None", "Amsterdam"], "buyer_country": ["None", "England"], "shipto": ["None", "Customer Name 2"], "tcs": ["None", "0"], "created": ["None", "2023-09-12 08:59:11.997322"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "buyer_address_type": ["None", "Default"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", ""], "mode_of_payment": ["None", "30"], "buyer_address2": ["None", "Cm3"], "other_reference": ["None", ""], "id": ["None", "7"], "other": ["None", "0"], "shipto_address_type": ["None", "Default"], "igst": ["None", "0"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "shipto_address3": ["None", "Address Line1"], "price_list": ["None", "Manual"], "order_no": ["None", ""], "buyer_address1": ["None", "Cm3"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00002"], "free_qty": ["None", "0"], "ol_rate": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "updated": ["None", "2023-09-12 08:59:11.997404"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 08:59:11.983348+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "shipto_city": ["None", "Mumbai"], "status": ["None", "1"], "sgst": ["None", "0"]}	2023-09-12 14:29:12.01+05:30	2	66	127.0.0.1	\N
580	7	7	2223SO00002	2	{"shipto_state": ["Maharashtra", "None"], "shipto_pincode": ["493320", "None"], "company": ["ABC", "None"], "buyer_city": ["Amsterdam", "None"], "terms_of_delivery": ["30", "None"], "buyer_state": ["Amsterdam", "None"], "buyer_country": ["England", "None"], "shipto": ["Customer Name 2", "None"], "tcs": ["0", "None"], "created": ["2023-09-12 08:59:11.997322", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "bill_qty": ["0", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "buyer_address_type": ["Default", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "narration": ["", "None"], "mode_of_payment": ["30", "None"], "buyer_address2": ["Cm3", "None"], "other_reference": ["", "None"], "id": ["7", "None"], "other": ["0", "None"], "shipto_address_type": ["Default", "None"], "igst": ["0", "None"], "cgst": ["0", "None"], "shipto_country": ["India", "None"], "shipto_address3": ["Address Line1", "None"], "price_list": ["Manual", "None"], "order_no": ["", "None"], "buyer_address1": ["Cm3", "None"], "buyer_pincode": ["321456", "None"], "buyer": ["Cm3", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00002", "None"], "free_qty": ["0", "None"], "ol_rate": ["0", "None"], "so_due_date": ["2023-09-13", "None"], "updated": ["2023-09-12 08:59:11.997404", "None"], "buyer_mailingname": ["CM3", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 08:59:11.983348+00:00", "None"], "total": ["0", "None"], "shipto_address2": ["Address Line1", "None"], "ammount": ["0", "None"], "buyer_address3": ["Cm3", "None"], "shipto_city": ["Mumbai", "None"], "status": ["1", "None"], "sgst": ["0", "None"]}	2023-09-12 14:29:12.028+05:30	2	66	127.0.0.1	\N
644	2	2	2223CN00002	1	{"tcs": ["0.00", "0"], "ammount": ["0.00", "50.00"], "other": ["0.00", "0"], "omrpvalue": ["0.00", "0"], "ol_rate": ["0.00", "0"], "total": ["0.00", "50"], "mrpvalue": ["0.00", "0"]}	2023-09-12 15:18:45.595+05:30	2	74	127.0.0.1	\N
645	1	1	division	1	{"name": ["Division 1", "division"]}	2023-09-12 15:32:41.475+05:30	2	37	127.0.0.1	\N
581	8	8	2223SO00002	0	{"shipto_state": ["None", "Maharashtra"], "shipto_pincode": ["None", "493320"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "buyer_state": ["None", "Amsterdam"], "buyer_country": ["None", "England"], "shipto": ["None", "Customer Name 2"], "tcs": ["None", "0"], "created": ["None", "2023-09-12 08:59:58.189313"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "buyer_address_type": ["None", "Default"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", ""], "mode_of_payment": ["None", "30"], "buyer_address2": ["None", "Cm3"], "other_reference": ["None", ""], "id": ["None", "8"], "other": ["None", "0"], "shipto_address_type": ["None", "Default"], "igst": ["None", "0"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "shipto_address3": ["None", "Address Line1"], "price_list": ["None", "Manual"], "order_no": ["None", ""], "buyer_address1": ["None", "Cm3"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00002"], "free_qty": ["None", "0"], "ol_rate": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "updated": ["None", "2023-09-12 08:59:58.189339"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 08:59:58.185865+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "shipto_city": ["None", "Mumbai"], "status": ["None", "1"], "sgst": ["None", "0"]}	2023-09-12 14:29:58.199+05:30	2	66	127.0.0.1	\N
582	8	8	2223SO00002	2	{"shipto_state": ["Maharashtra", "None"], "shipto_pincode": ["493320", "None"], "company": ["ABC", "None"], "buyer_city": ["Amsterdam", "None"], "terms_of_delivery": ["30", "None"], "buyer_state": ["Amsterdam", "None"], "buyer_country": ["England", "None"], "shipto": ["Customer Name 2", "None"], "tcs": ["0", "None"], "created": ["2023-09-12 08:59:58.189313", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "bill_qty": ["0", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "buyer_address_type": ["Default", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "narration": ["", "None"], "mode_of_payment": ["30", "None"], "buyer_address2": ["Cm3", "None"], "other_reference": ["", "None"], "id": ["8", "None"], "other": ["0", "None"], "shipto_address_type": ["Default", "None"], "igst": ["0", "None"], "cgst": ["0", "None"], "shipto_country": ["India", "None"], "shipto_address3": ["Address Line1", "None"], "price_list": ["Manual", "None"], "order_no": ["", "None"], "buyer_address1": ["Cm3", "None"], "buyer_pincode": ["321456", "None"], "buyer": ["Cm3", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00002", "None"], "free_qty": ["0", "None"], "ol_rate": ["0", "None"], "so_due_date": ["2023-09-13", "None"], "updated": ["2023-09-12 08:59:58.189339", "None"], "buyer_mailingname": ["CM3", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 08:59:58.185865+00:00", "None"], "total": ["0", "None"], "shipto_address2": ["Address Line1", "None"], "ammount": ["0", "None"], "buyer_address3": ["Cm3", "None"], "shipto_city": ["Mumbai", "None"], "status": ["1", "None"], "sgst": ["0", "None"]}	2023-09-12 14:29:58.209+05:30	2	66	127.0.0.1	\N
583	9	9	2223SO00002	0	{"total": ["None", "0"], "shipto_address2": ["None", "Address Line2"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-20"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "updated": ["None", "2023-09-12 09:04:30.952927"], "status": ["None", "1"], "buyer_country": ["None", "England"], "sgst": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "shipto_pincode": ["None", "390001"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto_city": ["None", "Vadodara"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-12 09:04:30.952903"], "shipto_country": ["None", "India"], "cgst": ["None", "0"], "other_reference": ["None", ""], "id": ["None", "9"], "shipto_address_type": ["None", "Default"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line3"], "order_no": ["None", ""], "price_list": ["None", "Manual"], "buyer_address2": ["None", "Cm3"], "other": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", ""], "buyer": ["None", "Cm3"], "ol_rate": ["None", "0"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00002"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Cm3"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:04:30.950021+00:00"], "buyer_mailingname": ["None", "CM3"]}	2023-09-12 14:34:30.966+05:30	2	66	127.0.0.1	\N
584	9	9	2223SO00002	2	{"total": ["0", "None"], "shipto_address2": ["Address Line2", "None"], "ammount": ["0", "None"], "so_due_date": ["2023-09-20", "None"], "buyer_state": ["Amsterdam", "None"], "buyer_address3": ["Cm3", "None"], "updated": ["2023-09-12 09:04:30.952927", "None"], "status": ["1", "None"], "buyer_country": ["England", "None"], "sgst": ["0", "None"], "shipto_state": ["Gujarat-1", "None"], "shipto_pincode": ["390001", "None"], "company": ["ABC", "None"], "buyer_city": ["Amsterdam", "None"], "terms_of_delivery": ["30", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto_city": ["Vadodara", "None"], "tcs": ["0", "None"], "shipto_mailingname": ["CUSTOMER NAME", "None"], "bill_qty": ["0", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "shipto_pan_no": ["AAPOS1478Q", "None"], "buyer_address_type": ["Default", "None"], "narration": ["", "None"], "shipto": ["Customer Name", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "created": ["2023-09-12 09:04:30.952903", "None"], "shipto_country": ["India", "None"], "cgst": ["0", "None"], "other_reference": ["", "None"], "id": ["9", "None"], "shipto_address_type": ["Default", "None"], "igst": ["0", "None"], "shipto_address3": ["Address Line3", "None"], "order_no": ["", "None"], "price_list": ["Manual", "None"], "buyer_address2": ["Cm3", "None"], "other": ["0", "None"], "buyer_pincode": ["321456", "None"], "shipto_gstin": ["", "None"], "buyer": ["Cm3", "None"], "ol_rate": ["0", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00002", "None"], "shipto_address1": ["Address Line1", "None"], "buyer_address1": ["Cm3", "None"], "free_qty": ["0", "None"], "so_date": ["2023-09-12 09:04:30.950021+00:00", "None"], "buyer_mailingname": ["CM3", "None"]}	2023-09-12 14:34:30.98+05:30	2	66	127.0.0.1	\N
670	13	13	PRODUCTION	2	{"mrp": ["100.00", "None"], "created": ["2023-09-05", "None"], "batch": ["20230905000995", "None"], "product": ["FG1", "None"], "rate": ["0.00", "None"], "id": ["13", "None"], "godown": ["PRODUCTION", "None"], "updated": ["2023-09-05", "None"], "company": ["ABC", "None"], "closing_balance": ["2.0000", "None"]}	2023-09-13 09:36:42.2+05:30	2	84	127.0.0.1	\N
585	10	10	2223SO00002	0	{"total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "updated": ["None", "2023-09-12 09:05:47.601400"], "status": ["None", "1"], "buyer_country": ["None", "England"], "sgst": ["None", "0"], "shipto_state": ["None", "Maharashtra"], "shipto_pincode": ["None", "493320"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto_city": ["None", "Mumbai"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-12 09:05:47.601357"], "shipto_country": ["None", "India"], "cgst": ["None", "0"], "other_reference": ["None", ""], "id": ["None", "10"], "shipto_address_type": ["None", "Default"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line1"], "order_no": ["None", ""], "price_list": ["None", "Manual"], "buyer_address2": ["None", "Cm3"], "other": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Cm3"], "ol_rate": ["None", "0"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00002"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Cm3"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:05:47.598177+00:00"], "buyer_mailingname": ["None", "CM3"]}	2023-09-12 14:35:47.609+05:30	2	66	127.0.0.1	\N
586	2	2	FG1	0	{"item": ["None", "FG1"], "cgstrate": ["None", "0.00"], "mrp": ["None", "100.00"], "igst": ["None", "0.00"], "pack": ["None", "5.00"], "cgst": ["None", "0.00"], "available_qty": ["None", "21"], "discount": ["None", "0"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "so": ["None", "2223SO00002"], "actual_qty": ["None", "1"], "free_qty": ["None", "0"], "rate": ["None", "100"], "id": ["None", "2"], "sgst": ["None", "0.00"], "amount": ["None", "100.00"], "offer_mrp": ["None", "0"], "billed_qty": ["None", "1"]}	2023-09-12 14:35:47.623+05:30	2	67	127.0.0.1	\N
587	10	10	2223SO00002	1	{"total": ["0.00", "100"], "ammount": ["0.00", "100.00"], "bill_qty": ["0.00", "1"], "other": ["0.00", "0"], "ol_rate": ["0.00", "0"], "discount": ["0.00", "0.0"], "free_qty": ["0.00", "0"], "so_date": ["2023-09-12", "2023-09-12 09:05:47.598177+00:00"]}	2023-09-12 14:35:47.638+05:30	2	66	127.0.0.1	\N
588	4	4	Price_list object (4)	0	{"id": ["None", "4"], "created": ["None", "2023-09-12"], "price_level": ["None", "Manual"], "product": ["None", "NFG"], "updated": ["None", "2023-09-12"], "applicable_from": ["None", "2023-09-12"], "rate": ["None", "1000"]}	2023-09-12 14:36:31.732+05:30	2	38	127.0.0.1	\N
589	11	11	2223SO00003	0	{"total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "updated": ["None", "2023-09-12 09:06:58.218505"], "status": ["None", "1"], "buyer_country": ["None", "England"], "sgst": ["None", "0"], "shipto_state": ["None", "Maharashtra"], "shipto_pincode": ["None", "493320"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto_city": ["None", "Mumbai"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-12 09:06:58.218480"], "shipto_country": ["None", "India"], "cgst": ["None", "0"], "other_reference": ["None", ""], "id": ["None", "11"], "shipto_address_type": ["None", "Default"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line1"], "order_no": ["None", ""], "price_list": ["None", "Manual"], "buyer_address2": ["None", "Cm3"], "other": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Cm3"], "ol_rate": ["None", "0"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00003"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Cm3"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:06:58.215482+00:00"], "buyer_mailingname": ["None", "CM3"]}	2023-09-12 14:36:58.227+05:30	2	66	127.0.0.1	\N
590	11	11	2223SO00003	2	{"total": ["0", "None"], "shipto_address2": ["Address Line1", "None"], "ammount": ["0", "None"], "so_due_date": ["2023-09-13", "None"], "buyer_state": ["Amsterdam", "None"], "buyer_address3": ["Cm3", "None"], "updated": ["2023-09-12 09:06:58.218505", "None"], "status": ["1", "None"], "buyer_country": ["England", "None"], "sgst": ["0", "None"], "shipto_state": ["Maharashtra", "None"], "shipto_pincode": ["493320", "None"], "company": ["ABC", "None"], "buyer_city": ["Amsterdam", "None"], "terms_of_delivery": ["30", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto_city": ["Mumbai", "None"], "tcs": ["0", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "bill_qty": ["0", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "narration": ["", "None"], "shipto": ["Customer Name 2", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "created": ["2023-09-12 09:06:58.218480", "None"], "shipto_country": ["India", "None"], "cgst": ["0", "None"], "other_reference": ["", "None"], "id": ["11", "None"], "shipto_address_type": ["Default", "None"], "igst": ["0", "None"], "shipto_address3": ["Address Line1", "None"], "order_no": ["", "None"], "price_list": ["Manual", "None"], "buyer_address2": ["Cm3", "None"], "other": ["0", "None"], "buyer_pincode": ["321456", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "buyer": ["Cm3", "None"], "ol_rate": ["0", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00003", "None"], "shipto_address1": ["Address Line1", "None"], "buyer_address1": ["Cm3", "None"], "free_qty": ["0", "None"], "so_date": ["2023-09-12 09:06:58.215482+00:00", "None"], "buyer_mailingname": ["CM3", "None"]}	2023-09-12 14:36:58.239+05:30	2	66	127.0.0.1	\N
591	4	4	NFG	1	{"mrp": ["0.00", "1000"], "inner_qty": ["None", "0"], "outer_qty": ["None", "0"]}	2023-09-12 14:39:53.277+05:30	2	20	127.0.0.1	\N
592	4	4	NFG	1	{"mrp": ["1000.00", "1000"], "inner_qty": ["0.00", "0"], "outer_qty": ["0.00", "0"]}	2023-09-12 14:39:55.669+05:30	2	20	127.0.0.1	\N
671	2	2	ShortageDamageEntry object (2)	0	{"sqty": ["None", "1"], "id": ["None", "2"], "sremarks": ["None", "ABC"], "dremarks": ["None", "ABC"], "company": ["None", "ABC"], "dqty": ["None", "1"], "item": ["None", "RAW2"], "shoratage": ["None", ""], "updated": ["None", "2023-09-13"], "createdby": ["None", "admin"], "rate": ["None", "132.00"], "created": ["None", "2023-09-13"], "godown": ["None", "New1231"]}	2023-09-13 09:37:04.574+05:30	2	86	127.0.0.1	\N
593	12	12	2223SO00003	0	{"total": ["None", "0"], "shipto_address2": ["None", "Address Line2"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "buyer_state": ["None", "Maharashtra"], "buyer_address3": ["None", "Address Line1"], "updated": ["None", "2023-09-12 09:11:12.665521"], "status": ["None", "1"], "buyer_country": ["None", "India"], "sgst": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "shipto_pincode": ["None", "390001"], "company": ["None", "ABC"], "buyer_city": ["None", "Mumbai"], "terms_of_delivery": ["None", "30"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto_city": ["None", "Vadodara"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "XXAAPOD1234Z"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Unknown"], "created": ["None", "2023-09-12 09:11:12.665470"], "shipto_country": ["None", "India"], "cgst": ["None", "0"], "other_reference": ["None", ""], "id": ["None", "12"], "shipto_address_type": ["None", "Default"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line3"], "order_no": ["None", ""], "price_list": ["None", "10%"], "buyer_address2": ["None", "Address Line1"], "other": ["None", "0"], "buyer_pincode": ["None", "493320"], "shipto_gstin": ["None", ""], "buyer": ["None", "Customer Name 2"], "ol_rate": ["None", "0"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00003"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Address Line1"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:11:12.660492+00:00"], "buyer_mailingname": ["None", "CUSTOMER NAME 2"]}	2023-09-12 14:41:12.672+05:30	2	66	127.0.0.1	\N
594	12	12	2223SO00003	2	{"total": ["0", "None"], "shipto_address2": ["Address Line2", "None"], "ammount": ["0", "None"], "so_due_date": ["2023-09-13", "None"], "buyer_state": ["Maharashtra", "None"], "buyer_address3": ["Address Line1", "None"], "updated": ["2023-09-12 09:11:12.665521", "None"], "status": ["1", "None"], "buyer_country": ["India", "None"], "sgst": ["0", "None"], "shipto_state": ["Gujarat-1", "None"], "shipto_pincode": ["390001", "None"], "company": ["ABC", "None"], "buyer_city": ["Mumbai", "None"], "terms_of_delivery": ["30", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto_city": ["Vadodara", "None"], "tcs": ["0", "None"], "shipto_mailingname": ["CUSTOMER NAME", "None"], "bill_qty": ["0", "None"], "buyer_gstin": ["XXAAPOD1234Z", "None"], "shipto_pan_no": ["AAPOS1478Q", "None"], "buyer_address_type": ["Default", "None"], "narration": ["", "None"], "shipto": ["Customer Name", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "created": ["2023-09-12 09:11:12.665470", "None"], "shipto_country": ["India", "None"], "cgst": ["0", "None"], "other_reference": ["", "None"], "id": ["12", "None"], "shipto_address_type": ["Default", "None"], "igst": ["0", "None"], "shipto_address3": ["Address Line3", "None"], "order_no": ["", "None"], "price_list": ["10%", "None"], "buyer_address2": ["Address Line1", "None"], "other": ["0", "None"], "buyer_pincode": ["493320", "None"], "shipto_gstin": ["", "None"], "buyer": ["Customer Name 2", "None"], "ol_rate": ["0", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00003", "None"], "shipto_address1": ["Address Line1", "None"], "buyer_address1": ["Address Line1", "None"], "free_qty": ["0", "None"], "so_date": ["2023-09-12 09:11:12.660492+00:00", "None"], "buyer_mailingname": ["CUSTOMER NAME 2", "None"]}	2023-09-12 14:41:12.685+05:30	2	66	127.0.0.1	\N
595	13	13	2223SO00003	0	{"shipto_address_type": ["None", "Default"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "mode_of_payment": ["None", "30"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "bill_qty": ["None", "0"], "id": ["None", "13"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line1"], "order_no": ["None", ""], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "other_reference": ["None", ""], "other": ["None", "0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Cm3"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00003"], "buyer_mailingname": ["None", "CM3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "so_due_date": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line1"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:12:56.467715+00:00"], "shipto_pincode": ["None", "493320"], "ammount": ["None", "0"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "company": ["None", "ABC"], "shipto_state": ["None", "Maharashtra"], "updated": ["None", "2023-09-12 09:12:56.471835"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_city": ["None", "Mumbai"], "terms_of_delivery": ["None", "30"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_country": ["None", "England"], "shipto": ["None", "Customer Name 2"], "tcs": ["None", "0"], "created": ["None", "2023-09-12 09:12:56.471808"]}	2023-09-12 14:42:56.479+05:30	2	66	127.0.0.1	\N
596	3	3	NFG	0	{"rate": ["None", "1000"], "sgstrate": ["None", "0.00"], "actual_qty": ["None", "1"], "sgst": ["None", "0.00"], "free_qty": ["None", "0"], "id": ["None", "3"], "offer_mrp": ["None", "0"], "mrp": ["None", "1000.00"], "amount": ["None", "1000.00"], "billed_qty": ["None", "1"], "available_qty": ["None", "1"], "igst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "pack": ["None", "0.00"], "item": ["None", "NFG"], "discount": ["None", "0"], "so": ["None", "2223SO00003"], "igstrate": ["None", "0.00"], "cgst": ["None", "0.00"]}	2023-09-12 14:42:56.493+05:30	2	67	127.0.0.1	\N
597	3	3	NFG	2	{"rate": ["1000.00", "None"], "sgstrate": ["0.00", "None"], "actual_qty": ["1.00", "None"], "sgst": ["0.00", "None"], "free_qty": ["0.00", "None"], "id": ["3", "None"], "offer_mrp": ["0.00", "None"], "mrp": ["1000.00", "None"], "amount": ["1000.00", "None"], "billed_qty": ["1.00", "None"], "available_qty": ["1.00", "None"], "igst": ["0.00", "None"], "cgstrate": ["0.00", "None"], "pack": ["0.00", "None"], "item": ["NFG", "None"], "discount": ["0.00", "None"], "so": ["2223SO00003", "None"], "igstrate": ["0.00", "None"], "cgst": ["0.00", "None"]}	2023-09-12 14:42:56.504+05:30	2	67	127.0.0.1	\N
672	36	36	SHORTAGE	0	{"mrp": ["None", "0.00"], "created": ["None", "2023-09-13"], "batch": ["None", "20230905003002"], "product": ["None", "RAW2"], "rate": ["None", "132.00"], "id": ["None", "36"], "godown": ["None", "SHORTAGE"], "updated": ["None", "2023-09-13"], "company": ["None", "ABC"], "closing_balance": ["None", "1"]}	2023-09-13 09:37:04.586+05:30	2	84	127.0.0.1	\N
673	37	37	DAMAGE & SCRAP	0	{"mrp": ["None", "0.00"], "created": ["None", "2023-09-13"], "batch": ["None", "20230905003002"], "product": ["None", "RAW2"], "rate": ["None", "132.00"], "id": ["None", "37"], "godown": ["None", "DAMAGE & SCRAP"], "updated": ["None", "2023-09-13"], "company": ["None", "ABC"], "closing_balance": ["None", "1"]}	2023-09-13 09:37:04.596+05:30	2	84	127.0.0.1	\N
674	4	4	New1231	1	{"closing_balance": ["560.0000", "558.0000"]}	2023-09-13 09:37:04.606+05:30	2	84	127.0.0.1	\N
675	1	1	DAMAGE & SCRAP	1	{"parent": ["DAMAGE & SCRAP", "Primary"], "godown_type": ["False", "True"]}	2023-09-13 09:38:15.684+05:30	2	10	127.0.0.1	\N
598	13	13	2223SO00003	2	{"shipto_address_type": ["Default", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "narration": ["", "None"], "mode_of_payment": ["30", "None"], "cgst": ["0", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "buyer_address2": ["Cm3", "None"], "shipto_country": ["India", "None"], "bill_qty": ["0", "None"], "id": ["13", "None"], "igst": ["0", "None"], "shipto_address3": ["Address Line1", "None"], "order_no": ["", "None"], "price_list": ["Manual", "None"], "buyer_pincode": ["321456", "None"], "other_reference": ["", "None"], "other": ["0", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "buyer": ["Cm3", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00003", "None"], "buyer_mailingname": ["CM3", "None"], "total": ["0", "None"], "buyer_address1": ["Cm3", "None"], "so_due_date": ["2023-09-13", "None"], "shipto_address2": ["Address Line1", "None"], "ol_rate": ["0", "None"], "shipto_address1": ["Address Line1", "None"], "so_date": ["2023-09-12 09:12:56.467715+00:00", "None"], "shipto_pincode": ["493320", "None"], "ammount": ["0", "None"], "sgst": ["0", "None"], "buyer_state": ["Amsterdam", "None"], "buyer_address3": ["Cm3", "None"], "company": ["ABC", "None"], "shipto_state": ["Maharashtra", "None"], "updated": ["2023-09-12 09:12:56.471835", "None"], "free_qty": ["0", "None"], "status": ["1", "None"], "shipto_city": ["Mumbai", "None"], "terms_of_delivery": ["30", "None"], "buyer_city": ["Amsterdam", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "buyer_country": ["England", "None"], "shipto": ["Customer Name 2", "None"], "tcs": ["0", "None"], "created": ["2023-09-12 09:12:56.471808", "None"]}	2023-09-12 14:42:56.507+05:30	2	66	127.0.0.1	\N
599	14	14	2223SO00003	0	{"shipto_address1": ["None", "Address Line1"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:14:33.880685+00:00"], "buyer_mailingname": ["None", "CM3"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "buyer_address1": ["None", "Cm3"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "updated": ["None", "2023-09-12 09:14:33.885594"], "so_due_date": ["None", "2023-09-13"], "buyer_state": ["None", "Amsterdam"], "shipto_pincode": ["None", "493320"], "buyer_country": ["None", "England"], "status": ["None", "1"], "sgst": ["None", "0"], "shipto_state": ["None", "Maharashtra"], "terms_of_delivery": ["None", "30"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "isscheme": ["None", "False"], "round_off": ["None", "0"], "shipto_city": ["None", "Mumbai"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "asdsasda152ad"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "narration": ["None", ""], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "created": ["None", "2023-09-12 09:14:33.885568"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "id": ["None", "14"], "order_no": ["None", ""], "igst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_address3": ["None", "Address Line1"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "other": ["None", "0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "ol_rate": ["None", "0"], "buyer": ["None", "Cm3"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00003"]}	2023-09-12 14:44:33.9+05:30	2	66	127.0.0.1	\N
600	4	4	NFG	0	{"item": ["None", "NFG"], "billed_qty": ["None", "1"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "mrp": ["None", "1000.00"], "available_qty": ["None", "1"], "cgst": ["None", "0.00"], "discount": ["None", "0"], "pack": ["None", "0.00"], "igstrate": ["None", "0.00"], "so": ["None", "2223SO00003"], "actual_qty": ["None", "1"], "sgstrate": ["None", "0.00"], "free_qty": ["None", "0"], "offer_mrp": ["None", "0"], "rate": ["None", "1000"], "sgst": ["None", "0.00"], "id": ["None", "4"], "amount": ["None", "1000.00"]}	2023-09-12 14:44:33.918+05:30	2	67	127.0.0.1	\N
601	4	4	NFG	2	{"item": ["NFG", "None"], "billed_qty": ["1.00", "None"], "cgstrate": ["0.00", "None"], "igst": ["0.00", "None"], "mrp": ["1000.00", "None"], "available_qty": ["1.00", "None"], "cgst": ["0.00", "None"], "discount": ["0.00", "None"], "pack": ["0.00", "None"], "igstrate": ["0.00", "None"], "so": ["2223SO00003", "None"], "actual_qty": ["1.00", "None"], "sgstrate": ["0.00", "None"], "free_qty": ["0.00", "None"], "offer_mrp": ["0.00", "None"], "rate": ["1000.00", "None"], "sgst": ["0.00", "None"], "id": ["4", "None"], "amount": ["1000.00", "None"]}	2023-09-12 14:44:33.929+05:30	2	67	127.0.0.1	\N
602	14	14	2223SO00003	2	{"shipto_address1": ["Address Line1", "None"], "free_qty": ["0", "None"], "so_date": ["2023-09-12 09:14:33.880685+00:00", "None"], "buyer_mailingname": ["CM3", "None"], "ammount": ["0", "None"], "buyer_address3": ["Cm3", "None"], "buyer_address1": ["Cm3", "None"], "total": ["0", "None"], "shipto_address2": ["Address Line1", "None"], "updated": ["2023-09-12 09:14:33.885594", "None"], "so_due_date": ["2023-09-13", "None"], "buyer_state": ["Amsterdam", "None"], "shipto_pincode": ["493320", "None"], "buyer_country": ["England", "None"], "status": ["1", "None"], "sgst": ["0", "None"], "shipto_state": ["Maharashtra", "None"], "terms_of_delivery": ["30", "None"], "company": ["ABC", "None"], "buyer_city": ["Amsterdam", "None"], "isscheme": ["False", "None"], "round_off": ["0", "None"], "shipto_city": ["Mumbai", "None"], "tcs": ["0", "None"], "shipto_mailingname": ["CUSTOMER NAME 2", "None"], "shipto_pan_no": ["AAPOD1234Z", "None"], "buyer_address_type": ["Default", "None"], "bill_qty": ["0", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "cgst": ["0", "None"], "shipto_country": ["India", "None"], "narration": ["", "None"], "shipto": ["Customer Name 2", "None"], "mode_of_payment": ["30", "None"], "created": ["2023-09-12 09:14:33.885568", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "shipto_address_type": ["Default", "None"], "other_reference": ["", "None"], "id": ["14", "None"], "order_no": ["", "None"], "igst": ["0", "None"], "buyer_address2": ["Cm3", "None"], "shipto_address3": ["Address Line1", "None"], "price_list": ["Manual", "None"], "buyer_pincode": ["321456", "None"], "other": ["0", "None"], "shipto_gstin": ["XXAAPOD1234Z", "None"], "ol_rate": ["0", "None"], "buyer": ["Cm3", "None"], "discount": ["0.0", "None"], "so_no": ["2223SO00003", "None"]}	2023-09-12 14:44:33.93+05:30	2	66	127.0.0.1	\N
676	1	1	DAMAGE & SCRAP	1	{"godown_type": ["True", "False"]}	2023-09-13 09:38:24.165+05:30	2	10	127.0.0.1	\N
677	6	6	ALLOCATED	1	{"name": ["Primary", "ALLOCATED"], "parent": ["DAMAGE & SCRAP", "Primary"]}	2023-09-13 09:39:00.689+05:30	2	10	127.0.0.1	\N
678	4	4	ABCD	1	{"mailing_name": ["ABC", "ABCD"], "name": ["ABC", "ABCD"], "transation_type": ["None", ""], "maintain_bill_by_bill": ["True", "False"]}	2023-09-13 09:56:35.208+05:30	2	39	127.0.0.1	\N
777	40	40	DAMAGE & SCRAP	0	{"created": ["None", "2023-09-13"], "rate": ["None", "132.00"], "godown": ["None", "DAMAGE & SCRAP"], "batch": ["None", "20230905003002"], "closing_balance": ["None", "1"], "id": ["None", "40"], "company": ["None", "ABC"], "updated": ["None", "2023-09-13"], "product": ["None", "RAW2"], "mrp": ["None", "0.00"]}	2023-09-13 13:56:04.133+05:30	2	84	127.0.0.1	\N
603	15	15	2223SO00003	0	{"so_no": ["None", "2223SO00003"], "buyer_address1": ["None", "Cm3"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:15:57.432403+00:00"], "ammount": ["None", "0"], "ol_rate": ["None", "0"], "buyer_address3": ["None", "Cm3"], "shipto_pincode": ["None", "390001"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line2"], "so_due_date": ["None", "2023-09-13"], "buyer_state": ["None", "Amsterdam"], "updated": ["None", "2023-09-12 09:15:57.438805"], "buyer_country": ["None", "England"], "shipto_city": ["None", "Vadodara"], "status": ["None", "1"], "sgst": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "terms_of_delivery": ["None", "30"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto": ["None", "Customer Name"], "created": ["None", "2023-09-12 09:15:57.438778"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "asdsasda152ad"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "narration": ["None", ""], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "id": ["None", "15"], "order_no": ["None", ""], "igst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "other": ["None", "0"], "shipto_gstin": ["None", ""], "buyer": ["None", "Cm3"], "discount": ["None", "0.0"]}	2023-09-12 14:45:57.447+05:30	2	66	127.0.0.1	\N
604	5	5	NFG	0	{"billed_qty": ["None", "1"], "item": ["None", "NFG"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "mrp": ["None", "1000.00"], "available_qty": ["None", "1"], "pack": ["None", "0.00"], "cgst": ["None", "0.00"], "so": ["None", "2223SO00003"], "discount": ["None", "0"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "actual_qty": ["None", "1"], "id": ["None", "5"], "free_qty": ["None", "0"], "rate": ["None", "1000"], "sgst": ["None", "0.00"], "offer_mrp": ["None", "0"], "amount": ["None", "1000.00"]}	2023-09-12 14:45:57.466+05:30	2	67	127.0.0.1	\N
605	5	5	NFG	2	{"billed_qty": ["1.00", "None"], "item": ["NFG", "None"], "cgstrate": ["0.00", "None"], "igst": ["0.00", "None"], "mrp": ["1000.00", "None"], "available_qty": ["1.00", "None"], "pack": ["0.00", "None"], "cgst": ["0.00", "None"], "so": ["2223SO00003", "None"], "discount": ["0.00", "None"], "igstrate": ["0.00", "None"], "sgstrate": ["0.00", "None"], "actual_qty": ["1.00", "None"], "id": ["5", "None"], "free_qty": ["0.00", "None"], "rate": ["1000.00", "None"], "sgst": ["0.00", "None"], "offer_mrp": ["0.00", "None"], "amount": ["1000.00", "None"]}	2023-09-12 14:45:57.483+05:30	2	67	127.0.0.1	\N
606	15	15	2223SO00003	2	{"so_no": ["2223SO00003", "None"], "buyer_address1": ["Cm3", "None"], "buyer_mailingname": ["CM3", "None"], "shipto_address1": ["Address Line1", "None"], "free_qty": ["0", "None"], "so_date": ["2023-09-12 09:15:57.432403+00:00", "None"], "ammount": ["0", "None"], "ol_rate": ["0", "None"], "buyer_address3": ["Cm3", "None"], "shipto_pincode": ["390001", "None"], "total": ["0", "None"], "shipto_address2": ["Address Line2", "None"], "so_due_date": ["2023-09-13", "None"], "buyer_state": ["Amsterdam", "None"], "updated": ["2023-09-12 09:15:57.438805", "None"], "buyer_country": ["England", "None"], "shipto_city": ["Vadodara", "None"], "status": ["1", "None"], "sgst": ["0", "None"], "shipto_state": ["Gujarat-1", "None"], "terms_of_delivery": ["30", "None"], "company": ["ABC", "None"], "buyer_city": ["Amsterdam", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "shipto": ["Customer Name", "None"], "created": ["2023-09-12 09:15:57.438778", "None"], "tcs": ["0", "None"], "shipto_mailingname": ["CUSTOMER NAME", "None"], "shipto_pan_no": ["AAPOS1478Q", "None"], "buyer_address_type": ["Default", "None"], "bill_qty": ["0", "None"], "buyer_gstin": ["asdsasda152ad", "None"], "cgst": ["0", "None"], "shipto_country": ["India", "None"], "narration": ["", "None"], "mode_of_payment": ["30", "None"], "buyer_gst_reg_type": ["Consumer", "None"], "shipto_address_type": ["Default", "None"], "other_reference": ["", "None"], "id": ["15", "None"], "order_no": ["", "None"], "igst": ["0", "None"], "buyer_address2": ["Cm3", "None"], "shipto_address3": ["Address Line3", "None"], "price_list": ["Manual", "None"], "buyer_pincode": ["321456", "None"], "other": ["0", "None"], "shipto_gstin": ["", "None"], "buyer": ["Cm3", "None"], "discount": ["0.0", "None"]}	2023-09-12 14:45:57.485+05:30	2	66	127.0.0.1	\N
607	16	16	2223SO00003	0	{"shipto_address1": ["None", "Address Line1"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-12 09:17:47.143606+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line2"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "buyer_address3": ["None", "Address Line1"], "shipto_pincode": ["None", "390001"], "updated": ["None", "2023-09-12 09:17:47.147372"], "buyer_state": ["None", "Maharashtra"], "buyer_country": ["None", "India"], "shipto_city": ["None", "Vadodara"], "tcs": ["None", "0"], "status": ["None", "1"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "sgst": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "terms_of_delivery": ["None", "30"], "company": ["None", "ABC"], "isscheme": ["None", "False"], "buyer_city": ["None", "Mumbai"], "round_off": ["None", "0"], "shipto": ["None", "Customer Name"], "created": ["None", "2023-09-12 09:17:47.147346"], "bill_qty": ["None", "0"], "buyer_gstin": ["None", "XXAAPOD1234Z"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "narration": ["None", ""], "mode_of_payment": ["None", "30"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Unknown"], "shipto_country": ["None", "India"], "id": ["None", "16"], "buyer_address2": ["None", "Address Line1"], "other_reference": ["None", ""], "order_no": ["None", "ABC123"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "10%"], "buyer_pincode": ["None", "493320"], "other": ["None", "0"], "ol_rate": ["None", "0"], "shipto_gstin": ["None", ""], "so_no": ["None", "2223SO00003"], "buyer": ["None", "Customer Name 2"], "buyer_mailingname": ["None", "CUSTOMER NAME 2"], "discount": ["None", "0.0"], "buyer_address1": ["None", "Address Line1"]}	2023-09-12 14:47:47.156+05:30	2	66	127.0.0.1	\N
679	6	6	ABCD	0	{"check_credit_days": ["None", "True"], "override_credit_limit": ["None", "False"], "party_type": ["None", "Channel 1"], "mobile_no": ["None", "3595868745"], "purchase_qdn_seller": ["None", "purchase.Qdn.None"], "price_level": ["None", ""], "pin_code": ["None", "390002"], "account_no": ["None", ""], "pi": ["None", "purchase.Purchase.None"], "istcsapplicable": ["None", "False"], "contact_person": ["None", ""], "invoice_buyer": ["None", "sales.Invoice.None"], "rsm": ["None", "RSM 1"], "dafault_credit_period": ["None", "30"], "country": ["None", "India"], "proformainvoice_shipto": ["None", "sales.ProformaInvoice.None"], "rso_buyer": ["None", "sales.Rso.None"], "state": ["None", "Gujarat-1"], "gst_registration_type": ["None", "Unknown"], "salesorder_buyer": ["None", "sales.Salesorder.None"], "maintain_bill_by_bill": ["None", "False"], "created": ["None", "2023-09-13"], "deliverynote_shipto": ["None", "sales.Delivery_note.None"], "se": ["None", "Sales person 3"], "mailing_name": ["None", "ABCD"], "qdn_buyer": ["None", "sales.Qdn.None"], "name": ["None", "ABCD"], "is_transporter": ["None", "False"], "pan_no": ["None", "IIABC1245K"], "zsm": ["None", "ZSM 2"], "addressline1": ["None", "ABC"], "email_id": ["None", "abc@xyz.com"], "group": ["None", "Sundry Debtors"], "city": ["None", "Vadodara"], "multiple_address_list": ["None", "False"], "region": ["None", "Bihar"], "gstin": ["None", "12AYRFG125I"], "deliverynote_buyer": ["None", "sales.Delivery_note.None"], "addressline3": ["None", "ABC"], "grn": ["None", "purchase.Grn.None"], "asm": ["None", "Sales Executive 1"], "cn_buyer": ["None", "sales.CreditNote.None"], "website": ["None", ""], "salesorder_shipto": ["None", "sales.Salesorder.None"], "allow_loose_packing": ["None", "True"], "po": ["None", "purchase.Purchase_order.None"], "payment_terms": ["None", "40"], "addressline2": ["None", "ABC"], "contact_details": ["None", "False"], "debitnote_seller": ["None", "purchase.DebitNote.None"], "vendor_code": ["None", "200005"], "invoice_shipto": ["None", "sales.Invoice.None"], "zone": ["None", "East Zone"], "id": ["None", "6"], "pr_seller": ["None", "purchase.PurchaseReturn.None"], "cc_email": ["None", ""], "ifsc_code": ["None", ""], "account_name": ["None", ""], "updated": ["None", "2023-09-13"], "proformainvoice_buyer": ["None", "sales.ProformaInvoice.None"], "bank": ["None", ""], "credit_limit": ["None", "50000"], "devision": ["None", "division"]}	2023-09-13 10:16:27.022+05:30	2	39	127.0.0.1	\N
608	17	17	2223SO00004	0	{"mode_of_payment": ["None", "30"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Unknown"], "shipto_country": ["None", "India"], "order_no": ["None", "ABC123"], "id": ["None", "17"], "buyer_address2": ["None", "Address Line1"], "shipto_address_type": ["None", "Default"], "bill_qty": ["None", "0"], "igst": ["None", "0"], "shipto_gstin": ["None", ""], "buyer": ["None", "Customer Name 2"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "10%"], "buyer_pincode": ["None", "493320"], "other_reference": ["None", ""], "other": ["None", "0"], "so_no": ["None", "2223SO00004"], "buyer_mailingname": ["None", "CUSTOMER NAME 2"], "discount": ["None", "0.0"], "total": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line2"], "so_due_date": ["None", "2023-09-13"], "ol_rate": ["None", "0"], "updated": ["None", "2023-09-12 09:18:10.888724"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:18:10.885799+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Address Line1"], "shipto_pincode": ["None", "390001"], "narration": ["None", ""], "sgst": ["None", "0"], "buyer_state": ["None", "Maharashtra"], "shipto_state": ["None", "Gujarat-1"], "company": ["None", "ABC"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_city": ["None", "Vadodara"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "terms_of_delivery": ["None", "30"], "isscheme": ["None", "False"], "buyer_city": ["None", "Mumbai"], "buyer_gstin": ["None", "XXAAPOD1234Z"], "buyer_country": ["None", "India"], "round_off": ["None", "0"], "shipto": ["None", "Customer Name"], "created": ["None", "2023-09-12 09:18:10.888701"], "tcs": ["None", "0"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"]}	2023-09-12 14:48:10.899+05:30	2	66	127.0.0.1	\N
609	18	18	2223SO00005	0	{"mode_of_payment": ["None", "30"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Unknown"], "shipto_country": ["None", "India"], "order_no": ["None", "ABC123"], "id": ["None", "18"], "buyer_address2": ["None", "Address Line1"], "shipto_address_type": ["None", "Default"], "bill_qty": ["None", "0"], "igst": ["None", "0"], "shipto_gstin": ["None", ""], "buyer": ["None", "Customer Name 2"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "10%"], "buyer_pincode": ["None", "493320"], "other_reference": ["None", ""], "other": ["None", "0"], "so_no": ["None", "2223SO00005"], "buyer_mailingname": ["None", "CUSTOMER NAME 2"], "discount": ["None", "0.0"], "total": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line2"], "so_due_date": ["None", "2023-09-13"], "ol_rate": ["None", "0"], "updated": ["None", "2023-09-12 09:18:11.832092"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:18:11.829391+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Address Line1"], "shipto_pincode": ["None", "390001"], "narration": ["None", ""], "sgst": ["None", "0"], "buyer_state": ["None", "Maharashtra"], "shipto_state": ["None", "Gujarat-1"], "company": ["None", "ABC"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_city": ["None", "Vadodara"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "terms_of_delivery": ["None", "30"], "isscheme": ["None", "False"], "buyer_city": ["None", "Mumbai"], "buyer_gstin": ["None", "XXAAPOD1234Z"], "buyer_country": ["None", "India"], "round_off": ["None", "0"], "shipto": ["None", "Customer Name"], "created": ["None", "2023-09-12 09:18:11.832069"], "tcs": ["None", "0"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"]}	2023-09-12 14:48:11.84+05:30	2	66	127.0.0.1	\N
610	19	19	2223SO00006	0	{"mode_of_payment": ["None", "30"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_country": ["None", "India"], "order_no": ["None", "ABC123"], "id": ["None", "19"], "buyer_address2": ["None", "Cm3"], "shipto_address_type": ["None", "Default"], "bill_qty": ["None", "0"], "igst": ["None", "0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Cm3"], "shipto_address3": ["None", "Address Line1"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "other_reference": ["None", ""], "other": ["None", "0"], "so_no": ["None", "2223SO00006"], "buyer_mailingname": ["None", "CM3"], "discount": ["None", "0.0"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "so_due_date": ["None", "2023-09-13"], "ol_rate": ["None", "0"], "updated": ["None", "2023-09-12 09:18:59.341887"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:18:59.338249+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "shipto_pincode": ["None", "493320"], "narration": ["None", ""], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "shipto_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_city": ["None", "Mumbai"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "terms_of_delivery": ["None", "30"], "isscheme": ["None", "False"], "buyer_city": ["None", "Amsterdam"], "buyer_gstin": ["None", "asdsasda152ad"], "buyer_country": ["None", "England"], "round_off": ["None", "0"], "shipto": ["None", "Customer Name 2"], "created": ["None", "2023-09-12 09:18:59.341817"], "tcs": ["None", "0"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"]}	2023-09-12 14:48:59.349+05:30	2	66	127.0.0.1	\N
611	20	20	2223SO00007	0	{"isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "narration": ["None", ""], "round_off": ["None", "0"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "created": ["None", "2023-09-12 09:22:40.705039"], "buyer_gst_reg_type": ["None", "Consumer"], "other_reference": ["None", ""], "id": ["None", "20"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "order_no": ["None", "ABC123"], "price_list": ["None", "Manual"], "buyer_address2": ["None", "Cm3"], "shipto_address3": ["None", "Address Line1"], "other": ["None", "0"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Cm3"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00007"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CM3"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:22:40.701844+00:00"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "so_due_date": ["None", "2023-09-13"], "buyer_address3": ["None", "Cm3"], "ammount": ["None", "0"], "updated": ["None", "2023-09-12 09:22:40.705092"], "free_qty": ["None", "0"], "status": ["None", "1"], "shipto_state": ["None", "Maharashtra"], "shipto_pincode": ["None", "493320"], "company": ["None", "ABC"], "buyer_city": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "bill_qty": ["None", "0"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "buyer_country": ["None", "England"], "shipto_city": ["None", "Mumbai"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"]}	2023-09-12 14:52:40.713+05:30	2	66	127.0.0.1	\N
778	36	36	SHORTAGE	2	{"created": ["2023-09-13", "None"], "rate": ["132.00", "None"], "godown": ["SHORTAGE", "None"], "batch": ["20230905003002", "None"], "closing_balance": ["1.0000", "None"], "id": ["36", "None"], "company": ["ABC", "None"], "updated": ["2023-09-13", "None"], "product": ["RAW2", "None"], "mrp": ["0.00", "None"]}	2023-09-13 13:56:04.141+05:30	2	84	127.0.0.1	\N
612	21	21	2223SO00008	0	{"other": ["None", "0"], "discount": ["None", "0.0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00008"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:23:22.964532+00:00"], "buyer_mailingname": ["None", "CM3"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "updated": ["None", "2023-09-12 09:23:22.969705"], "so_due_date": ["None", "2023-09-13"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "shipto_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "shipto_city": ["None", "Mumbai"], "buyer_country": ["None", "England"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-12 09:23:22.969673"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "id": ["None", "21"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", "ABC123"], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "price_list": ["None", "Manual"], "shipto_address3": ["None", "Address Line1"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"]}	2023-09-12 14:53:22.979+05:30	2	66	127.0.0.1	\N
613	22	22	2223SO00009	0	{"other": ["None", "0"], "discount": ["None", "0.0"], "shipto_gstin": ["None", ""], "so_no": ["None", "2223SO00009"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:25:44.422308+00:00"], "buyer_mailingname": ["None", "CUSTOMER NAME 2"], "ammount": ["None", "0"], "buyer_address3": ["None", "Address Line1"], "total": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line2"], "updated": ["None", "2023-09-12 09:25:44.425283"], "so_due_date": ["None", "2023-09-13"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "390001"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Maharashtra"], "shipto_state": ["None", "Gujarat-1"], "company": ["None", "ABC"], "shipto_city": ["None", "Vadodara"], "buyer_country": ["None", "India"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Mumbai"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "bill_qty": ["None", "0"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "XXAAPOD1234Z"], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Unknown"], "created": ["None", "2023-09-12 09:25:44.425258"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "id": ["None", "22"], "shipto_pan_no": ["None", "AAPOS1478Q"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", "ABC123"], "cgst": ["None", "0"], "buyer_address2": ["None", "Address Line1"], "shipto_country": ["None", "India"], "price_list": ["None", "10%"], "shipto_address3": ["None", "Address Line3"], "igst": ["None", "0"], "buyer_pincode": ["None", "493320"], "buyer": ["None", "Customer Name 2"]}	2023-09-12 14:55:44.434+05:30	2	66	127.0.0.1	\N
614	23	23	2223SO00010	0	{"other": ["None", "0"], "discount": ["None", "0.0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00010"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:26:14.173661+00:00"], "buyer_mailingname": ["None", "CM3"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "updated": ["None", "2023-09-12 09:26:14.178160"], "so_due_date": ["None", "2023-09-13"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "shipto_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "shipto_city": ["None", "Mumbai"], "buyer_country": ["None", "England"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-12 09:26:14.178119"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "id": ["None", "23"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", "ABC123"], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "price_list": ["None", "Manual"], "shipto_address3": ["None", "Address Line1"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"]}	2023-09-12 14:56:14.184+05:30	2	66	127.0.0.1	\N
615	24	24	2223SO00011	0	{"other": ["None", "0"], "discount": ["None", "0.0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00011"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:26:20.925842+00:00"], "buyer_mailingname": ["None", "CM3"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "updated": ["None", "2023-09-12 09:26:20.928506"], "so_due_date": ["None", "2023-09-13"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "shipto_state": ["None", "Maharashtra"], "company": ["None", "ABC"], "shipto_city": ["None", "Mumbai"], "buyer_country": ["None", "England"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "CUSTOMER NAME 2"], "bill_qty": ["None", "0"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "created": ["None", "2023-09-12 09:26:20.928484"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "id": ["None", "24"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", "ABC123"], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "price_list": ["None", "Manual"], "shipto_address3": ["None", "Address Line1"], "igst": ["None", "0"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"]}	2023-09-12 14:56:20.935+05:30	2	66	127.0.0.1	\N
779	39	39	SHORTAGE	2	{"created": ["2023-09-13", "None"], "rate": ["132.00", "None"], "godown": ["SHORTAGE", "None"], "batch": ["20230905003002", "None"], "closing_balance": ["1.0000", "None"], "id": ["39", "None"], "company": ["ABC", "None"], "updated": ["2023-09-13", "None"], "product": ["RAW2", "None"], "mrp": ["0.00", "None"]}	2023-09-13 13:56:04.147+05:30	2	84	127.0.0.1	\N
781	5	5	UN ALLOCATED	1	{"parent": ["ALLOCATED", "UN ALLOCATED"]}	2023-09-13 13:57:26.073+05:30	2	10	127.0.0.1	\N
616	25	25	2223SO00012	0	{"so_no": ["None", "2223SO00012"], "buyer_mailingname": ["None", "CM3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line2"], "updated": ["None", "2023-09-12 09:27:24.116403"], "so_due_date": ["None", "2023-09-13"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "390001"], "ammount": ["None", "0"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "company": ["None", "ABC"], "shipto_state": ["None", "Gujarat-1"], "shipto_city": ["None", "Vadodara"], "status": ["None", "1"], "buyer_country": ["None", "England"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "created": ["None", "2023-09-12 09:27:24.116381"], "buyer_gst_reg_type": ["None", "Consumer"], "bill_qty": ["None", "0"], "shipto_address_type": ["None", "Default"], "shipto_pan_no": ["None", "AAPOS1478Q"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", ""], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "other_reference": ["None", ""], "id": ["None", "25"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"], "shipto_gstin": ["None", ""], "other": ["None", "0"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:27:24.113540+00:00"], "discount": ["None", "0.0"]}	2023-09-12 14:57:24.126+05:30	2	66	127.0.0.1	\N
617	6	6	FG1	0	{"amount": ["None", "100.00"], "billed_qty": ["None", "1"], "item": ["None", "FG1"], "mrp": ["None", "100.00"], "pack": ["None", "5.00"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "available_qty": ["None", "20"], "cgst": ["None", "0.00"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "so": ["None", "2223SO00012"], "discount": ["None", "0"], "actual_qty": ["None", "1"], "rate": ["None", "100"], "id": ["None", "6"], "free_qty": ["None", "0"], "offer_mrp": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 14:57:24.14+05:30	2	67	127.0.0.1	\N
618	25	25	2223SO00012	1	{"total": ["0.00", "100"], "free_qty": ["0.00", "0"], "ammount": ["0.00", "100.00"], "bill_qty": ["0.00", "1"], "other": ["0.00", "0"], "ol_rate": ["0.00", "0"], "so_date": ["2023-09-12", "2023-09-12 09:27:24.113540+00:00"], "discount": ["0.00", "0.0"]}	2023-09-12 14:57:24.15+05:30	2	66	127.0.0.1	\N
619	20	20	2223SO00007	1	{"status": ["1", "2"]}	2023-09-12 14:58:00.352+05:30	2	66	127.0.0.1	\N
620	21	21	2223SO00008	1	{"status": ["1", "2"]}	2023-09-12 14:58:04.37+05:30	2	66	127.0.0.1	\N
621	22	22	2223SO00009	1	{"status": ["1", "2"]}	2023-09-12 14:58:07.002+05:30	2	66	127.0.0.1	\N
622	19	19	2223SO00006	1	{"status": ["1", "2"]}	2023-09-12 14:58:09.968+05:30	2	66	127.0.0.1	\N
623	18	18	2223SO00005	1	{"status": ["1", "2"]}	2023-09-12 14:58:12.011+05:30	2	66	127.0.0.1	\N
624	17	17	2223SO00004	1	{"status": ["1", "2"]}	2023-09-12 14:58:14.488+05:30	2	66	127.0.0.1	\N
625	16	16	2223SO00003	1	{"status": ["1", "2"]}	2023-09-12 14:58:17.417+05:30	2	66	127.0.0.1	\N
626	23	23	2223SO00010	1	{"status": ["1", "2"]}	2023-09-12 14:58:19.58+05:30	2	66	127.0.0.1	\N
627	24	24	2223SO00011	1	{"status": ["1", "2"]}	2023-09-12 14:58:21.79+05:30	2	66	127.0.0.1	\N
628	26	26	2223SO00013	0	{"so_no": ["None", "2223SO00013"], "buyer_mailingname": ["None", "CM3"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line2"], "updated": ["None", "2023-09-12 09:29:43.101130"], "so_due_date": ["None", "2023-09-13"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "390001"], "ammount": ["None", "0"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "company": ["None", "ABC"], "shipto_state": ["None", "Gujarat-1"], "shipto_city": ["None", "Vadodara"], "status": ["None", "1"], "buyer_country": ["None", "England"], "terms_of_delivery": ["None", "30"], "tcs": ["None", "0"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto": ["None", "Customer Name"], "mode_of_payment": ["None", "30"], "created": ["None", "2023-09-12 09:29:43.101085"], "buyer_gst_reg_type": ["None", "Consumer"], "bill_qty": ["None", "0"], "shipto_address_type": ["None", "Default"], "shipto_pan_no": ["None", "AAPOS1478Q"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", ""], "cgst": ["None", "0"], "buyer_address2": ["None", "Cm3"], "shipto_country": ["None", "India"], "other_reference": ["None", ""], "id": ["None", "26"], "igst": ["None", "0"], "shipto_address3": ["None", "Address Line3"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "buyer": ["None", "Cm3"], "shipto_gstin": ["None", ""], "other": ["None", "0"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 09:29:43.096547+00:00"], "discount": ["None", "0.0"]}	2023-09-12 14:59:43.108+05:30	2	66	127.0.0.1	\N
629	7	7	NFG	0	{"amount": ["None", "150.00"], "billed_qty": ["None", "1"], "item": ["None", "NFG"], "mrp": ["None", "1000.00"], "pack": ["None", "0.00"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "available_qty": ["None", "1"], "cgst": ["None", "0.00"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "so": ["None", "2223SO00013"], "discount": ["None", "0"], "actual_qty": ["None", "1"], "rate": ["None", "150"], "id": ["None", "7"], "free_qty": ["None", "0"], "offer_mrp": ["None", "0"], "sgst": ["None", "0.00"]}	2023-09-12 14:59:43.122+05:30	2	67	127.0.0.1	\N
630	26	26	2223SO00013	1	{"total": ["0.00", "150"], "free_qty": ["0.00", "0"], "ammount": ["0.00", "150.00"], "bill_qty": ["0.00", "1"], "other": ["0.00", "0"], "ol_rate": ["0.00", "0"], "so_date": ["2023-09-12", "2023-09-12 09:29:43.096547+00:00"], "discount": ["0.00", "0.0"]}	2023-09-12 14:59:43.133+05:30	2	66	127.0.0.1	\N
680	1	1	2223RSO00001	0	{"rso_no": ["None", "2223RSO00001"], "igst": ["None", "0"], "id": ["None", "1"], "discount": ["None", "0"], "updated": ["None", "2023-09-13"], "buyer_address3": ["None", "Address Line3"], "round_off": ["None", "0"], "created": ["None", "2023-09-13"], "buyer_address2": ["None", "Address Line2"], "buyer_address_type": ["None", "Default"], "company": ["None", "ABC"], "channel": ["None", "Channel 1"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "ammount": ["None", "0"], "sgst": ["None", "0"], "status": ["None", "1"], "total": ["None", "0"], "rso_date": ["None", "2023-09-13 04:59:15.794889+00:00"], "cgst": ["None", "0"], "narration": ["None", ""], "buyer_country": ["None", "India"], "free_qty": ["None", "0"], "is_cm": ["None", "False"], "buyer_state": ["None", "Gujarat-1"], "division": ["None", "division"], "buyer": ["None", "Customer Name"], "buyer_pincode": ["None", "390001"], "buyer_city": ["None", "Vadodara"], "buyer_gstin": ["None", ""], "omrpvalue": ["None", "0"], "bill_qty": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "mrpvalue": ["None", "0"], "tcs": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "is_ivt": ["None", "True"]}	2023-09-13 10:29:15.808+05:30	2	78	127.0.0.1	\N
782	7	7	SHORTAGE	1	{"parent": ["DAMAGE & SCRAP", "SHORTAGE"]}	2023-09-13 13:57:38.776+05:30	2	10	127.0.0.1	\N
631	2	2	2223DN00002	0	{"ls_status": ["None", "False"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Amsterdam"], "buyer_address3": ["None", "Cm3"], "price_list": ["None", "Manual"], "round_off": ["None", "0.00"], "sales_order": ["None", "2223SO00013"], "dn_no": ["None", "2223DN00002"], "buyer_pincode": ["None", "321456"], "shipto_pincode": ["None", "390001"], "igst": ["None", "0.00"], "dn_date": ["None", "2023-09-12 09:46:40.155773+00:00"], "shipto": ["None", "Customer Name"], "bill_qty": ["None", "1.00"], "shipto_gstin": ["None", ""], "tcs": ["None", "0.00"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "CM3"], "shipto_address2": ["None", "Address Line2"], "shipto_address_type": ["None", "Default"], "created": ["None", "2023-09-12"], "buyer_address1": ["None", "Cm3"], "shipto_pan_no": ["None", "AAPOS1478Q"], "mode_of_payment": ["None", "30"], "shipto_address1": ["None", "Address Line1"], "discount": ["None", "0.00"], "updated": ["None", "2023-09-12"], "buyer_address2": ["None", "Cm3"], "cgst": ["None", "0.00"], "buyer_gst_reg_type": ["None", "Consumer"], "order_no": ["None", ""], "terms_of_delivery": ["None", "30"], "shipto_address3": ["None", "Address Line3"], "ammount": ["None", "150.00"], "buyer_country": ["None", "England"], "sgst": ["None", "0.00"], "shipto_country": ["None", "India"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "shipto_state": ["None", "Gujarat-1"], "status": ["None", "1"], "buyer_city": ["None", "Amsterdam"], "narration": ["None", ""], "shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0.00"], "ps_status": ["None", "False"], "id": ["None", "2"], "other": ["None", "0.00"], "other_reference": ["None", ""], "buyer": ["None", "Cm3"], "buyer_gstin": ["None", "asdsasda152ad"], "buyer_address_type": ["None", "Default"], "total": ["None", "150.00"]}	2023-09-12 15:16:40.17+05:30	2	68	127.0.0.1	\N
632	30	30	PRODUCTION	2	{"godown": ["PRODUCTION", "None"], "updated": ["2023-09-12", "None"], "closing_balance": ["0", "None"], "mrp": ["0.00", "None"], "created": ["2023-09-12", "None"], "id": ["30", "None"], "company": ["ABC", "None"], "product": ["NFG", "None"], "rate": ["0.00", "None"], "batch": ["20230912000998", "None"]}	2023-09-12 15:16:40.182+05:30	2	84	127.0.0.1	\N
633	2	2	LoadingSheet object (2)	0	{"qty": ["None", "1.0000"], "batch": ["None", "20230912000998"], "offermrp": ["None", "0.00"], "prate": ["None", "0.00"], "item": ["None", "NFG"], "godown": ["None", "PRODUCTION"], "updated": ["None", "2023-09-12"], "dn": ["None", "2223DN00002"], "mrp": ["None", "1000.00"], "company": ["None", "ABC"], "id": ["None", "2"], "created": ["None", "2023-09-12"]}	2023-09-12 15:16:40.194+05:30	2	80	127.0.0.1	\N
634	2	2	DnItems object (2)	0	{"dn": ["None", "2223DN00002"], "igstrate": ["None", "0.00"], "actual_qty": ["None", "1.00"], "discount": ["None", "0.00"], "free_qty": ["None", "0.00"], "amount": ["None", "150.00"], "rate": ["None", "150.00"], "cgst": ["None", "0.00"], "available_qty": ["None", "1.00"], "id": ["None", "2"], "pack": ["None", "0.00"], "billed_qty": ["None", "1.00"], "item": ["None", "NFG"], "sgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "mrp": ["None", "1000.00"], "offer_mrp": ["None", "0.00"], "sgstrate": ["None", "0.00"], "prate": ["None", "0.00"], "igst": ["None", "0.00"]}	2023-09-12 15:16:40.203+05:30	2	69	127.0.0.1	\N
635	2	2	2223DN00002	1	{"dn_date": ["2023-09-12", "2023-09-12 09:46:40.155773+00:00"]}	2023-09-12 15:16:40.217+05:30	2	68	127.0.0.1	\N
636	26	26	2223SO00013	1	{"status": ["1", "3"]}	2023-09-12 15:16:40.23+05:30	2	66	127.0.0.1	\N
637	2	2	2223INV00002	0	{"dn": ["None", "2223DN00002"], "shipto_mailingname": ["None", "CUSTOMER NAME"], "round_off": ["None", "0.00"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-12"], "buyer_address_type": ["None", "Default"], "buyer_city": ["None", "Amsterdam"], "other": ["None", "0.00"], "narration": ["None", ""], "channel": ["None", "Channel 2"], "inv_date": ["None", "2023-09-12 09:48:02.051042+00:00"], "buyer_address2": ["None", "Cm3"], "buyer_gstin": ["None", "asdsasda152ad"], "division": ["None", "Manual"], "tcs": ["None", "0.00"], "shipto_country": ["None", "India"], "bill_qty": ["None", "1.00"], "shipto_address_type": ["None", "Default"], "shipto_pincode": ["None", "390001"], "sgst": ["None", "0.00"], "total": ["None", "150.00"], "shipto_address3": ["None", "Address Line3"], "discount": ["None", "0.00"], "buyer": ["None", "Cm3"], "buyer_pincode": ["None", "321456"], "order_no": ["None", ""], "buyer_address1": ["None", "Cm3"], "mode_of_payment": ["None", "30"], "terms_of_delivery": ["None", "30"], "inv_no": ["None", "2223INV00002"], "shipto_gstin": ["None", ""], "ol_rate": ["None", "0.00"], "updated": ["None", "2023-09-12"], "buyer_mailingname": ["None", "CM3"], "cgst": ["None", "0.00"], "is_ivt": ["None", "False"], "buyer_country": ["None", "England"], "igst": ["None", "0.00"], "status": ["None", "1"], "ammount": ["None", "150.00"], "company": ["None", "ABC"], "buyer_state": ["None", "Amsterdam"], "shipto_address1": ["None", "Address Line1"], "mrpvalue": ["None", "0"], "shipto_city": ["None", "Vadodara"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "Cm3"], "id": ["None", "2"], "other_reference": ["None", ""], "price_list": ["None", "Manual"], "shipto_address2": ["None", "Address Line2"], "free_qty": ["None", "0.00"], "is_ict": ["None", "False"], "shipto": ["None", "Customer Name"]}	2023-09-12 15:18:02.064+05:30	2	70	127.0.0.1	\N
638	2	2	InvItems object (2)	0	{"inv": ["None", "2223INV00002"], "new_rate": ["None", "150.00"], "mrp": ["None", "1000.00"], "igst": ["None", "0.00"], "free_qty": ["None", "0.00"], "nb_qty": ["None", "1.000"], "cgst": ["None", "0.00"], "amount": ["None", "150.00"], "rate": ["None", "150.00"], "available_qty": ["None", "1.00"], "id": ["None", "2"], "actual_qty": ["None", "1.000"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "1.000"], "sgst": ["None", "0.00"], "item": ["None", "NFG"], "discount": ["None", "0.00"], "prate": ["None", "0.00"], "offer_mrp": ["None", "0.00"], "pack": ["None", "0.00"], "nf_qty": ["None", "0.00"], "sgstrate": ["None", "0.00"], "igstrate": ["None", "0.00"]}	2023-09-12 15:18:02.075+05:30	2	71	127.0.0.1	\N
639	2	2	2223DN00002	1	{"status": ["1", "3"]}	2023-09-12 15:18:02.098+05:30	2	68	127.0.0.1	\N
640	2	2	2223INV00002	1	{"inv_date": ["2023-09-12", "2023-09-12 09:48:02.051042+00:00"], "mrpvalue": ["0.00", "1000.00000"], "omrpvalue": ["0.00", "0.00000"]}	2023-09-12 15:18:02.111+05:30	2	70	127.0.0.1	\N
641	2	2	2223CN00002	0	{"id": ["None", "2"], "status": ["None", "1"], "cn_no": ["None", "2223CN00002"], "igst": ["None", "0"], "cn_date": ["None", "2023-09-12"], "buyer_address3": ["None", "Cm3"], "company": ["None", "ABC"], "buyer_address2": ["None", "Cm3"], "tcs": ["None", "0"], "round_off": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "ammount": ["None", "0"], "updated": ["None", "2023-09-12"], "buyer_city": ["None", "Amsterdam"], "discount": ["None", "0.00"], "inv": ["None", "2223INV00002"], "buyer_mailingname": ["None", "CM3"], "cgst": ["None", "0"], "other": ["None", "0"], "sgst": ["None", "0"], "channel": ["None", "Channel 2"], "omrpvalue": ["None", "0"], "ol_rate": ["None", "0"], "narration": ["None", ""], "buyer_country": ["None", "England"], "created": ["None", "2023-09-12"], "buyer": ["None", "Cm3"], "buyer_address_type": ["None", "Default"], "buyer_gstin": ["None", "asdsasda152ad"], "division": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "total": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "mrpvalue": ["None", "0"], "buyer_address1": ["None", "Cm3"]}	2023-09-12 15:18:45.563+05:30	2	74	127.0.0.1	\N
642	2	2	InvItems object (2)	1	{"new_rate": ["150.00", "100.00"]}	2023-09-12 15:18:45.572+05:30	2	71	127.0.0.1	\N
646	27	27	2223SO00014	0	{"buyer_pincode": ["None", "390001"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "so_no": ["None", "2223SO00014"], "buyer": ["None", "Customer Name"], "discount": ["None", "0.0"], "buyer_address1": ["None", "Address Line1"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "shipto_address1": ["None", "Address Line1"], "so_date": ["None", "2023-09-12 11:42:46.359166+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "Address Line1"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-13"], "buyer_address3": ["None", "Address Line3"], "updated": ["None", "2023-09-12 11:42:46.362339"], "buyer_state": ["None", "Gujarat-1"], "shipto_pincode": ["None", "493320"], "status": ["None", "1"], "sgst": ["None", "0"], "shipto_state": ["None", "Maharashtra"], "terms_of_delivery": ["None", "30"], "buyer_city": ["None", "Vadodara"], "company": ["None", "ABC"], "free_qty": ["None", "0"], "shipto_city": ["None", "Mumbai"], "round_off": ["None", "0"], "buyer_gstin": ["None", ""], "shipto_mailingname": ["None", "Customer Name 2"], "buyer_address_type": ["None", "Default"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", ""], "isscheme": ["None", "False"], "mode_of_payment": ["None", "30"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_country": ["None", "India"], "shipto": ["None", "Customer Name 2"], "tcs": ["None", "0"], "id": ["None", "27"], "created": ["None", "2023-09-12 11:42:46.362314"], "bill_qty": ["None", "0"], "shipto_address_type": ["None", "Default"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "order_no": ["None", ""], "igst": ["None", "0"], "buyer_address2": ["None", "Address Line2"], "price_list": ["None", "5%"], "shipto_address3": ["None", "Address Line1"], "other_reference": ["None", ""], "other": ["None", "0"]}	2023-09-12 17:12:46.373+05:30	2	66	127.0.0.1	\N
647	8	8	FG1	0	{"id": ["None", "8"], "free_qty": ["None", "0"], "offer_mrp": ["None", "0"], "sgst": ["None", "0.00"], "amount": ["None", "200.00"], "mrp": ["None", "100.00"], "igst": ["None", "0.00"], "billed_qty": ["None", "2"], "cgstrate": ["None", "0.00"], "item": ["None", "FG1"], "available_qty": ["None", "19"], "discount": ["None", "0"], "pack": ["None", "5.00"], "igstrate": ["None", "0.00"], "cgst": ["None", "0.00"], "so": ["None", "2223SO00014"], "sgstrate": ["None", "0.00"], "actual_qty": ["None", "2"], "rate": ["None", "100.00"]}	2023-09-12 17:12:46.388+05:30	2	67	127.0.0.1	\N
648	27	27	2223SO00014	1	{"discount": ["0.00", "0.0"], "ol_rate": ["0.00", "0"], "so_date": ["2023-09-12", "2023-09-12 11:42:46.359166+00:00"], "total": ["0.00", "200"], "ammount": ["0.00", "200.00"], "free_qty": ["0.00", "0"], "bill_qty": ["0.00", "2"], "other": ["0.00", "0"]}	2023-09-12 17:12:46.403+05:30	2	66	127.0.0.1	\N
649	3	3	2223DN00003	0	{"other_reference": ["None", ""], "dn_no": ["None", "2223DN00003"], "buyer": ["None", "Customer Name"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Gujarat-1"], "ls_status": ["None", "False"], "shipto_pan_no": ["None", "AAPOD1234Z"], "round_off": ["None", "0.00"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "buyer_pincode": ["None", "390001"], "company": ["None", "ABC"], "sales_order": ["None", "2223SO00014"], "buyer_address3": ["None", "Address Line3"], "price_list": ["None", "5%"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "shipto_pincode": ["None", "493320"], "igst": ["None", "0.00"], "dn_date": ["None", "2023-09-12 11:43:07.643952+00:00"], "shipto_address2": ["None", "Address Line1"], "tcs": ["None", "0.00"], "shipto": ["None", "Customer Name 2"], "bill_qty": ["None", "2.00"], "mode_of_payment": ["None", "30"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "updated": ["None", "2023-09-12"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Address Line1"], "cgst": ["None", "0.00"], "shipto_state": ["None", "Maharashtra"], "terms_of_delivery": ["None", "30"], "status": ["None", "1"], "created": ["None", "2023-09-12"], "shipto_address3": ["None", "Address Line1"], "discount": ["None", "0.00"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_address2": ["None", "Address Line2"], "shipto_country": ["None", "India"], "order_no": ["None", ""], "ps_status": ["None", "False"], "buyer_city": ["None", "Vadodara"], "sgst": ["None", "0.00"], "id": ["None", "3"], "buyer_gstin": ["None", ""], "ammount": ["None", "200.00"], "buyer_country": ["None", "India"], "shipto_city": ["None", "Mumbai"], "narration": ["None", ""], "shipto_mailingname": ["None", "Customer Name 2"], "other": ["None", "0.00"], "ol_rate": ["None", "0.00"], "total": ["None", "200.00"]}	2023-09-12 17:13:07.66+05:30	2	68	127.0.0.1	\N
650	7	7	PRODUCTION	1	{"closing_balance": ["3.0000", "1.0000"]}	2023-09-12 17:13:07.671+05:30	2	84	127.0.0.1	\N
651	3	3	LoadingSheet object (3)	0	{"company": ["None", "ABC"], "godown": ["None", "PRODUCTION"], "created": ["None", "2023-09-12"], "qty": ["None", "2.0000"], "batch": ["None", "20230905000995"], "id": ["None", "3"], "item": ["None", "FG1"], "offermrp": ["None", "0.00"], "prate": ["None", "0.00"], "updated": ["None", "2023-09-12"], "dn": ["None", "2223DN00003"], "mrp": ["None", "100.00"]}	2023-09-12 17:13:07.685+05:30	2	80	127.0.0.1	\N
652	3	3	DnItems object (3)	0	{"free_qty": ["None", "0.00"], "rate": ["None", "100.00"], "sgst": ["None", "0.00"], "pack": ["None", "5.00"], "id": ["None", "3"], "cgst": ["None", "0.00"], "available_qty": ["None", "19.00"], "mrp": ["None", "100.00"], "billed_qty": ["None", "2.00"], "sgstrate": ["None", "0.00"], "item": ["None", "FG1"], "cgstrate": ["None", "0.00"], "offer_mrp": ["None", "0.00"], "igst": ["None", "0.00"], "dn": ["None", "2223DN00003"], "prate": ["None", "0.00"], "discount": ["None", "0.00"], "igstrate": ["None", "0.00"], "actual_qty": ["None", "2.00"], "amount": ["None", "200.00"]}	2023-09-12 17:13:07.695+05:30	2	69	127.0.0.1	\N
653	3	3	2223DN00003	1	{"dn_date": ["2023-09-12", "2023-09-12 11:43:07.643952+00:00"]}	2023-09-12 17:13:07.712+05:30	2	68	127.0.0.1	\N
654	27	27	2223SO00014	1	{"status": ["1", "3"]}	2023-09-12 17:13:07.728+05:30	2	66	127.0.0.1	\N
681	1	1	RsoItems object (1)	0	{"inv": ["None", "2223RSO00001"], "mrp": ["None", "1000.00"], "sgstrate": ["None", "0.00"], "billed_qty": ["None", "1"], "discount": ["None", "0"], "igstrate": ["None", "0.00"], "id": ["None", "1"], "cgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "billed": ["None", "1"], "amount": ["None", "100"], "rate": ["None", "100"], "igst": ["None", "0.00"], "cgst": ["None", "0.00"], "free_qty": ["None", "0"], "item": ["None", "NFG"]}	2023-09-13 10:29:15.82+05:30	2	79	127.0.0.1	\N
682	1	1	2223RSO00001	1	{"discount": ["0.00", "0"], "ammount": ["0.00", "100"], "total": ["0.00", "100"], "rso_date": ["2023-09-13", "2023-09-13 04:59:15.794889+00:00"], "free_qty": ["0.00", "0"], "omrpvalue": ["0.00", "0"], "bill_qty": ["0.00", "1"], "mrpvalue": ["0.00", "1000.00"], "tcs": ["0.00", "0"]}	2023-09-13 10:29:15.829+05:30	2	78	127.0.0.1	\N
783	4	4	ShortageDamageEntry object (4)	0	{"sqty": ["None", "5"], "dremarks": ["None", "Nothing"], "id": ["None", "4"], "dqty": ["None", "0"], "item": ["None", "RAW1"], "rate": ["None", "1.00"], "sremarks": ["None", "ABC"], "godown": ["None", "PRODUCTION"], "createdby": ["None", "admin"], "updated": ["None", "2023-09-13"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "purchase": ["None", "2223PINV00003"], "shoratage": ["None", ""]}	2023-09-13 14:09:14.31+05:30	2	86	127.0.0.1	\N
655	3	3	2223INV00003	0	{"narration": ["None", ""], "buyer_address_type": ["None", "Default"], "buyer_gstin": ["None", ""], "buyer_gst_reg_type": ["None", "Consumer"], "shipto": ["None", "Customer Name 2"], "channel": ["None", "Channel 1"], "bill_qty": ["None", "2.00"], "shipto_address_type": ["None", "Default"], "division": ["None", "division"], "tcs": ["None", "0.00"], "shipto_country": ["None", "India"], "inv_date": ["None", "2023-09-12 11:43:20.895018+00:00"], "buyer_address2": ["None", "Address Line2"], "shipto_pincode": ["None", "493320"], "discount": ["None", "0.00"], "total": ["None", "200.00"], "buyer": ["None", "Customer Name"], "buyer_pincode": ["None", "390001"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "terms_of_delivery": ["None", "30"], "buyer_country": ["None", "India"], "shipto_address3": ["None", "Address Line1"], "order_no": ["None", ""], "sgst": ["None", "0.00"], "inv_no": ["None", "2223INV00003"], "is_ivt": ["None", "False"], "shipto_mailingname": ["None", "Customer Name 2"], "cgst": ["None", "0.00"], "shipto_address1": ["None", "Address Line1"], "igst": ["None", "0.00"], "updated": ["None", "2023-09-12"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "id": ["None", "3"], "ammount": ["None", "200.00"], "price_list": ["None", "5%"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line1"], "company": ["None", "ABC"], "status": ["None", "1"], "mrpvalue": ["None", "0"], "mode_of_payment": ["None", "30"], "is_ict": ["None", "False"], "dn": ["None", "2223DN00003"], "omrpvalue": ["None", "0"], "round_off": ["None", "0.00"], "buyer_state": ["None", "Gujarat-1"], "buyer_address3": ["None", "Address Line3"], "created": ["None", "2023-09-12"], "shipto_state": ["None", "Maharashtra"], "free_qty": ["None", "0.00"], "other_reference": ["None", ""], "ol_rate": ["None", "0.00"], "shipto_city": ["None", "Mumbai"], "other": ["None", "0.00"], "buyer_city": ["None", "Vadodara"]}	2023-09-12 17:13:20.909+05:30	2	70	127.0.0.1	\N
656	3	3	InvItems object (3)	0	{"igst": ["None", "0.00"], "free_qty": ["None", "0.00"], "cgst": ["None", "0.00"], "nb_qty": ["None", "2.000"], "amount": ["None", "200.00"], "rate": ["None", "100.00"], "id": ["None", "3"], "available_qty": ["None", "19.00"], "cgstrate": ["None", "0.00"], "actual_qty": ["None", "2.000"], "sgst": ["None", "0.00"], "item": ["None", "FG1"], "billed_qty": ["None", "2.000"], "prate": ["None", "0.00"], "discount": ["None", "0.00"], "pack": ["None", "5.00"], "offer_mrp": ["None", "0.00"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "nf_qty": ["None", "0.00"], "mrp": ["None", "100.00"], "inv": ["None", "2223INV00003"], "new_rate": ["None", "100.00"]}	2023-09-12 17:13:20.922+05:30	2	71	127.0.0.1	\N
657	3	3	2223DN00003	1	{"status": ["1", "3"]}	2023-09-12 17:13:20.941+05:30	2	68	127.0.0.1	\N
658	3	3	2223INV00003	1	{"inv_date": ["2023-09-12", "2023-09-12 11:43:20.895018+00:00"], "mrpvalue": ["0.00", "200.00000"], "omrpvalue": ["0.00", "0.00000"]}	2023-09-12 17:13:20.955+05:30	2	70	127.0.0.1	\N
659	3	3	2223CN00003	0	{"division": ["None", "division"], "buyer_address_type": ["None", "Default"], "buyer_gstin": ["None", ""], "narration": ["None", ""], "buyer_country": ["None", "India"], "buyer_pincode": ["None", "390001"], "other": ["None", "0"], "status": ["None", "1"], "buyer_address1": ["None", "Address Line1"], "tcs": ["None", "0"], "total": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "cn_date": ["None", "2023-09-12"], "id": ["None", "3"], "company": ["None", "ABC"], "buyer_state": ["None", "Gujarat-1"], "cn_no": ["None", "2223CN00003"], "buyer_address2": ["None", "Address Line2"], "discount": ["None", "0.00"], "igst": ["None", "0"], "inv": ["None", "2223INV00003"], "buyer_address3": ["None", "Address Line3"], "round_off": ["None", "0"], "sgst": ["None", "0"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "cgst": ["None", "0"], "ammount": ["None", "0"], "buyer_city": ["None", "Vadodara"], "updated": ["None", "2023-09-12"], "channel": ["None", "Channel 1"], "created": ["None", "2023-09-12"], "omrpvalue": ["None", "0"], "ol_rate": ["None", "0"], "mrpvalue": ["None", "0"], "buyer": ["None", "Customer Name"]}	2023-09-12 17:13:37.24+05:30	2	74	127.0.0.1	\N
660	3	3	CreditNoteItems object (3)	0	{"amount": ["None", "0.00"], "sgstrate": ["None", "0.00"], "rate": ["None", "0"], "igstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "2.00"], "item": ["None", "FG1"], "id": ["None", "3"], "igst": ["None", "0.00"], "inv": ["None", "2223CN00003"], "rates": ["None", "100.00"], "cgst": ["None", "0.00"], "discount": ["None", "0.00"], "mrp": ["None", "100.00"]}	2023-09-12 17:13:37.275+05:30	2	75	127.0.0.1	\N
661	3	3	2223CN00003	1	{"other": ["0.00", "0"], "tcs": ["0.00", "0"], "total": ["0.00", "0"], "omrpvalue": ["0.00", "0"], "ol_rate": ["0.00", "0"], "mrpvalue": ["0.00", "0"]}	2023-09-12 17:13:37.284+05:30	2	74	127.0.0.1	\N
662	7	7	SHORTAGE	0	{"name": ["None", "SHORTAGE"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "created": ["None", "2023-09-13"], "id": ["None", "7"], "parent": ["None", "Alkapuri"], "godown_type": ["None", "True"], "updated": ["None", "2023-09-13"]}	2023-09-13 09:34:27.105+05:30	2	10	127.0.0.1	\N
663	8	8	DAMAGE & SCRAP	0	{"name": ["None", "DAMAGE & SCRAP"], "material_transferred": ["None", "warehouse.MaterialTransferred.None"], "created": ["None", "2023-09-13"], "id": ["None", "8"], "godown_type": ["None", "False"], "updated": ["None", "2023-09-13"]}	2023-09-13 09:35:08.828+05:30	2	10	127.0.0.1	\N
664	8	8	DAMAGE & SCRAP	2	{"name": ["DAMAGE & SCRAP", "None"], "material_transferred": ["warehouse.MaterialTransferred.None", "None"], "created": ["2023-09-13", "None"], "id": ["8", "None"], "godown_type": ["False", "None"], "updated": ["2023-09-13", "None"]}	2023-09-13 09:35:36.629+05:30	2	10	127.0.0.1	\N
666	3	3	Production123	2	{"name": ["Production123", "None"], "material_transferred": ["warehouse.MaterialTransferred.None", "None"], "created": ["2023-07-28", "None"], "id": ["3", "None"], "parent": ["DAMAGE & SCRAP", "None"], "godown_type": ["True", "None"], "updated": ["2023-09-05", "None"]}	2023-09-13 09:36:36.745+05:30	2	10	127.0.0.1	\N
667	1	1	ShortageDamageEntry object (1)	0	{"sqty": ["None", "1"], "id": ["None", "1"], "sremarks": ["None", "ABC"], "dremarks": ["None", "ABC"], "company": ["None", "ABC"], "dqty": ["None", "1"], "item": ["None", "FG1"], "shoratage": ["None", ""], "updated": ["None", "2023-09-13"], "createdby": ["None", "admin"], "rate": ["None", "0.00"], "created": ["None", "2023-09-13"], "godown": ["None", "PRODUCTION"]}	2023-09-13 09:36:42.167+05:30	2	86	127.0.0.1	\N
668	34	34	SHORTAGE	0	{"mrp": ["None", "100.00"], "created": ["None", "2023-09-13"], "batch": ["None", "20230905000995"], "product": ["None", "FG1"], "rate": ["None", "0.00"], "id": ["None", "34"], "godown": ["None", "SHORTAGE"], "updated": ["None", "2023-09-13"], "company": ["None", "ABC"], "closing_balance": ["None", "1"]}	2023-09-13 09:36:42.18+05:30	2	84	127.0.0.1	\N
669	35	35	DAMAGE & SCRAP	0	{"mrp": ["None", "100.00"], "created": ["None", "2023-09-13"], "batch": ["None", "20230905000995"], "product": ["None", "FG1"], "rate": ["None", "0.00"], "id": ["None", "35"], "godown": ["None", "DAMAGE & SCRAP"], "updated": ["None", "2023-09-13"], "company": ["None", "ABC"], "closing_balance": ["None", "1"]}	2023-09-13 09:36:42.191+05:30	2	84	127.0.0.1	\N
683	4	4	2223INV00004	0	{"shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0"], "is_ict": ["None", "False"], "free_qty": ["None", "0"], "buyer_gst_reg_type": ["None", "Unknown"], "shipto_state": ["None", "Gujarat-1"], "other": ["None", "0"], "buyer_city": ["None", "Vadodara"], "round_off": ["None", "0"], "bill_qty": ["None", "0"], "channel": ["None", "Channel 1"], "shipto": ["None", "ABCD"], "inv_date": ["None", "2023-09-13 04:59:42.996071+00:00"], "shipto_mailingname": ["None", "ABCD"], "buyer_address_type": ["None", "Default"], "buyer_gstin": ["None", "12AYRFG125I"], "shipto_country": ["None", "India"], "buyer_address2": ["None", "ABC"], "buyer": ["None", "ABCD"], "shipto_address_type": ["None", ""], "shipto_pincode": ["None", "390002"], "sgst": ["None", "0"], "division": ["None", "division"], "tcs": ["None", "0"], "shipto_address3": ["None", "ABC"], "buyer_country": ["None", "India"], "shipto_pan_no": ["None", "IIABC1245K"], "total": ["None", "0"], "discount": ["None", "0"], "inv_no": ["None", "2223INV00004"], "buyer_pincode": ["None", "390002"], "shipto_gstin": ["None", "12AYRFG125I"], "igst": ["None", "0"], "updated": ["None", "2023-09-13"], "shipto_address2": ["None", "ABC"], "status": ["None", "1"], "ammount": ["None", "0"], "is_ivt": ["None", "True"], "buyer_address1": ["None", "ABC"], "cgst": ["None", "0"], "company": ["None", "ABC"], "shipto_address1": ["None", "ABC"], "buyer_mailingname": ["None", "ABCD"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "ABC"], "id": ["None", "4"], "buyer_state": ["None", "Gujarat-1"], "mrpvalue": ["None", "0"], "created": ["None", "2023-09-13"]}	2023-09-13 10:29:43.007+05:30	2	70	127.0.0.1	\N
684	4	4	InvItems object (4)	0	{"nb_qty": ["None", "1.00"], "amount": ["None", "100.00"], "rate": ["None", "100"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "1.00"], "id": ["None", "4"], "available_qty": ["None", "1.00"], "actual_qty": ["None", "1.00"], "sgst": ["None", "0.0000"], "item": ["None", "NFG"], "prate": ["None", "100.00"], "discount": ["None", "0"], "pack": ["None", "0.00"], "offer_mrp": ["None", "1000.00"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "inv": ["None", "2223INV00004"], "nf_qty": ["None", "0"], "new_rate": ["None", "100"], "mrp": ["None", "1000.00"], "igst": ["None", "0.0000"], "cgst": ["None", "0.0000"], "free_qty": ["None", "0"]}	2023-09-13 10:29:43.02+05:30	2	71	127.0.0.1	\N
685	4	4	2223INV00004	1	{"ol_rate": ["0.00", "0"], "free_qty": ["0.00", "0"], "other": ["0.00", "0"], "round_off": ["0.00", "0.0000"], "bill_qty": ["0.00", "0"], "inv_date": ["2023-09-13", "2023-09-13 04:59:42.996071+00:00"], "sgst": ["0.00", "0.0000"], "tcs": ["0.00", "0"], "total": ["0.00", "100"], "discount": ["0.00", "0"], "igst": ["0.00", "0.0000"], "ammount": ["0.00", "100.00"], "cgst": ["0.00", "0.0000"], "omrpvalue": ["0.00", "0"], "mrpvalue": ["0.00", "1000.0000"]}	2023-09-13 10:29:43.029+05:30	2	70	127.0.0.1	\N
686	4	4	ECOM	0	{"name": ["None", "ECOM"], "id": ["None", "4"], "updated": ["None", "2023-09-13"], "created": ["None", "2023-09-13"]}	2023-09-13 10:41:04.76+05:30	2	37	127.0.0.1	\N
687	28	28	2223SO00015	0	{"created": ["None", "2023-09-13 05:14:27.178059"], "id": ["None", "28"], "shipto_pan_no": ["None", "IIABC1245K"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "cgst": ["None", "0"], "narration": ["None", ""], "shipto_country": ["None", "INDIA"], "order_no": ["None", ""], "buyer_address2": ["None", "B"], "shipto_address3": ["None", "C"], "price_list": ["None", "10%"], "other_reference": ["None", ""], "igst": ["None", "0"], "mode_of_payment": ["None", "0"], "buyer_pincode": ["None", "40025"], "buyer": ["None", "ABCD"], "other": ["None", "0"], "discount": ["None", "0.0"], "ol_rate": ["None", "0"], "buyer_mailingname": ["None", "ABCD"], "shipto_address1": ["None", "A"], "so_date": ["None", "2023-09-13 05:14:27.175290+00:00"], "total": ["None", "0"], "so_no": ["None", "2223SO00015"], "shipto_address2": ["None", "B"], "so_due_date": ["None", "2023-09-14"], "buyer_address1": ["None", "A"], "updated": ["None", "2023-09-13 05:14:27.178127"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "buyer_address3": ["None", "C"], "shipto_pincode": ["None", "80010"], "sgst": ["None", "0"], "buyer_state": ["None", "New York"], "shipto_state": ["None", "New Jersey"], "company": ["None", "ABC"], "buyer_country": ["None", "INDIA"], "shipto_city": ["None", "NJC"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "COD"], "tcs": ["None", "0"], "buyer_city": ["None", "NYC1"], "shipto_mailingname": ["None", "CS"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_gst_reg_type": ["None", "Unknown"], "shipto": ["None", "Customer Name"]}	2023-09-13 10:44:27.189+05:30	2	66	127.0.0.1	\N
688	28	28	2223SO00015	2	{"created": ["2023-09-13 05:14:27.178059", "None"], "id": ["28", "None"], "shipto_pan_no": ["IIABC1245K", "None"], "buyer_address_type": ["Default", "None"], "shipto_address_type": ["Default", "None"], "cgst": ["0", "None"], "narration": ["", "None"], "shipto_country": ["INDIA", "None"], "order_no": ["", "None"], "buyer_address2": ["B", "None"], "shipto_address3": ["C", "None"], "price_list": ["10%", "None"], "other_reference": ["", "None"], "igst": ["0", "None"], "mode_of_payment": ["0", "None"], "buyer_pincode": ["40025", "None"], "buyer": ["ABCD", "None"], "other": ["0", "None"], "discount": ["0.0", "None"], "ol_rate": ["0", "None"], "buyer_mailingname": ["ABCD", "None"], "shipto_address1": ["A", "None"], "so_date": ["2023-09-13 05:14:27.175290+00:00", "None"], "total": ["0", "None"], "so_no": ["2223SO00015", "None"], "shipto_address2": ["B", "None"], "so_due_date": ["2023-09-14", "None"], "buyer_address1": ["A", "None"], "updated": ["2023-09-13 05:14:27.178127", "None"], "free_qty": ["0", "None"], "status": ["1", "None"], "ammount": ["0", "None"], "buyer_address3": ["C", "None"], "shipto_pincode": ["80010", "None"], "sgst": ["0", "None"], "buyer_state": ["New York", "None"], "shipto_state": ["New Jersey", "None"], "company": ["ABC", "None"], "buyer_country": ["INDIA", "None"], "shipto_city": ["NJC", "None"], "bill_qty": ["0", "None"], "terms_of_delivery": ["COD", "None"], "tcs": ["0", "None"], "buyer_city": ["NYC1", "None"], "shipto_mailingname": ["CS", "None"], "round_off": ["0", "None"], "isscheme": ["False", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "shipto": ["Customer Name", "None"]}	2023-09-13 10:44:27.202+05:30	2	66	127.0.0.1	\N
708	4	4	LoadingSheet object (4)	0	{"dn": ["None", "2223DN00004"], "prate": ["None", "1.00"], "godown": ["None", "PRODUCTION"], "company": ["None", "ABC"], "updated": ["None", "2023-09-13"], "batch": ["None", "20230912003001"], "id": ["None", "4"], "item": ["None", "RAW1"], "mrp": ["None", "345.00"], "offermrp": ["None", "0.00"], "qty": ["None", "10.0000"], "created": ["None", "2023-09-13"]}	2023-09-13 11:14:31.118+05:30	2	80	127.0.0.1	\N
709	4	4	DnItems object (4)	0	{"igstrate": ["None", "0.00"], "dn": ["None", "2223DN00004"], "actual_qty": ["None", "10.00"], "amount": ["None", "810.00"], "free_qty": ["None", "0.00"], "rate": ["None", "90.00"], "pack": ["None", "1.00"], "cgst": ["None", "0.00"], "available_qty": ["None", "669.00"], "id": ["None", "4"], "sgst": ["None", "0.00"], "billed_qty": ["None", "10.00"], "item": ["None", "RAW1"], "sgstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "mrp": ["None", "345.00"], "offer_mrp": ["None", "0.00"], "igst": ["None", "0.00"], "prate": ["None", "1.00"], "discount": ["None", "10.00"]}	2023-09-13 11:14:31.13+05:30	2	69	127.0.0.1	\N
710	4	4	2223DN00004	1	{"dn_date": ["2023-09-13", "2023-09-13 05:44:31.074704+00:00"]}	2023-09-13 11:14:31.143+05:30	2	68	127.0.0.1	\N
711	34	34	2223SO00020	1	{"status": ["1", "3"]}	2023-09-13 11:14:31.157+05:30	2	66	127.0.0.1	\N
689	29	29	2223SO00015	0	{"other": ["None", "0"], "ol_rate": ["None", "0"], "shipto_address1": ["None", "A"], "so_date": ["None", "2023-09-13 05:18:00.696125+00:00"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00015"], "buyer_mailingname": ["None", "ABCD"], "buyer_pincode": ["None", "40025"], "total": ["None", "0"], "buyer_address1": ["None", "A"], "shipto_address2": ["None", "B"], "so_due_date": ["None", "2023-09-30"], "updated": ["None", "2023-09-13 05:18:00.700048"], "free_qty": ["None", "0"], "shipto_pincode": ["None", "80010"], "ammount": ["None", "0"], "sgst": ["None", "0"], "buyer_state": ["None", "New York"], "buyer_address3": ["None", "C"], "company": ["None", "ABC"], "shipto_state": ["None", "New Jersey"], "shipto_city": ["None", "NJC"], "buyer_country": ["None", "INDIA"], "status": ["None", "1"], "terms_of_delivery": ["None", "Paid"], "tcs": ["None", "0"], "buyer_city": ["None", "NYC1"], "shipto_mailingname": ["None", "CS"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "shipto": ["None", "ABCD"], "created": ["None", "2023-09-13 05:18:00.700011"], "bill_qty": ["None", "0"], "shipto_address_type": ["None", "Default"], "shipto_pan_no": ["None", "AAPOS1478Q"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "order_no": ["None", ""], "mode_of_payment": ["None", "0"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_address2": ["None", "B"], "shipto_country": ["None", "INDIA"], "other_reference": ["None", ""], "id": ["None", "29"], "igst": ["None", "0"], "shipto_address3": ["None", "C"], "price_list": ["None", "5%"], "buyer": ["None", "Customer Name"]}	2023-09-13 10:48:00.712+05:30	2	66	127.0.0.1	\N
690	30	30	2223SO00016	0	{"company": ["None", "ABC"], "updated": ["None", "2023-09-13 05:19:01.180855"], "buyer_state": ["None", "New York"], "status": ["None", "1"], "buyer_country": ["None", "INDIA"], "shipto_city": ["None", "NJC"], "terms_of_delivery": ["None", "Paid"], "sgst": ["None", "0"], "buyer_city": ["None", "NYC1"], "shipto_mailingname": ["None", "CS"], "tcs": ["None", "0"], "isscheme": ["None", "False"], "round_off": ["None", "0"], "shipto": ["None", "ABCD"], "created": ["None", "2023-09-13 05:19:01.180832"], "shipto_state": ["None", "New Jersey"], "bill_qty": ["None", "0"], "shipto_pan_no": ["None", "AAPOS1478Q"], "narration": ["None", ""], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "mode_of_payment": ["None", "0"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_country": ["None", "INDIA"], "order_no": ["None", ""], "id": ["None", "30"], "buyer_address2": ["None", "B"], "other_reference": ["None", ""], "igst": ["None", "0"], "buyer_pincode": ["None", "40025"], "shipto_address3": ["None", "C"], "price_list": ["None", "5%"], "shipto_pincode": ["None", "80010"], "other": ["None", "0"], "ol_rate": ["None", "0"], "buyer": ["None", "Customer Name"], "so_no": ["None", "2223SO00016"], "buyer_mailingname": ["None", "ABCD"], "discount": ["None", "0.0"], "total": ["None", "0"], "buyer_address1": ["None", "A"], "shipto_address2": ["None", "B"], "so_due_date": ["None", "2023-09-30"], "shipto_address1": ["None", "A"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-13 05:19:01.178740+00:00"], "ammount": ["None", "0"], "buyer_address3": ["None", "C"]}	2023-09-13 10:49:01.19+05:30	2	66	127.0.0.1	\N
691	31	31	2223SO00017	0	{"company": ["None", "ABC"], "updated": ["None", "2023-09-13 05:19:16.330428"], "shipto_address1": ["None", "A"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-13 05:19:16.328238+00:00"], "shipto_city": ["None", "NJC"], "sgst": ["None", "0"], "buyer_city": ["None", "NYC1"], "round_off": ["None", "0"], "isscheme": ["None", "False"], "buyer_country": ["None", "INDIA"], "status": ["None", "1"], "shipto": ["None", "ABCD"], "terms_of_delivery": ["None", "Paid"], "created": ["None", "2023-09-13 05:19:16.330407"], "shipto_mailingname": ["None", "CS"], "tcs": ["None", "0"], "buyer_address3": ["None", "C"], "buyer_address_type": ["None", "Default"], "mode_of_payment": ["None", "0"], "cgst": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_address2": ["None", "B"], "shipto_country": ["None", "INDIA"], "order_no": ["None", ""], "bill_qty": ["None", "0"], "id": ["None", "31"], "shipto_pan_no": ["None", "AAPOS1478Q"], "narration": ["None", ""], "shipto_address_type": ["None", "Default"], "shipto_address3": ["None", "C"], "price_list": ["None", "5%"], "buyer_pincode": ["None", "40025"], "shipto_state": ["None", "New Jersey"], "other_reference": ["None", ""], "other": ["None", "0"], "igst": ["None", "0"], "buyer": ["None", "Customer Name"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00017"], "buyer_mailingname": ["None", "ABCD"], "total": ["None", "0"], "buyer_address1": ["None", "A"], "shipto_address2": ["None", "B"], "so_due_date": ["None", "2023-09-30"], "ol_rate": ["None", "0"], "shipto_pincode": ["None", "80010"], "ammount": ["None", "0"], "buyer_state": ["None", "New York"]}	2023-09-13 10:49:16.339+05:30	2	66	127.0.0.1	\N
692	32	32	2223SO00018	0	{"status": ["None", "1"], "buyer_country": ["None", "INDIA"], "shipto_city": ["None", "NJC"], "terms_of_delivery": ["None", "Paid"], "buyer_city": ["None", "NYC1"], "sgst": ["None", "0"], "shipto_state": ["None", "New Jersey"], "round_off": ["None", "0"], "company": ["None", "ABC"], "isscheme": ["None", "False"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CS"], "bill_qty": ["None", "0"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer_address_type": ["None", "Default"], "narration": ["None", ""], "shipto": ["None", "ABCD"], "mode_of_payment": ["None", "0"], "created": ["None", "2023-09-13 05:19:54.298613"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto_country": ["None", "INDIA"], "cgst": ["None", "0"], "id": ["None", "32"], "updated": ["None", "2023-09-13 05:19:54.298635"], "shipto_address_type": ["None", "Default"], "other_reference": ["None", ""], "order_no": ["None", ""], "buyer_pincode": ["None", "40025"], "igst": ["None", "0"], "buyer_address2": ["None", "B"], "shipto_address3": ["None", "C"], "price_list": ["None", "5%"], "other": ["None", "0"], "ol_rate": ["None", "0"], "buyer": ["None", "Customer Name"], "discount": ["None", "0.0"], "so_no": ["None", "2223SO00018"], "buyer_mailingname": ["None", "ABCD"], "buyer_address1": ["None", "A"], "shipto_address1": ["None", "A"], "free_qty": ["None", "0"], "so_date": ["None", "2023-09-13 05:19:54.295973+00:00"], "total": ["None", "0"], "shipto_address2": ["None", "B"], "ammount": ["None", "0"], "so_due_date": ["None", "2023-09-30"], "buyer_address3": ["None", "C"], "shipto_pincode": ["None", "80010"], "buyer_state": ["None", "New York"]}	2023-09-13 10:49:54.31+05:30	2	66	127.0.0.1	\N
693	5	5	Price_list object (5)	0	{"id": ["None", "5"], "updated": ["None", "2023-09-13"], "price_level": ["None", "Manual"], "rate": ["None", "100"], "product": ["None", "RAW1"], "created": ["None", "2023-09-13"], "applicable_from": ["None", "2023-09-13"]}	2023-09-13 10:51:20.843+05:30	2	38	127.0.0.1	\N
694	6	6	Price_list object (6)	0	{"id": ["None", "6"], "updated": ["None", "2023-09-13"], "price_level": ["None", "10%"], "rate": ["None", "90"], "product": ["None", "RAW1"], "created": ["None", "2023-09-13"], "applicable_from": ["None", "2023-09-13"]}	2023-09-13 10:51:47.98+05:30	2	38	127.0.0.1	\N
695	32	32	2223SO00018	1	{"shipto_address3": ["C", "None"], "shipto_gstin": ["None", ""], "buyer_address3": ["C", "None"]}	2023-09-13 10:53:18.463+05:30	2	66	127.0.0.1	\N
697	31	31	2223SO00017	1	{"status": ["1", "2"]}	2023-09-13 10:54:33.892+05:30	2	66	127.0.0.1	\N
698	30	30	2223SO00016	1	{"status": ["1", "2"]}	2023-09-13 10:55:22.714+05:30	2	66	127.0.0.1	\N
700	33	33	2223SO00019	0	{"buyer_country": ["None", "England"], "shipto_city": ["None", "Mumbai"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "Customer Name 2"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "30"], "isscheme": ["None", "False"], "buyer_city": ["None", "Amsterdam"], "buyer_gstin": ["None", "asdsasda152ad"], "round_off": ["None", "0"], "shipto": ["None", "Customer Name 2"], "mode_of_payment": ["None", "30"], "created": ["None", "2023-09-13 05:26:34.596318"], "buyer_gst_reg_type": ["None", "Consumer"], "id": ["None", "33"], "shipto_pan_no": ["None", "AAPOD1234Z"], "narration": ["None", "New One"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "cgst": ["None", "0"], "shipto_country": ["None", "India"], "order_no": ["None", ""], "buyer_address2": ["None", "Cm3"], "shipto_address3": ["None", "Address Line1"], "price_list": ["None", "Manual"], "other_reference": ["None", ""], "shipto_state": ["None", "Maharashtra"], "igst": ["None", "0"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "buyer": ["None", "Cm3"], "buyer_pincode": ["None", "321456"], "discount": ["None", "0.0"], "other": ["None", "0"], "ol_rate": ["None", "5"], "so_no": ["None", "2223SO00019"], "buyer_mailingname": ["None", "CM3"], "so_date": ["None", "2023-09-13 05:26:34.593420+00:00"], "shipto_address1": ["None", "Address Line1"], "total": ["None", "0"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "so_due_date": ["None", "2023-09-30"], "updated": ["None", "2023-09-13 05:26:34.596343"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "buyer_address3": ["None", "Cm3"], "shipto_pincode": ["None", "493320"], "sgst": ["None", "0"], "buyer_state": ["None", "Amsterdam"], "company": ["None", "ABC"]}	2023-09-13 10:56:34.603+05:30	2	66	127.0.0.1	\N
701	9	9	RAW1	0	{"id": ["None", "9"], "actual_qty": ["None", "11"], "free_qty": ["None", "0"], "rate": ["None", "150"], "sgst": ["None", "0.00"], "offer_mrp": ["None", "0"], "billed_qty": ["None", "11"], "amount": ["None", "1567.50"], "item": ["None", "RAW1"], "igst": ["None", "0.00"], "mrp": ["None", "345.00"], "cgstrate": ["None", "0.00"], "pack": ["None", "1.00"], "cgst": ["None", "0.00"], "available_qty": ["None", "680"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "discount": ["None", "5"], "so": ["None", "2223SO00019"]}	2023-09-13 10:56:34.617+05:30	2	67	127.0.0.1	\N
702	33	33	2223SO00019	1	{"bill_qty": ["0.00", "11"], "round_off": ["0.00", "-0.38"], "cgst": ["0.00", "39.19"], "igst": ["0.00", "78.38"], "discount": ["0.00", "0.0"], "other": ["0.00", "1567.50"], "ol_rate": ["5.00", "5"], "so_date": ["2023-09-13", "2023-09-13 05:26:34.593420+00:00"], "total": ["0.00", "3213"], "free_qty": ["0.00", "0"], "ammount": ["0.00", "1567.50"], "sgst": ["0.00", "39.19"]}	2023-09-13 10:56:34.63+05:30	2	66	127.0.0.1	\N
703	34	34	2223SO00020	0	{"buyer_country": ["None", "India"], "shipto_city": ["None", "Amsterdam"], "tcs": ["None", "0"], "shipto_mailingname": ["None", "CM3"], "bill_qty": ["None", "0"], "terms_of_delivery": ["None", "40"], "isscheme": ["None", "False"], "buyer_city": ["None", "Vadodara"], "buyer_gstin": ["None", "12AYRFG125I"], "round_off": ["None", "0"], "shipto": ["None", "Cm3"], "mode_of_payment": ["None", "30"], "created": ["None", "2023-09-13 05:27:19.858033"], "buyer_gst_reg_type": ["None", "Unknown"], "id": ["None", "34"], "shipto_pan_no": ["None", "asdsas1a"], "narration": ["None", "New Two"], "buyer_address_type": ["None", "Default"], "shipto_address_type": ["None", "Default"], "cgst": ["None", "0"], "shipto_country": ["None", "England"], "order_no": ["None", ""], "buyer_address2": ["None", "ABC"], "shipto_address3": ["None", "Cm3"], "price_list": ["None", "10%"], "other_reference": ["None", ""], "shipto_state": ["None", "Amsterdam"], "igst": ["None", "0"], "shipto_gstin": ["None", "asdsasda152ad"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "discount": ["None", "0.0"], "other": ["None", "0"], "ol_rate": ["None", "5"], "so_no": ["None", "2223SO00020"], "buyer_mailingname": ["None", "ABCD"], "so_date": ["None", "2023-09-13 05:27:19.852675+00:00"], "shipto_address1": ["None", "Cm3"], "total": ["None", "0"], "buyer_address1": ["None", "ABC"], "shipto_address2": ["None", "Cm3"], "so_due_date": ["None", "2023-09-30"], "updated": ["None", "2023-09-13 05:27:19.858067"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "buyer_address3": ["None", "ABC"], "shipto_pincode": ["None", "321456"], "sgst": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "company": ["None", "ABC"]}	2023-09-13 10:57:19.865+05:30	2	66	127.0.0.1	\N
704	10	10	RAW1	0	{"id": ["None", "10"], "actual_qty": ["None", "10"], "free_qty": ["None", "0"], "rate": ["None", "90.00"], "sgst": ["None", "0.00"], "offer_mrp": ["None", "0"], "billed_qty": ["None", "10"], "amount": ["None", "810.00"], "item": ["None", "RAW1"], "igst": ["None", "0.00"], "mrp": ["None", "345.00"], "cgstrate": ["None", "0.00"], "pack": ["None", "1.00"], "cgst": ["None", "0.00"], "available_qty": ["None", "669"], "igstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "discount": ["None", "10"], "so": ["None", "2223SO00020"]}	2023-09-13 10:57:19.882+05:30	2	67	127.0.0.1	\N
705	34	34	2223SO00020	1	{"bill_qty": ["0.00", "10"], "round_off": ["0.00", "-0.50"], "cgst": ["0.00", "20.25"], "igst": ["0.00", "40.50"], "discount": ["0.00", "0.0"], "other": ["0.00", "810"], "ol_rate": ["5.00", "5"], "so_date": ["2023-09-13", "2023-09-13 05:27:19.852675+00:00"], "total": ["0.00", "1660"], "free_qty": ["0.00", "0"], "ammount": ["0.00", "810.00"], "sgst": ["0.00", "20.25"]}	2023-09-13 10:57:19.894+05:30	2	66	127.0.0.1	\N
706	4	4	2223DN00004	0	{"shipto_pan_no": ["None", "asdsas1a"], "buyer_address_type": ["None", "Default"], "total": ["None", "1660.00"], "ls_status": ["None", "False"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Gujarat-1"], "other_reference": ["None", ""], "sales_order": ["None", "2223SO00020"], "buyer_address3": ["None", "ABC"], "price_list": ["None", "10%"], "dn_no": ["None", "2223DN00004"], "buyer_pincode": ["None", "390002"], "shipto_pincode": ["None", "321456"], "igst": ["None", "40.50"], "dn_date": ["None", "2023-09-13 05:44:31.074704+00:00"], "shipto_gstin": ["None", "asdsasda152ad"], "tcs": ["None", "0.00"], "shipto": ["None", "Cm3"], "bill_qty": ["None", "10.00"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "ABCD"], "created": ["None", "2023-09-13"], "buyer_address1": ["None", "ABC"], "shipto_address2": ["None", "Cm3"], "discount": ["None", "0.00"], "terms_of_delivery": ["None", "40"], "buyer_address2": ["None", "ABC"], "shipto_address3": ["None", "Cm3"], "mode_of_payment": ["None", "30"], "shipto_address1": ["None", "Cm3"], "updated": ["None", "2023-09-13"], "buyer_gst_reg_type": ["None", "Unknown"], "cgst": ["None", "20.25"], "shipto_state": ["None", "Amsterdam"], "order_no": ["None", ""], "status": ["None", "1"], "ps_status": ["None", "False"], "sgst": ["None", "20.25"], "id": ["None", "4"], "shipto_country": ["None", "England"], "buyer_country": ["None", "India"], "ammount": ["None", "810.00"], "round_off": ["None", "-0.50"], "buyer_city": ["None", "Vadodara"], "shipto_mailingname": ["None", "CM3"], "narration": ["None", "New Two"], "buyer_gstin": ["None", "12AYRFG125I"], "shipto_city": ["None", "Amsterdam"], "ol_rate": ["None", "5.00"], "buyer": ["None", "ABCD"], "other": ["None", "810.00"], "shipto_address_type": ["None", "Default"]}	2023-09-13 11:14:31.088+05:30	2	68	127.0.0.1	\N
707	26	26	PRODUCTION	1	{"closing_balance": ["680.0000", "670.0000"]}	2023-09-13 11:14:31.102+05:30	2	84	127.0.0.1	\N
712	5	5	2223INV00005	0	{"bill_qty": ["None", "10.00"], "inv_date": ["None", "2023-09-13 05:51:51.101274+00:00"], "channel": ["None", "Channel 1"], "buyer_address2": ["None", "ABC"], "shipto_address_type": ["None", "Default"], "shipto_address3": ["None", "Cm3"], "discount": ["None", "0.00"], "buyer_country": ["None", "India"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "shipto_pincode": ["None", "321456"], "sgst": ["None", "20.25"], "total": ["None", "1660.00"], "order_no": ["None", ""], "updated": ["None", "2023-09-13"], "buyer_mailingname": ["None", "ABCD"], "igst": ["None", "40.50"], "price_list": ["None", "10%"], "shipto_address2": ["None", "Cm3"], "status": ["None", "1"], "id": ["None", "5"], "ammount": ["None", "810.00"], "terms_of_delivery": ["None", "40"], "inv_no": ["None", "2223INV00005"], "buyer_address1": ["None", "ABC"], "shipto_gstin": ["None", "asdsasda152ad"], "cgst": ["None", "20.25"], "is_ivt": ["None", "False"], "mode_of_payment": ["None", "30"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "ABC"], "free_qty": ["None", "0.00"], "company": ["None", "ABC"], "buyer_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-13"], "shipto_address1": ["None", "Cm3"], "mrpvalue": ["None", "0"], "shipto_city": ["None", "Amsterdam"], "other_reference": ["None", ""], "round_off": ["None", "-0.50"], "shipto_state": ["None", "Amsterdam"], "buyer_address_type": ["None", "Default"], "buyer_city": ["None", "Vadodara"], "ol_rate": ["None", "5.00"], "narration": ["None", "New Two"], "is_ict": ["None", "False"], "dn": ["None", "2223DN00004"], "buyer_gst_reg_type": ["None", "Unknown"], "shipto": ["None", "Cm3"], "other": ["None", "810.00"], "shipto_mailingname": ["None", "CM3"], "buyer_gstin": ["None", "12AYRFG125I"], "division": ["None", "ECOM"], "tcs": ["None", "0.00"], "shipto_country": ["None", "England"]}	2023-09-13 11:21:51.117+05:30	2	70	127.0.0.1	\N
713	5	5	InvItems object (5)	0	{"rate": ["None", "90.00"], "actual_qty": ["None", "10.000"], "discount": ["None", "10.00"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "10.000"], "sgst": ["None", "0.00"], "item": ["None", "RAW1"], "id": ["None", "5"], "pack": ["None", "1.00"], "nf_qty": ["None", "0.00"], "offer_mrp": ["None", "0.00"], "igstrate": ["None", "0.00"], "prate": ["None", "1.00"], "sgstrate": ["None", "0.00"], "inv": ["None", "2223INV00005"], "new_rate": ["None", "90.00"], "nb_qty": ["None", "10.000"], "mrp": ["None", "345.00"], "free_qty": ["None", "0.00"], "igst": ["None", "0.00"], "amount": ["None", "810.00"], "available_qty": ["None", "669.00"], "cgst": ["None", "0.00"]}	2023-09-13 11:21:51.132+05:30	2	71	127.0.0.1	\N
714	4	4	2223DN00004	1	{"status": ["1", "3"]}	2023-09-13 11:21:51.157+05:30	2	68	127.0.0.1	\N
715	5	5	2223INV00005	1	{"inv_date": ["2023-09-13", "2023-09-13 05:51:51.101274+00:00"], "omrpvalue": ["0.00", "0.00000"], "mrpvalue": ["0.00", "3450.00000"]}	2023-09-13 11:21:51.176+05:30	2	70	127.0.0.1	\N
716	4	4	2223CN00004	0	{"buyer_pincode": ["None", "390002"], "total": ["None", "0"], "buyer_gst_reg_type": ["None", "Unknown"], "mrpvalue": ["None", "0"], "division": ["None", "ECOM"], "buyer_address1": ["None", "ABC"], "other": ["None", "0"], "id": ["None", "4"], "status": ["None", "1"], "cn_no": ["None", "2223CN00004"], "buyer_address2": ["None", "ABC"], "igst": ["None", "0"], "cn_date": ["None", "2023-09-13"], "buyer_address3": ["None", "ABC"], "company": ["None", "ABC"], "buyer_state": ["None", "Gujarat-1"], "buyer_gstin": ["None", "12AYRFG125I"], "tcs": ["None", "0"], "round_off": ["None", "0"], "ammount": ["None", "0"], "updated": ["None", "2023-09-13"], "buyer_city": ["None", "Vadodara"], "discount": ["None", "0.00"], "inv": ["None", "2223INV00005"], "buyer_mailingname": ["None", "ABCD"], "sgst": ["None", "0"], "cgst": ["None", "0"], "omrpvalue": ["None", "0"], "channel": ["None", "Channel 1"], "ol_rate": ["None", "0"], "created": ["None", "2023-09-13"], "narration": ["None", "New Two"], "buyer_country": ["None", "India"], "buyer": ["None", "ABCD"], "buyer_address_type": ["None", "Default"]}	2023-09-13 11:22:39.43+05:30	2	74	127.0.0.1	\N
717	4	4	2223CN00004	2	{"buyer_pincode": ["390002", "None"], "total": ["0", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "mrpvalue": ["0", "None"], "division": ["ECOM", "None"], "buyer_address1": ["ABC", "None"], "other": ["0", "None"], "id": ["4", "None"], "status": ["1", "None"], "cn_no": ["2223CN00004", "None"], "buyer_address2": ["ABC", "None"], "igst": ["0", "None"], "cn_date": ["2023-09-13", "None"], "buyer_address3": ["ABC", "None"], "company": ["ABC", "None"], "buyer_state": ["Gujarat-1", "None"], "buyer_gstin": ["12AYRFG125I", "None"], "tcs": ["0", "None"], "round_off": ["0", "None"], "ammount": ["0", "None"], "updated": ["2023-09-13", "None"], "buyer_city": ["Vadodara", "None"], "discount": ["0.00", "None"], "inv": ["2223INV00005", "None"], "buyer_mailingname": ["ABCD", "None"], "sgst": ["0", "None"], "cgst": ["0", "None"], "omrpvalue": ["0", "None"], "channel": ["Channel 1", "None"], "ol_rate": ["0", "None"], "created": ["2023-09-13", "None"], "narration": ["New Two", "None"], "buyer_country": ["India", "None"], "buyer": ["ABCD", "None"], "buyer_address_type": ["Default", "None"]}	2023-09-13 11:22:39.439+05:30	2	74	127.0.0.1	\N
718	5	5	2223CN00004	0	{"buyer_pincode": ["None", "390002"], "total": ["None", "0"], "buyer_gst_reg_type": ["None", "Unknown"], "mrpvalue": ["None", "0"], "division": ["None", "ECOM"], "buyer_address1": ["None", "ABC"], "other": ["None", "0"], "id": ["None", "5"], "status": ["None", "1"], "cn_no": ["None", "2223CN00004"], "buyer_address2": ["None", "ABC"], "igst": ["None", "0"], "cn_date": ["None", "2023-09-13"], "buyer_address3": ["None", "ABC"], "company": ["None", "ABC"], "buyer_state": ["None", "Gujarat-1"], "buyer_gstin": ["None", "12AYRFG125I"], "tcs": ["None", "0"], "round_off": ["None", "0"], "ammount": ["None", "0"], "updated": ["None", "2023-09-13"], "buyer_city": ["None", "Vadodara"], "discount": ["None", "0.00"], "inv": ["None", "2223INV00005"], "buyer_mailingname": ["None", "ABCD"], "sgst": ["None", "0"], "cgst": ["None", "0"], "omrpvalue": ["None", "0"], "channel": ["None", "Channel 1"], "ol_rate": ["None", "0"], "created": ["None", "2023-09-13"], "narration": ["None", "New Two"], "buyer_country": ["None", "India"], "buyer": ["None", "ABCD"], "buyer_address_type": ["None", "Default"]}	2023-09-13 11:23:23.602+05:30	2	74	127.0.0.1	\N
719	5	5	InvItems object (5)	1	{"new_rate": ["90.00", "80.00"]}	2023-09-13 11:23:23.61+05:30	2	71	127.0.0.1	\N
720	4	4	CreditNoteItems object (4)	0	{"rates": ["None", "90.00"], "discount": ["None", "10.00"], "inv": ["None", "2223CN00004"], "igstrate": ["None", "0.00"], "id": ["None", "4"], "sgstrate": ["None", "0.00"], "rate": ["None", "10"], "item": ["None", "RAW1"], "amount": ["None", "90.00"], "igst": ["None", "0.00"], "billed_qty": ["None", "10.00"], "sgst": ["None", "0.00"], "cgstrate": ["None", "0.00"], "mrp": ["None", "345.00"], "cgst": ["None", "0.00"]}	2023-09-13 11:23:23.624+05:30	2	75	127.0.0.1	\N
721	5	5	2223CN00004	1	{"total": ["0.00", "90"], "mrpvalue": ["0.00", "0"], "other": ["0.00", "0"], "tcs": ["0.00", "0"], "ammount": ["0.00", "90.00"], "omrpvalue": ["0.00", "0"], "ol_rate": ["0.00", "0"]}	2023-09-13 11:23:23.635+05:30	2	74	127.0.0.1	\N
773	1	1	PackingSheet object (1)	0	{"remarks": ["None", ""], "to_box": ["None", "2"], "offermrp": ["None", "0.00"], "status": ["None", "False"], "dn": ["None", "2223DN00006"], "company": ["None", "ABC"], "total_box": ["None", "3"], "created": ["None", "2023-09-13"], "qty": ["None", "1.000"], "item": ["None", "FG1"], "mrp": ["None", "100.00"], "updated": ["None", "2023-09-13"], "id": ["None", "1"], "from_box": ["None", "1"]}	2023-09-13 12:33:59.474+05:30	2	81	127.0.0.1	\N
722	5	5	2223DN00005	0	{"shipto_pan_no": ["None", "AAPOD1234Z"], "buyer_address_type": ["None", "Default"], "total": ["None", "3213.00"], "ls_status": ["None", "False"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Amsterdam"], "other_reference": ["None", ""], "sales_order": ["None", "2223SO00019"], "buyer_address3": ["None", "Cm3"], "price_list": ["None", "Manual"], "dn_no": ["None", "2223DN00005"], "buyer_pincode": ["None", "321456"], "shipto_pincode": ["None", "493320"], "igst": ["None", "78.38"], "dn_date": ["None", "2023-09-13 05:57:32.149274+00:00"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "tcs": ["None", "0.00"], "shipto": ["None", "Customer Name 2"], "bill_qty": ["None", "11.00"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "CM3"], "created": ["None", "2023-09-13"], "buyer_address1": ["None", "Cm3"], "shipto_address2": ["None", "Address Line1"], "discount": ["None", "0.00"], "terms_of_delivery": ["None", "30"], "buyer_address2": ["None", "Cm3"], "shipto_address3": ["None", "Address Line1"], "mode_of_payment": ["None", "30"], "shipto_address1": ["None", "Address Line1"], "updated": ["None", "2023-09-13"], "buyer_gst_reg_type": ["None", "Consumer"], "cgst": ["None", "39.19"], "shipto_state": ["None", "Maharashtra"], "order_no": ["None", ""], "status": ["None", "1"], "ps_status": ["None", "False"], "sgst": ["None", "39.19"], "id": ["None", "5"], "shipto_country": ["None", "India"], "buyer_country": ["None", "England"], "ammount": ["None", "1567.50"], "round_off": ["None", "-0.38"], "buyer_city": ["None", "Amsterdam"], "shipto_mailingname": ["None", "Customer Name 2"], "narration": ["None", "New One"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_city": ["None", "Mumbai"], "ol_rate": ["None", "5.00"], "buyer": ["None", "Cm3"], "other": ["None", "1567.50"], "shipto_address_type": ["None", "Default"]}	2023-09-13 11:27:32.16+05:30	2	68	127.0.0.1	\N
723	26	26	PRODUCTION	1	{"closing_balance": ["670.0000", "659.0000"]}	2023-09-13 11:27:32.182+05:30	2	84	127.0.0.1	\N
724	5	5	LoadingSheet object (5)	0	{"dn": ["None", "2223DN00005"], "prate": ["None", "1.00"], "godown": ["None", "PRODUCTION"], "company": ["None", "ABC"], "updated": ["None", "2023-09-13"], "batch": ["None", "20230912003001"], "id": ["None", "5"], "item": ["None", "RAW1"], "mrp": ["None", "345.00"], "offermrp": ["None", "0.00"], "qty": ["None", "11.0000"], "created": ["None", "2023-09-13"]}	2023-09-13 11:27:32.199+05:30	2	80	127.0.0.1	\N
725	5	5	DnItems object (5)	0	{"igstrate": ["None", "0.00"], "dn": ["None", "2223DN00005"], "actual_qty": ["None", "11.00"], "amount": ["None", "1567.50"], "free_qty": ["None", "0.00"], "rate": ["None", "150.00"], "pack": ["None", "1.00"], "cgst": ["None", "0.00"], "available_qty": ["None", "680.00"], "id": ["None", "5"], "sgst": ["None", "0.00"], "billed_qty": ["None", "11.00"], "item": ["None", "RAW1"], "sgstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "mrp": ["None", "345.00"], "offer_mrp": ["None", "0.00"], "igst": ["None", "0.00"], "prate": ["None", "1.00"], "discount": ["None", "5.00"]}	2023-09-13 11:27:32.214+05:30	2	69	127.0.0.1	\N
726	5	5	2223DN00005	1	{"dn_date": ["2023-09-13", "2023-09-13 05:57:32.149274+00:00"]}	2023-09-13 11:27:32.229+05:30	2	68	127.0.0.1	\N
727	33	33	2223SO00019	1	{"status": ["1", "3"]}	2023-09-13 11:27:32.242+05:30	2	66	127.0.0.1	\N
728	1	1	2223PI00001	0	{"sgst": ["None", "39.19"], "buyer_gstin": ["None", "asdsasda152ad"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "cgst": ["None", "39.19"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_mailingname": ["None", "CM3"], "order_no": ["None", ""], "igst": ["None", "78.38"], "updated": ["None", "2023-09-13"], "ammount": ["None", "1567.50"], "inv_no": ["None", "2223PI00001"], "buyer_address1": ["None", "Cm3"], "discount": ["None", "0.00"], "inv_date": ["None", "2023-09-13 05:57:49.987847+00:00"], "buyer_country": ["None", "England"], "omrpvalue": ["None", "0"], "other_reference": ["None", ""], "buyer_address3": ["None", "Cm3"], "shipto_pincode": ["None", "493320"], "price_list": ["None", "Manual"], "shipto_address2": ["None", "Address Line1"], "company": ["None", "ABC"], "status": ["None", "1"], "buyer_state": ["None", "Amsterdam"], "terms_of_delivery": ["None", "30"], "shipto_city": ["None", "Mumbai"], "is_ict": ["None", "False"], "shipto_state": ["None", "Maharashtra"], "other": ["None", "1567.50"], "created": ["None", "2023-09-13"], "buyer_city": ["None", "Amsterdam"], "buyer_pincode": ["None", "321456"], "is_ivt": ["None", "False"], "ol_rate": ["None", "5.00"], "narration": ["None", "New One"], "shipto_address1": ["None", "Address Line1"], "shipto_address3": ["None", "Address Line1"], "shipto": ["None", "Customer Name 2"], "shipto_mailingname": ["None", "Customer Name 2"], "division": ["None", "Manual"], "free_qty": ["None", "0.00"], "mrpvalue": ["None", "0"], "tcs": ["None", "0.00"], "shipto_country": ["None", "India"], "mode_of_payment": ["None", "30"], "dn": ["None", "2223DN00005"], "id": ["None", "1"], "bill_qty": ["None", "11.00"], "channel": ["None", "Channel 2"], "shipto_address_type": ["None", "Default"], "round_off": ["None", "-0.38"], "buyer_address_type": ["None", "Default"], "total": ["None", "3213.00"], "buyer_address2": ["None", "Cm3"], "buyer": ["None", "Cm3"]}	2023-09-13 11:27:49.999+05:30	2	72	127.0.0.1	\N
729	1	1	ProformaInvItems object (1)	0	{"item": ["None", "RAW1"], "sgst": ["None", "0.00"], "offer_mrp": ["None", "0.00"], "sgstrate": ["None", "0.00"], "pack": ["None", "1.00"], "igstrate": ["None", "0.00"], "actual_qty": ["None", "11.000"], "new_rate": ["None", "150.00"], "inv": ["None", "2223PI00001"], "id": ["None", "1"], "prate": ["None", "1.00"], "mrp": ["None", "345.00"], "discount": ["None", "5.00"], "free_qty": ["None", "0.00"], "nb_qty": ["None", "11.000"], "cgst": ["None", "0.00"], "nf_qty": ["None", "0.00"], "amount": ["None", "1567.50"], "rate": ["None", "150.00"], "available_qty": ["None", "680.00"], "igst": ["None", "0.00"], "billed_qty": ["None", "11.000"], "cgstrate": ["None", "0.00"]}	2023-09-13 11:27:50.014+05:30	2	73	127.0.0.1	\N
730	1	1	2223PI00001	1	{"inv_date": ["2023-09-13", "2023-09-13 05:57:49.987847+00:00"], "omrpvalue": ["0.00", "0.00000"], "mrpvalue": ["0.00", "3795.00000"]}	2023-09-13 11:27:50.033+05:30	2	72	127.0.0.1	\N
731	5	5	2223DN00005	1	{"status": ["1", "3"]}	2023-09-13 11:27:50.051+05:30	2	68	127.0.0.1	\N
732	2	2	2223RSO00002	0	{"cgst": ["None", "0"], "omrpvalue": ["None", "0"], "division": ["None", "ECOM"], "rso_ref": ["None", "Ab1"], "is_cm": ["None", "True"], "buyer_city": ["None", "Vadodara"], "bill_qty": ["None", "0"], "is_ivt": ["None", "False"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "buyer_gst_reg_type": ["None", "Unknown"], "igst": ["None", "0"], "buyer_gstin": ["None", "12AYRFG125I"], "tcs": ["None", "0"], "rso_no": ["None", "2223RSO00002"], "created": ["None", "2023-09-13"], "rso_date": ["None", "2023-09-13 05:58:28.204045+00:00"], "mrpvalue": ["None", "0"], "buyer_address1": ["None", "ABC"], "discount": ["None", "0"], "updated": ["None", "2023-09-13"], "round_off": ["None", "0"], "buyer_address2": ["None", "ABC"], "id": ["None", "2"], "sgst": ["None", "0"], "buyer_address_type": ["None", "Default"], "buyer_address3": ["None", "ABC"], "ref_date": ["None", "2023-09-14"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "ABCD"], "total": ["None", "0"], "channel": ["None", "Channel 1"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "narration": ["None", ""], "buyer_country": ["None", "India"], "buyer_state": ["None", "Gujarat-1"]}	2023-09-13 11:28:28.212+05:30	2	78	127.0.0.1	\N
733	6	6	2223INV00006	0	{"bill_qty": ["None", "11.00"], "inv_date": ["None", "2023-09-13 06:04:35.664587+00:00"], "channel": ["None", "Channel 2"], "buyer_address2": ["None", "Cm3"], "shipto_address_type": ["None", "Default"], "shipto_address3": ["None", "Address Line1"], "discount": ["None", "0.00"], "buyer_country": ["None", "England"], "buyer": ["None", "Cm3"], "buyer_pincode": ["None", "321456"], "shipto_pincode": ["None", "493320"], "sgst": ["None", "39.19"], "total": ["None", "3213.00"], "order_no": ["None", ""], "updated": ["None", "2023-09-13"], "buyer_mailingname": ["None", "CM3"], "igst": ["None", "78.38"], "price_list": ["None", "Manual"], "shipto_address2": ["None", "Address Line1"], "status": ["None", "1"], "id": ["None", "6"], "ammount": ["None", "1567.50"], "terms_of_delivery": ["None", "30"], "inv_no": ["None", "2223INV00006"], "buyer_address1": ["None", "Cm3"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "cgst": ["None", "39.19"], "is_ivt": ["None", "False"], "mode_of_payment": ["None", "30"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "Cm3"], "free_qty": ["None", "0.00"], "company": ["None", "ABC"], "buyer_state": ["None", "Amsterdam"], "created": ["None", "2023-09-13"], "shipto_address1": ["None", "Address Line1"], "mrpvalue": ["None", "0"], "shipto_city": ["None", "Mumbai"], "other_reference": ["None", ""], "round_off": ["None", "-0.38"], "shipto_state": ["None", "Maharashtra"], "buyer_address_type": ["None", "Default"], "buyer_city": ["None", "Amsterdam"], "ol_rate": ["None", "5.00"], "narration": ["None", "New One"], "is_ict": ["None", "False"], "dn": ["None", "2223DN00005"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto": ["None", "Customer Name 2"], "other": ["None", "1567.50"], "shipto_mailingname": ["None", "Customer Name 2"], "buyer_gstin": ["None", "asdsasda152ad"], "division": ["None", "Manual"], "tcs": ["None", "0.00"], "shipto_country": ["None", "India"]}	2023-09-13 11:34:35.683+05:30	2	70	127.0.0.1	\N
734	6	6	InvItems object (6)	0	{"rate": ["None", "150.00"], "actual_qty": ["None", "11.000"], "discount": ["None", "5.00"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "11.000"], "sgst": ["None", "0.00"], "item": ["None", "RAW1"], "id": ["None", "6"], "pack": ["None", "1.00"], "nf_qty": ["None", "0.00"], "offer_mrp": ["None", "0.00"], "igstrate": ["None", "0.00"], "prate": ["None", "1.00"], "sgstrate": ["None", "0.00"], "inv": ["None", "2223INV00006"], "new_rate": ["None", "150.00"], "nb_qty": ["None", "11.00"], "mrp": ["None", "345.00"], "free_qty": ["None", "0.00"], "igst": ["None", "0.00"], "amount": ["None", "1567.50"], "available_qty": ["None", "680.00"], "cgst": ["None", "0.00"]}	2023-09-13 11:34:35.697+05:30	2	71	127.0.0.1	\N
735	1	1	2223PI00001	1	{"status": ["1", "3"]}	2023-09-13 11:34:35.718+05:30	2	72	127.0.0.1	\N
736	6	6	2223INV00006	1	{"inv_date": ["2023-09-13", "2023-09-13 06:04:35.664587+00:00"], "mrpvalue": ["0.00", "3795.00"]}	2023-09-13 11:34:35.733+05:30	2	70	127.0.0.1	\N
737	3	3	2223RSO00003	0	{"cgst": ["None", "0"], "omrpvalue": ["None", "0"], "division": ["None", "division"], "is_cm": ["None", "False"], "buyer_city": ["None", "Vadodara"], "bill_qty": ["None", "0"], "is_ivt": ["None", "False"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "buyer_gst_reg_type": ["None", "Unknown"], "igst": ["None", "0"], "buyer_gstin": ["None", "12AYRFG125I"], "tcs": ["None", "0"], "rso_no": ["None", "2223RSO00003"], "created": ["None", "2023-09-13"], "rso_date": ["None", "2023-09-13 06:10:08.841427+00:00"], "mrpvalue": ["None", "0"], "buyer_address1": ["None", "ABC"], "discount": ["None", "0.00"], "updated": ["None", "2023-09-13"], "round_off": ["None", "0"], "buyer_address2": ["None", "ABC"], "id": ["None", "3"], "sgst": ["None", "0"], "buyer_address_type": ["None", "Default"], "buyer_address3": ["None", "ABC"], "company": ["None", "ABC"], "inv": ["None", "2223INV00004"], "buyer_mailingname": ["None", "ABCD"], "total": ["None", "0"], "channel": ["None", "Channel 1"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "buyer_country": ["None", "India"], "buyer_state": ["None", "Gujarat-1"]}	2023-09-13 11:40:08.855+05:30	2	78	127.0.0.1	\N
738	3	3	2223RSO00003	2	{"cgst": ["0", "None"], "omrpvalue": ["0", "None"], "division": ["division", "None"], "is_cm": ["False", "None"], "buyer_city": ["Vadodara", "None"], "bill_qty": ["0", "None"], "is_ivt": ["False", "None"], "buyer": ["ABCD", "None"], "buyer_pincode": ["390002", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "igst": ["0", "None"], "buyer_gstin": ["12AYRFG125I", "None"], "tcs": ["0", "None"], "rso_no": ["2223RSO00003", "None"], "created": ["2023-09-13", "None"], "rso_date": ["2023-09-13 06:10:08.841427+00:00", "None"], "mrpvalue": ["0", "None"], "buyer_address1": ["ABC", "None"], "discount": ["0.00", "None"], "updated": ["2023-09-13", "None"], "round_off": ["0", "None"], "buyer_address2": ["ABC", "None"], "id": ["3", "None"], "sgst": ["0", "None"], "buyer_address_type": ["Default", "None"], "buyer_address3": ["ABC", "None"], "company": ["ABC", "None"], "inv": ["2223INV00004", "None"], "buyer_mailingname": ["ABCD", "None"], "total": ["0", "None"], "channel": ["Channel 1", "None"], "free_qty": ["0", "None"], "status": ["1", "None"], "ammount": ["0", "None"], "buyer_country": ["India", "None"], "buyer_state": ["Gujarat-1", "None"]}	2023-09-13 11:40:08.863+05:30	2	78	127.0.0.1	\N
739	1	1	2223RSO00001	1	{"status": ["1", "2"]}	2023-09-13 11:40:33.046+05:30	2	78	127.0.0.1	\N
740	2	2	2223RSO00002	1	{"status": ["1", "2"]}	2023-09-13 11:40:37.391+05:30	2	78	127.0.0.1	\N
741	4	4	2223RSO00003	0	{"cgst": ["None", "0"], "omrpvalue": ["None", "0"], "division": ["None", "ECOM"], "rso_ref": ["None", "Ab1"], "is_cm": ["None", "True"], "buyer_city": ["None", "Vadodara"], "bill_qty": ["None", "0"], "is_ivt": ["None", "False"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "buyer_gst_reg_type": ["None", "Unknown"], "igst": ["None", "0"], "buyer_gstin": ["None", "12AYRFG125I"], "tcs": ["None", "0"], "rso_no": ["None", "2223RSO00003"], "created": ["None", "2023-09-13"], "rso_date": ["None", "2023-09-13 06:11:39.694272+00:00"], "mrpvalue": ["None", "0"], "buyer_address1": ["None", "ABC"], "discount": ["None", "0"], "updated": ["None", "2023-09-13"], "round_off": ["None", "0"], "buyer_address2": ["None", "ABC"], "id": ["None", "4"], "sgst": ["None", "0"], "buyer_address_type": ["None", "Default"], "buyer_address3": ["None", "ABC"], "ref_date": ["None", "2023-09-14"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "ABCD"], "total": ["None", "0"], "channel": ["None", "Channel 1"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "narration": ["None", ""], "buyer_country": ["None", "India"], "buyer_state": ["None", "Gujarat-1"]}	2023-09-13 11:41:39.705+05:30	2	78	127.0.0.1	\N
742	1	1	SalesTarget object (1)	0	{"se": ["None", "Sales person 7"], "zone": ["None", "North East Zone"], "buyer": ["None", "Cm3"], "region": ["None", "Jharkhand"], "created": ["None", "2023-09-13"], "updated": ["None", "2023-09-13"], "rsm": ["None", "RSM 1"], "asm": ["None", "Sales Executive 5"], "id": ["None", "1"], "months": ["None", "2023-09-01"], "zsm": ["None", "ZSM 3"], "target": ["None", "10"]}	2023-09-13 11:42:10.175+05:30	2	83	127.0.0.1	\N
774	2	2	PackingSheet object (2)	0	{"id": ["None", "2"], "created": ["None", "2023-09-13"], "mrp": ["None", "100"], "from_box": ["None", "1"], "updated": ["None", "2023-09-13"], "to_box": ["None", "1"], "dn": ["None", "2223DN00004"], "company": ["None", "ABC"], "status": ["None", "True"], "item": ["None", "NFG"], "offermrp": ["None", "90"], "qty": ["None", "2"]}	2023-09-13 13:01:45.225+05:30	2	81	127.0.0.1	\N
743	7	7	2223INV00007	0	{"bill_qty": ["None", "0"], "inv_date": ["None", "2023-09-13 06:15:51.377197+00:00"], "channel": ["None", "Channel 1"], "buyer_address2": ["None", "Address Line2"], "shipto_address_type": ["None", ""], "shipto_address3": ["None", "Address Line3"], "discount": ["None", "0"], "buyer_country": ["None", "India"], "buyer": ["None", "Customer Name"], "buyer_pincode": ["None", "390001"], "shipto_pincode": ["None", "390001"], "sgst": ["None", "0"], "shipto_pan_no": ["None", "AAPOS1478Q"], "total": ["None", "0"], "updated": ["None", "2023-09-13"], "buyer_mailingname": ["None", "Customer Name"], "igst": ["None", "0"], "shipto_address2": ["None", "Address Line2"], "status": ["None", "1"], "id": ["None", "7"], "ammount": ["None", "0"], "inv_no": ["None", "2223INV00007"], "buyer_address1": ["None", "Address Line1"], "shipto_gstin": ["None", ""], "cgst": ["None", "0"], "is_ivt": ["None", "True"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "free_qty": ["None", "0"], "company": ["None", "ABC"], "buyer_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-13"], "shipto_address1": ["None", "Address Line1"], "mrpvalue": ["None", "0"], "shipto_city": ["None", "Vadodara"], "round_off": ["None", "0"], "shipto_state": ["None", "Gujarat-1"], "buyer_address_type": ["None", "Default"], "buyer_city": ["None", "Vadodara"], "ol_rate": ["None", "0"], "is_ict": ["None", "False"], "buyer_gst_reg_type": ["None", "Consumer"], "shipto": ["None", "Customer Name"], "other": ["None", "0"], "shipto_mailingname": ["None", "Customer Name"], "buyer_gstin": ["None", ""], "division": ["None", "ECOM"], "tcs": ["None", "0"], "shipto_country": ["None", "India"]}	2023-09-13 11:45:51.386+05:30	2	70	127.0.0.1	\N
744	7	7	InvItems object (7)	0	{"rate": ["None", "999"], "actual_qty": ["None", "1.00"], "discount": ["None", "0"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "1.00"], "sgst": ["None", "0.0000"], "item": ["None", "NFG"], "id": ["None", "7"], "pack": ["None", "0.00"], "nf_qty": ["None", "0"], "offer_mrp": ["None", "1000.00"], "igstrate": ["None", "0.00"], "prate": ["None", "100.00"], "sgstrate": ["None", "0.00"], "inv": ["None", "2223INV00007"], "new_rate": ["None", "999"], "nb_qty": ["None", "1.00"], "mrp": ["None", "1000.00"], "free_qty": ["None", "0"], "igst": ["None", "0.0000"], "amount": ["None", "999.00"], "available_qty": ["None", "1.00"], "cgst": ["None", "0.0000"]}	2023-09-13 11:45:51.398+05:30	2	71	127.0.0.1	\N
745	7	7	2223INV00007	1	{"bill_qty": ["0.00", "0"], "inv_date": ["2023-09-13", "2023-09-13 06:15:51.377197+00:00"], "discount": ["0.00", "0"], "sgst": ["0.00", "0.0000"], "total": ["0.00", "999"], "igst": ["0.00", "0.0000"], "ammount": ["0.00", "999.00"], "cgst": ["0.00", "0.0000"], "omrpvalue": ["0.00", "0"], "free_qty": ["0.00", "0"], "mrpvalue": ["0.00", "1000.0000"], "round_off": ["0.00", "0.0000"], "ol_rate": ["0.00", "0"], "other": ["0.00", "0"], "tcs": ["0.00", "0"]}	2023-09-13 11:45:51.407+05:30	2	70	127.0.0.1	\N
746	5	5	2223RSO00004	0	{"cgst": ["None", "0"], "omrpvalue": ["None", "0"], "division": ["None", "ECOM"], "is_cm": ["None", "False"], "buyer_city": ["None", "Vadodara"], "bill_qty": ["None", "0"], "is_ivt": ["None", "False"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "buyer_gst_reg_type": ["None", "Unknown"], "igst": ["None", "0"], "buyer_gstin": ["None", "12AYRFG125I"], "tcs": ["None", "0"], "rso_no": ["None", "2223RSO00004"], "created": ["None", "2023-09-13"], "rso_date": ["None", "2023-09-13 06:17:19.607585+00:00"], "mrpvalue": ["None", "0"], "buyer_address1": ["None", "ABC"], "discount": ["None", "0.00"], "updated": ["None", "2023-09-13"], "round_off": ["None", "0"], "buyer_address2": ["None", "ABC"], "id": ["None", "5"], "sgst": ["None", "0"], "buyer_address_type": ["None", "Default"], "buyer_address3": ["None", "ABC"], "company": ["None", "ABC"], "inv": ["None", "2223INV00005"], "buyer_mailingname": ["None", "ABCD"], "total": ["None", "0"], "channel": ["None", "Channel 1"], "free_qty": ["None", "0"], "status": ["None", "1"], "ammount": ["None", "0"], "narration": ["None", "New Two"], "buyer_country": ["None", "India"], "buyer_state": ["None", "Gujarat-1"]}	2023-09-13 11:47:19.614+05:30	2	78	127.0.0.1	\N
747	5	5	2223RSO00004	2	{"cgst": ["0", "None"], "omrpvalue": ["0", "None"], "division": ["ECOM", "None"], "is_cm": ["False", "None"], "buyer_city": ["Vadodara", "None"], "bill_qty": ["0", "None"], "is_ivt": ["False", "None"], "buyer": ["ABCD", "None"], "buyer_pincode": ["390002", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "igst": ["0", "None"], "buyer_gstin": ["12AYRFG125I", "None"], "tcs": ["0", "None"], "rso_no": ["2223RSO00004", "None"], "created": ["2023-09-13", "None"], "rso_date": ["2023-09-13 06:17:19.607585+00:00", "None"], "mrpvalue": ["0", "None"], "buyer_address1": ["ABC", "None"], "discount": ["0.00", "None"], "updated": ["2023-09-13", "None"], "round_off": ["0", "None"], "buyer_address2": ["ABC", "None"], "id": ["5", "None"], "sgst": ["0", "None"], "buyer_address_type": ["Default", "None"], "buyer_address3": ["ABC", "None"], "company": ["ABC", "None"], "inv": ["2223INV00005", "None"], "buyer_mailingname": ["ABCD", "None"], "total": ["0", "None"], "channel": ["Channel 1", "None"], "free_qty": ["0", "None"], "status": ["1", "None"], "ammount": ["0", "None"], "narration": ["New Two", "None"], "buyer_country": ["India", "None"], "buyer_state": ["Gujarat-1", "None"]}	2023-09-13 11:47:19.623+05:30	2	78	127.0.0.1	\N
748	4	4	2223RSO00003	1	{"status": ["1", "2"]}	2023-09-13 11:47:25.932+05:30	2	78	127.0.0.1	\N
749	9	9	PalletTransferEntry object (9)	0	{"company": ["None", "ABC"], "tgodown": ["None", "UN ALLOCATED"], "item": ["None", "FG1"], "fgodown": ["None", "DAMAGE & SCRAP"], "id": ["None", "9"], "qty": ["None", "1"], "created": ["None", "2023-09-13"], "createdby": ["None", "admin"]}	2023-09-13 11:50:25.628+05:30	2	87	127.0.0.1	\N
750	38	38	UN ALLOCATED	0	{"batch": ["None", "20230905000995"], "id": ["None", "38"], "company": ["None", "ABC"], "updated": ["None", "2023-09-13"], "created": ["None", "2023-09-13"], "mrp": ["None", "100.00"], "godown": ["None", "UN ALLOCATED"], "product": ["None", "FG1"], "rate": ["None", "0.00"]}	2023-09-13 11:50:25.641+05:30	2	84	127.0.0.1	\N
751	35	35	DAMAGE & SCRAP	2	{"batch": ["20230905000995", "None"], "closing_balance": ["1.0000", "None"], "id": ["35", "None"], "company": ["ABC", "None"], "updated": ["2023-09-13", "None"], "created": ["2023-09-13", "None"], "mrp": ["100.00", "None"], "godown": ["DAMAGE & SCRAP", "None"], "product": ["FG1", "None"], "rate": ["0.00", "None"]}	2023-09-13 11:50:25.648+05:30	2	84	127.0.0.1	\N
752	38	38	UN ALLOCATED	1	{"closing_balance": ["None", "1.0000"]}	2023-09-13 11:50:25.655+05:30	2	84	127.0.0.1	\N
754	4	4	2223INV00004	1	{"lr_no": ["", "LR111"], "lr_date": ["None", "2023-09-14"]}	2023-09-13 11:51:27.615+05:30	2	70	127.0.0.1	\N
755	5	5	2223INV00005	1	{"lr_no": ["None", "LR2"], "lr_date": ["None", "2023-09-14"]}	2023-09-13 11:51:42.961+05:30	2	70	127.0.0.1	\N
756	6	6	2223INV00006	1	{"lr_no": ["None", ""]}	2023-09-13 11:51:58.992+05:30	2	70	127.0.0.1	\N
775	3	3	ShortageDamageEntry object (3)	0	{"sqty": ["None", "1"], "dremarks": ["None", "ABC"], "id": ["None", "3"], "dqty": ["None", "1"], "item": ["None", "RAW2"], "rate": ["None", "132.00"], "sremarks": ["None", "ABC"], "godown": ["None", "SHORTAGE"], "createdby": ["None", "admin"], "updated": ["None", "2023-09-13"], "created": ["None", "2023-09-13"], "company": ["None", "ABC"], "shoratage": ["None", ""]}	2023-09-13 13:56:04.109+05:30	2	86	127.0.0.1	\N
757	6	6	2223DN00006	0	{"shipto_mailingname": ["None", "CUSTOMER NAME 2"], "buyer_address_type": ["None", "Default"], "id": ["None", "6"], "buyer_gstin": ["None", "asdsasda152ad"], "ammount": ["None", "100.00"], "buyer_country": ["None", "England"], "shipto_city": ["None", "Mumbai"], "ol_rate": ["None", "0.00"], "narration": ["None", ""], "other": ["None", "0.00"], "shipto_pan_no": ["None", "AAPOD1234Z"], "buyer": ["None", "Cm3"], "buyer_address2": ["None", "Cm3"], "total": ["None", "100.00"], "other_reference": ["None", ""], "dn_no": ["None", "2223DN00006"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Amsterdam"], "ls_status": ["None", "False"], "round_off": ["None", "0.00"], "shipto_address_type": ["None", "Default"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", "XXAAPOD1234Z"], "company": ["None", "ABC"], "sales_order": ["None", "2223SO00002"], "dn_date": ["None", "2023-09-13 06:32:51.006998+00:00"], "buyer_address3": ["None", "Cm3"], "shipto_country": ["None", "India"], "shipto_pincode": ["None", "493320"], "updated": ["None", "2023-09-13"], "buyer_mailingname": ["None", "CM3"], "cgst": ["None", "0.00"], "igst": ["None", "0.00"], "created": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line1"], "tcs": ["None", "0.00"], "shipto": ["None", "Customer Name 2"], "bill_qty": ["None", "1.00"], "mode_of_payment": ["None", "30"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Cm3"], "shipto_state": ["None", "Maharashtra"], "status": ["None", "1"], "buyer_city": ["None", "Amsterdam"], "shipto_address3": ["None", "Address Line1"], "sgst": ["None", "0.00"], "terms_of_delivery": ["None", "30"], "discount": ["None", "0.00"], "ps_status": ["None", "False"], "buyer_gst_reg_type": ["None", "Consumer"], "order_no": ["None", ""]}	2023-09-13 12:02:51.033+05:30	2	68	127.0.0.1	\N
758	34	34	SHORTAGE	2	{"batch": ["20230905000995", "None"], "closing_balance": ["0", "None"], "id": ["34", "None"], "company": ["ABC", "None"], "updated": ["2023-09-13", "None"], "created": ["2023-09-13", "None"], "mrp": ["100.00", "None"], "godown": ["SHORTAGE", "None"], "product": ["FG1", "None"], "rate": ["0.00", "None"]}	2023-09-13 12:02:51.046+05:30	2	84	127.0.0.1	\N
759	6	6	LoadingSheet object (6)	0	{"company": ["None", "ABC"], "prate": ["None", "0.00"], "godown": ["None", "SHORTAGE"], "mrp": ["None", "100.00"], "dn": ["None", "2223DN00006"], "batch": ["None", "20230905000995"], "offermrp": ["None", "0.00"], "item": ["None", "FG1"], "qty": ["None", "1.0000"], "created": ["None", "2023-09-13"], "updated": ["None", "2023-09-13"], "id": ["None", "6"]}	2023-09-13 12:02:51.056+05:30	2	80	127.0.0.1	\N
760	6	6	DnItems object (6)	0	{"rate": ["None", "100.00"], "id": ["None", "6"], "free_qty": ["None", "0.00"], "amount": ["None", "100.00"], "available_qty": ["None", "21.00"], "pack": ["None", "5.00"], "sgst": ["None", "0.00"], "mrp": ["None", "100.00"], "cgst": ["None", "0.00"], "billed_qty": ["None", "1.00"], "offer_mrp": ["None", "0.00"], "item": ["None", "FG1"], "sgstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "prate": ["None", "0.00"], "dn": ["None", "2223DN00006"], "discount": ["None", "0.00"], "igstrate": ["None", "0.00"], "actual_qty": ["None", "1.00"]}	2023-09-13 12:02:51.066+05:30	2	69	127.0.0.1	\N
761	6	6	2223DN00006	1	{"dn_date": ["2023-09-13", "2023-09-13 06:32:51.006998+00:00"]}	2023-09-13 12:02:51.081+05:30	2	68	127.0.0.1	\N
762	10	10	2223SO00002	1	{"status": ["1", "3"]}	2023-09-13 12:02:51.094+05:30	2	66	127.0.0.1	\N
764	7	7	2223DN00007	0	{"shipto_mailingname": ["None", "CUSTOMER NAME"], "buyer_address_type": ["None", "Default"], "id": ["None", "7"], "buyer_gstin": ["None", "asdsasda152ad"], "ammount": ["None", "100.00"], "buyer_country": ["None", "England"], "shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0.00"], "narration": ["None", ""], "other": ["None", "0.00"], "shipto_pan_no": ["None", "AAPOS1478Q"], "buyer": ["None", "Cm3"], "buyer_address2": ["None", "Cm3"], "total": ["None", "100.00"], "other_reference": ["None", ""], "dn_no": ["None", "2223DN00007"], "free_qty": ["None", "0.00"], "buyer_state": ["None", "Amsterdam"], "ls_status": ["None", "False"], "round_off": ["None", "0.00"], "shipto_address_type": ["None", "Default"], "price_list": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "shipto_gstin": ["None", ""], "company": ["None", "ABC"], "sales_order": ["None", "2223SO00012"], "dn_date": ["None", "2023-09-13 06:44:40.844659+00:00"], "buyer_address3": ["None", "Cm3"], "shipto_country": ["None", "India"], "shipto_pincode": ["None", "390001"], "updated": ["None", "2023-09-13"], "buyer_mailingname": ["None", "CM3"], "cgst": ["None", "0.00"], "igst": ["None", "0.00"], "created": ["None", "2023-09-13"], "shipto_address2": ["None", "Address Line2"], "tcs": ["None", "0.00"], "shipto": ["None", "Customer Name"], "bill_qty": ["None", "1.00"], "mode_of_payment": ["None", "30"], "shipto_address1": ["None", "Address Line1"], "buyer_address1": ["None", "Cm3"], "shipto_state": ["None", "Gujarat-1"], "status": ["None", "1"], "buyer_city": ["None", "Amsterdam"], "shipto_address3": ["None", "Address Line3"], "sgst": ["None", "0.00"], "terms_of_delivery": ["None", "30"], "discount": ["None", "0.00"], "ps_status": ["None", "False"], "buyer_gst_reg_type": ["None", "Consumer"], "order_no": ["None", ""]}	2023-09-13 12:14:40.854+05:30	2	68	127.0.0.1	\N
765	7	7	PRODUCTION	2	{"batch": ["20230905000998", "None"], "closing_balance": ["0", "None"], "id": ["7", "None"], "company": ["ABC", "None"], "updated": ["2023-09-12", "None"], "created": ["2023-09-05", "None"], "mrp": ["100.00", "None"], "godown": ["PRODUCTION", "None"], "product": ["FG1", "None"], "rate": ["0.00", "None"]}	2023-09-13 12:14:40.864+05:30	2	84	127.0.0.1	\N
766	7	7	LoadingSheet object (7)	0	{"company": ["None", "ABC"], "prate": ["None", "0.00"], "godown": ["None", "PRODUCTION"], "mrp": ["None", "100.00"], "dn": ["None", "2223DN00007"], "batch": ["None", "20230905000996"], "offermrp": ["None", "0.00"], "item": ["None", "FG1"], "qty": ["None", "1.0000"], "created": ["None", "2023-09-13"], "updated": ["None", "2023-09-13"], "id": ["None", "7"]}	2023-09-13 12:14:40.882+05:30	2	80	127.0.0.1	\N
767	7	7	DnItems object (7)	0	{"rate": ["None", "100.00"], "id": ["None", "7"], "free_qty": ["None", "0.00"], "amount": ["None", "100.00"], "available_qty": ["None", "20.00"], "pack": ["None", "5.00"], "sgst": ["None", "0.00"], "mrp": ["None", "100.00"], "cgst": ["None", "0.00"], "billed_qty": ["None", "1.00"], "offer_mrp": ["None", "0.00"], "item": ["None", "FG1"], "sgstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "igst": ["None", "0.00"], "prate": ["None", "0.00"], "dn": ["None", "2223DN00007"], "discount": ["None", "0.00"], "igstrate": ["None", "0.00"], "actual_qty": ["None", "1.00"]}	2023-09-13 12:14:40.892+05:30	2	69	127.0.0.1	\N
768	7	7	2223DN00007	1	{"dn_date": ["2023-09-13", "2023-09-13 06:44:40.844659+00:00"]}	2023-09-13 12:14:40.905+05:30	2	68	127.0.0.1	\N
769	25	25	2223SO00012	1	{"status": ["1", "3"]}	2023-09-13 12:14:40.916+05:30	2	66	127.0.0.1	\N
770	7	7	2223DN00007	1	{"ls_status": ["False", "True"]}	2023-09-13 12:15:03.231+05:30	2	68	127.0.0.1	\N
771	7	7	2223DN00007	1	{"ps_status": ["False", "True"]}	2023-09-13 12:15:16.571+05:30	2	68	127.0.0.1	\N
772	6	6	2223DN00006	1	{"ps_status": ["False", "True"]}	2023-09-13 12:33:59.453+05:30	2	68	127.0.0.1	\N
784	41	41	SHORTAGE	0	{"created": ["None", "2023-09-13"], "rate": ["None", "1.00"], "godown": ["None", "SHORTAGE"], "batch": ["None", "20230912003001"], "closing_balance": ["None", "5"], "id": ["None", "41"], "company": ["None", "ABC"], "updated": ["None", "2023-09-13"], "product": ["None", "RAW1"], "mrp": ["None", ""]}	2023-09-13 14:09:14.321+05:30	2	84	127.0.0.1	\N
785	26	26	PRODUCTION	1	{"closing_balance": ["659.0000", "654.0000"]}	2023-09-13 14:09:14.329+05:30	2	84	127.0.0.1	\N
786	5	5	ShortageDamageEntry object (5)	0	{"sqty": ["None", "1"], "updated": ["None", "2023-09-13"], "dqty": ["None", "0"], "item": ["None", "RAW1"], "created": ["None", "2023-09-13"], "sremarks": ["None", "Short product"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "createdby": ["None", "admin"], "id": ["None", "5"], "rate": ["None", "1.00"], "company": ["None", "ABC"], "purchase": ["None", "2223PINV00003"], "dremarks": ["None", "No Damage"]}	2023-09-13 14:10:31.881+05:30	2	86	127.0.0.1	\N
787	42	42	SHORTAGE	0	{"id": ["None", "42"], "godown": ["None", "SHORTAGE"], "created": ["None", "2023-09-13"], "mrp": ["None", ""], "company": ["None", "ABC"], "closing_balance": ["None", "1"], "rate": ["None", "1.00"], "product": ["None", "RAW1"], "batch": ["None", "20230912003001"], "updated": ["None", "2023-09-13"]}	2023-09-13 14:10:31.897+05:30	2	84	127.0.0.1	\N
788	26	26	PRODUCTION	1	{"closing_balance": ["654.0000", "653.0000"]}	2023-09-13 14:10:31.907+05:30	2	84	127.0.0.1	\N
789	6	6	ShortageDamageEntry object (6)	0	{"sqty": ["None", "0"], "updated": ["None", "2023-09-13"], "dqty": ["None", "2"], "item": ["None", "RAW1"], "created": ["None", "2023-09-13"], "sremarks": ["None", "NA"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "createdby": ["None", "admin"], "id": ["None", "6"], "rate": ["None", "1.00"], "company": ["None", "ABC"], "purchase": ["None", "2223PINV00003"], "dremarks": ["None", "Damage"]}	2023-09-13 14:11:10.694+05:30	2	86	127.0.0.1	\N
790	43	43	DAMAGE & SCRAP	0	{"id": ["None", "43"], "godown": ["None", "DAMAGE & SCRAP"], "created": ["None", "2023-09-13"], "mrp": ["None", ""], "company": ["None", "ABC"], "closing_balance": ["None", "2"], "rate": ["None", "1.00"], "product": ["None", "RAW1"], "batch": ["None", "20230912003001"], "updated": ["None", "2023-09-13"]}	2023-09-13 14:11:10.705+05:30	2	84	127.0.0.1	\N
791	26	26	PRODUCTION	1	{"closing_balance": ["653.0000", "651.0000"]}	2023-09-13 14:11:10.713+05:30	2	84	127.0.0.1	\N
792	7	7	ShortageDamageEntry object (7)	0	{"updated": ["None", "2023-09-13"], "createdby": ["None", "admin"], "rate": ["None", "1.00"], "purchase": ["None", "2223PINV00005"], "shoratage": ["None", ""], "godown": ["None", "PRODUCTION"], "id": ["None", "7"], "sremarks": ["None", "ABC"], "company": ["None", "ABC"], "created": ["None", "2023-09-13"], "item": ["None", "RAW2"], "sqty": ["None", "10"], "dremarks": ["None", "ABC"], "dqty": ["None", "0"]}	2023-09-13 14:21:15.887+05:30	2	86	127.0.0.1	\N
793	44	44	SHORTAGE	0	{"product": ["None", "RAW2"], "created": ["None", "2023-09-13"], "batch": ["None", "20230912005001"], "updated": ["None", "2023-09-13"], "rate": ["None", "1.00"], "godown": ["None", "SHORTAGE"], "mrp": ["None", "0.00"], "company": ["None", "ABC"], "closing_balance": ["None", "10"], "id": ["None", "44"]}	2023-09-13 14:21:15.902+05:30	2	84	127.0.0.1	\N
794	32	32	PRODUCTION	1	{"closing_balance": ["80.0000", "70.0000"]}	2023-09-13 14:21:15.913+05:30	2	84	127.0.0.1	\N
795	8	8	ShortageDamageEntry object (8)	0	{"sremarks": ["None", "ABC"], "created": ["None", "2023-09-13"], "updated": ["None", "2023-09-13"], "dqty": ["None", "0"], "item": ["None", "RAW1"], "shoratage": ["None", ""], "createdby": ["None", "admin"], "rate": ["None", "1.00"], "purchase": ["None", "2223PINV00003"], "godown": ["None", "PRODUCTION"], "sqty": ["None", "9"], "id": ["None", "8"], "company": ["None", "ABC"], "dremarks": ["None", ""]}	2023-09-13 14:21:53.402+05:30	2	86	127.0.0.1	\N
796	45	45	SHORTAGE	0	{"updated": ["None", "2023-09-13"], "company": ["None", "ABC"], "godown": ["None", "SHORTAGE"], "mrp": ["None", ""], "rate": ["None", "1.00"], "created": ["None", "2023-09-13"], "batch": ["None", "20230912003001"], "closing_balance": ["None", "9"], "product": ["None", "RAW1"], "id": ["None", "45"]}	2023-09-13 14:21:53.414+05:30	2	84	127.0.0.1	\N
797	26	26	PRODUCTION	1	{"closing_balance": ["651.0000", "642.0000"]}	2023-09-13 14:21:53.422+05:30	2	84	127.0.0.1	\N
798	46	46	SHORTAGE	0	{"company": ["None", "ABC"], "product": ["None", "RAW1"], "id": ["None", "46"], "batch": ["None", "20230905003001"], "updated": ["None", "2023-09-13"], "rate": ["None", "120.00"], "godown": ["None", "SHORTAGE"], "closing_balance": ["None", "1"], "mrp": ["None", ""], "created": ["None", "2023-09-13"]}	2023-09-13 14:29:32.545+05:30	2	84	127.0.0.1	\N
799	47	47	DAMAGE & SCRAP	0	{"company": ["None", "ABC"], "product": ["None", "RAW1"], "id": ["None", "47"], "batch": ["None", "20230905003001"], "updated": ["None", "2023-09-13"], "rate": ["None", "120.00"], "godown": ["None", "DAMAGE & SCRAP"], "closing_balance": ["None", "1"], "mrp": ["None", ""], "created": ["None", "2023-09-13"]}	2023-09-13 14:29:32.561+05:30	2	84	127.0.0.1	\N
800	48	48	SHORTAGE	0	{"id": ["None", "48"], "godown": ["None", "SHORTAGE"], "created": ["None", "2023-09-13"], "updated": ["None", "2023-09-13"], "rate": ["None", "120.00"], "closing_balance": ["None", "1"], "mrp": ["None", ""], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230905003001"]}	2023-09-13 14:33:41.659+05:30	2	84	127.0.0.1	\N
801	49	49	DAMAGE & SCRAP	0	{"id": ["None", "49"], "godown": ["None", "DAMAGE & SCRAP"], "created": ["None", "2023-09-13"], "updated": ["None", "2023-09-13"], "rate": ["None", "120.00"], "closing_balance": ["None", "1"], "mrp": ["None", ""], "company": ["None", "ABC"], "product": ["None", "RAW1"], "batch": ["None", "20230905003001"]}	2023-09-13 14:33:41.669+05:30	2	84	127.0.0.1	\N
802	50	50	SHORTAGE	0	{"batch": ["None", "20230905003001"], "product": ["None", "RAW1"], "rate": ["None", "120.00"], "id": ["None", "50"], "godown": ["None", "SHORTAGE"], "updated": ["None", "2023-09-13"], "mrp": ["None", ""], "company": ["None", "ABC"], "closing_balance": ["None", "1"], "created": ["None", "2023-09-13"]}	2023-09-13 14:43:05.861+05:30	2	84	127.0.0.1	\N
803	51	51	DAMAGE & SCRAP	0	{"batch": ["None", "20230905003001"], "product": ["None", "RAW1"], "rate": ["None", "120.00"], "id": ["None", "51"], "godown": ["None", "DAMAGE & SCRAP"], "updated": ["None", "2023-09-13"], "mrp": ["None", ""], "company": ["None", "ABC"], "closing_balance": ["None", "1"], "created": ["None", "2023-09-13"]}	2023-09-13 14:43:05.873+05:30	2	84	127.0.0.1	\N
804	9	9	ShortageDamageEntry object (9)	0	{"item": ["None", "RAW1"], "createdby": ["None", "admin"], "rate": ["None", "120.00"], "purchase": ["None", "2223PINV00003"], "shoratage": ["None", ""], "godown": ["None", "DAMAGE & SCRAP"], "sqty": ["None", "1"], "id": ["None", "9"], "company": ["None", "ABC"], "created": ["None", "2023-09-13"], "sremarks": ["None", "1"], "updated": ["None", "2023-09-13"], "dremarks": ["None", "NA"], "dqty": ["None", "0"]}	2023-09-13 14:47:45.901+05:30	2	86	127.0.0.1	\N
805	52	52	SHORTAGE	0	{"company": ["None", "ABC"], "product": ["None", "RAW1"], "id": ["None", "52"], "batch": ["None", "20230905003001"], "updated": ["None", "2023-09-13"], "rate": ["None", "120.00"], "godown": ["None", "SHORTAGE"], "closing_balance": ["None", "1"], "mrp": ["None", ""], "created": ["None", "2023-09-13"]}	2023-09-13 14:47:45.914+05:30	2	84	127.0.0.1	\N
806	47	47	DAMAGE & SCRAP	2	{"company": ["ABC", "None"], "product": ["RAW1", "None"], "id": ["47", "None"], "batch": ["20230905003001", "None"], "updated": ["2023-09-13", "None"], "rate": ["120.00", "None"], "godown": ["DAMAGE & SCRAP", "None"], "closing_balance": ["1.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-13", "None"]}	2023-09-13 14:47:45.92+05:30	2	84	127.0.0.1	\N
807	10	10	ShortageDamageEntry object (10)	0	{"item": ["None", "RAW1"], "createdby": ["None", "admin"], "rate": ["None", "120.00"], "purchase": ["None", "2223PINV00003"], "shoratage": ["None", ""], "godown": ["None", "DAMAGE & SCRAP"], "sqty": ["None", "0"], "id": ["None", "10"], "company": ["None", "ABC"], "created": ["None", "2023-09-13"], "sremarks": ["None", "NA"], "updated": ["None", "2023-09-13"], "dremarks": ["None", "1"], "dqty": ["None", "1"]}	2023-09-13 14:48:04.474+05:30	2	86	127.0.0.1	\N
808	53	53	DAMAGE & SCRAP	0	{"company": ["None", "ABC"], "product": ["None", "RAW1"], "id": ["None", "53"], "batch": ["None", "20230905003001"], "updated": ["None", "2023-09-13"], "rate": ["None", "120.00"], "godown": ["None", "DAMAGE & SCRAP"], "closing_balance": ["None", "1"], "mrp": ["None", ""], "created": ["None", "2023-09-13"]}	2023-09-13 14:48:04.484+05:30	2	84	127.0.0.1	\N
809	49	49	DAMAGE & SCRAP	2	{"company": ["ABC", "None"], "product": ["RAW1", "None"], "id": ["49", "None"], "batch": ["20230905003001", "None"], "updated": ["2023-09-13", "None"], "rate": ["120.00", "None"], "godown": ["DAMAGE & SCRAP", "None"], "closing_balance": ["1.0000", "None"], "mrp": ["", "None"], "created": ["2023-09-13", "None"]}	2023-09-13 14:48:04.491+05:30	2	84	127.0.0.1	\N
810	10	10	ShortageDamageEntry object (10)	1	{"shoratage": ["", "1"], "jobwork": ["None", "2223JC00005"]}	2023-09-13 14:50:05.861+05:30	2	86	127.0.0.1	\N
811	2	2	FINISHED GOODS	1	{"name": ["Finished Goods", "FINISHED GOODS"]}	2023-09-13 14:52:02.613+05:30	2	16	127.0.0.1	\N
812	8	8	2223INV00008	0	{"buyer_mailingname": ["None", "Customer Name"], "shipto_address1": ["None", "Address Line1"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "id": ["None", "8"], "ammount": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line2"], "company": ["None", "ABC"], "status": ["None", "1"], "mrpvalue": ["None", "0"], "is_ict": ["None", "False"], "free_qty": ["None", "0"], "round_off": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "shipto_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-14"], "buyer_city": ["None", "Vadodara"], "other": ["None", "0"], "shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_gstin": ["None", ""], "shipto_mailingname": ["None", "Customer Name"], "buyer_address_type": ["None", "Default"], "is_ivt": ["None", "True"], "shipto": ["None", "Customer Name"], "bill_qty": ["None", "0"], "inv_date": ["None", "2023-09-14 04:50:15.148742+00:00"], "channel": ["None", "Channel 1"], "division": ["None", "ECOM"], "shipto_address_type": ["None", ""], "tcs": ["None", "0"], "buyer_address2": ["None", "Address Line2"], "shipto_country": ["None", "India"], "buyer": ["None", "Customer Name"], "shipto_address3": ["None", "Address Line3"], "shipto_pincode": ["None", "390001"], "sgst": ["None", "0"], "total": ["None", "0"], "discount": ["None", "0"], "buyer_pincode": ["None", "390001"], "shipto_gstin": ["None", ""], "updated": ["None", "2023-09-14"], "buyer_country": ["None", "India"], "shipto_pan_no": ["None", "AAPOS1478Q"], "igst": ["None", "0"], "inv_no": ["None", "2223INV00008"], "cgst": ["None", "0"]}	2023-09-14 10:20:15.162+05:30	2	70	127.0.0.1	\N
813	8	8	InvItems object (8)	0	{"sgstrate": ["None", "0.00"], "nf_qty": ["None", "0"], "inv": ["None", "2223INV00008"], "new_rate": ["None", "900"], "igst": ["None", "0.0000"], "mrp": ["None", "1000.00"], "free_qty": ["None", "0"], "cgst": ["None", "0.0000"], "amount": ["None", "900.00"], "rate": ["None", "900"], "nb_qty": ["None", "1.00"], "available_qty": ["None", "1.00"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "1.00"], "actual_qty": ["None", "1.00"], "id": ["None", "8"], "prate": ["None", "100.00"], "sgst": ["None", "0.0000"], "offer_mrp": ["None", "1000.00"], "item": ["None", "NFG"], "pack": ["None", "0.00"], "discount": ["None", "0"], "igstrate": ["None", "0.00"]}	2023-09-14 10:20:15.174+05:30	2	71	127.0.0.1	\N
814	8	8	2223INV00008	1	{"omrpvalue": ["0.00", "0"], "ammount": ["0.00", "900.00"], "mrpvalue": ["0.00", "1000.0000"], "free_qty": ["0.00", "0"], "round_off": ["0.00", "0.0000"], "other": ["0.00", "0"], "ol_rate": ["0.00", "0"], "bill_qty": ["0.00", "0"], "inv_date": ["2023-09-14", "2023-09-14 04:50:15.148742+00:00"], "tcs": ["0.00", "0"], "sgst": ["0.00", "0.0000"], "total": ["0.00", "900"], "discount": ["0.00", "0"], "igst": ["0.00", "0.0000"], "cgst": ["0.00", "0.0000"]}	2023-09-14 10:20:15.182+05:30	2	70	127.0.0.1	\N
815	6	6	2223RSO00004	0	{"buyer_state": ["None", "Gujarat-1"], "cgst": ["None", "0"], "is_cm": ["None", "False"], "narration": ["None", ""], "buyer_country": ["None", "India"], "buyer_city": ["None", "Vadodara"], "omrpvalue": ["None", "0"], "division": ["None", "ECOM"], "buyer_pincode": ["None", "390001"], "bill_qty": ["None", "0"], "buyer": ["None", "Customer Name"], "buyer_gstin": ["None", ""], "igst": ["None", "0"], "is_ivt": ["None", "True"], "buyer_gst_reg_type": ["None", "Consumer"], "rso_no": ["None", "2223RSO00004"], "mrpvalue": ["None", "0"], "tcs": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "rso_date": ["None", "2023-09-14 04:51:29.006226+00:00"], "round_off": ["None", "0"], "id": ["None", "6"], "created": ["None", "2023-09-14"], "buyer_address2": ["None", "Address Line2"], "discount": ["None", "0"], "updated": ["None", "2023-09-14"], "buyer_address3": ["None", "Address Line3"], "sgst": ["None", "0"], "total": ["None", "0"], "buyer_address_type": ["None", "Default"], "channel": ["None", "Channel 1"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "Customer Name"], "ammount": ["None", "0"], "free_qty": ["None", "0"], "status": ["None", "1"]}	2023-09-14 10:21:29.016+05:30	2	78	127.0.0.1	\N
816	2	2	RsoItems object (2)	0	{"amount": ["None", "1500"], "igst": ["None", "0.00"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "billed": ["None", "10"], "rate": ["None", "150"], "mrp": ["None", "0.00"], "cgst": ["None", "0.00"], "billed_qty": ["None", "10"], "inv": ["None", "2223RSO00004"], "cgstrate": ["None", "0.00"], "free_qty": ["None", "0"], "id": ["None", "2"], "item": ["None", "NFG2"], "discount": ["None", "0"], "igstrate": ["None", "0.00"]}	2023-09-14 10:21:29.03+05:30	2	79	127.0.0.1	\N
817	6	6	2223RSO00004	1	{"omrpvalue": ["0.00", "0"], "bill_qty": ["0.00", "10"], "tcs": ["0.00", "0"], "rso_date": ["2023-09-14", "2023-09-14 04:51:29.006226+00:00"], "discount": ["0.00", "0"], "total": ["0.00", "1500"], "ammount": ["0.00", "1500"], "free_qty": ["0.00", "0"]}	2023-09-14 10:21:29.036+05:30	2	78	127.0.0.1	\N
818	7	7	2223RSO00005	0	{"buyer_state": ["None", "Gujarat-1"], "cgst": ["None", "0"], "is_cm": ["None", "False"], "narration": ["None", "New Two"], "buyer_country": ["None", "India"], "buyer_city": ["None", "Vadodara"], "omrpvalue": ["None", "0"], "division": ["None", "ECOM"], "buyer_pincode": ["None", "390002"], "bill_qty": ["None", "0"], "buyer": ["None", "ABCD"], "buyer_gstin": ["None", "12AYRFG125I"], "igst": ["None", "0"], "is_ivt": ["None", "False"], "buyer_gst_reg_type": ["None", "Unknown"], "rso_no": ["None", "2223RSO00005"], "mrpvalue": ["None", "0"], "tcs": ["None", "0"], "buyer_address1": ["None", "ABC"], "rso_date": ["None", "2023-09-14 04:52:55.946654+00:00"], "round_off": ["None", "0"], "id": ["None", "7"], "created": ["None", "2023-09-14"], "buyer_address2": ["None", "ABC"], "discount": ["None", "0.00"], "updated": ["None", "2023-09-14"], "buyer_address3": ["None", "ABC"], "inv": ["None", "2223INV00005"], "sgst": ["None", "0"], "total": ["None", "0"], "buyer_address_type": ["None", "Default"], "channel": ["None", "Channel 1"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "ABCD"], "ammount": ["None", "0"], "free_qty": ["None", "0"], "status": ["None", "1"]}	2023-09-14 10:22:55.954+05:30	2	78	127.0.0.1	\N
819	7	7	2223RSO00005	2	{"buyer_state": ["Gujarat-1", "None"], "cgst": ["0", "None"], "is_cm": ["False", "None"], "narration": ["New Two", "None"], "buyer_country": ["India", "None"], "buyer_city": ["Vadodara", "None"], "omrpvalue": ["0", "None"], "division": ["ECOM", "None"], "buyer_pincode": ["390002", "None"], "bill_qty": ["0", "None"], "buyer": ["ABCD", "None"], "buyer_gstin": ["12AYRFG125I", "None"], "igst": ["0", "None"], "is_ivt": ["False", "None"], "buyer_gst_reg_type": ["Unknown", "None"], "rso_no": ["2223RSO00005", "None"], "mrpvalue": ["0", "None"], "tcs": ["0", "None"], "buyer_address1": ["ABC", "None"], "rso_date": ["2023-09-14 04:52:55.946654+00:00", "None"], "round_off": ["0", "None"], "id": ["7", "None"], "created": ["2023-09-14", "None"], "buyer_address2": ["ABC", "None"], "discount": ["0.00", "None"], "updated": ["2023-09-14", "None"], "buyer_address3": ["ABC", "None"], "inv": ["2223INV00005", "None"], "sgst": ["0", "None"], "total": ["0", "None"], "buyer_address_type": ["Default", "None"], "channel": ["Channel 1", "None"], "company": ["ABC", "None"], "buyer_mailingname": ["ABCD", "None"], "ammount": ["0", "None"], "free_qty": ["0", "None"], "status": ["1", "None"]}	2023-09-14 10:22:55.962+05:30	2	78	127.0.0.1	\N
820	8	8	2223RSO00005	0	{"buyer_state": ["None", "Amsterdam"], "cgst": ["None", "0"], "is_cm": ["None", "False"], "narration": ["None", ""], "buyer_country": ["None", "England"], "buyer_city": ["None", "Amsterdam"], "omrpvalue": ["None", "0"], "division": ["None", "Manual"], "buyer_pincode": ["None", "321456"], "bill_qty": ["None", "0"], "buyer": ["None", "Cm3"], "buyer_gstin": ["None", "asdsasda152ad"], "igst": ["None", "0"], "is_ivt": ["None", "True"], "buyer_gst_reg_type": ["None", "Consumer"], "rso_no": ["None", "2223RSO00005"], "mrpvalue": ["None", "0"], "tcs": ["None", "0"], "buyer_address1": ["None", "Cm3"], "rso_date": ["None", "2023-09-14 04:57:55.054060+00:00"], "round_off": ["None", "0"], "id": ["None", "8"], "created": ["None", "2023-09-14"], "buyer_address2": ["None", "Cm3"], "discount": ["None", "0"], "updated": ["None", "2023-09-14"], "buyer_address3": ["None", "Cm3"], "sgst": ["None", "0"], "total": ["None", "0"], "buyer_address_type": ["None", "Default"], "channel": ["None", "Channel 2"], "company": ["None", "ABC"], "buyer_mailingname": ["None", "CM3"], "ammount": ["None", "0"], "free_qty": ["None", "0"], "status": ["None", "1"]}	2023-09-14 10:27:55.062+05:30	2	78	127.0.0.1	\N
821	3	3	RsoItems object (3)	0	{"amount": ["None", "999"], "igst": ["None", "0.00"], "sgstrate": ["None", "0.00"], "sgst": ["None", "0.00"], "billed": ["None", "1"], "rate": ["None", "999"], "mrp": ["None", "100.00"], "cgst": ["None", "0.00"], "billed_qty": ["None", "1"], "inv": ["None", "2223RSO00005"], "cgstrate": ["None", "0.00"], "free_qty": ["None", "0"], "id": ["None", "3"], "item": ["None", "FG1"], "discount": ["None", "0"], "igstrate": ["None", "0.00"]}	2023-09-14 10:27:55.072+05:30	2	79	127.0.0.1	\N
822	8	8	2223RSO00005	1	{"omrpvalue": ["0.00", "0"], "bill_qty": ["0.00", "1"], "mrpvalue": ["0.00", "100.00"], "tcs": ["0.00", "0"], "rso_date": ["2023-09-14", "2023-09-14 04:57:55.054060+00:00"], "discount": ["0.00", "0"], "total": ["0.00", "999"], "ammount": ["0.00", "999"], "free_qty": ["0.00", "0"]}	2023-09-14 10:27:55.08+05:30	2	78	127.0.0.1	\N
823	9	9	2223INV00009	0	{"buyer_mailingname": ["None", "Customer Name"], "shipto_address1": ["None", "Address Line1"], "omrpvalue": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "id": ["None", "9"], "ammount": ["None", "0"], "buyer_address1": ["None", "Address Line1"], "shipto_address2": ["None", "Address Line2"], "company": ["None", "ABC"], "status": ["None", "1"], "mrpvalue": ["None", "0"], "is_ict": ["None", "False"], "free_qty": ["None", "0"], "round_off": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "shipto_state": ["None", "Gujarat-1"], "created": ["None", "2023-09-14"], "buyer_city": ["None", "Vadodara"], "other": ["None", "0"], "shipto_city": ["None", "Vadodara"], "ol_rate": ["None", "0"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_gstin": ["None", ""], "shipto_mailingname": ["None", "Customer Name"], "buyer_address_type": ["None", "Default"], "is_ivt": ["None", "True"], "shipto": ["None", "Customer Name"], "bill_qty": ["None", "0"], "inv_date": ["None", "2023-09-14 05:02:03.301749+00:00"], "channel": ["None", "Channel 1"], "division": ["None", "ECOM"], "shipto_address_type": ["None", ""], "tcs": ["None", "0"], "buyer_address2": ["None", "Address Line2"], "shipto_country": ["None", "India"], "buyer": ["None", "Customer Name"], "shipto_address3": ["None", "Address Line3"], "shipto_pincode": ["None", "390001"], "sgst": ["None", "0"], "total": ["None", "0"], "discount": ["None", "0"], "buyer_pincode": ["None", "390001"], "shipto_gstin": ["None", ""], "updated": ["None", "2023-09-14"], "buyer_country": ["None", "India"], "shipto_pan_no": ["None", "AAPOS1478Q"], "igst": ["None", "0"], "inv_no": ["None", "2223INV00009"], "cgst": ["None", "0"]}	2023-09-14 10:32:03.312+05:30	2	70	127.0.0.1	\N
824	9	9	InvItems object (9)	0	{"sgstrate": ["None", "0.00"], "nf_qty": ["None", "0"], "inv": ["None", "2223INV00009"], "new_rate": ["None", "999"], "igst": ["None", "0.0000"], "mrp": ["None", "100.00"], "free_qty": ["None", "0"], "cgst": ["None", "0.0000"], "amount": ["None", "999.00"], "rate": ["None", "999"], "nb_qty": ["None", "1.00"], "available_qty": ["None", "1.00"], "cgstrate": ["None", "0.00"], "billed_qty": ["None", "1.00"], "actual_qty": ["None", "1.00"], "id": ["None", "9"], "prate": ["None", "999.00"], "sgst": ["None", "0.0000"], "offer_mrp": ["None", "100.00"], "item": ["None", "FG1"], "pack": ["None", "5.00"], "discount": ["None", "0"], "igstrate": ["None", "0.00"]}	2023-09-14 10:32:03.324+05:30	2	71	127.0.0.1	\N
825	9	9	2223INV00009	1	{"omrpvalue": ["0.00", "0"], "ammount": ["0.00", "999.00"], "mrpvalue": ["0.00", "100.0000"], "free_qty": ["0.00", "0"], "round_off": ["0.00", "0.0000"], "other": ["0.00", "0"], "ol_rate": ["0.00", "0"], "bill_qty": ["0.00", "0"], "inv_date": ["2023-09-14", "2023-09-14 05:02:03.301749+00:00"], "tcs": ["0.00", "0"], "sgst": ["0.00", "0.0000"], "total": ["0.00", "999"], "discount": ["0.00", "0"], "igst": ["0.00", "0.0000"], "cgst": ["0.00", "0.0000"]}	2023-09-14 10:32:03.332+05:30	2	70	127.0.0.1	\N
826	1	1	2223SQ00001	0	{"discount": ["None", "0.00"], "buyer_address_type": ["None", "Default"], "buyer_gst_reg_type": ["None", "Consumer"], "buyer_pincode": ["None", "390001"], "buyer_gstin": ["None", ""], "omrpvalue": ["None", "0"], "division": ["None", "division"], "free_qty": ["None", "0"], "status": ["None", "1"], "buyer_address2": ["None", "Address Line2"], "tcs": ["None", "0"], "qdn_date": ["None", "2023-09-14"], "buyer_address1": ["None", "Address Line1"], "company": ["None", "ABC"], "round_off": ["None", "0"], "buyer_address3": ["None", "Address Line3"], "total": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "mrpvalue": ["None", "0"], "updated": ["None", "2023-09-14"], "cgst": ["None", "0"], "inv": ["None", "2223INV00003"], "buyer_mailingname": ["None", "CUSTOMER NAME"], "id": ["None", "1"], "sgst": ["None", "0"], "buyer_city": ["None", "Vadodara"], "igst": ["None", "0"], "narration": ["None", ""], "qdn_no": ["None", "2223SQ00001"], "channel": ["None", "Channel 1"], "bill_qty": ["None", "0"], "ammount": ["None", "0"], "created": ["None", "2023-09-14"], "buyer_country": ["None", "India"], "buyer": ["None", "Customer Name"]}	2023-09-14 10:44:59.257+05:30	2	76	127.0.0.1	\N
827	3	3	InvItems object (3)	1	{"nb_qty": ["2.00", "1.00"]}	2023-09-14 10:44:59.269+05:30	2	71	127.0.0.1	\N
828	1	1	QdnItems object (1)	0	{"cgstrate": ["None", "0.00"], "cgst": ["None", "0.0000"], "billed_qty": ["None", "1"], "igstrate": ["None", "0.00"], "free_qty": ["None", "0"], "igst": ["None", "0.0000"], "item": ["None", "FG1"], "sgstrate": ["None", "0.00"], "discount": ["None", "0.00"], "mrp": ["None", "100.00"], "rate": ["None", "100.00"], "billed": ["None", "1.00"], "id": ["None", "1"], "amount": ["None", "100.00"], "sgst": ["None", "0.0000"], "inv": ["None", "2223SQ00001"]}	2023-09-14 10:44:59.283+05:30	2	77	127.0.0.1	\N
829	1	1	2223SQ00001	1	{"omrpvalue": ["0.00", "0"], "free_qty": ["0.00", "0"], "tcs": ["0.00", "0"], "total": ["0.00", "100"], "mrpvalue": ["0.00", "100.00"], "bill_qty": ["0.00", "1"], "ammount": ["0.00", "100.00"]}	2023-09-14 10:44:59.29+05:30	2	76	127.0.0.1	\N
830	6	6	2223CN00005	0	{"buyer_city": ["None", "Vadodara"], "cgst": ["None", "0"], "buyer_mailingname": ["None", "ABCD"], "sgst": ["None", "0"], "buyer_country": ["None", "India"], "omrpvalue": ["None", "0"], "channel": ["None", "Channel 1"], "ol_rate": ["None", "0"], "created": ["None", "2023-09-14"], "buyer_address_type": ["None", "Default"], "buyer": ["None", "ABCD"], "buyer_pincode": ["None", "390002"], "buyer_gst_reg_type": ["None", "Unknown"], "buyer_gstin": ["None", "12AYRFG125I"], "mrpvalue": ["None", "0"], "division": ["None", "division"], "status": ["None", "1"], "total": ["None", "0"], "id": ["None", "6"], "other": ["None", "0"], "buyer_address1": ["None", "ABC"], "igst": ["None", "0"], "cn_date": ["None", "2023-09-14"], "cn_no": ["None", "2223CN00005"], "buyer_address2": ["None", "ABC"], "tcs": ["None", "0"], "round_off": ["None", "0"], "buyer_state": ["None", "Gujarat-1"], "buyer_address3": ["None", "ABC"], "updated": ["None", "2023-09-14"], "ammount": ["None", "0"], "company": ["None", "ABC"], "discount": ["None", "0.00"], "inv": ["None", "2223INV00004"]}	2023-09-14 10:46:51.864+05:30	2	74	127.0.0.1	\N
831	4	4	InvItems object (4)	1	{"new_rate": ["100.00", "10.00"]}	2023-09-14 10:46:51.875+05:30	2	71	127.0.0.1	\N
832	5	5	CreditNoteItems object (5)	0	{"cgst": ["None", "0.00"], "mrp": ["None", "1000.00"], "discount": ["None", "0.00"], "igstrate": ["None", "0.00"], "cgstrate": ["None", "0.00"], "sgstrate": ["None", "0.00"], "inv": ["None", "2223CN00005"], "rate": ["None", "90"], "item": ["None", "NFG"], "amount": ["None", "90.00"], "rates": ["None", "100.00"], "igst": ["None", "0.00"], "billed_qty": ["None", "1.00"], "sgst": ["None", "0.00"], "id": ["None", "5"]}	2023-09-14 10:46:51.89+05:30	2	75	127.0.0.1	\N
833	6	6	2223CN00005	1	{"omrpvalue": ["0.00", "0"], "ol_rate": ["0.00", "0"], "mrpvalue": ["0.00", "0"], "total": ["0.00", "90"], "other": ["0.00", "0"], "tcs": ["0.00", "0"], "ammount": ["0.00", "90.00"]}	2023-09-14 10:46:51.897+05:30	2	74	127.0.0.1	\N
866	1	1	CSM00001	0	{"drawn_by": ["None", "admin"], "id": ["None", "1"], "consumable_indent_items": ["None", "production.ConsItems.None"], "no": ["None", "CSM00001"], "qty": ["None", "80.0000"], "created": ["None", "2023-09-05 11:40:37.432000"], "issuer": ["None", "admin"], "updated": ["None", "2023-09-05 11:40:37.496000"], "company": ["None", "ABC"]}	2023-09-14 12:45:54.578247+05:30	\N	50	\N	\N
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auth_group (id, name) FROM stdin;
293	Admin
294	Article Create
295	Brand Create
296	Category Create
297	Product Class Create
298	Godown Create
299	Subbrand Create
300	Article View
301	Brand View
302	Category Update
303	Product Class View
304	Godown View
305	Subbrand View
306	Article Update
307	Brand Update
308	Category Delete
309	Product Class Update
310	Godown Update
311	Subbrand Update
312	Article Delete
313	Brand Delete
314	Category View
315	Product Class Delete
316	Godown Delete
317	Subbrand Delete
318	Subclass Create
319	Subclass View
320	Subclass Update
321	Subclass Delete
322	Product Type Create
323	Product Type View
324	Product Type Update
325	Product Type Delete
326	Customer Margin Create
327	Customer Margin View
328	Customer Margin Update
329	Customer Margin Delete
330	Pricelist Create
331	Pricelist View
332	Pricelist Update
333	Pricelist Delete
334	Scheme Create
335	Scheme View
336	Scheme Update
337	Scheme Delete
338	Units Of Measure Create
339	Units Of Measure View
340	Units Of Measure Update
341	Units Of Measure Delete
342	ICT Create
343	ICT View
344	ICT Update
345	ICT Delete
346	IVT Create
347	IVT View
348	IVT Update
349	IVT Delete
350	IVT Sale Create
351	IVT Sale Update
352	IVT Sale Delete
353	IVT Sale View
354	Currency Create
355	Currency View
356	Currency Update
357	Currency Delete
358	Customer Create
359	Customer View
360	Customer Update
361	Customer Delete
362	Vendor Create
363	Vendor View
364	Vendor Update
365	Vendor Delete
366	Ledger Create
367	Ledger View
368	Ledger Update
369	Ledger Delete
370	ASM Create
371	ASM View
372	ASM Update
373	ASM Delete
374	ZSM Create
375	ZSM View
376	ZSM Update
377	ZSM Delete
378	RSM Create
379	RSM View
380	RSM Update
381	RSM Delete
382	Country Create
383	Country View
384	Country Update
385	Country Delete
386	State Create
387	State View
388	State Update
389	State Delete
390	City Create
391	City View
392	City Update
393	City Delete
394	Channel Create
395	Channel View
396	Channel Update
397	Channel Delete
398	Zone Create
399	Zone View
400	Zone Update
401	Zone Delete
402	Division Create
403	Division View
404	Division Update
405	Division Delete
406	SE Create
407	SE View
408	SE Update
409	SE Delete
410	Region Create
411	Region View
412	Region Update
413	Region Delete
414	BOM Create
415	BOM View
416	BOM Update
417	BOM Delete
418	JobOrder Create
419	JobOrder View
420	JobOrder Update
421	JobOrder Delete
422	Standard Cost Create
423	Standard Cost View
424	Standard Cost Update
425	Standard Cost Delete
426	Purchase Order Create
427	Purchase Order View
428	Purchase Order Update
429	Purchase Order Delete
430	GRN Create
431	GRN Update
432	GRN Delete
433	GRN View
434	Purchase Create
435	Purchase View
436	Purchase Update
437	Purchase Delete
438	DebitNote Create
439	DebitNote View
440	DebitNote Update
441	DebitNote Delete
442	Purchase QDN Create
443	Purchase QDN View
444	Purchase QDN Update
445	Purchase QDN Delete
446	Purchase Return Create
447	Purchase Return View
448	Purchase Return Update
449	Purchase Return Delete
450	Article Master Report
451	Stock Summary (Salable) Report
452	Stock Report
453	Inventory Report
454	Vendor Master Report
455	Customer Master Report
456	Delivery Note Report
457	GRN Report
458	Purchase Order Report
459	PO vs GRN Report
460	Purchase Report
461	Standard Cost Report
462	Sales Order Report
463	Order vs Sales Tracker Report
464	BOM Report
465	Production Report
466	Material Used Report
467	HSN Report
468	Weekly Sales Performance Report
469	Regional Sales Performance Report
470	Sales Order Create
471	Sales Order View
472	Sales Order Update
473	Sales Order Delete
474	Delivery Note Create
475	Delivery Note View
476	Delivery Note Update
477	Delivery Note Delete
478	Packing Sheet Create
479	Packing Sheet View
480	Packing Sheet Update
481	Packing Sheet Delete
482	Loading Sheet View
483	Sales Invoice Create
484	Sales Invoice View
485	Sales Invoice Update
486	Sales Invoice Delete
487	Credit Note Create
488	Credit Note View
489	Credit Note Update
490	Credit Note Delete
491	Sales QDN Create
492	Sales QDN View
493	Sales QDN Update
494	Sales QDN Delete
495	RSO Create
496	RSO View
497	RSO Update
498	RSO Delete
499	Credit Memo Create
500	Credit Memo View
501	Credit Memo Update
502	Credit Memo Delete
503	Sales Target Create
504	Sales Target View
505	Sales Target Update
506	Sales Target Delete
507	LR Details Create
508	LR Details View
509	LR Details Update
510	LR Details Delete
511	Transport Details Create
512	Transport Details View
513	Transport Details Update
514	Transport Details Delete
515	Pallet Transfer
516	Shortage/Damage
517	Sales Invoice Report
518	Customer Sales Performance Report
519	Zonal Sales Performance Report
520	Quarterly Sales Performance Report
521	Category Sales Performance Report
522	Product Sales Performance Report
523	Payment Receivable Report
524	Payment Payable Report
525	Count of Item Sold Report
526	Product vs Party Sales Report
527	Stock Aeging Report
528	Score Card Report
529	DSR Report
530	Job Card View
531	Job Card Create
532	Job Card Update
533	Job Card Delete
534	RM Indent View
535	RM Indent Create
536	RM Indent Update
537	RM Indent Delete
538	Material Transfer View
539	Material Transfer Create
540	Material Transfer Update
541	Material Transfer Delete
542	Consumables View
543	Consumables Create
544	Consumables Update
545	Consumables Delete
546	Production View
547	Production Create
548	Production Update
549	Production Delete
550	Sales Pro Forma Invoice View
551	Sales Pro Forma Invoice Create
552	Sales Pro Forma Invoice Update
553	Sales Pro Forma Invoice Delete
554	Target vs Sales Performance Report
555	Purchase Order Amend
556	Company Profile
557	Sales Invoice Email
558	Purchase Order Email
559	Credit Note Email
560	Debit Note Email
561	Purchase Return Email
562	purchase QDN Email
563	Credit Memo Email
564	Sales QDN Email
565	Return Sales Order Email
566	Sales Proforma Invoices Email
567	ECOM Sales Order View
568	ECOM Sales Order Delete
569	ECOM Sales Order Create
570	ECOM Sales Order Update
571	Multiple Addresss Report
572	Pallet Transfer Report
573	Loading Sheet Report
574	Production Tracker Report
575	RM Indent Report
576	Shortage-Damage Report
577	Sales Order Email
578	CORELLE
579	ECOM
580	EXPORT
581	IB
582	MT
583	STATIONERY
584	TOY
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
373	Can add todo	94	add_todo
374	Can change todo	94	change_todo
375	Can delete todo	94	delete_todo
376	Can view todo	94	view_todo
361	Can add user dashboard module	91	add_userdashboardmodule
362	Can change user dashboard module	91	change_userdashboardmodule
363	Can delete user dashboard module	91	delete_userdashboardmodule
364	Can view user dashboard module	91	view_userdashboardmodule
365	Can add bookmark	92	add_bookmark
366	Can change bookmark	92	change_bookmark
367	Can delete bookmark	92	delete_bookmark
368	Can view bookmark	92	view_bookmark
369	Can add pinned application	93	add_pinnedapplication
370	Can change pinned application	93	change_pinnedapplication
371	Can delete pinned application	93	delete_pinnedapplication
372	Can view pinned application	93	view_pinnedapplication
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add log entry	7	add_logentry
26	Can change log entry	7	change_logentry
27	Can delete log entry	7	delete_logentry
28	Can view log entry	7	view_logentry
29	Can add company	8	add_company
30	Can change company	8	change_company
31	Can delete company	8	delete_company
32	Can view company	8	view_company
33	Can add logged in user	9	add_loggedinuser
34	Can change logged in user	9	change_loggedinuser
35	Can delete logged in user	9	delete_loggedinuser
36	Can view logged in user	9	view_loggedinuser
41	Can add brand	11	add_brand
42	Can change brand	11	change_brand
43	Can delete brand	11	delete_brand
44	Can view brand	11	view_brand
49	Can add category	13	add_category
50	Can change category	13	change_category
51	Can delete category	13	delete_category
52	Can view category	13	view_category
53	Can add class	14	add_class
54	Can change class	14	change_class
55	Can delete class	14	delete_class
56	Can view class	14	view_class
37	Can add godown	10	add_godown
38	Can change godown	10	change_godown
39	Can delete godown	10	delete_godown
40	Can view godown	10	view_godown
85	Can add gst_list	22	add_gst_list
86	Can change gst_list	22	change_gst_list
87	Can delete gst_list	22	delete_gst_list
88	Can view gst_list	22	view_gst_list
77	Can add product_master	20	add_product_master
78	Can change product_master	20	change_product_master
79	Can delete product_master	20	delete_product_master
80	Can view product_master	20	view_product_master
61	Can add product type	16	add_producttype
62	Can change product type	16	change_producttype
63	Can delete product type	16	delete_producttype
64	Can view product type	16	view_producttype
73	Can add scheme	19	add_scheme
74	Can change scheme	19	change_scheme
75	Can delete scheme	19	delete_scheme
76	Can view scheme	19	view_scheme
45	Can add sub brand	12	add_subbrand
46	Can change sub brand	12	change_subbrand
47	Can delete sub brand	12	delete_subbrand
48	Can view sub brand	12	view_subbrand
57	Can add sub class	15	add_subclass
58	Can change sub class	15	change_subclass
59	Can delete sub class	15	delete_subclass
60	Can view sub class	15	view_subclass
65	Can add uqc	17	add_uqc
66	Can change uqc	17	change_uqc
67	Can delete uqc	17	delete_uqc
68	Can view uqc	17	view_uqc
69	Can add unit of measure	18	add_unitofmeasure
70	Can change unit of measure	18	change_unitofmeasure
71	Can delete unit of measure	18	delete_unitofmeasure
72	Can view unit of measure	18	view_unitofmeasure
81	Can add std_rate	21	add_std_rate
82	Can change std_rate	21	change_std_rate
83	Can delete std_rate	21	delete_std_rate
84	Can view std_rate	21	view_std_rate
89	Can add currency	23	add_currency
90	Can change currency	23	change_currency
91	Can delete currency	23	delete_currency
92	Can view currency	23	view_currency
117	Can add asm	30	add_asm
118	Can change asm	30	change_asm
119	Can delete asm	30	delete_asm
120	Can view asm	30	view_asm
137	Can add city	35	add_city
138	Can change city	35	change_city
139	Can delete city	35	delete_city
140	Can view city	35	view_city
129	Can add country	33	add_country
130	Can change country	33	change_country
131	Can delete country	33	delete_country
132	Can view country	33	view_country
145	Can add division	37	add_division
146	Can change division	37	change_division
147	Can delete division	37	delete_division
148	Can view division	37	view_division
93	Can add group	24	add_group
94	Can change group	24	change_group
95	Can delete group	24	delete_group
96	Can view group	24	view_group
125	Can add party type	32	add_partytype
126	Can change party type	32	change_partytype
127	Can delete party type	32	delete_partytype
128	Can view party type	32	view_partytype
141	Can add price_level	36	add_price_level
142	Can change price_level	36	change_price_level
143	Can delete price_level	36	delete_price_level
144	Can view price_level	36	view_price_level
105	Can add region	27	add_region
106	Can change region	27	change_region
107	Can delete region	27	delete_region
108	Can view region	27	view_region
113	Can add rsm	29	add_rsm
114	Can change rsm	29	change_rsm
115	Can delete rsm	29	delete_rsm
116	Can view rsm	29	view_rsm
101	Can add zone	26	add_zone
102	Can change zone	26	change_zone
103	Can delete zone	26	delete_zone
104	Can view zone	26	view_zone
109	Can add zsm	28	add_zsm
110	Can change zsm	28	change_zsm
111	Can delete zsm	28	delete_zsm
112	Can view zsm	28	view_zsm
133	Can add state	34	add_state
134	Can change state	34	change_state
135	Can delete state	34	delete_state
136	Can view state	34	view_state
121	Can add se	31	add_se
122	Can change se	31	change_se
123	Can delete se	31	delete_se
124	Can view se	31	view_se
153	Can add party_master	39	add_party_master
154	Can change party_master	39	change_party_master
155	Can delete party_master	39	delete_party_master
156	Can view party_master	39	view_party_master
157	Can add party_contact_details	40	add_party_contact_details
158	Can change party_contact_details	40	change_party_contact_details
159	Can delete party_contact_details	40	delete_party_contact_details
160	Can view party_contact_details	40	view_party_contact_details
97	Can add ledgers type	25	add_ledgerstype
98	Can change ledgers type	25	change_ledgerstype
99	Can delete ledgers type	25	delete_ledgerstype
100	Can view ledgers type	25	view_ledgerstype
149	Can add price_list	38	add_price_list
150	Can change price_list	38	change_price_list
151	Can delete price_list	38	delete_price_list
152	Can view price_list	38	view_price_list
161	Can add currency	41	add_currency
162	Can change currency	41	change_currency
163	Can delete currency	41	delete_currency
164	Can view currency	41	view_currency
165	Can add bom	42	add_bom
166	Can change bom	42	change_bom
167	Can delete bom	42	delete_bom
168	Can view bom	42	view_bom
173	Can add job order	44	add_joborder
174	Can change job order	44	change_joborder
175	Can delete job order	44	delete_joborder
176	Can view job order	44	view_joborder
169	Can add bom items	43	add_bomitems
170	Can change bom items	43	change_bomitems
171	Can delete bom items	43	delete_bomitems
172	Can view bom items	43	view_bomitems
177	Can add sales projection	45	add_salesprojection
178	Can change sales projection	45	change_salesprojection
179	Can delete sales projection	45	delete_salesprojection
180	Can view sales projection	45	view_salesprojection
205	Can add consumption	52	add_consumption
206	Can change consumption	52	change_consumption
207	Can delete consumption	52	delete_consumption
208	Can view consumption	52	view_consumption
181	Can add job card	46	add_jobcard
182	Can change job card	46	change_jobcard
183	Can delete job card	46	delete_jobcard
184	Can view job card	46	view_jobcard
185	Can add rm indent	47	add_rmindent
186	Can change rm indent	47	change_rmindent
187	Can delete rm indent	47	delete_rmindent
188	Can view rm indent	47	view_rmindent
189	Can add rm indent items	48	add_rmindentitems
190	Can change rm indent items	48	change_rmindentitems
191	Can delete rm indent items	48	delete_rmindentitems
192	Can view rm indent items	48	view_rmindentitems
193	Can add rm item godown	49	add_rmitemgodown
194	Can change rm item godown	49	change_rmitemgodown
195	Can delete rm item godown	49	delete_rmitemgodown
196	Can view rm item godown	49	view_rmitemgodown
209	Can add consumption items	53	add_consumptionitems
210	Can change consumption items	53	change_consumptionitems
211	Can delete consumption items	53	delete_consumptionitems
212	Can view consumption items	53	view_consumptionitems
197	Can add consumable indent	50	add_consumableindent
198	Can change consumable indent	50	change_consumableindent
199	Can delete consumable indent	50	delete_consumableindent
200	Can view consumable indent	50	view_consumableindent
201	Can add cons items	51	add_consitems
202	Can change cons items	51	change_consitems
203	Can delete cons items	51	delete_consitems
204	Can view cons items	51	view_consitems
237	Can add debit note	60	add_debitnote
238	Can change debit note	60	change_debitnote
239	Can delete debit note	60	delete_debitnote
240	Can view debit note	60	view_debitnote
225	Can add grn	57	add_grn
226	Can change grn	57	change_grn
227	Can delete grn	57	delete_grn
228	Can view grn	57	view_grn
221	Can add purchase	56	add_purchase
222	Can change purchase	56	change_purchase
223	Can delete purchase	56	delete_purchase
224	Can view purchase	56	view_purchase
253	Can add purchase return	64	add_purchasereturn
254	Can change purchase return	64	change_purchasereturn
255	Can delete purchase return	64	delete_purchasereturn
256	Can view purchase return	64	view_purchasereturn
245	Can add qdn	62	add_qdn
246	Can change qdn	62	change_qdn
247	Can delete qdn	62	delete_qdn
248	Can view qdn	62	view_qdn
249	Can add qdn items	63	add_qdnitems
250	Can change qdn items	63	change_qdnitems
251	Can delete qdn items	63	delete_qdnitems
252	Can view qdn items	63	view_qdnitems
257	Can add purchase return items	65	add_purchasereturnitems
258	Can change purchase return items	65	change_purchasereturnitems
259	Can delete purchase return items	65	delete_purchasereturnitems
260	Can view purchase return items	65	view_purchasereturnitems
213	Can add purchase_order	54	add_purchase_order
214	Can change purchase_order	54	change_purchase_order
215	Can delete purchase_order	54	delete_purchase_order
216	Can view purchase_order	54	view_purchase_order
217	Can add po items	55	add_poitems
218	Can change po items	55	change_poitems
219	Can delete po items	55	delete_poitems
220	Can view po items	55	view_poitems
233	Can add pi items	59	add_piitems
234	Can change pi items	59	change_piitems
235	Can delete pi items	59	delete_piitems
236	Can view pi items	59	view_piitems
229	Can add grn items	58	add_grnitems
230	Can change grn items	58	change_grnitems
231	Can delete grn items	58	delete_grnitems
232	Can view grn items	58	view_grnitems
241	Can add debit note items	61	add_debitnoteitems
242	Can change debit note items	61	change_debitnoteitems
243	Can delete debit note items	61	delete_debitnoteitems
244	Can view debit note items	61	view_debitnoteitems
293	Can add credit note	74	add_creditnote
294	Can change credit note	74	change_creditnote
295	Can delete credit note	74	delete_creditnote
296	Can view credit note	74	view_creditnote
269	Can add delivery_note	68	add_delivery_note
270	Can change delivery_note	68	change_delivery_note
271	Can delete delivery_note	68	delete_delivery_note
272	Can view delivery_note	68	view_delivery_note
277	Can add invoice	70	add_invoice
278	Can change invoice	70	change_invoice
279	Can delete invoice	70	delete_invoice
280	Can view invoice	70	view_invoice
301	Can add qdn	76	add_qdn
302	Can change qdn	76	change_qdn
303	Can delete qdn	76	delete_qdn
304	Can view qdn	76	view_qdn
309	Can add rso	78	add_rso
310	Can change rso	78	change_rso
311	Can delete rso	78	delete_rso
312	Can view rso	78	view_rso
261	Can add salesorder	66	add_salesorder
262	Can change salesorder	66	change_salesorder
263	Can delete salesorder	66	delete_salesorder
264	Can view salesorder	66	view_salesorder
265	Can add so items	67	add_soitems
266	Can change so items	67	change_soitems
267	Can delete so items	67	delete_soitems
268	Can view so items	67	view_soitems
325	Can add sale qty	82	add_saleqty
326	Can change sale qty	82	change_saleqty
327	Can delete sale qty	82	delete_saleqty
328	Can view sale qty	82	view_saleqty
313	Can add rso items	79	add_rsoitems
314	Can change rso items	79	change_rsoitems
315	Can delete rso items	79	delete_rsoitems
316	Can view rso items	79	view_rsoitems
305	Can add qdn items	77	add_qdnitems
306	Can change qdn items	77	change_qdnitems
307	Can delete qdn items	77	delete_qdnitems
308	Can view qdn items	77	view_qdnitems
321	Can add packing sheet	81	add_packingsheet
322	Can change packing sheet	81	change_packingsheet
323	Can delete packing sheet	81	delete_packingsheet
324	Can view packing sheet	81	view_packingsheet
317	Can add loading sheet	80	add_loadingsheet
318	Can change loading sheet	80	change_loadingsheet
319	Can delete loading sheet	80	delete_loadingsheet
320	Can view loading sheet	80	view_loadingsheet
281	Can add inv items	71	add_invitems
282	Can change inv items	71	change_invitems
283	Can delete inv items	71	delete_invitems
284	Can view inv items	71	view_invitems
273	Can add dn items	69	add_dnitems
274	Can change dn items	69	change_dnitems
275	Can delete dn items	69	delete_dnitems
276	Can view dn items	69	view_dnitems
297	Can add credit note items	75	add_creditnoteitems
298	Can change credit note items	75	change_creditnoteitems
299	Can delete credit note items	75	delete_creditnoteitems
300	Can view credit note items	75	view_creditnoteitems
329	Can add sales target	83	add_salestarget
330	Can change sales target	83	change_salestarget
331	Can delete sales target	83	delete_salestarget
332	Can view sales target	83	view_salestarget
285	Can add proforma invoice	72	add_proformainvoice
286	Can change proforma invoice	72	change_proformainvoice
287	Can delete proforma invoice	72	delete_proformainvoice
288	Can view proforma invoice	72	view_proformainvoice
289	Can add proforma inv items	73	add_proformainvitems
290	Can change proforma inv items	73	change_proformainvitems
291	Can delete proforma inv items	73	delete_proformainvitems
292	Can view proforma inv items	73	view_proformainvitems
333	Can add stock_summary	84	add_stock_summary
334	Can change stock_summary	84	change_stock_summary
335	Can delete stock_summary	84	delete_stock_summary
336	Can view stock_summary	84	view_stock_summary
341	Can add shortage damage entry	86	add_shortagedamageentry
342	Can change shortage damage entry	86	change_shortagedamageentry
343	Can delete shortage damage entry	86	delete_shortagedamageentry
344	Can view shortage damage entry	86	view_shortagedamageentry
337	Can add material transferred	85	add_materialtransferred
338	Can change material transferred	85	change_materialtransferred
339	Can delete material transferred	85	delete_materialtransferred
340	Can view material transferred	85	view_materialtransferred
345	Can add pallet transfer entry	87	add_pallettransferentry
346	Can change pallet transfer entry	87	change_pallettransferentry
347	Can delete pallet transfer entry	87	delete_pallettransferentry
348	Can view pallet transfer entry	87	view_pallettransferentry
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$320000$PNxlfIqsjaxsGzbyC8g00e$p9QhiTLAPWyhzRilafUWTtCJx1fX1OgwpXq5IGPX/BE=	2023-09-18 16:45:18.751538+05:30	t	admin			admin@admin.com	t	t	2023-03-03 11:52:53+05:30
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
293	2	512
294	2	513
295	2	514
296	2	515
297	2	516
298	2	517
299	2	518
300	2	519
301	2	520
302	2	521
303	2	522
304	2	523
305	2	524
306	2	525
307	2	526
308	2	527
309	2	528
310	2	529
311	2	530
312	2	531
313	2	532
314	2	533
315	2	534
316	2	535
317	2	536
318	2	537
319	2	538
320	2	539
321	2	540
322	2	541
323	2	542
324	2	543
325	2	544
326	2	545
327	2	546
328	2	547
329	2	548
330	2	549
331	2	550
332	2	551
333	2	552
334	2	553
335	2	554
336	2	555
337	2	556
338	2	557
339	2	558
340	2	559
341	2	560
342	2	561
343	2	562
344	2	563
345	2	564
346	2	565
347	2	566
348	2	567
349	2	568
350	2	569
351	2	570
352	2	571
353	2	572
354	2	573
355	2	574
356	2	575
357	2	576
358	2	577
359	2	578
360	2	579
361	2	580
362	2	581
363	2	582
364	2	583
365	2	584
366	2	293
367	2	294
368	2	295
369	2	296
370	2	297
371	2	298
372	2	299
373	2	300
374	2	301
375	2	302
376	2	303
377	2	304
378	2	305
379	2	306
380	2	307
381	2	308
382	2	309
383	2	310
384	2	311
385	2	312
386	2	313
387	2	314
388	2	315
389	2	316
390	2	317
391	2	318
392	2	319
393	2	320
394	2	321
395	2	322
396	2	323
397	2	324
398	2	325
399	2	326
400	2	327
401	2	328
402	2	329
403	2	330
404	2	331
405	2	332
406	2	333
407	2	334
408	2	335
409	2	336
410	2	337
411	2	338
412	2	339
413	2	340
414	2	341
415	2	342
416	2	343
417	2	344
418	2	345
419	2	346
420	2	347
421	2	348
422	2	349
423	2	350
424	2	351
425	2	352
426	2	353
427	2	354
428	2	355
429	2	356
430	2	357
431	2	358
432	2	359
433	2	360
434	2	361
435	2	362
436	2	363
437	2	364
438	2	365
439	2	366
440	2	367
441	2	368
442	2	369
443	2	370
444	2	371
445	2	372
446	2	373
447	2	374
448	2	375
449	2	376
450	2	377
451	2	378
452	2	379
453	2	380
454	2	381
455	2	382
456	2	383
457	2	384
458	2	385
459	2	386
460	2	387
461	2	388
462	2	389
463	2	390
464	2	391
465	2	392
466	2	393
467	2	394
468	2	395
469	2	396
470	2	397
471	2	398
472	2	399
473	2	400
474	2	401
475	2	402
476	2	403
477	2	404
478	2	405
479	2	406
480	2	407
481	2	408
482	2	409
483	2	410
484	2	411
485	2	412
486	2	413
487	2	414
488	2	415
489	2	416
490	2	417
491	2	418
492	2	419
493	2	420
494	2	421
495	2	422
496	2	423
497	2	424
498	2	425
499	2	426
500	2	427
501	2	428
502	2	429
503	2	430
504	2	431
505	2	432
506	2	433
507	2	434
508	2	435
509	2	436
510	2	437
511	2	438
512	2	439
513	2	440
514	2	441
515	2	442
516	2	443
517	2	444
518	2	445
519	2	446
520	2	447
521	2	448
522	2	449
523	2	450
524	2	451
525	2	452
526	2	453
527	2	454
528	2	455
529	2	456
530	2	457
531	2	458
532	2	459
533	2	460
534	2	461
535	2	462
536	2	463
537	2	464
538	2	465
539	2	466
540	2	467
541	2	468
542	2	469
543	2	470
544	2	471
545	2	472
546	2	473
547	2	474
548	2	475
549	2	476
550	2	477
551	2	478
552	2	479
553	2	480
554	2	481
555	2	482
556	2	483
557	2	484
558	2	485
559	2	486
560	2	487
561	2	488
562	2	489
563	2	490
564	2	491
565	2	492
566	2	493
567	2	494
568	2	495
569	2	496
570	2	497
571	2	498
572	2	499
573	2	500
574	2	501
575	2	502
576	2	503
577	2	504
578	2	505
579	2	506
580	2	507
581	2	508
582	2	509
583	2	510
584	2	511
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
361	2	1
362	2	2
363	2	3
364	2	4
365	2	5
366	2	6
367	2	7
368	2	8
369	2	9
370	2	10
371	2	11
372	2	12
373	2	13
374	2	14
375	2	15
376	2	16
377	2	17
378	2	18
379	2	19
380	2	20
381	2	21
382	2	22
383	2	23
384	2	24
385	2	25
386	2	26
387	2	27
388	2	28
389	2	29
390	2	30
391	2	31
392	2	32
393	2	33
394	2	34
395	2	35
396	2	36
397	2	37
398	2	38
399	2	39
400	2	40
401	2	41
402	2	42
403	2	43
404	2	44
405	2	45
406	2	46
407	2	47
408	2	48
409	2	49
410	2	50
411	2	51
412	2	52
413	2	53
414	2	54
415	2	55
416	2	56
417	2	57
418	2	58
419	2	59
420	2	60
421	2	61
422	2	62
423	2	63
424	2	64
425	2	65
426	2	66
427	2	67
428	2	68
429	2	69
430	2	70
431	2	71
432	2	72
433	2	73
434	2	74
435	2	75
436	2	76
437	2	77
438	2	78
439	2	79
440	2	80
441	2	81
442	2	82
443	2	83
444	2	84
445	2	85
446	2	86
447	2	87
448	2	88
449	2	89
450	2	90
451	2	91
452	2	92
453	2	93
454	2	94
455	2	95
456	2	96
457	2	97
458	2	98
459	2	99
460	2	100
461	2	101
462	2	102
463	2	103
464	2	104
465	2	105
466	2	106
467	2	107
468	2	108
469	2	109
470	2	110
471	2	111
472	2	112
473	2	113
474	2	114
475	2	115
476	2	116
477	2	117
478	2	118
479	2	119
480	2	120
481	2	121
482	2	122
483	2	123
484	2	124
485	2	125
486	2	126
487	2	127
488	2	128
489	2	129
490	2	130
491	2	131
492	2	132
493	2	133
494	2	134
495	2	135
496	2	136
497	2	137
498	2	138
499	2	139
500	2	140
501	2	141
502	2	142
503	2	143
504	2	144
505	2	145
506	2	146
507	2	147
508	2	148
509	2	149
510	2	150
511	2	151
512	2	152
513	2	153
514	2	154
515	2	155
516	2	156
517	2	157
518	2	158
519	2	159
520	2	160
521	2	161
522	2	162
523	2	163
524	2	164
525	2	165
526	2	166
527	2	167
528	2	168
529	2	169
530	2	170
531	2	171
532	2	172
533	2	173
534	2	174
535	2	175
536	2	176
537	2	177
538	2	178
539	2	179
540	2	180
541	2	181
542	2	182
543	2	183
544	2	184
545	2	185
546	2	186
547	2	187
548	2	188
549	2	189
550	2	190
551	2	191
552	2	192
553	2	193
554	2	194
555	2	195
556	2	196
557	2	197
558	2	198
559	2	199
560	2	200
561	2	201
562	2	202
563	2	203
564	2	204
565	2	205
566	2	206
567	2	207
568	2	208
569	2	209
570	2	210
571	2	211
572	2	212
573	2	213
574	2	214
575	2	215
576	2	216
577	2	217
578	2	218
579	2	219
580	2	220
581	2	221
582	2	222
583	2	223
584	2	224
585	2	225
586	2	226
587	2	227
588	2	228
589	2	229
590	2	230
591	2	231
592	2	232
593	2	233
594	2	234
595	2	235
596	2	236
597	2	237
598	2	238
599	2	239
600	2	240
601	2	241
602	2	242
603	2	243
604	2	244
605	2	245
606	2	246
607	2	247
608	2	248
609	2	249
610	2	250
611	2	251
612	2	252
613	2	253
614	2	254
615	2	255
616	2	256
617	2	257
618	2	258
619	2	259
620	2	260
621	2	261
622	2	262
623	2	263
624	2	264
625	2	265
626	2	266
627	2	267
628	2	268
629	2	269
630	2	270
631	2	271
632	2	272
633	2	273
634	2	274
635	2	275
636	2	276
637	2	277
638	2	278
639	2	279
640	2	280
641	2	281
642	2	282
643	2	283
644	2	284
645	2	285
646	2	286
647	2	287
648	2	288
649	2	289
650	2	290
651	2	291
652	2	292
653	2	293
654	2	294
655	2	295
656	2	296
657	2	297
658	2	298
659	2	299
660	2	300
661	2	301
662	2	302
663	2	303
664	2	304
665	2	305
666	2	306
667	2	307
668	2	308
669	2	309
670	2	310
671	2	311
672	2	312
673	2	313
674	2	314
675	2	315
676	2	316
677	2	317
678	2	318
679	2	319
680	2	320
681	2	321
682	2	322
683	2	323
684	2	324
685	2	325
686	2	326
687	2	327
688	2	328
689	2	329
690	2	330
691	2	331
692	2	332
693	2	333
694	2	334
695	2	335
696	2	336
697	2	337
698	2	338
699	2	339
700	2	340
701	2	341
702	2	342
703	2	343
704	2	344
705	2	345
706	2	346
707	2	347
708	2	348
709	2	361
710	2	362
711	2	363
712	2	364
713	2	365
714	2	366
715	2	367
716	2	368
717	2	369
718	2	370
719	2	371
720	2	372
\.


--
-- Data for Name: company_company; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.company_company (id, name, tally_name, ledger_name, ipaddress, dis_addtype, dis_name, dis_add1, dis_add2, dis_add3, dis_country, dis_state, dis_city, dis_pincode, dis_gstin, pan_no, so_series, dn_series, inv_series, debitnote_series, sales_qdn_series, rso_series, po_series, ict_series, grn_series, pi_series, creditnote_series, purchase_qdn_series, purchase_return_series, joborder_series, job_series, rm_series, cms_series, pds_series, created, updated, pinv_series) FROM stdin;
1	ABC	ABCD	ABCD	http://localhost:9001	Default	ABCD	ABCD	ABCD	ABCD	INDIA	GUJARAT	VADODARA	391775	24AAKCS5015L1Z8	AAKCS5015L	2223SO	2223DN	2223INV	2223DB	2223SQ	2223RSO	2223PO	2223ICT	2223GRN	2223PINV	2223CN	2223PQ	2223PR	2223JO	2223JC	2223RM	2223CSM	2223PRD	2023-03-03	2023-07-28	2223PI
2	XYZ	XYZ	XYZ	http://localhost:9001	Default	XYZ	XYZ	XYZ	XYZ	INDIA	GUJARAT	VADODARA	391775	24AAJCR4497G1Z1	AAJCR4497G	2223SO	2223DN	2223INV	2223DB	2223SQ	2223RSO	2223PO	2223ICT	2223GRN	2223PINV	2223CN	2223PQ	2223PR	2223JO	2223JC	2223RM	2223CSM	2223PRD	2023-03-03	2023-03-03	2223PI
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2023-03-03 12:08:52.893+05:30	1	STONE SAPPHIRE (INDIA) PRIVATE LIMITED	1	[{"added": {}}]	8	2
2	2023-03-03 12:12:08.96+05:30	2	REDRIDGE INDIA PVT LTD	1	[{"added": {}}]	8	2
3	2023-03-03 12:13:45.143+05:30	1	ABCD	2	[{"changed": {"fields": ["Name", "Tally name", "Ledger name", "Dis name", "Dis add1", "Dis add2", "Dis add3"]}}]	8	2
4	2023-03-03 12:14:09.15+05:30	2	XYZ	2	[{"changed": {"fields": ["Name", "Tally name", "Ledger name", "Dis name", "Dis add1", "Dis add2", "Dis add3"]}}]	8	2
5	2023-03-03 12:17:10.412+05:30	1	admin	2	[{"changed": {"fields": ["User permissions"]}}]	4	2
6	2023-03-03 12:17:45.317+05:30	1	admin	2	[{"changed": {"fields": ["Groups"]}}]	4	2
7	2023-03-03 12:45:52.59+05:30	1	Sundry Debtors	1	[{"added": {}}]	24	2
8	2023-03-03 12:46:06.83+05:30	2	Sundry Creditors	1	[{"added": {}}]	24	2
9	2023-03-03 12:46:16.242+05:30	3	Sales Accounts	1	[{"added": {}}]	24	2
10	2023-03-03 12:46:26.336+05:30	4	Purchase Accounts	1	[{"added": {}}]	24	2
11	2023-03-03 12:46:37.99+05:30	5	Direct Income	1	[{"added": {}}]	24	2
12	2023-03-03 12:46:48.413+05:30	6	Direct Expense	1	[{"added": {}}]	24	2
13	2023-09-05 16:54:10.452+05:30	5	UN ALLOCATED	1	[{"added": {}}]	10	2
14	2023-09-05 17:05:21.926+05:30	2	PRODUCTION	2	[{"changed": {"fields": ["Name"]}}]	10	2
15	2023-09-12 17:50:40.402+05:30	293	Sundry Creditors	1	[{"added": {}}]	3	2
16	2023-09-12 17:51:23.845+05:30	293	Sundry Creditors	3		3	2
17	2023-09-13 09:34:27.106+05:30	7	SHORTAGE	1	[{"added": {}}]	10	2
18	2023-09-13 09:35:08.829+05:30	8	DAMAGE & SCRAP	1	[{"added": {}}]	10	2
19	2023-09-13 09:35:36.621+05:30	8	DAMAGE & SCRAP	3		10	2
20	2023-09-13 09:35:50.805+05:30	1	DAMAGE & SCRAP	2	[{"changed": {"fields": ["Name"]}}]	10	2
21	2023-09-13 09:36:36.737+05:30	3	Production123	3		10	2
22	2023-09-13 10:41:04.762+05:30	4	ECOM	1	[{"added": {}}]	37	2
23	2023-09-13 13:01:45.226+05:30	2	PackingSheet object (2)	1	[{"added": {}}]	81	2
24	2023-09-13 14:50:05.862+05:30	10	ShortageDamageEntry object (10)	2	[{"changed": {"fields": ["Shoratage", "Jobwork"]}}]	86	2
25	2023-09-13 14:52:02.614+05:30	2	FINISHED GOODS	2	[{"changed": {"fields": ["Name"]}}]	16	2
26	2023-09-15 09:58:14.013206+05:30	1	TODO_Test	1	[{"added": {}}]	94	2
27	2023-09-15 10:12:08.886151+05:30	1	TODO_Test	2	[]	94	2
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
94	todo	todo
91	dashboard	userdashboardmodule
92	jet	bookmark
93	jet	pinnedapplication
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	auditlog	logentry
8	company	company
9	accounts	loggedinuser
11	inventory	brand
13	inventory	category
14	inventory	class
10	inventory	godown
22	inventory	gst_list
20	inventory	product_master
16	inventory	producttype
19	inventory	scheme
12	inventory	subbrand
15	inventory	subclass
17	inventory	uqc
18	inventory	unitofmeasure
21	inventory	std_rate
23	inventory	currency
30	ledgers	asm
35	ledgers	city
33	ledgers	country
37	ledgers	division
24	ledgers	group
32	ledgers	partytype
36	ledgers	price_level
27	ledgers	region
29	ledgers	rsm
26	ledgers	zone
28	ledgers	zsm
34	ledgers	state
31	ledgers	se
39	ledgers	party_master
40	ledgers	party_contact_details
25	ledgers	ledgerstype
38	ledgers	price_list
41	ledgers	currency
42	planning	bom
44	planning	joborder
43	planning	bomitems
45	planning	salesprojection
52	production	consumption
46	production	jobcard
47	production	rmindent
48	production	rmindentitems
49	production	rmitemgodown
53	production	consumptionitems
50	production	consumableindent
51	production	consitems
60	purchase	debitnote
57	purchase	grn
56	purchase	purchase
64	purchase	purchasereturn
62	purchase	qdn
63	purchase	qdnitems
65	purchase	purchasereturnitems
54	purchase	purchase_order
55	purchase	poitems
59	purchase	piitems
58	purchase	grnitems
61	purchase	debitnoteitems
74	sales	creditnote
68	sales	delivery_note
70	sales	invoice
76	sales	qdn
78	sales	rso
66	sales	salesorder
67	sales	soitems
82	sales	saleqty
79	sales	rsoitems
77	sales	qdnitems
81	sales	packingsheet
80	sales	loadingsheet
71	sales	invitems
69	sales	dnitems
75	sales	creditnoteitems
83	sales	salestarget
72	sales	proformainvoice
73	sales	proformainvitems
84	warehouse	stock_summary
86	warehouse	shortagedamageentry
85	warehouse	materialtransferred
87	warehouse	pallettransferentry
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2023-09-14 12:40:56.652229+05:30
2	auth	0001_initial	2023-09-14 12:40:56.730821+05:30
3	accounts	0001_initial	2023-09-14 12:40:56.744557+05:30
4	admin	0001_initial	2023-09-14 12:40:56.769595+05:30
5	admin	0002_logentry_remove_auto_add	2023-09-14 12:40:56.77957+05:30
6	admin	0003_logentry_add_action_flag_choices	2023-09-14 12:40:56.787725+05:30
7	auditlog	0001_initial	2023-09-14 12:40:56.814991+05:30
8	auditlog	0002_auto_support_long_primary_keys	2023-09-14 12:40:56.845612+05:30
9	auditlog	0003_logentry_remote_addr	2023-09-14 12:40:56.856804+05:30
10	auditlog	0004_logentry_detailed_object_repr	2023-09-14 12:40:56.864207+05:30
11	auditlog	0005_logentry_additional_data_verbose_name	2023-09-14 12:40:56.874055+05:30
12	auditlog	0006_object_pk_index	2023-09-14 12:40:56.90318+05:30
13	auditlog	0007_object_pk_type	2023-09-14 12:40:56.913346+05:30
14	auditlog	0008_action_index	2023-09-14 12:40:56.924993+05:30
15	auditlog	0009_alter_logentry_additional_data	2023-09-14 12:40:56.933925+05:30
16	contenttypes	0002_remove_content_type_name	2023-09-14 12:40:56.953517+05:30
17	auth	0002_alter_permission_name_max_length	2023-09-14 12:40:56.96336+05:30
18	auth	0003_alter_user_email_max_length	2023-09-14 12:40:56.974914+05:30
19	auth	0004_alter_user_username_opts	2023-09-14 12:40:57.041554+05:30
20	auth	0005_alter_user_last_login_null	2023-09-14 12:40:57.048993+05:30
21	auth	0006_require_contenttypes_0002	2023-09-14 12:40:57.053365+05:30
22	auth	0007_alter_validators_add_error_messages	2023-09-14 12:40:57.063598+05:30
23	auth	0008_alter_user_username_max_length	2023-09-14 12:40:57.078297+05:30
24	auth	0009_alter_user_last_name_max_length	2023-09-14 12:40:57.089979+05:30
25	auth	0010_alter_group_name_max_length	2023-09-14 12:40:57.101663+05:30
26	auth	0011_update_proxy_permissions	2023-09-14 12:40:57.111932+05:30
27	auth	0012_alter_user_first_name_max_length	2023-09-14 12:40:57.123949+05:30
28	company	0001_initial	2023-09-14 12:40:57.136617+05:30
29	company	0002_alter_company_name	2023-09-14 12:40:57.143581+05:30
30	company	0003_company_created_company_updated	2023-09-14 12:40:57.15206+05:30
31	company	0004_remove_company_color	2023-09-14 12:40:57.158605+05:30
32	company	0005_company_pinv_series	2023-09-14 12:40:57.164028+05:30
33	inventory	0001_initial	2023-09-14 12:40:57.294186+05:30
34	ledgers	0001_initial	2023-09-14 12:40:57.65446+05:30
35	ledgers	0002_currency_alter_asm_options_alter_city_options_and_more	2023-09-14 12:40:57.751246+05:30
36	ledgers	0004_alter_region_unique_together	2023-09-14 12:40:57.764863+05:30
37	ledgers	0005_alter_division_name	2023-09-14 12:40:57.857062+05:30
38	ledgers	0006_asm_created_asm_updated_currency_created_and_more	2023-09-14 12:40:57.981963+05:30
39	inventory	0002_initial	2023-09-14 12:40:58.15237+05:30
40	inventory	0003_alter_brand_options_alter_category_options_and_more	2023-09-14 12:40:58.195958+05:30
41	inventory	0004_alter_godown_name	2023-09-14 12:40:58.205204+05:30
42	inventory	0005_alter_unitofmeasure_name	2023-09-14 12:40:58.219414+05:30
43	inventory	0006_alter_std_rate_unique_together	2023-09-14 12:40:58.240295+05:30
44	inventory	0007_currency	2023-09-14 12:40:58.246689+05:30
45	inventory	0008_brand_created_brand_updated_category_created_and_more	2023-09-14 12:40:58.460621+05:30
46	inventory	0009_producttype_dl_purchase_producttype_dl_sales	2023-09-14 12:40:58.510758+05:30
47	inventory	0010_alter_product_master_created	2023-09-14 12:40:58.534128+05:30
48	inventory	0011_alter_gst_list_hsncode	2023-09-14 12:40:58.551414+05:30
49	inventory	0012_alter_gst_list_calc_type_alter_gst_list_suply_type_and_more	2023-09-14 12:40:58.594137+05:30
50	ledgers	0007_alter_party_master_cc_email	2023-09-14 12:40:58.61593+05:30
51	ledgers	0008_alter_party_contact_details_fax_no_and_more	2023-09-14 12:40:58.681468+05:30
52	ledgers	0009_alter_party_master_gst_registration_type	2023-09-14 12:40:58.705612+05:30
53	ledgers	0010_alter_party_contact_details_pin_code_and_more	2023-09-14 12:40:58.979689+05:30
54	ledgers	0011_alter_party_contact_details_city_and_more	2023-09-14 12:40:59.07847+05:30
55	ledgers	0012_alter_party_contact_details_gst_registration_type	2023-09-14 12:40:59.096099+05:30
56	ledgers	0013_alter_party_contact_details_gst_registration_type_and_more	2023-09-14 12:40:59.142256+05:30
57	ledgers	0014_party_master_is_transporter	2023-09-14 12:40:59.165376+05:30
58	planning	0001_initial	2023-09-14 12:40:59.293898+05:30
59	planning	0002_alter_bom_options_alter_bomitems_options_and_more	2023-09-14 12:40:59.354357+05:30
60	planning	0003_alter_bom_name	2023-09-14 12:40:59.373071+05:30
61	planning	0004_alter_joborder_due_date	2023-09-14 12:40:59.485419+05:30
62	planning	0005_bom_created_bom_updated	2023-09-14 12:40:59.519176+05:30
63	planning	0006_alter_joborder_status	2023-09-14 12:40:59.550186+05:30
64	planning	0007_alter_joborder_name	2023-09-14 12:40:59.570219+05:30
65	planning	0008_alter_joborder_category_alter_joborder_details_and_more	2023-09-14 12:40:59.654666+05:30
66	production	0001_initial	2023-09-14 12:41:00.009673+05:30
67	production	0002_alter_consumableindent_options_and_more	2023-09-14 12:41:00.094451+05:30
68	production	0003_alter_jobcard_start	2023-09-14 12:41:00.123192+05:30
69	production	0004_alter_consumptionitems_consumption	2023-09-14 12:41:00.163145+05:30
70	production	0005_jobcard_rqty	2023-09-14 12:41:00.186054+05:30
71	production	0006_consumption_qty	2023-09-14 12:41:00.200731+05:30
72	production	0007_rmitemgodown_created_rmitemgodown_updated	2023-09-14 12:41:00.220738+05:30
73	production	0008_jobcard_status	2023-09-14 12:41:00.246796+05:30
74	purchase	0001_initial	2023-09-14 12:41:01.347453+05:30
75	purchase	0002_purchase_order_currency_purchase_order_ex_rate	2023-09-14 12:41:01.412112+05:30
76	purchase	0003_debitnote_currency_debitnote_ex_rate_grn_currency_and_more	2023-09-14 12:41:01.677466+05:30
77	purchase	0004_alter_grnitems_grn_alter_poitems_po	2023-09-14 12:41:01.775157+05:30
78	purchase	0005_alter_debitnoteitems_debitnote_and_more	2023-09-14 12:41:01.99047+05:30
79	purchase	0006_alter_debitnote_seller_gstin_and_more	2023-09-14 12:41:02.155984+05:30
80	purchase	0007_alter_debitnote_currency_alter_grn_currency_and_more	2023-09-14 12:41:02.347723+05:30
81	purchase	0008_piitems_created	2023-09-14 12:41:02.384533+05:30
82	purchase	0009_alter_grn_options_alter_purchase_options_and_more	2023-09-14 12:41:02.631018+05:30
83	purchase	0010_alter_purchase_order_po_no	2023-09-14 12:41:02.669503+05:30
84	purchase	0011_alter_poitems_pack	2023-09-14 12:41:02.706404+05:30
85	sales	0001_initial	2023-09-14 12:41:04.190226+05:30
86	sales	0002_alter_creditnote_options_alter_delivery_note_options_and_more	2023-09-14 12:41:04.509499+05:30
87	sales	0003_invoice_channel_invoice_division	2023-09-14 12:41:04.596292+05:30
88	sales	0004_remove_rso_buyer_remove_rso_buyer_address1_and_more	2023-09-14 12:41:05.29018+05:30
89	sales	0005_alter_creditnoteitems_creditnote_alter_dnitems_dn_and_more	2023-09-14 12:41:05.704141+05:30
90	sales	0006_alter_packingsheet_dn_alter_packingsheet_item	2023-09-14 12:41:05.900425+05:30
91	sales	0007_rso_buyer_rso_buyer_address1_rso_buyer_address2_and_more	2023-09-14 12:41:06.500162+05:30
92	sales	0008_rso_is_cm	2023-09-14 12:41:06.548494+05:30
93	sales	0009_rso_rso_ref	2023-09-14 12:41:06.59607+05:30
94	sales	0010_alter_salesorder_created_alter_salesorder_updated	2023-09-14 12:41:06.713097+05:30
95	sales	0011_alter_invoice_shipto_gstin_and_more	2023-09-14 12:41:06.804456+05:30
96	sales	0012_alter_delivery_note_buyer_gstin_and_more	2023-09-14 12:41:07.066317+05:30
97	sales	0013_alter_dnitems_available_qty_alter_dnitems_mrp_and_more	2023-09-14 12:41:07.483571+05:30
98	sales	0014_salestarget	2023-09-14 12:41:07.57655+05:30
99	sales	0015_salestarget_company_salestarget_created_and_more	2023-09-14 12:41:07.830244+05:30
100	sales	0016_proformainvoice_proformainvitems	2023-09-14 12:41:07.984476+05:30
101	sales	0017_rename_customer_salestarget_buyer_and_more	2023-09-14 12:41:08.171201+05:30
102	sales	0018_alter_proformainvitems_inv	2023-09-14 12:41:08.2468+05:30
103	sales	0019_rename_destination_proformainvoice_destintaion_and_more	2023-09-14 12:41:08.340491+05:30
104	sales	0020_alter_delivery_note_buyer_address1_and_more	2023-09-14 12:41:09.951444+05:30
105	sales	0021_alter_delivery_note_shipto_pan_no	2023-09-14 12:41:10.002594+05:30
106	sales	0022_salesorder_shipto_pan_no	2023-09-14 12:41:10.150077+05:30
107	sales	0023_alter_salesorder_ref_no_alter_salesorder_so_no	2023-09-14 12:41:10.245471+05:30
108	sales	0024_alter_invoice_status_alter_proformainvoice_status	2023-09-14 12:41:10.334938+05:30
109	sales	0025_rso_ref_date	2023-09-14 12:41:10.384283+05:30
110	sales	0026_alter_rso_ref_date	2023-09-14 12:41:10.519178+05:30
111	sales	0027_alter_packingsheet_total_box_alter_rso_inv	2023-09-14 12:41:10.637083+05:30
112	sales	0028_rename_new_qty_invitems_nb_qty	2023-09-14 12:41:10.684079+05:30
113	sales	0029_invitems_nf_qty	2023-09-14 12:41:10.729359+05:30
114	sales	0030_rename_new_qty_proformainvitems_nb_qty	2023-09-14 12:41:10.771724+05:30
115	sales	0031_proformainvitems_nf_qty	2023-09-14 12:41:10.817011+05:30
116	sales	0032_rename_qdn_qty_qdn_qb_qty	2023-09-14 12:41:10.993191+05:30
117	sales	0033_qdn_qf_qty	2023-09-14 12:41:11.03478+05:30
118	sales	0034_rename_qdn_qty_qdnitems_qb_qty_and_more	2023-09-14 12:41:11.150923+05:30
119	sales	0035_qdnitems_qf_qty_rso_rf_qty_rsoitems_rf_qty	2023-09-14 12:41:11.262188+05:30
120	sales	0036_alter_rso_buyer_gst_reg_type_alter_rso_buyer_gstin	2023-09-14 12:41:11.427089+05:30
121	sales	0037_alter_invoice_carrier_agent_and_more	2023-09-14 12:41:11.757585+05:30
122	sales	0038_alter_invoice_unique_together	2023-09-14 12:41:11.810617+05:30
123	sales	0039_creditnote_mrpvalue_creditnote_omrpvalue_and_more	2023-09-14 12:41:12.121774+05:30
124	sales	0040_alter_rso_buyer_address1_alter_rso_buyer_address2_and_more	2023-09-14 12:41:12.249393+05:30
125	sales	0041_creditnoteitems_mrp_qdnitems_mrp_rsoitems_mrp	2023-09-14 12:41:12.355025+05:30
126	sales	0042_creditnote_buyer_creditnote_buyer_address1_and_more	2023-09-14 12:41:13.278886+05:30
127	sales	0043_qdn_buyer_qdn_buyer_address1_qdn_buyer_address2_and_more	2023-09-14 12:41:14.002144+05:30
128	sales	0044_rso_channel_rso_division	2023-09-14 12:41:14.093962+05:30
129	sales	0045_rename_rate_creditnoteitems_rates	2023-09-14 12:41:14.21263+05:30
130	sales	0046_rename_rate_diff_creditnoteitems_rate	2023-09-14 12:41:14.253044+05:30
131	sales	0047_rename_creditnote_creditnoteitems_inv	2023-09-14 12:41:14.29834+05:30
132	sales	0048_rename_qb_qty_qdn_bill_qty_and_more	2023-09-14 12:41:14.425284+05:30
133	sales	0049_rename_qb_qty_qdnitems_billed_qty_and_more	2023-09-14 12:41:14.60555+05:30
134	sales	0050_rename_billed_qty_rsoitems_billed_and_more	2023-09-14 12:41:14.682475+05:30
135	sales	0051_rename_rb_qty_rsoitems_billed_qty_and_more	2023-09-14 12:41:14.758026+05:30
136	sales	0052_rename_rb_qty_rso_bill_qty_and_more	2023-09-14 12:41:14.848118+05:30
137	sales	0053_alter_rso_rso_date	2023-09-14 12:41:14.906821+05:30
138	sales	0054_packingsheet_remarks_alter_packingsheet_mrp_and_more	2023-09-14 12:41:15.295601+05:30
139	sales	0055_alter_delivery_note_dn_date_alter_salesorder_so_date	2023-09-14 12:41:15.401265+05:30
140	sales	0056_alter_salesorder_unique_together	2023-09-14 12:41:15.453353+05:30
141	sales	0057_alter_salesorder_options	2023-09-14 12:41:15.59979+05:30
142	sales	0058_alter_creditnote_status_alter_qdn_status_and_more	2023-09-14 12:41:15.735797+05:30
143	sessions	0001_initial	2023-09-14 12:41:15.750162+05:30
144	warehouse	0001_initial	2023-09-14 12:41:16.130792+05:30
145	warehouse	0002_materialtransferred_created_and_more	2023-09-14 12:41:16.454137+05:30
146	warehouse	0003_alter_stock_summary_batch	2023-09-14 12:41:16.517146+05:30
147	warehouse	0004_pallettransferentry	2023-09-14 12:41:16.597693+05:30
148	warehouse	0005_pallettransferentry_company	2023-09-14 12:41:16.684723+05:30
149	warehouse	0006_alter_stock_summary_closing_balance	2023-09-14 12:41:16.846463+05:30
150	warehouse	0007_shortagedamageentry_company_and_more	2023-09-14 12:41:16.982082+05:30
151	todo	0001_initial	2023-09-15 09:54:35.075392+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
p0prxp7gl0qnztl8vwku4137qxbub433	eyJza2V5Ijp7fX0:1qRQnR:TFbnh57mMYuaHufJ45WhHip8_GCBM_561KFws6eq3i4	2023-08-17 10:52:49.178+05:30
vjt8d4i5nvga5xd11kdwtu055kj3h4co	eyJza2V5Ijp7fX0:1qaaMo:I61I_bkiVIJaloeYgTs53YFVN4tp3wp2WtBZXUWi9i0	2023-09-11 16:55:10.23+05:30
vfxkv6ps5zp2uutsv1ivaq7bnvhoil5l	.eJxVjDEOgzAMRe_iuYpIoEnM2L1nQDG2C6UCicBQIe7eIrGw_vfe3yAP8oV622_QpHXpmjXL3PQMNTi4bJTaQcYD8DuNr8m007jMPZlDMSfN5jmxfB6neznoUu7-dSWxFCkiq1BkJC1cUXqn4h3GEAQDqfXOEaK9I1kJHK0GrTR5xkph_wFFcDuR:1qiCDm:6Tr2Vwf8bPZ0-1eXgrZC3_QWK8djzrPEktreEdv6m4I	2023-10-02 16:45:18.756032+05:30
\.


--
-- Data for Name: inventory_brand; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_brand (id, under, name, code, created, updated) FROM stdin;
1	Primary	Neti	1122	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_category; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_category (id, under, name, code, created, updated) FROM stdin;
1	Primary	IT	\N	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_class; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_class (id, name, code, created, updated) FROM stdin;
1	Class 1	\N	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_currency; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_currency (id, name, code, symbol, created, updated) FROM stdin;
1	Indian Rupees	001	INR	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_godown; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_godown (id, godown_type, name, parent_id, created, updated) FROM stdin;
1	f	DAMAGE & SCRAP	1	2023-07-28	2023-09-13
2	t	PRODUCTION	2	2023-07-28	2023-09-05
4	t	New1231	2	2023-08-02	2023-08-02
5	f	UN ALLOCATED	5	2023-09-05	2023-09-13
6	f	ALLOCATED	6	2023-09-05	2023-09-13
7	t	SHORTAGE	7	2023-09-13	2023-09-13
\.


--
-- Data for Name: inventory_gst_list; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_gst_list (id, applicable_from, discription, hsncode, "is_Non_gst", calc_type, taxability, reverse_charge, input_credit_ineligible, cgstrate, sgstrate, igstrate, suply_type, product_id, created, updated) FROM stdin;
\.


--
-- Data for Name: inventory_product_master; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_product_master (id, product_name, product_code, description, notes, is_saleable, is_batch, track_dom, exp_date, bill_of_material, set_std_rate, costing_method, valuation_method, article_code, ean_code, old_product_code, mrp, gst, hsn, opening_balance, shape_code, size, style_shape, series, pattern, country_of_origin, color_shade_theme, inner_qty, outer_qty, imported_by, mfd_by, mkt_by, product_portfolio, isgstapplicable, behaviour, ipd, ins, tsm, tpc, trs, additional_units_id, brand_id, category_id, dl_purchase_id, dl_sales_id, product_class_id, product_type_id, sub_brand_id, sub_class_id, units_of_measure_id, created, updated) FROM stdin;
1	Finished Good	FG1	Finished Good	\N	f	f	f	f	f	f	1	1	5112210001		None	100.00	0.00	\N	\N								10.00	5.00				\N	t	f	f	f	f	f	f	1	1	1	1	1	1	1	1	1	1	2023-07-28	2023-09-05
2	RAW1	RAW1	raw material	\N	f	f	f	f	f	f	1	1	5112210002	EAB123	None	345.00	0.00	\N	\N	123	123	34	45	56	34	234	12.00	1.00	34	435	Sk	\N	t	f	f	f	f	f	f	1	1	1	1	1	1	2	1	1	1	2023-09-05	2023-09-05
3	RAW2	RAW2	asdsad	\N	f	f	f	f	f	f	1	1	5112210003	EAZN12	None	0.00	0.00	\N	\N								123.00	123.00				\N	t	f	f	f	f	f	f	\N	1	1	1	1	1	2	1	1	1	2023-09-05	2023-09-05
4	New FG 	NFG	New FG 	\N	f	f	f	f	f	f	1	1	5112210004		None	1000.00	0.00	\N	\N								0.00	0.00				\N	t	f	f	f	f	f	f	1	1	1	1	1	1	2	1	1	1	2023-09-12	2023-09-12
5	New FG 2	NFG2	New FG 2	\N	f	f	f	f	f	f	1	1	5112210005		None	0.00	0.00	\N	\N								1000.00	1000.00				\N	t	f	f	f	f	f	f	1	1	1	1	1	1	1	1	1	1	2023-09-12	2023-09-12
\.


--
-- Data for Name: inventory_producttype; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_producttype (id, name, code, created, updated, dl_purchase_id, dl_sales_id) FROM stdin;
1	IB	\N	2023-07-28	2023-07-28	1	1
2	FINISHED GOODS	\N	2023-07-28	2023-09-13	1	1
\.


--
-- Data for Name: inventory_scheme; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_scheme (id, name, created, updated) FROM stdin;
\.


--
-- Data for Name: inventory_std_rate; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_std_rate (id, rate_type, applicable_from, rate, uom, product_id, created, updated) FROM stdin;
1	1	2023-08-02	1.00	Demo	1	2023-08-02	2023-08-02
2	1	2023-09-05	10.00	Demo	2	2023-09-05	2023-09-05
3	1	2023-09-05	12.00	Demo	3	2023-09-05	2023-09-05
4	1	2023-09-12	1.00	Demo	5	2023-09-12	2023-09-12
\.


--
-- Data for Name: inventory_subbrand; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_subbrand (id, name, code, created, updated) FROM stdin;
1	Neti - Sub	\N	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_subclass; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_subclass (id, name, code, created, updated) FROM stdin;
1	Sub Class 1	\N	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_unitofmeasure; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_unitofmeasure (id, uom_type, symbol, name, decimal_places, uqc_id, created, updated) FROM stdin;
1	\N	Demo	Demo	2	1	2023-07-28	2023-07-28
\.


--
-- Data for Name: inventory_uqc; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.inventory_uqc (id, name, created, updated) FROM stdin;
1	BAG-BAGS	2023-03-03	2023-03-03
2	BAL-BALE	2023-03-03	2023-03-03
3	BDL-BUNDLES	2023-03-03	2023-03-03
4	BKL-BUCKLES	2023-03-03	2023-03-03
5	BOU-BILLION OF UNITS	2023-03-03	2023-03-03
6	BOX-BOX	2023-03-03	2023-03-03
7	BTL-BOTTLES	2023-03-03	2023-03-03
8	BUN-BUNCHES	2023-03-03	2023-03-03
9	CAN-CANS	2023-03-03	2023-03-03
10	CBM-CUBIC METERS	2023-03-03	2023-03-03
11	CCM-CUBIC CENTIMETERS	2023-03-03	2023-03-03
12	CMS-CENTIMETERS	2023-03-03	2023-03-03
13	CTN-CARTONS	2023-03-03	2023-03-03
14	DOZ-DOZENS	2023-03-03	2023-03-03
15	DRM-DRUMS	2023-03-03	2023-03-03
16	GGK-GREAT GROSS	2023-03-03	2023-03-03
17	GMS-GRAMMES	2023-03-03	2023-03-03
18	GRS-GROSS	2023-03-03	2023-03-03
19	GYD-GROSS YARDS	2023-03-03	2023-03-03
20	KGS-KILOGRAMS	2023-03-03	2023-03-03
21	KLR-KILOLITRE	2023-03-03	2023-03-03
22	KME-KILOMETRE	2023-03-03	2023-03-03
23	MLT-MILILITRE	2023-03-03	2023-03-03
24	MTR-METERS	2023-03-03	2023-03-03
25	MTS-METRIC TON	2023-03-03	2023-03-03
26	NOS-NUMBERS	2023-03-03	2023-03-03
27	PAC-PACKS	2023-03-03	2023-03-03
28	PCS-PIECES	2023-03-03	2023-03-03
29	PRS-PAIRS	2023-03-03	2023-03-03
30	QTL-QUINTAL	2023-03-03	2023-03-03
31	ROL-ROLLS	2023-03-03	2023-03-03
32	SET-SETS	2023-03-03	2023-03-03
33	SQF-SQUARE FEET	2023-03-03	2023-03-03
34	SQM-SQUARE METERS	2023-03-03	2023-03-03
35	SQY-SQUARE YARDS	2023-03-03	2023-03-03
36	TBS-TABLETS	2023-03-03	2023-03-03
37	TGM-TEN GROSS	2023-03-03	2023-03-03
38	THD-THOUSANDS	2023-03-03	2023-03-03
39	TON-TONNES	2023-03-03	2023-03-03
40	TUB-TUBES	2023-03-03	2023-03-03
41	UGS-US GALLONS	2023-03-03	2023-03-03
42	UNT-UNITS	2023-03-03	2023-03-03
43	YDS-YARDS	2023-03-03	2023-03-03
44	OTH-OTHERS	2023-03-03	2023-03-03
\.


--
-- Data for Name: ledgers_asm; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_asm (id, name, region_id, rsm_id, zone_id, zsm_id, created, updated) FROM stdin;
1	Sales Executive 1	4	1	5	1	2023-07-28	2023-07-28
2	Sales Executive 2	3	2	5	1	2023-07-28	2023-07-28
3	Sales Executive 1	6	3	3	2	2023-07-28	2023-07-28
4	Sales Executive 3	5	6	3	2	2023-07-28	2023-07-28
5	Sales Executive 4	1	5	6	3	2023-07-28	2023-07-28
6	Sales Executive 5	2	7	6	3	2023-07-28	2023-07-28
7	Sales Executive 6	9	10	2	5	2023-07-28	2023-07-28
8	Sales Executive 7	10	11	2	5	2023-07-28	2023-07-28
9	Sales Executive 7	11	12	4	6	2023-07-28	2023-07-28
10	Sales Executive 8	12	13	4	6	2023-07-28	2023-07-28
11	Sales Executive 9	5	4	3	2	2023-07-28	2023-07-28
12	Sales Executive 10	7	8	1	4	2023-07-28	2023-07-28
13	Sales Executive 11	7	8	1	4	2023-07-28	2023-07-28
14	Sales Executive 12	8	9	1	4	2023-07-28	2023-07-28
\.


--
-- Data for Name: ledgers_city; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_city (id, created, updated, name, state_id) FROM stdin;
1	2023-07-28	2023-07-28	Vadodara	1
2	2023-07-28	2023-07-28	New York City	5
3	2023-07-28	2023-07-28	Ahmedabad	1
4	2023-07-28	2023-07-28	Mumbai	2
5	2023-07-28	2023-07-28	Pune	2
6	2023-07-28	2023-07-28	NYC1	5
7	2023-07-28	2023-07-28	NJC	6
8	2023-07-28	2023-07-28	Melburn	7
9	2023-07-28	2023-07-28	Victencia	8
10	2023-07-28	2023-07-28	London	3
11	2023-07-28	2023-07-28	Amsterdam	4
\.


--
-- Data for Name: ledgers_country; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_country (id, created, updated, name) FROM stdin;
1	2023-07-28	2023-07-28	India
2	2023-07-28	2023-07-28	England
3	2023-07-28	2023-07-28	USA
4	2023-07-28	2023-07-28	Australia
\.


--
-- Data for Name: ledgers_currency; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_currency (id, code, name, created, updated) FROM stdin;
\.


--
-- Data for Name: ledgers_division; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_division (id, created, updated, name) FROM stdin;
1	2023-07-28	2023-09-12	division
2	2023-07-28	2023-07-28	Division 2
3	2023-08-02	2023-08-02	Manual
4	2023-09-13	2023-09-13	ECOM
\.


--
-- Data for Name: ledgers_group; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_group (id, name, created, updated) FROM stdin;
1	Sundry Debtors	2023-03-03	2023-03-03
2	Sundry Creditors	2023-03-03	2023-03-03
3	Sales Accounts	2023-03-03	2023-03-03
4	Purchase Accounts	2023-03-03	2023-03-03
5	Direct Income	2023-03-03	2023-03-03
6	Direct Expense	2023-03-03	2023-03-03
\.


--
-- Data for Name: ledgers_ledgerstype; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_ledgerstype (id, name, gst_applicable, type_of_supply, under_id, created, updated) FROM stdin;
1	GST SALES A/C	1	1	3	2023-03-03	2023-03-03
2	FIXED ASSETS SALES A/C	1	1	3	2023-03-03	2023-03-03
3	MISC SALES A/C	1	1	3	2023-03-03	2023-03-03
4	PM SALES A/C	1	1	3	2023-03-03	2023-03-03
6	RM SALES A/C	1	1	3	2023-03-03	2023-03-03
7	GST PURCHASE A/C	1	1	4	2023-03-03	2023-03-03
8	FIXED ASSETS PURCHASE A/C	1	1	4	2023-03-03	2023-03-03
9	MISC PURCHASE A/C	1	1	4	2023-03-03	2023-03-03
10	PM PURCHASE A/C	1	1	4	2023-03-03	2023-03-03
12	RM PURCHASE A/C	1	1	4	2023-03-03	2023-03-03
13	Inward Freight	1	2	6	2023-03-03	2023-03-03
\.


--
-- Data for Name: ledgers_party_contact_details; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_party_contact_details (id, created, updated, address_type, mailing_name, addressline1, addressline2, addressline3, country_id, state_id, city_id, pin_code, contact_person, phone_no, mobile_no, fax_no, email_id, pan_no, gst_registration_type, gstin, party_id) FROM stdin;
\.


--
-- Data for Name: ledgers_party_master; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_party_master (id, created, updated, name, maintain_bill_by_bill, dafault_credit_period, check_credit_days, credit_limit, closing_balance, override_credit_limit, payment_terms, allow_loose_packing, istcsapplicable, vendor_code, mailing_name, addressline1, addressline2, addressline3, pin_code, mobile_no, contact_details, contact_person, phone_no, fax_no, email_id, cc_email, website, multiple_address_list, gst_registration_type, gstin, pan_no, transation_type, bank, ifsc_code, account_no, account_name, asm_id, city_id, country_id, devision_id, group_id, party_type_id, price_level_id, region_id, rsm_id, se_id, state_id, zone_id, zsm_id, is_transporter) FROM stdin;
1	2023-07-28	2023-07-28	Customer Name	f	30	t	300000	\N	f	30	t	f	200001	Customer Name	Address Line1	Address Line2	Address Line3	390001	7698552641	f	Contact Person	\N	\N	Demo@neti.com			f	Consumer		AAPOS1478Q						1	1	1	4	1	1	1	4	1	1	1	5	1	f
2	2023-07-28	2023-07-28	Customer Name 2	f	30	t	500000	\N	f	30	t	f	200003	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	7565412581	f	Contact Person 2	\N	\N	Email@neti.com			f	Unknown	XXAAPOD1234Z	AAPOD1234Z						9	4	1	1	1	2	3	11	12	13	2	4	6	f
3	2023-08-02	2023-08-02	Demo	t	30	t	\N	\N	f	\N	t	f	400001	Demo	Demo	Demo	Demo	392154	1236547897	f	Demo	\N	\N	Demo@neti.com			f	Regular	XXDemos1234D	Demos1234D	\N					\N	3	1	1	2	3	5	\N	\N	\N	1	4	\N	f
4	2023-08-02	2023-09-13	ABCD	f	30	t	\N	\N	f	\N	t	f	400002	ABCD	ABC	ABC	ABC	392220	3216547892	f	Vendor	\N	\N	Vendor@domain.com			f	Regular	AAAAAAA0258A	AAAAA0258A						\N	5	1	3	2	3	5	\N	\N	\N	2	4	\N	f
5	2023-08-02	2023-08-02	Cm3	f	30	t	500000	\N	f	30	t	f	200004	CM3	Cm3	Cm3	Cm3	321456	3652147895	f	Cm3	\N	\N	Cm3@g.com			f	Consumer	asdsasda152ad	asdsas1a	\N					6	11	2	3	1	2	5	2	7	7	4	6	3	f
6	2023-09-13	2023-09-13	ABCD	f	30	t	50000	\N	f	40	t	f	200005	ABCD	ABC	ABC	ABC	390002	3595868745	f		\N	\N	abc@xyz.com			f	Unknown	12AYRFG125I	IIABC1245K						3	1	1	4	1	1	3	6	3	3	1	3	2	f
7	2023-09-15	2023-09-15	XYZ	f	30	t	50000	\N	f	30	t	f	200006	XYZ	XYZ	XYZ	XYZ	390002	8541457856	f		\N	\N	XYZ@XYZ.com			f	Unknown	AVIIADV125L	IIADV125L	\N					1	1	1	1	1	3	5	4	1	1	1	5	1	f
9	2023-09-15	2023-09-15	XYZ	t	30	t	\N	\N	f	\N	t	f	400003	XYZ	XYZ	XYZ	XYZ	390002	8541457856	f		\N	\N	XYZ@XYZ.com			f	Unknown	AVIIADV125L	IIADV125L	\N					\N	1	1	1	2	3	5	\N	\N	\N	1	5	\N	f
11	2023-09-15	2023-09-15	ABC	f	30	t	100000	\N	f	30	t	f	200007	ABC	ABC	ABC	ABC	154782	5689784512	f		\N	\N	ABC@ABC.com			f	Unknown	AAAAAAA123A	AAAAA123A	\N					10	5	1	1	1	1	5	12	13	14	2	4	6	f
12	2023-09-15	2023-09-15	ABC	t	30	t	\N	\N	f	\N	t	f	400004	ABC	ABC	ABC	ABC	154782	5689784512	f		\N	\N	ABC@ABC.com			f	Unknown	AAAAAAA123A	AAAAA123A	\N					\N	5	1	1	2	3	5	\N	\N	\N	2	4	\N	f
\.


--
-- Data for Name: ledgers_party_master_products; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_party_master_products (id, party_master_id, product_master_id) FROM stdin;
\.


--
-- Data for Name: ledgers_partytype; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_partytype (id, code, name, created, updated) FROM stdin;
1	\N	Channel 1	2023-07-28	2023-07-28
2	\N	Channel 2	2023-07-28	2023-07-28
3	\N	IB	2023-08-02	2023-08-02
\.


--
-- Data for Name: ledgers_price_level; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_price_level (id, created, updated, name, code) FROM stdin;
1	2023-07-28	2023-07-28	5%	\N
2	2023-07-28	2023-07-28	15%	\N
3	2023-07-28	2023-07-28	10%	\N
4	2023-07-28	2023-07-28	20%	\N
5	2023-08-02	2023-08-02	Manual	\N
\.


--
-- Data for Name: ledgers_price_list; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_price_list (id, created, updated, applicable_from, rate, price_level_id, product_id) FROM stdin;
1	2023-08-02	2023-08-09	2023-08-09	100.00	5	1
2	2023-09-05	2023-09-05	2023-09-05	100.00	1	1
3	2023-09-12	2023-09-12	2023-09-12	1000.00	1	4
4	2023-09-12	2023-09-12	2023-09-12	1000.00	5	4
5	2023-09-13	2023-09-13	2023-09-13	100.00	5	2
6	2023-09-13	2023-09-13	2023-09-13	90.00	3	2
\.


--
-- Data for Name: ledgers_region; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_region (id, name, zone_id, created, updated) FROM stdin;
1	Arunachal Pradesh	6	2023-07-28	2023-07-28
2	Jharkhand	6	2023-07-28	2023-07-28
3	Madhya Pradesh	5	2023-07-28	2023-07-28
4	Chhattisgarh	5	2023-07-28	2023-07-28
5	West Bengal	3	2023-07-28	2023-07-28
6	Bihar	3	2023-07-28	2023-07-28
7	Awadh	1	2023-07-28	2023-07-28
8	Ladakh	1	2023-07-28	2023-07-28
9	Bangalore	2	2023-07-28	2023-07-28
10	Chennai	2	2023-07-28	2023-07-28
11	Gujarat	4	2023-07-28	2023-07-28
12	Mumbai	4	2023-07-28	2023-07-28
\.


--
-- Data for Name: ledgers_rsm; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_rsm (id, name, region_id, zone_id, zsm_id, created, updated) FROM stdin;
1	RSM 1	4	5	1	2023-07-28	2023-07-28
2	RSM 2	3	5	1	2023-07-28	2023-07-28
3	RSM 1	6	3	2	2023-07-28	2023-07-28
4	RSM 2	5	3	2	2023-07-28	2023-07-28
5	RSM 1	1	6	3	2023-07-28	2023-07-28
6	RSM 3	5	3	2	2023-07-28	2023-07-28
7	RSM 1	2	6	3	2023-07-28	2023-07-28
8	RSM 1	7	1	4	2023-07-28	2023-07-28
9	RSM 2	8	1	4	2023-07-28	2023-07-28
10	RSM 1	9	2	5	2023-07-28	2023-07-28
11	RSM 2	10	2	5	2023-07-28	2023-07-28
12	RSM 1	11	4	6	2023-07-28	2023-07-28
13	RSM 2	12	4	6	2023-07-28	2023-07-28
\.


--
-- Data for Name: ledgers_se; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_se (id, name, asm_id, region_id, rsm_id, zone_id, zsm_id, created, updated) FROM stdin;
1	Sales person 1	1	4	1	5	1	2023-07-28	2023-07-28
2	Sales person 2	2	3	2	5	1	2023-07-28	2023-07-28
3	Sales person 3	3	6	3	3	2	2023-07-28	2023-07-28
4	Sales person 4	4	5	6	3	2	2023-07-28	2023-07-28
5	Sales person 5	11	5	4	3	2	2023-07-28	2023-07-28
6	Sales person 6	5	1	5	6	3	2023-07-28	2023-07-28
7	Sales person 7	6	2	7	6	3	2023-07-28	2023-07-28
8	Sales person 7	12	7	8	1	4	2023-07-28	2023-07-28
9	Sales person 8	14	8	9	1	4	2023-07-28	2023-07-28
10	Sales person 9	14	8	9	1	4	2023-07-28	2023-07-28
11	Sales person 10	7	9	10	2	5	2023-07-28	2023-07-28
12	Sales person 11	8	10	11	2	5	2023-07-28	2023-07-28
13	Sales person 13	9	11	12	4	6	2023-07-28	2023-07-28
14	Sales person 14	10	12	13	4	6	2023-07-28	2023-07-28
\.


--
-- Data for Name: ledgers_state; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_state (id, created, updated, name, country_id) FROM stdin;
1	2023-07-28	2023-07-28	Gujarat-1	1
2	2023-07-28	2023-07-28	Maharashtra	1
3	2023-07-28	2023-07-28	London	2
4	2023-07-28	2023-07-28	Amsterdam	2
5	2023-07-28	2023-07-28	New York	3
6	2023-07-28	2023-07-28	New Jersey	3
7	2023-07-28	2023-07-28	Sydney	4
8	2023-07-28	2023-07-28	Victoria	4
\.


--
-- Data for Name: ledgers_zone; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_zone (id, name, created, updated) FROM stdin;
1	North Zone	2023-07-28	2023-07-28
2	South Zone	2023-07-28	2023-07-28
3	East Zone	2023-07-28	2023-07-28
4	West Zone	2023-07-28	2023-07-28
5	Central Zone	2023-07-28	2023-07-28
6	North East Zone	2023-07-28	2023-07-28
\.


--
-- Data for Name: ledgers_zsm; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.ledgers_zsm (id, name, zone_id, created, updated) FROM stdin;
1	ZSM 1	5	2023-07-28	2023-07-28
2	ZSM 2	3	2023-07-28	2023-07-28
3	ZSM 3	6	2023-07-28	2023-07-28
4	ZSM 4	1	2023-07-28	2023-07-28
5	ZSM 5	2	2023-07-28	2023-07-28
6	ZSM 6	4	2023-07-28	2023-07-28
\.


--
-- Data for Name: planning_bom; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.planning_bom (id, name, description, last_date, product_id, created, updated) FROM stdin;
1	BOM FG1	 Description	\N	1	2023-07-28	2023-09-05
2	Description	 Description	\N	1	2023-09-12	2023-09-12
3	NFG	 NFG	\N	4	2023-09-12	2023-09-12
\.


--
-- Data for Name: planning_bomitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.planning_bomitems (id, qty, bom_id, item_id) FROM stdin;
4	10.0000	1	2
5	20.0000	1	3
6	100.0000	2	1
7	200.0000	2	2
12	1000.0000	3	2
13	2000.0000	3	5
\.


--
-- Data for Name: planning_joborder; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.planning_joborder (id, created, updated, no, name, qty, remain_qty, date, due_date, ref, details, category, issuedby, remarks, status, bom_id, company_id, product_id) FROM stdin;
1	2023-07-28 16:18:28.352+05:30	2023-08-02 11:51:49.572+05:30	2223JO00001	Job Name	50.0000	39.0000	2023-07-28	2023-07-31		Job Details	Job Category	admin	Special Instructions	2	1	1	1
2	2023-09-05 16:36:16.296+05:30	2023-09-05 16:37:05.528+05:30	2223JO00002	job fg1	10.0000	0.0000	2023-09-05	2023-09-12		job fg1	fg1	admin	fg1	3	1	1	1
3	2023-09-05 16:38:24.96+05:30	2023-09-05 16:41:42.915+05:30	2223JO00003	job 2	10.0000	0.0000	2023-09-05	2023-09-09		job 1	job	admin	sad	3	1	1	1
4	2023-09-05 16:42:10.474+05:30	2023-09-05 17:00:22.674+05:30	2223JO00004	asd	10.0000	0.0000	2023-09-05	2023-09-02		asd	asd	admin	sad	3	1	1	1
5	2023-09-05 17:07:37.697+05:30	2023-09-05 17:08:04.934+05:30	2223JO00005	final job	15.0000	3.0000	2023-09-05	2023-09-07		final jopob	final job	admin	sp inst	2	1	1	1
6	2023-09-12 10:22:22.003+05:30	2023-09-12 10:26:21.159+05:30	2223JO00006	Final Job RM FG1	10.0000	5.0000	2023-09-12	2023-09-13		Final Job RM FG1	Final Job RM FG1	admin	NA	2	1	1	1
7	2023-09-12 11:34:41.611+05:30	2023-09-12 12:03:36.488+05:30	2223JO00007	NFG JO	1.0000	0.0000	2023-09-12	2023-09-13		NFG JO	NFG JO	admin	NFG JO	3	3	1	4
\.


--
-- Data for Name: planning_salesprojection; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.planning_salesprojection (id, created, updated, p_qty, a_qty, from_date, to_date, division_id, product_id) FROM stdin;
\.


--
-- Data for Name: production_consitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_consitems (id, qty, con_qty, indent_id, item_id) FROM stdin;
1	80.0000	80.0000	1	2
\.


--
-- Data for Name: production_consumableindent; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_consumableindent (id, created, updated, no, qty, company_id, drawn_by_id, issuer_id) FROM stdin;
1	2023-09-05 17:10:37.432+05:30	2023-09-05 17:10:37.496+05:30	CSM00001	80.0000	1	2	2
\.


--
-- Data for Name: production_consumption; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_consumption (id, created, updated, no, date, company_id, jobcard_id, qty) FROM stdin;
1	2023-09-05 17:05:34.801+05:30	2023-09-05 17:05:34.801+05:30	PRD00001	2023-09-05	1	5	5.0000
2	2023-09-05 17:06:27.011+05:30	2023-09-05 17:06:27.011+05:30	PRD00002	2023-09-05	1	5	3.0000
3	2023-09-05 17:12:13.092+05:30	2023-09-05 17:12:13.092+05:30	PRD00003	2023-09-05	1	6	12.0000
4	2023-09-05 17:12:52.278+05:30	2023-09-05 17:12:52.278+05:30	PRD00004	2023-09-05	1	5	2.0000
5	2023-09-12 14:04:06.005+05:30	2023-09-12 14:04:06.005+05:30	PRD00005	2023-09-12	1	8	1.0000
6	2023-09-12 14:11:58.084+05:30	2023-09-12 14:11:58.084+05:30	PRD00006	2023-09-12	1	2	1.0000
\.


--
-- Data for Name: production_consumptionitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_consumptionitems (id, rate, mrp, batch, qty, consumption_id, item_id) FROM stdin;
1	120.00		20230905003001	50.0000	1	2
2	132.00		20230905003002	100.0000	1	3
3	120.00		20230905003001	30.0000	2	2
4	132.00		20230905003002	60.0000	2	3
5	120.00		20230905003001	60.0000	3	2
6	120.00		20230905003001	120.0000	3	2
7	132.00		20230905003002	240.0000	3	3
8	120.00	345.00	20230905003001	20.0000	4	2
9	132.00		20230905003002	40.0000	4	3
10	120.00		20230905003001	100.0000	5	2
11	1.00	345.00	20230912003001	1000.0000	5	2
12	1.00	0.00	20230912004001	2000.0000	5	5
13	1.00		20230912003001	10.0000	6	2
14	1.00		20230912003001	10.0000	6	2
15	1.00	0.00	20230912005001	20.0000	6	3
\.


--
-- Data for Name: production_jobcard; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_jobcard (id, created, updated, no, qty, start, company_id, joborder_id, product_id, rqty, status) FROM stdin;
1	2023-07-28 16:20:59.841+05:30	2023-07-28 16:20:59.841+05:30	2223JC00001	10.0000	2023-07-31	1	1	1	10.0000	1
2	2023-08-02 11:51:49.535+05:30	2023-09-12 14:11:58.079+05:30	2223JC00002	1.0000	2023-08-31	1	1	1	0.0000	1
3	2023-09-05 16:37:05.477+05:30	2023-09-05 16:37:05.543+05:30	2223JC00003	10.0000	2023-09-05	1	2	1	10.0000	4
4	2023-09-05 16:41:42.863+05:30	2023-09-05 16:41:42.93+05:30	2223JC00004	10.0000	2023-09-01	1	3	1	10.0000	4
5	2023-09-05 17:00:22.62+05:30	2023-09-05 17:12:52.271+05:30	2223JC00005	10.0000	2023-09-09	1	4	1	0.0000	4
6	2023-09-05 17:08:04.883+05:30	2023-09-05 17:12:13.087+05:30	2223JC00006	12.0000	2023-09-08	1	5	1	0.0000	1
7	2023-09-12 10:26:21.106+05:30	2023-09-12 10:26:21.106+05:30	2223JC00007	5.0000	2023-09-13	1	6	1	5.0000	1
8	2023-09-12 12:03:36.437+05:30	2023-09-12 14:04:06.001+05:30	2223JC00008	1.0000	2023-09-13	1	7	4	0.0000	4
\.


--
-- Data for Name: production_rmindent; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_rmindent (id, created, updated, no, status, company_id, jobcard_id) FROM stdin;
1	2023-07-28 16:20:59.854+05:30	2023-08-02 11:47:13.923+05:30	2223JC00001	3	1	1
2	2023-08-02 11:51:49.546+05:30	2023-08-02 11:52:05.064+05:30	2223JC00002	3	1	2
3	2023-09-05 16:37:05.49+05:30	2023-09-05 16:37:05.49+05:30	2223JC00003	1	1	3
4	2023-09-05 16:41:42.876+05:30	2023-09-05 16:41:42.876+05:30	2223JC00004	1	1	4
5	2023-09-05 17:00:22.633+05:30	2023-09-05 17:03:13.489+05:30	2223JC00005	3	1	5
6	2023-09-05 17:08:04.895+05:30	2023-09-05 17:09:31.924+05:30	2223JC00006	3	1	6
7	2023-09-12 10:26:21.119+05:30	2023-09-12 10:26:21.119+05:30	2223JC00007	1	1	7
8	2023-09-12 12:03:36.45+05:30	2023-09-12 12:04:23.226+05:30	2223JC00008	3	1	8
\.


--
-- Data for Name: production_rmindentitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_rmindentitems (id, qty, bom_id, item_id, rmindent_id) FROM stdin;
1	1000.0000	1	1	1
2	100.0000	1	1	2
3	100.0000	1	2	3
4	200.0000	1	3	3
5	100.0000	1	2	4
6	200.0000	1	3	4
7	100.0000	1	2	5
8	200.0000	1	3	5
9	120.0000	1	2	6
10	240.0000	1	3	6
11	50.0000	1	2	7
12	100.0000	1	3	7
13	1000.0000	3	2	8
14	2000.0000	3	5	8
\.


--
-- Data for Name: production_rmitemgodown; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.production_rmitemgodown (id, rate, mrp, batch, godown, qty, rmitem_id, created, updated) FROM stdin;
1	120.00		20230905003001	New1231	100.00	7	2023-09-05	2023-09-05
2	132.00		20230905003002	New1231	200.00	8	2023-09-05	2023-09-05
3	120.00		20230905003001	New1231	120.00	9	2023-09-05	2023-09-05
4	132.00		20230905003002	New1231	240.00	10	2023-09-05	2023-09-05
5	120.00		20230905003001	New1231	200.00	13	2023-09-12	2023-09-12
6	1.00		20230912002002	PRODUCTION	100.00	13	2023-09-12	2023-09-12
7	1.00		20230912003001	PRODUCTION	700.00	13	2023-09-12	2023-09-12
8	1.00		20230912002001	PRODUCTION	100.00	14	2023-09-12	2023-09-12
9	1.00		20230912003002	PRODUCTION	1500.00	14	2023-09-12	2023-09-12
10	1.00		20230912004001	PRODUCTION	400.00	14	2023-09-12	2023-09-12
\.


--
-- Data for Name: purchase_debitnote; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_debitnote (id, status, created, updated, db_no, db_date, seller_address_type, seller_gst_reg_type, seller_state, seller_country, seller_city, seller_mailingname, seller_address1, seller_address2, seller_address3, seller_pincode, seller_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, mode_of_payment, other_reference, terms_of_delivery, dispatch_through, destination, narration, ammount, cgst, sgst, igst, tcs, ol_rate, round_off, total, company_id, pi_no_id, seller_id, shipto_id, currency, ex_rate) FROM stdin;
1	1	2023-08-09 10:18:49.366+05:30	2023-08-09 10:18:49.386+05:30	2223DB00001	2023-08-09	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8			\N		1	\N		0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1	1	4	1	INR	1.00
\.


--
-- Data for Name: purchase_debitnoteitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_debitnoteitems (id, product_code, batch, pack, mrp, actual_qty, actual_rate, rate_diff, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, "debitNote_id", item_id) FROM stdin;
\.


--
-- Data for Name: purchase_grn; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_grn (id, status, created, updated, grn_no, grn_date, seller_address_type, seller_gst_reg_type, seller_state, seller_country, seller_city, seller_mailingname, seller_address1, seller_address2, seller_address3, seller_pincode, seller_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, ammount, cgst, sgst, igst, tcs, other, round_off, total, narration, mode_of_payment, other_reference, terms_of_delivery, dispatch_through, destintaion, company_id, other_ledger_id, pi_id, po_id, seller_id, shipto_id, currency, ex_rate) FROM stdin;
1	3	2023-08-09 10:15:52.855+05:30	2023-08-09 14:02:11.034+05:30	2223GRN00001	2023-08-09	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	0.00	2.50	2.50	5.00	0.00	100.00	0.00	105.00					1	\N	1	\N	1	1	4	1	001	1.00
2	1	2023-09-05 16:53:37.966+05:30	2023-09-05 16:53:37.966+05:30	2223GRN00002	2023-09-05	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00					0	\N	1	\N	\N	3	4	1	001	12.00
3	1	2023-09-05 16:54:18.877+05:30	2023-09-05 16:54:18.96+05:30	2223GRN00003	2023-09-05	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	16000.00	0.00	0.00	0.00	0.00	0.00	0.00	16000.00					0	\N	1	\N	\N	3	4	1	001	12.00
4	3	2023-09-12 11:53:52.49+05:30	2023-09-12 11:54:35.102+05:30	2223GRN00004	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	200.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00					0	\N	1	\N	2	4	4	1	001	2.00
5	3	2023-09-12 12:00:28.542+05:30	2023-09-12 12:00:48.288+05:30	2223GRN00005	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	3000.00	0.00	0.00	0.00	0.00	0.00	0.00	3000.00					0	\N	1	\N	3	5	4	1	001	1.00
6	3	2023-09-12 12:02:37.946+05:30	2023-09-12 12:03:00.117+05:30	2223GRN00006	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	500.00	0.00	0.00	0.00	0.00	0.00	0.00	500.00					0	\N	1	\N	4	6	4	1	001	1.00
7	3	2023-09-12 14:09:17.527+05:30	2023-09-12 14:09:47.268+05:30	2223GRN00007	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	100.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00					0	\N	1	\N	5	7	4	1	001	1.00
\.


--
-- Data for Name: purchase_grnitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_grnitems (id, product_code, batch, pack, mrp, actual_qty, recd_qty, rate, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, grn_id, item_id) FROM stdin;
1	RAW1	20230905003001	1.00	345.00	0.00	500.00	10.00	0.00	0.00	0.00	0.00	0.00	0.00	5000.00	3	2
2	RAW2	20230905003002	123.00	0.00	0.00	1000.00	11.00	0.00	0.00	0.00	0.00	0.00	0.00	11000.00	3	3
3	NFG2	20230912002001	1000.00	0.00	0.00	100.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	4	5
4	RAW1	20230912002002	1.00	345.00	0.00	100.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	4	2
5	RAW1	20230912003001	1.00	345.00	0.00	1500.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	5	2
6	NFG2	20230912003002	1000.00	0.00	0.00	1500.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	5	5
7	NFG2	20230912004001	1000.00	0.00	0.00	500.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	500.00	6	5
8	RAW2	20230912005001	123.00	0.00	0.00	100.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	7	3
\.


--
-- Data for Name: purchase_grnitems_godown; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_grnitems_godown (id, grnitems_id, godown_id) FROM stdin;
\.


--
-- Data for Name: purchase_piitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_piitems (id, product_code, batch, pack, mrp, basic_qty, recd_qty, rate, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, grn_id, item_id, pi_id, created) FROM stdin;
1	NFG2	20230912002001	1000.00	0.00	0.00	100.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	4	5	2	2023-09-12 11:54:35.084+05:30
2	RAW1	20230912002002	1.00	345.00	0.00	100.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	4	2	2	2023-09-12 11:54:35.088+05:30
3	RAW1	20230912003001	1.00	345.00	0.00	1500.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	5	2	3	2023-09-12 12:00:48.269+05:30
4	NFG2	20230912003002	1000.00	0.00	0.00	1500.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	5	5	3	2023-09-12 12:00:48.272+05:30
5	NFG2	20230912004001	1000.00	0.00	0.00	500.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	500.00	6	5	4	2023-09-12 12:03:00.102+05:30
6	RAW2	20230912005001	123.00	0.00	0.00	100.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	7	3	5	2023-09-12 14:09:47.256+05:30
7	RAW1	20230912003001	1.00	345.00	61.00	61.00	300.00	0.00	0.00	0.00	0.00	0.00	0.00	18300.00	\N	2	6	2023-09-15 12:20:05.573822+05:30
8	RAW2	20230905003002	123.00	0.00	38.00	38.00	120.00	0.00	0.00	0.00	0.00	0.00	0.00	4560.00	\N	3	7	2023-09-15 12:36:33.792401+05:30
\.


--
-- Data for Name: purchase_poitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_poitems (id, product_code, pack, basic_qty, actual_qty, amend_qty, rate, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, item_id, po_id) FROM stdin;
1	01	5.00	10.00	10.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	10.00	1	1
2	RAW1	1.00	500.00	0.00	0.00	10.00	0.00	0.00	0.00	0.00	0.00	0.00	5000.00	2	3
3	RAW2	123.00	1000.00	0.00	0.00	11.00	0.00	0.00	0.00	0.00	0.00	0.00	11000.00	3	3
4	NFG2	1000.00	100.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	5	4
5	RAW1	1.00	100.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	2	4
6	RAW1	1.00	1500.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	2	5
7	NFG2	1000.00	1500.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	5	5
8	NFG2	1000.00	500.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	500.00	5	6
9	RAW2	123.00	100.00	0.00	0.00	1.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	3	7
\.


--
-- Data for Name: purchase_purchase; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_purchase (id, status, created, updated, pi_no, pi_date, seller_address_type, seller_gst_reg_type, seller_state, seller_country, seller_city, seller_mailingname, seller_address1, seller_address2, seller_address3, seller_pincode, seller_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, mode_of_payment, other_reference, terms_of_delivery, dispatch_through, destination, supplier_invoice, supplier_date, ammount, cgst, sgst, igst, tcs, other, ol_rate, round_off, total, narration, is_ict, company_id, other_ledger_id, seller_id, shipto_id, currency, ex_rate) FROM stdin;
1	1	2023-08-09 10:18:34.537+05:30	2023-08-09 10:18:34.586+05:30	2223PINV00001	2023-08-09	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N		\N		1	\N	111	2023-08-09	0.00	0.00	0.00	0.00	0.00	10.00	0.00	0.00	10.00		f	1	\N	4	1	001	1.00
2	1	2023-09-12 11:54:35.072+05:30	2023-09-12 11:54:35.172+05:30	2223PINV00002	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N		\N		0	\N	777	2023-09-12	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00		f	1	\N	4	1	001	2.00
3	1	2023-09-12 12:00:48.256+05:30	2023-09-12 12:00:48.35+05:30	2223PINV00003	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N		\N		0	\N	888	2023-09-12	3000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	3000.00		f	1	\N	4	1	001	1.00
4	1	2023-09-12 12:03:00.091+05:30	2023-09-12 12:03:00.164+05:30	2223PINV00004	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N		\N		0	\N	999	2023-09-12	500.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	500.00		f	1	\N	4	1	001	1.00
5	1	2023-09-12 14:09:47.244+05:30	2023-09-12 14:09:47.31+05:30	2223PINV00005	2023-09-12	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N		\N		0	\N	222	2023-09-12	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00		f	1	\N	4	1	001	1.00
6	1	2023-09-15 12:20:05.492892+05:30	2023-09-15 12:20:05.591178+05:30	2223ICT00001	2023-09-15	Default	Regular	Maharashtra	India	Pune	ABCD	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	\N	\N	\N	\N	\N	2223ICT00001	2023-09-15	18300.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	18300.00		t	2	\N	4	1	INR	1.00
7	1	2023-09-15 12:36:33.752292+05:30	2023-09-15 12:36:33.807784+05:30	2223ICT00002	2023-09-15	Default	Regular	Maharashtra	India	Pune	ABCD	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8	\N	\N	\N	\N	\N	\N	2223ICT00002	2023-09-15	4560.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	4560.00		t	2	\N	4	1	INR	1.00
\.


--
-- Data for Name: purchase_purchase_order; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_purchase_order (id, created, updated, status, po_no, ref_no, po_date, po_due_date, seller_address_type, seller_mailingname, seller_address1, seller_address2, seller_address3, seller_state, seller_city, seller_country, seller_pincode, seller_gst_reg_type, seller_gstin, shipto_address_type, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_city, shipto_state, shipto_country, shipto_pincode, shipto_gstin, mode_of_payment, other_reference, terms_of_delivery, ammount, cgst, sgst, igst, tcs, other, ol_rate, round_off, total, dispatch_through, destintaion, narration, company_id, other_ledger_id, seller_id, shipto_id, currency, ex_rate) FROM stdin;
1	2023-08-02 12:24:10.275+05:30	2023-08-09 14:02:11.015+05:30	4	2223PO00001	\N	2023-08-02	2023-08-31	Default	ABC	ABC	ABC	ABC	Maharashtra	Pune	India	392220	Regular	AAAAAAA0258A	Default	ABCD	ABCD	ABCD	ABCD	VADODARA	GUJARAT	INDIA	391775	24AAKCS5015L1Z8				10.00	0.00	0.00	0.00	0.00	10.00	5.00	0.00	20.00		\N		1	\N	4	1	001	1.00
3	2023-09-05 16:53:04.437+05:30	2023-09-05 16:54:18.973+05:30	4	2223PO00002	\N	2023-09-05	2023-09-09	Default	ABC	ABC	ABC	ABC	Maharashtra	Pune	India	392220	Regular	AAAAAAA0258A	Default	ABCD	ABCD	ABCD	ABCD	VADODARA	GUJARAT	INDIA	391775	24AAKCS5015L1Z8				16000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	16000.00		\N		1	\N	4	1	001	1.00
4	2023-09-12 11:50:53.133+05:30	2023-09-12 11:54:35.158+05:30	5	2223PO00003	\N	2023-09-12	2023-09-13	Default	ABC	ABC	ABC	ABC	Maharashtra	Pune	India	392220	Regular	AAAAAAA0258A	Default	ABCD	ABCD	ABCD	ABCD	VADODARA	GUJARAT	INDIA	391775	24AAKCS5015L1Z8				200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00		\N		1	\N	4	1	001	1.00
5	2023-09-12 12:00:05.191+05:30	2023-09-12 12:00:48.337+05:30	5	2223PO00004	\N	2023-09-12	2023-09-13	Default	ABC	ABC	ABC	ABC	Maharashtra	Pune	India	392220	Regular	AAAAAAA0258A	Default	ABCD	ABCD	ABCD	ABCD	VADODARA	GUJARAT	INDIA	391775	24AAKCS5015L1Z8				3000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	3000.00		\N		1	\N	4	1	001	1.00
6	2023-09-12 12:02:20.457+05:30	2023-09-12 12:03:00.15+05:30	5	2223PO00005	\N	2023-09-12	2023-09-13	Default	ABC	ABC	ABC	ABC	Maharashtra	Pune	India	392220	Regular	AAAAAAA0258A	Default	ABCD	ABCD	ABCD	ABCD	VADODARA	GUJARAT	INDIA	391775	24AAKCS5015L1Z8				500.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	500.00		\N		1	\N	4	1	001	1.00
7	2023-09-12 14:08:32.638+05:30	2023-09-12 14:09:47.298+05:30	5	2223PO00006	\N	2023-09-12	2023-09-13	Default	ABC	ABC	ABC	ABC	Maharashtra	Pune	India	392220	Regular	AAAAAAA0258A	Default	ABCD	ABCD	ABCD	ABCD	VADODARA	GUJARAT	INDIA	391775	24AAKCS5015L1Z8				100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00		\N		1	\N	4	1	001	1.00
\.


--
-- Data for Name: purchase_purchasereturn; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_purchasereturn (id, status, created, updated, pr_no, pr_date, seller_address_type, seller_gst_reg_type, seller_state, seller_country, seller_city, seller_mailingname, seller_address1, seller_address2, seller_address3, seller_pincode, seller_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, mode_of_payment, other_reference, terms_of_delivery, dispatch_through, destination, narration, ammount, cgst, sgst, igst, tcs, ol_rate, round_off, total, company_id, pi_no_id, seller_id, shipto_id) FROM stdin;
1	1	2023-08-09 10:19:24.449+05:30	2023-08-09 10:19:24.469+05:30	2223PR00001	2023-08-09	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8			\N		1	\N		0.00	0.50	0.50	0.50	0.00	5.00	0.50	11.00	1	1	4	1
\.


--
-- Data for Name: purchase_purchasereturnitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_purchasereturnitems (id, product_code, batch, pack, mrp, actual_qty, return_qty, rate, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, item_id, pr_id) FROM stdin;
\.


--
-- Data for Name: purchase_qdn; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_qdn (id, status, created, updated, qdn_no, qdn_date, seller_address_type, seller_gst_reg_type, seller_state, seller_country, seller_city, seller_mailingname, seller_address1, seller_address2, seller_address3, seller_pincode, seller_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, mode_of_payment, other_reference, terms_of_delivery, dispatch_through, destination, narration, ammount, cgst, sgst, igst, tcs, ol_rate, round_off, total, company_id, pi_no_id, seller_id, shipto_id) FROM stdin;
1	1	2023-08-09 10:19:07.216+05:30	2023-08-09 10:19:07.236+05:30	2223PQ00001	2023-08-09	Default	Regular	Maharashtra	India	Pune	ABC	ABC	ABC	ABC	392220	AAAAAAA0258A	Default	INDIA	GUJARAT	VADODARA	ABCD	ABCD	ABCD	ABCD	391775	24AAKCS5015L1Z8			\N		1	\N		0.00	0.00	0.00	0.00	0.00	0.00	0.00	10.00	1	1	4	1
\.


--
-- Data for Name: purchase_qdnitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.purchase_qdnitems (id, product_code, batch, pack, mrp, actual_qty, qdn_qty, rate, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, item_id, qdn_id) FROM stdin;
\.


--
-- Data for Name: sales_creditnote; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_creditnote (id, created, updated, status, cn_no, cn_date, other, ol_rate, ammount, discount, cgst, sgst, igst, tcs, round_off, total, scheme, narration, company_id, inv_id, other_ledger_id, mrpvalue, omrpvalue, buyer_id, buyer_address1, buyer_address2, buyer_address3, buyer_address_type, buyer_city, buyer_country, buyer_gst_reg_type, buyer_gstin, buyer_mailingname, buyer_pincode, buyer_state, channel, division) FROM stdin;
1	2023-09-05	2023-09-05	1	2223CN00001	2023-09-05	0.00	0.00	20.00	0.00	0.00	0.00	0.00	0.00	0.00	20.00	\N		1	1	\N	0.00	0.00	1	Address Line1	Address Line2	Address Line3	Default	Vadodara	India	Consumer		CUSTOMER NAME	390001	Gujarat-1	Channel 1	Division 1
2	2023-09-12	2023-09-12	1	2223CN00002	2023-09-12	0.00	0.00	50.00	0.00	0.00	0.00	0.00	0.00	0.00	50.00	\N		1	2	\N	0.00	0.00	5	Cm3	Cm3	Cm3	Default	Amsterdam	England	Consumer	asdsasda152ad	CM3	321456	Amsterdam	Channel 2	Manual
3	2023-09-12	2023-09-12	1	2223CN00003	2023-09-12	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	\N		1	3	\N	0.00	0.00	1	Address Line1	Address Line2	Address Line3	Default	Vadodara	India	Consumer		CUSTOMER NAME	390001	Gujarat-1	Channel 1	division
5	2023-09-13	2023-09-13	1	2223CN00004	2023-09-13	0.00	0.00	90.00	0.00	0.00	0.00	0.00	0.00	0.00	90.00	\N	New Two	1	5	\N	0.00	0.00	6	ABC	ABC	ABC	Default	Vadodara	India	Unknown	12AYRFG125I	ABCD	390002	Gujarat-1	Channel 1	ECOM
6	2023-09-14	2023-09-14	1	2223CN00005	2023-09-14	0.00	0.00	90.00	0.00	0.00	0.00	0.00	0.00	0.00	90.00	\N	None	1	4	\N	0.00	0.00	6	ABC	ABC	ABC	Default	Vadodara	India	Unknown	12AYRFG125I	ABCD	390002	Gujarat-1	Channel 1	division
\.


--
-- Data for Name: sales_creditnoteitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_creditnoteitems (id, billed_qty, rates, rate, igstrate, sgstrate, cgstrate, discount, igst, sgst, cgst, amount, inv_id, item_id, mrp) FROM stdin;
1	2.00	100.00	10.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	20.00	1	1	100.00
2	1.00	150.00	50.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	50.00	2	4	1000.00
3	2.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	3	1	100.00
4	10.00	90.00	10.00	0.00	0.00	0.00	10.00	0.00	0.00	0.00	90.00	5	2	345.00
5	1.00	100.00	90.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	90.00	6	4	1000.00
\.


--
-- Data for Name: sales_delivery_note; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_delivery_note (id, status, created, updated, dn_no, dn_date, buyer_address_type, buyer_gst_reg_type, buyer_state, buyer_country, buyer_city, buyer_mailingname, buyer_address1, buyer_address2, buyer_address3, buyer_pincode, buyer_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, bill_qty, free_qty, ammount, ol_rate, other, discount, cgst, sgst, igst, tcs, round_off, total, scheme, price_list, narration, mode_of_payment, other_reference, terms_of_delivery, order_no, dispatch_doc_no, dispatch_through, destintaion, carrier_agent, carrier_agent_id, lr_no, lr_date, vehical_no, vehical_type, ls_status, ps_status, buyer_id, company_id, other_ledger_id, sales_order_id, shipto_id) FROM stdin;
1	3	2023-09-05	2023-09-05	2223DN00001	2023-09-05	Default	Consumer	Gujarat-1	India	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		AAPOS1478Q	2.00	0.00	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	\N	5%		30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	1	1	\N	2	1
2	3	2023-09-12	2023-09-12	2223DN00002	2023-09-12	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		AAPOS1478Q	1.00	0.00	150.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	150.00	\N	Manual		30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	5	1	\N	26	1
3	3	2023-09-12	2023-09-12	2223DN00003	2023-09-12	Default	Consumer	Gujarat-1	India	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	AAPOD1234Z	2.00	0.00	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	\N	5%		30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	1	1	\N	27	2
4	3	2023-09-13	2023-09-13	2223DN00004	2023-09-13	Default	Unknown	Gujarat-1	India	Vadodara	ABCD	ABC	ABC	ABC	390002	12AYRFG125I	Default	England	Amsterdam	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	asdsas1a	10.00	0.00	810.00	5.00	810.00	0.00	20.25	20.25	40.50	0.00	-0.50	1660.00	\N	10%	New Two	30		40		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	6	1	\N	34	5
5	3	2023-09-13	2023-09-13	2223DN00005	2023-09-13	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	AAPOD1234Z	11.00	0.00	1567.50	5.00	1567.50	0.00	39.19	39.19	78.38	0.00	-0.38	3213.00	\N	Manual	New One	30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	5	1	\N	33	2
6	1	2023-09-13	2023-09-13	2223DN00006	2023-09-13	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	AAPOD1234Z	1.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	\N	Manual		30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	5	1	\N	10	2
7	1	2023-09-13	2023-09-13	2223DN00007	2023-09-13	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		AAPOS1478Q	1.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	\N	Manual		30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	5	1	\N	25	1
\.


--
-- Data for Name: sales_dnitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_dnitems (id, mrp, offer_mrp, pack, available_qty, actual_qty, billed_qty, free_qty, rate, prate, discount, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, dn_id, item_id) FROM stdin;
1	100.00	0.00	5.00	22.00	2.000	2.000	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	1	1
2	1000.00	0.00	0.00	1.00	1.000	1.000	0.00	150.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	150.00	2	4
3	100.00	0.00	5.00	19.00	2.000	2.000	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	3	1
4	345.00	0.00	1.00	669.00	10.000	10.000	0.00	90.00	1.00	10.00	0.00	0.00	0.00	0.00	0.00	0.00	810.00	4	2
5	345.00	0.00	1.00	680.00	11.000	11.000	0.00	150.00	1.00	5.00	0.00	0.00	0.00	0.00	0.00	0.00	1567.50	5	2
6	100.00	0.00	5.00	21.00	1.000	1.000	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	6	1
7	100.00	0.00	5.00	20.00	1.000	1.000	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	7	1
\.


--
-- Data for Name: sales_dnitems_godown; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_dnitems_godown (id, dnitems_id, godown_id) FROM stdin;
8	1	2
9	2	2
10	3	2
11	4	2
12	5	2
13	6	7
14	7	2
\.


--
-- Data for Name: sales_invitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_invitems (id, mrp, offer_mrp, pack, available_qty, actual_qty, billed_qty, free_qty, nb_qty, rate, new_rate, prate, discount, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, inv_id, item_id, nf_qty) FROM stdin;
1	100.00	0.00	5.00	22.00	2.000	2.000	0.00	2.00	100.00	90.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	1	1	0.00
2	1000.00	0.00	0.00	1.00	1.000	1.000	0.00	1.00	150.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	150.00	2	4	0.00
3	100.00	0.00	5.00	19.00	2.000	2.000	0.00	1.00	100.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	3	1	0.00
4	1000.00	1000.00	0.00	1.00	1.000	1.000	0.00	1.00	100.00	10.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	4	4	0.00
5	345.00	0.00	1.00	669.00	10.000	10.000	0.00	10.00	90.00	80.00	1.00	10.00	0.00	0.00	0.00	0.00	0.00	0.00	810.00	5	2	0.00
6	345.00	0.00	1.00	680.00	11.000	11.000	0.00	11.00	150.00	150.00	1.00	5.00	0.00	0.00	0.00	0.00	0.00	0.00	1567.50	6	2	0.00
7	1000.00	1000.00	0.00	1.00	1.000	1.000	0.00	1.00	999.00	999.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	999.00	7	4	0.00
8	1000.00	1000.00	0.00	1.00	1.000	1.000	0.00	1.00	900.00	900.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	900.00	8	4	0.00
9	100.00	100.00	5.00	1.00	1.000	1.000	0.00	1.00	999.00	999.00	999.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	999.00	9	1	0.00
10	345.00	345.00	1.00	661.00	61.000	61.000	0.00	0.00	300.00	0.00	120.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	18300.00	10	2	0.00
11	0.00	0.00	123.00	638.00	38.000	38.000	0.00	0.00	120.00	0.00	132.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	4560.00	11	3	0.00
\.


--
-- Data for Name: sales_invoice; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_invoice (id, created, updated, inv_no, inv_date, status, buyer_address_type, buyer_gst_reg_type, buyer_state, buyer_country, buyer_city, buyer_mailingname, buyer_address1, buyer_address2, buyer_address3, buyer_pincode, buyer_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, bill_qty, free_qty, other, ol_rate, ammount, mrpvalue, omrpvalue, discount, sgst, cgst, igst, tcs, round_off, total, scheme, narration, price_list, mode_of_payment, other_reference, terms_of_delivery, order_no, dispatch_doc_no, dispatch_through, destination, carrier_agent, carrier_agent_id, lr_no, lr_date, vehical_type, vehical_no, is_ict, is_ivt, buyer_id, company_id, dn_id, other_ledger_id, shipto_id, channel, division) FROM stdin;
1	2023-09-05	2023-09-05	2223INV00001	2023-09-05	1	Default	Consumer	Gujarat-1	India	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		\N	2.00	0.00	0.00	0.00	200.00	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	\N		5%	30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	1	1	1	\N	1	Channel 1	Division 1
2	2023-09-12	2023-09-12	2223INV00002	2023-09-12	1	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		\N	1.00	0.00	0.00	0.00	150.00	1000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	150.00	\N		Manual	30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	5	1	2	\N	1	Channel 2	Manual
3	2023-09-12	2023-09-12	2223INV00003	2023-09-12	1	Default	Consumer	Gujarat-1	India	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	\N	2.00	0.00	0.00	0.00	200.00	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	\N		5%	30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	1	1	3	\N	2	Channel 1	division
4	2023-09-13	2023-09-13	2223INV00004	2023-09-13	1	Default	Unknown	Gujarat-1	India	Vadodara	ABCD	ABC	ABC	ABC	390002	12AYRFG125I		India	Gujarat-1	Vadodara	ABCD	ABC	ABC	ABC	390002	12AYRFG125I	IIABC1245K	0.00	0.00	0.00	0.00	100.00	1000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	LR111	2023-09-14	\N	\N	f	t	6	1	\N	\N	6	Channel 1	division
5	2023-09-13	2023-09-13	2223INV00005	2023-09-13	1	Default	Unknown	Gujarat-1	India	Vadodara	ABCD	ABC	ABC	ABC	390002	12AYRFG125I	Default	England	Amsterdam	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	\N	10.00	0.00	810.00	5.00	810.00	3450.00	0.00	0.00	20.25	20.25	40.50	0.00	-0.50	1660.00	\N	New Two	10%	30		40		\N	\N	\N	\N	\N	LR2	2023-09-14	\N	\N	f	f	6	1	4	\N	5	Channel 1	ECOM
6	2023-09-13	2023-09-13	2223INV00006	2023-09-13	1	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	\N	11.00	0.00	1567.50	5.00	1567.50	3795.00	0.00	0.00	39.19	39.19	78.38	0.00	-0.38	3213.00	\N	New One	Manual	30		30		\N	\N	\N	\N	\N		\N	\N	\N	f	f	5	1	5	\N	2	Channel 2	Manual
7	2023-09-13	2023-09-13	2223INV00007	2023-09-13	1	Default	Consumer	Gujarat-1	India	Vadodara	Customer Name	Address Line1	Address Line2	Address Line3	390001			India	Gujarat-1	Vadodara	Customer Name	Address Line1	Address Line2	Address Line3	390001		AAPOS1478Q	0.00	0.00	0.00	0.00	999.00	1000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	999.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	t	1	1	\N	\N	1	Channel 1	ECOM
8	2023-09-14	2023-09-14	2223INV00008	2023-09-14	1	Default	Consumer	Gujarat-1	India	Vadodara	Customer Name	Address Line1	Address Line2	Address Line3	390001			India	Gujarat-1	Vadodara	Customer Name	Address Line1	Address Line2	Address Line3	390001		AAPOS1478Q	0.00	0.00	0.00	0.00	900.00	1000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	900.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	t	1	1	\N	\N	1	Channel 1	ECOM
9	2023-09-14	2023-09-14	2223INV00009	2023-09-14	1	Default	Consumer	Gujarat-1	India	Vadodara	Customer Name	Address Line1	Address Line2	Address Line3	390001			India	Gujarat-1	Vadodara	Customer Name	Address Line1	Address Line2	Address Line3	390001		AAPOS1478Q	0.00	0.00	0.00	0.00	999.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	999.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	t	1	1	\N	\N	1	Channel 1	ECOM
10	2023-09-15	2023-09-15	2223ICT00001	2023-09-15	1	Default	Unknown	Gujarat-1	India	Vadodara	XYZ	XYZ	XYZ	XYZ	390002	AVIIADV125L	Default	India	Gujarat-1	Vadodara	XYZ	XYZ	XYZ	XYZ	390002	AVIIADV125L	IIADV125L	61.00	0.00	0.00	0.00	18300.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	18300.00	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	7	1	\N	\N	7	IB	division
11	2023-09-15	2023-09-15	2223ICT00002	2023-09-15	1	Default	Unknown	Gujarat-1	India	Vadodara	XYZ	XYZ	XYZ	XYZ	390002	AVIIADV125L	Default	India	Gujarat-1	Vadodara	XYZ	XYZ	XYZ	XYZ	390002	AVIIADV125L	IIADV125L	38.00	0.00	0.00	0.00	4560.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	4560.00	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	7	1	\N	\N	7	IB	division
\.


--
-- Data for Name: sales_loadingsheet; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_loadingsheet (id, created, updated, prate, mrp, batch, offermrp, godown, qty, company_id, dn_id, item_id) FROM stdin;
1	2023-09-05	2023-09-05	0.00	100.00	20230905000995	0.00	PRODUCTION	2.00	1	1	1
2	2023-09-12	2023-09-12	0.00	1000.00	20230912000998	0.00	PRODUCTION	1.00	1	2	4
3	2023-09-12	2023-09-12	0.00	100.00	20230905000995	0.00	PRODUCTION	2.00	1	3	1
4	2023-09-13	2023-09-13	1.00	345.00	20230912003001	0.00	PRODUCTION	10.00	1	4	2
5	2023-09-13	2023-09-13	1.00	345.00	20230912003001	0.00	PRODUCTION	11.00	1	5	2
6	2023-09-13	2023-09-13	0.00	100.00	20230905000995	0.00	SHORTAGE	1.00	1	6	1
7	2023-09-13	2023-09-13	0.00	100.00	20230905000996	0.00	PRODUCTION	1.00	1	7	1
\.


--
-- Data for Name: sales_packingsheet; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_packingsheet (id, created, updated, mrp, offermrp, qty, from_box, to_box, total_box, status, company_id, dn_id, item_id, remarks) FROM stdin;
1	2023-09-13	2023-09-13	100.00	0.00	1.00	1	2	3	f	1	6	1	
2	2023-09-13	2023-09-13	100	90	2.00	1	1	\N	t	1	4	4	\N
\.


--
-- Data for Name: sales_proformainvitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_proformainvitems (id, mrp, offer_mrp, pack, available_qty, actual_qty, billed_qty, free_qty, nb_qty, rate, new_rate, prate, discount, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, inv_id, item_id, nf_qty) FROM stdin;
1	345.00	0.00	1.00	680.00	11.000	11.000	0.00	11.00	150.00	150.00	1.00	5.00	0.00	0.00	0.00	0.00	0.00	0.00	1567.50	1	2	0.00
\.


--
-- Data for Name: sales_proformainvoice; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_proformainvoice (id, created, updated, inv_no, inv_date, status, buyer_address_type, buyer_gst_reg_type, division, channel, buyer_state, buyer_country, buyer_city, buyer_mailingname, buyer_address1, buyer_address2, buyer_address3, buyer_pincode, buyer_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, shipto_pan_no, bill_qty, free_qty, other, ol_rate, ammount, mrpvalue, omrpvalue, discount, sgst, cgst, igst, tcs, round_off, total, scheme, narration, price_list, mode_of_payment, other_reference, terms_of_delivery, order_no, dispatch_doc_no, dispatch_through, destintaion, carrier_agent, carrier_agent_id, lr_no, lr_date, vehical_type, vehical_no, is_ict, is_ivt, buyer_id, company_id, dn_id, other_ledger_id, shipto_id) FROM stdin;
1	2023-09-13	2023-09-13	2223PI00001	2023-09-13	3	Default	Consumer	Manual	Channel 2	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	\N	11.00	0.00	1567.50	5.00	1567.50	3795.00	0.00	0.00	39.19	39.19	78.38	0.00	-0.38	3213.00	\N	New One	Manual	30		30		\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	5	1	5	\N	2
\.


--
-- Data for Name: sales_qdn; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_qdn (id, created, updated, status, qdn_no, qdn_date, bill_qty, ammount, discount, cgst, sgst, igst, tcs, round_off, total, narration, company_id, inv_id, free_qty, mrpvalue, omrpvalue, buyer_id, buyer_address1, buyer_address2, buyer_address3, buyer_address_type, buyer_city, buyer_country, buyer_gst_reg_type, buyer_gstin, buyer_mailingname, buyer_pincode, buyer_state, channel, division) FROM stdin;
1	2023-09-14	2023-09-14	1	2223SQ00001	2023-09-14	1.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00		1	3	0.00	100.00	0.00	1	Address Line1	Address Line2	Address Line3	Default	Vadodara	India	Consumer		CUSTOMER NAME	390001	Gujarat-1	Channel 1	division
\.


--
-- Data for Name: sales_qdnitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_qdnitems (id, billed, billed_qty, rate, igstrate, sgstrate, cgstrate, discount, igst, sgst, cgst, amount, item_id, inv_id, free_qty, mrp) FROM stdin;
1	1.00	1.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	1	1	0.00	100.00
\.


--
-- Data for Name: sales_rso; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_rso (id, status, created, updated, rso_no, rso_date, bill_qty, ammount, discount, cgst, sgst, igst, tcs, round_off, total, is_ivt, narration, company_id, inv_id, buyer_id, buyer_address1, buyer_address2, buyer_address3, buyer_address_type, buyer_city, buyer_country, buyer_gst_reg_type, buyer_gstin, buyer_mailingname, buyer_pincode, buyer_state, is_cm, rso_ref, ref_date, free_qty, mrpvalue, omrpvalue, channel, division) FROM stdin;
1	2	2023-09-13	2023-09-13	2223RSO00001	2023-09-13	1.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	t		1	\N	1	Address Line1	Address Line2	Address Line3	Default	Vadodara	India	Consumer		CUSTOMER NAME	390001	Gujarat-1	f	\N	\N	0.00	1000.00	0.00	Channel 1	division
2	2	2023-09-13	2023-09-13	2223RSO00002	2023-09-13	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	f		1	\N	6	ABC	ABC	ABC	Default	Vadodara	India	Unknown	12AYRFG125I	ABCD	390002	Gujarat-1	t	Ab1	2023-09-14	0.00	0.00	0.00	Channel 1	ECOM
4	2	2023-09-13	2023-09-13	2223RSO00003	2023-09-13	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	f		1	\N	6	ABC	ABC	ABC	Default	Vadodara	India	Unknown	12AYRFG125I	ABCD	390002	Gujarat-1	t	Ab1	2023-09-14	0.00	0.00	0.00	Channel 1	ECOM
6	1	2023-09-14	2023-09-14	2223RSO00004	2023-09-14	10.00	1500.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	t		1	\N	1	Address Line1	Address Line2	Address Line3	Default	Vadodara	India	Consumer		Customer Name	390001	Gujarat-1	f	\N	\N	0.00	0.00	0.00	Channel 1	ECOM
8	1	2023-09-14	2023-09-14	2223RSO00005	2023-09-14	1.00	999.00	0.00	0.00	0.00	0.00	0.00	0.00	999.00	t		1	\N	5	Cm3	Cm3	Cm3	Default	Amsterdam	England	Consumer	asdsasda152ad	CM3	321456	Amsterdam	f	\N	\N	0.00	100.00	0.00	Channel 2	Manual
9	1	2023-09-14	2023-09-14	2223RSO00006	2023-09-14	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	f		1	\N	1	Address Line1	Address Line2	Address Line3	Default	Vadodara	India	Consumer		Customer Name	390001	Gujarat-1	t	2223SQ00001	2023-09-15	0.00	0.00	0.00	Channel 1	ECOM
\.


--
-- Data for Name: sales_rsoitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_rsoitems (id, billed, billed_qty, rate, igstrate, sgstrate, cgstrate, discount, igst, sgst, cgst, amount, item_id, inv_id, free_qty, mrp) FROM stdin;
1	1.00	1.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	4	1	0.00	1000.00
2	10.00	10.00	150.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	1500.00	5	6	0.00	0.00
3	1.00	1.00	999.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	999.00	1	8	0.00	100.00
\.


--
-- Data for Name: sales_saleqty; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_saleqty (id, created, updated, qty, company_id, product_id) FROM stdin;
\.


--
-- Data for Name: sales_salesorder; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_salesorder (id, created, updated, status, so_no, ref_no, so_date, so_due_date, price_list, isscheme, buyer_address_type, buyer_gst_reg_type, buyer_state, buyer_country, buyer_city, buyer_mailingname, buyer_address1, buyer_address2, buyer_address3, buyer_pincode, buyer_gstin, shipto_address_type, shipto_country, shipto_state, shipto_city, shipto_mailingname, shipto_address1, shipto_address2, shipto_address3, shipto_pincode, shipto_gstin, mode_of_payment, other_reference, order_no, terms_of_delivery, scheme, bill_qty, free_qty, ammount, other, ol_rate, discount, cgst, sgst, igst, tcs, round_off, total, narration, buyer_id, company_id, other_ledger_id, shipto_id, shipto_pan_no) FROM stdin;
2	2023-09-05 17:21:01.033+05:30	2023-09-05 17:25:46.297+05:30	3	2223SO00001	\N	2023-09-05	2023-09-06	5%	f	Default	Consumer	Gujarat-1	India	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30			30	\N	2.00	0.00	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00		1	1	\N	1	AAPOS1478Q
10	2023-09-12 14:35:47.601+05:30	2023-09-13 12:02:51.098+05:30	3	2223SO00002	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30			30	\N	1.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00		5	1	\N	2	AAPOD1234Z
16	2023-09-12 14:47:47.147+05:30	2023-09-12 14:58:17.421+05:30	2	2223SO00003	\N	2023-09-12	2023-09-13	10%	f	Default	Unknown	Maharashtra	India	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		2	1	\N	1	AAPOS1478Q
17	2023-09-12 14:48:10.888+05:30	2023-09-12 14:58:14.492+05:30	2	2223SO00004	\N	2023-09-12	2023-09-13	10%	f	Default	Unknown	Maharashtra	India	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		2	1	\N	1	AAPOS1478Q
18	2023-09-12 14:48:11.832+05:30	2023-09-12 14:58:12.015+05:30	2	2223SO00005	\N	2023-09-12	2023-09-13	10%	f	Default	Unknown	Maharashtra	India	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		2	1	\N	1	AAPOS1478Q
19	2023-09-12 14:48:59.341+05:30	2023-09-12 14:58:09.972+05:30	2	2223SO00006	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		5	1	\N	2	AAPOD1234Z
20	2023-09-12 14:52:40.705+05:30	2023-09-12 14:58:00.357+05:30	2	2223SO00007	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		5	1	\N	2	AAPOD1234Z
21	2023-09-12 14:53:22.969+05:30	2023-09-12 14:58:04.374+05:30	2	2223SO00008	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		5	1	\N	2	AAPOD1234Z
22	2023-09-12 14:55:44.425+05:30	2023-09-12 14:58:07.006+05:30	2	2223SO00009	\N	2023-09-12	2023-09-13	10%	f	Default	Unknown	Maharashtra	India	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		2	1	\N	1	AAPOS1478Q
23	2023-09-12 14:56:14.178+05:30	2023-09-12 14:58:19.584+05:30	2	2223SO00010	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		5	1	\N	2	AAPOD1234Z
24	2023-09-12 14:56:20.928+05:30	2023-09-12 14:58:21.794+05:30	2	2223SO00011	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	CUSTOMER NAME 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30		ABC123	30	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		5	1	\N	2	AAPOD1234Z
25	2023-09-12 14:57:24.116+05:30	2023-09-13 12:14:40.92+05:30	3	2223SO00012	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30			30	\N	1.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00		5	1	\N	1	AAPOS1478Q
26	2023-09-12 14:59:43.101+05:30	2023-09-12 15:18:02.086+05:30	3	2223SO00013	\N	2023-09-12	2023-09-13	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Gujarat-1	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		30			30	\N	1.00	0.00	150.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	150.00		5	1	\N	1	AAPOS1478Q
27	2023-09-12 17:12:46.362+05:30	2023-09-12 17:13:20.931+05:30	3	2223SO00014	\N	2023-09-12	2023-09-13	5%	f	Default	Consumer	Gujarat-1	India	Vadodara	CUSTOMER NAME	Address Line1	Address Line2	Address Line3	390001		Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30			30	\N	2.00	0.00	200.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00		1	1	\N	2	AAPOD1234Z
29	2023-09-13 10:48:00.7+05:30	2023-09-13 10:55:28.775+05:30	2	2223SO00015	\N	2023-09-13	2023-09-30	5%	f	Default	Consumer	New York	INDIA	NYC1	ABCD	A	B	C	40025	\N	Default	INDIA	New Jersey	NJC	CS	A	B	C	80010	\N	0			Paid	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		1	1	\N	6	AAPOS1478Q
30	2023-09-13 10:49:01.18+05:30	2023-09-13 10:55:22.718+05:30	2	2223SO00016	\N	2023-09-13	2023-09-30	5%	f	Default	Consumer	New York	INDIA	NYC1	ABCD	A	B	C	40025	\N	Default	INDIA	New Jersey	NJC	CS	A	B	C	80010	\N	0			Paid	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		1	1	\N	6	AAPOS1478Q
31	2023-09-13 10:49:16.33+05:30	2023-09-13 10:54:33.899+05:30	2	2223SO00017	\N	2023-09-13	2023-09-30	5%	f	Default	Consumer	New York	INDIA	NYC1	ABCD	A	B	C	40025	\N	Default	INDIA	New Jersey	NJC	CS	A	B	C	80010	\N	0			Paid	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		1	1	\N	6	AAPOS1478Q
32	2023-09-13 10:49:54.298+05:30	2023-09-13 10:54:30.184+05:30	2	2223SO00018	\N	2023-09-13	2023-09-30	5%	f	Default	Consumer	New York	INDIA	NYC1	ABCD	A	B	\N	40025	None	Default	INDIA	New Jersey	NJC	CS	A	B	\N	80010		0			Paid	\N	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00		1	1	\N	6	AAPOS1478Q
33	2023-09-13 10:56:34.596+05:30	2023-09-13 11:34:35.709+05:30	3	2223SO00019	\N	2023-09-13	2023-09-30	Manual	f	Default	Consumer	Amsterdam	England	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	Default	India	Maharashtra	Mumbai	Customer Name 2	Address Line1	Address Line1	Address Line1	493320	XXAAPOD1234Z	30			30	\N	11.00	0.00	1567.50	1567.50	5.00	0.00	39.19	39.19	78.38	0.00	-0.38	3213.00	New One	5	1	\N	2	AAPOD1234Z
34	2023-09-13 10:57:19.858+05:30	2023-09-13 11:21:51.145+05:30	3	2223SO00020	\N	2023-09-13	2023-09-30	10%	f	Default	Unknown	Gujarat-1	India	Vadodara	ABCD	ABC	ABC	ABC	390002	12AYRFG125I	Default	England	Amsterdam	Amsterdam	CM3	Cm3	Cm3	Cm3	321456	asdsasda152ad	30			40	\N	10.00	0.00	810.00	810.00	5.00	0.00	20.25	20.25	40.50	0.00	-0.50	1660.00	New Two	6	1	\N	5	asdsas1a
\.


--
-- Data for Name: sales_salestarget; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_salestarget (id, target, months, asm_id, buyer_id, region_id, rsm_id, se_id, zone_id, zsm_id, created, updated) FROM stdin;
1	10.00	2023-09-01	6	5	2	7	7	6	3	2023-09-13	2023-09-13
\.


--
-- Data for Name: sales_soitems; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.sales_soitems (id, mrp, pack, available_qty, offer_mrp, actual_qty, billed_qty, free_qty, rate, discount, igstrate, sgstrate, cgstrate, igst, sgst, cgst, amount, item_id, so_id) FROM stdin;
1	100.00	5.00	22.00	0.00	2.00	2.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	1	2
2	100.00	5.00	21.00	0.00	1.00	1.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	1	10
6	100.00	5.00	20.00	0.00	1.00	1.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	100.00	1	25
7	1000.00	0.00	1.00	0.00	1.00	1.00	0.00	150.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	150.00	4	26
8	100.00	5.00	19.00	0.00	2.00	2.00	0.00	100.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	200.00	1	27
9	345.00	1.00	680.00	0.00	11.00	11.00	0.00	150.00	5.00	0.00	0.00	0.00	0.00	0.00	0.00	1567.50	2	33
10	345.00	1.00	669.00	0.00	10.00	10.00	0.00	90.00	10.00	0.00	0.00	0.00	0.00	0.00	0.00	810.00	2	34
\.


--
-- Data for Name: todo_todo; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.todo_todo (id, todo) FROM stdin;
1	TODO_Test
\.


--
-- Data for Name: warehouse_materialtransferred; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.warehouse_materialtransferred (id, qty, rate, godown_id, indent_id, item_id, created, updated) FROM stdin;
\.


--
-- Data for Name: warehouse_pallettransferentry; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.warehouse_pallettransferentry (id, fgodown, tgodown, qty, created, createdby, item_id, company_id) FROM stdin;
1	UN ALLOCATED	New1231	500.0000	2023-09-05	admin	2	1
2	UN ALLOCATED	New1231	1000.0000	2023-09-05	admin	3	1
3	UN ALLOCATED	PRODUCTION	100.0000	2023-09-12	admin	5	1
4	UN ALLOCATED	PRODUCTION	100.0000	2023-09-12	admin	2	1
5	UN ALLOCATED	PRODUCTION	1500.0000	2023-09-12	admin	2	1
6	UN ALLOCATED	PRODUCTION	1500.0000	2023-09-12	admin	5	1
7	UN ALLOCATED	PRODUCTION	500.0000	2023-09-12	admin	5	1
8	UN ALLOCATED	PRODUCTION	100.0000	2023-09-12	admin	3	1
9	DAMAGE & SCRAP	UN ALLOCATED	1.0000	2023-09-13	admin	1	1
\.


--
-- Data for Name: warehouse_shortagedamageentry; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.warehouse_shortagedamageentry (id, shoratage, sqty, dqty, rate, sremarks, dremarks, godown_id, item_id, jobwork_id, purchase_id, created, updated, company_id, createdby) FROM stdin;
1		1.0000	1.0000	0.00	ABC	ABC	2	1	\N	\N	2023-09-13	2023-09-13	1	admin
2		1.0000	1.0000	132.00	ABC	ABC	4	3	\N	\N	2023-09-13	2023-09-13	1	admin
3		1.0000	1.0000	132.00	ABC	ABC	7	3	\N	\N	2023-09-13	2023-09-13	1	admin
4		5.0000	0.0000	1.00	ABC	Nothing	2	2	\N	3	2023-09-13	2023-09-13	1	admin
5		1.0000	0.0000	1.00	Short product	No Damage	2	2	\N	3	2023-09-13	2023-09-13	1	admin
6		0.0000	2.0000	1.00	NA	Damage	2	2	\N	3	2023-09-13	2023-09-13	1	admin
7		10.0000	0.0000	1.00	ABC	ABC	2	3	\N	5	2023-09-13	2023-09-13	1	admin
8		9.0000	0.0000	1.00	ABC		2	2	\N	3	2023-09-13	2023-09-13	1	admin
9		1.0000	0.0000	120.00	1	NA	1	2	\N	3	2023-09-13	2023-09-13	1	admin
10	1	0.0000	1.0000	120.00	NA	1	1	2	5	3	2023-09-13	2023-09-13	1	admin
\.


--
-- Data for Name: warehouse_stock_summary; Type: TABLE DATA; Schema: public; Owner: netitest
--

COPY public.warehouse_stock_summary (id, mrp, batch, rate, closing_balance, company_id, godown_id, product_id, created, updated) FROM stdin;
8	100.00	20230905000997	0.00	3.0000	1	2	1	2023-09-05	2023-09-13
12	100.00	20230905000996	0.00	12.0000	1	2	1	2023-09-05	2023-09-05
32	0.00	20230912005001	1.00	70.0000	1	2	3	2023-09-12	2023-09-13
33	100.00	20230912000997	0.00	1.0000	1	2	1	2023-09-12	2023-09-12
37	0.00	20230905003002	132.00	1.0000	1	1	3	2023-09-13	2023-09-13
38	100.00	20230905000995	0.00	1.0000	1	5	1	2023-09-13	2023-09-13
40	0.00	20230905003002	132.00	1.0000	1	1	3	2023-09-13	2023-09-13
41		20230912003001	1.00	5.0000	1	7	2	2023-09-13	2023-09-13
42		20230912003001	1.00	1.0000	1	7	2	2023-09-13	2023-09-13
43		20230912003001	1.00	2.0000	1	1	2	2023-09-13	2023-09-13
44	0.00	20230912005001	1.00	10.0000	1	7	3	2023-09-13	2023-09-13
45		20230912003001	1.00	9.0000	1	7	2	2023-09-13	2023-09-13
51		20230905003001	120.00	1.0000	1	1	2	2023-09-13	2023-09-13
53		20230905003001	120.00	1.0000	1	1	2	2023-09-13	2023-09-13
52		20230905003001	300.00	1.0000	2	7	2	2023-09-13	2023-09-15
46		20230905003001	300.00	1.0000	2	7	2	2023-09-13	2023-09-15
48		20230905003001	300.00	1.0000	2	7	2	2023-09-13	2023-09-15
50		20230905003001	300.00	1.0000	2	7	2	2023-09-13	2023-09-15
26		20230912003001	1.00	585.0000	1	2	2	2023-09-12	2023-09-15
54	345.00	20230912003001	300.00	57.0000	2	2	2	2023-09-15	2023-09-15
4	0.00	20230905003002	132.00	520.0000	1	4	3	2023-09-05	2023-09-15
55	0.00	20230905003002	120.00	38.0000	2	4	3	2023-09-15	2023-09-15
\.


--
-- Name: accounts_loggedinuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.accounts_loggedinuser_id_seq', 2, true);


--
-- Name: auditlog_logentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auditlog_logentry_id_seq', 891, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 584, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 376, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 584, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 720, true);


--
-- Name: company_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.company_company_id_seq', 2, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 27, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 94, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 151, true);


--
-- Name: inventory_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_brand_id_seq', 1, true);


--
-- Name: inventory_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_category_id_seq', 1, true);


--
-- Name: inventory_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_class_id_seq', 1, true);


--
-- Name: inventory_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_currency_id_seq', 1, true);


--
-- Name: inventory_godown_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_godown_id_seq', 7, true);


--
-- Name: inventory_gst_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_gst_list_id_seq', 1, false);


--
-- Name: inventory_product_master_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_product_master_id_seq', 5, true);


--
-- Name: inventory_producttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_producttype_id_seq', 2, true);


--
-- Name: inventory_scheme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_scheme_id_seq', 1, false);


--
-- Name: inventory_std_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_std_rate_id_seq', 4, true);


--
-- Name: inventory_subbrand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_subbrand_id_seq', 1, true);


--
-- Name: inventory_subclass_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_subclass_id_seq', 1, true);


--
-- Name: inventory_unitofmeasure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_unitofmeasure_id_seq', 1, true);


--
-- Name: inventory_uqc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.inventory_uqc_id_seq', 44, true);


--
-- Name: ledgers_asm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_asm_id_seq', 14, true);


--
-- Name: ledgers_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_city_id_seq', 11, true);


--
-- Name: ledgers_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_country_id_seq', 4, true);


--
-- Name: ledgers_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_currency_id_seq', 1, false);


--
-- Name: ledgers_division_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_division_id_seq', 4, true);


--
-- Name: ledgers_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_group_id_seq', 6, true);


--
-- Name: ledgers_ledgerstype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_ledgerstype_id_seq', 13, true);


--
-- Name: ledgers_party_contact_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_party_contact_details_id_seq', 1, false);


--
-- Name: ledgers_party_master_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_party_master_id_seq', 12, true);


--
-- Name: ledgers_party_master_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_party_master_products_id_seq', 1, false);


--
-- Name: ledgers_partytype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_partytype_id_seq', 3, true);


--
-- Name: ledgers_price_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_price_level_id_seq', 5, true);


--
-- Name: ledgers_price_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_price_list_id_seq', 6, true);


--
-- Name: ledgers_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_region_id_seq', 12, true);


--
-- Name: ledgers_rsm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_rsm_id_seq', 13, true);


--
-- Name: ledgers_se_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_se_id_seq', 14, true);


--
-- Name: ledgers_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_state_id_seq', 8, true);


--
-- Name: ledgers_zone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_zone_id_seq', 6, true);


--
-- Name: ledgers_zsm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.ledgers_zsm_id_seq', 6, true);


--
-- Name: planning_bom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.planning_bom_id_seq', 3, true);


--
-- Name: planning_bomitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.planning_bomitems_id_seq', 13, true);


--
-- Name: planning_joborder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.planning_joborder_id_seq', 7, true);


--
-- Name: planning_salesprojection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.planning_salesprojection_id_seq', 1, false);


--
-- Name: production_consitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_consitems_id_seq', 1, true);


--
-- Name: production_consumableindent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_consumableindent_id_seq', 1, true);


--
-- Name: production_consumption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_consumption_id_seq', 6, true);


--
-- Name: production_consumptionitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_consumptionitems_id_seq', 15, true);


--
-- Name: production_jobcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_jobcard_id_seq', 8, true);


--
-- Name: production_rmindent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_rmindent_id_seq', 8, true);


--
-- Name: production_rmindentitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_rmindentitems_id_seq', 14, true);


--
-- Name: production_rmitemgodown_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.production_rmitemgodown_id_seq', 10, true);


--
-- Name: purchase_debitnote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_debitnote_id_seq', 1, true);


--
-- Name: purchase_debitnoteitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_debitnoteitems_id_seq', 1, false);


--
-- Name: purchase_grn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_grn_id_seq', 7, true);


--
-- Name: purchase_grnitems_godown_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_grnitems_godown_id_seq', 1, false);


--
-- Name: purchase_grnitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_grnitems_id_seq', 8, true);


--
-- Name: purchase_piitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_piitems_id_seq', 8, true);


--
-- Name: purchase_poitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_poitems_id_seq', 9, true);


--
-- Name: purchase_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_purchase_id_seq', 7, true);


--
-- Name: purchase_purchase_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_purchase_order_id_seq', 7, true);


--
-- Name: purchase_purchasereturn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_purchasereturn_id_seq', 1, true);


--
-- Name: purchase_purchasereturnitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_purchasereturnitems_id_seq', 1, false);


--
-- Name: purchase_qdn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_qdn_id_seq', 1, true);


--
-- Name: purchase_qdnitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.purchase_qdnitems_id_seq', 1, false);


--
-- Name: sales_creditnote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_creditnote_id_seq', 6, true);


--
-- Name: sales_creditnoteitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_creditnoteitems_id_seq', 5, true);


--
-- Name: sales_delivery_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_delivery_note_id_seq', 7, true);


--
-- Name: sales_dnitems_godown_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_dnitems_godown_id_seq', 14, true);


--
-- Name: sales_dnitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_dnitems_id_seq', 7, true);


--
-- Name: sales_invitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_invitems_id_seq', 11, true);


--
-- Name: sales_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_invoice_id_seq', 11, true);


--
-- Name: sales_loadingsheet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_loadingsheet_id_seq', 7, true);


--
-- Name: sales_packingsheet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_packingsheet_id_seq', 2, true);


--
-- Name: sales_proformainvitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_proformainvitems_id_seq', 1, true);


--
-- Name: sales_proformainvoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_proformainvoice_id_seq', 1, true);


--
-- Name: sales_qdn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_qdn_id_seq', 1, true);


--
-- Name: sales_qdnitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_qdnitems_id_seq', 1, true);


--
-- Name: sales_rso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_rso_id_seq', 9, true);


--
-- Name: sales_rsoitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_rsoitems_id_seq', 3, true);


--
-- Name: sales_saleqty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_saleqty_id_seq', 1, false);


--
-- Name: sales_salesorder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_salesorder_id_seq', 34, true);


--
-- Name: sales_salestarget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_salestarget_id_seq', 1, true);


--
-- Name: sales_soitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.sales_soitems_id_seq', 10, true);


--
-- Name: todo_todo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.todo_todo_id_seq', 1, true);


--
-- Name: warehouse_materialtransferred_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.warehouse_materialtransferred_id_seq', 1, false);


--
-- Name: warehouse_pallettransferentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.warehouse_pallettransferentry_id_seq', 9, true);


--
-- Name: warehouse_shortagedamageentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.warehouse_shortagedamageentry_id_seq', 10, true);


--
-- Name: warehouse_stock_summary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netitest
--

SELECT pg_catalog.setval('public.warehouse_stock_summary_id_seq', 55, true);


--
-- Name: accounts_loggedinuser accounts_loggedinuser_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.accounts_loggedinuser
    ADD CONSTRAINT accounts_loggedinuser_pkey PRIMARY KEY (id);


--
-- Name: accounts_loggedinuser accounts_loggedinuser_user_id_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.accounts_loggedinuser
    ADD CONSTRAINT accounts_loggedinuser_user_id_key UNIQUE (user_id);


--
-- Name: auditlog_logentry auditlog_logentry_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auditlog_logentry
    ADD CONSTRAINT auditlog_logentry_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: company_company company_company_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.company_company
    ADD CONSTRAINT company_company_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: inventory_brand inventory_brand_code_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_brand
    ADD CONSTRAINT inventory_brand_code_key UNIQUE (code);


--
-- Name: inventory_brand inventory_brand_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_brand
    ADD CONSTRAINT inventory_brand_name_key UNIQUE (name);


--
-- Name: inventory_brand inventory_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_brand
    ADD CONSTRAINT inventory_brand_pkey PRIMARY KEY (id);


--
-- Name: inventory_category inventory_category_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_category
    ADD CONSTRAINT inventory_category_name_key UNIQUE (name);


--
-- Name: inventory_category inventory_category_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_category
    ADD CONSTRAINT inventory_category_pkey PRIMARY KEY (id);


--
-- Name: inventory_class inventory_class_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_class
    ADD CONSTRAINT inventory_class_name_key UNIQUE (name);


--
-- Name: inventory_class inventory_class_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_class
    ADD CONSTRAINT inventory_class_pkey PRIMARY KEY (id);


--
-- Name: inventory_currency inventory_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_currency
    ADD CONSTRAINT inventory_currency_pkey PRIMARY KEY (id);


--
-- Name: inventory_godown inventory_godown_name_149036a1_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_godown
    ADD CONSTRAINT inventory_godown_name_149036a1_uniq UNIQUE (name);


--
-- Name: inventory_godown inventory_godown_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_godown
    ADD CONSTRAINT inventory_godown_pkey PRIMARY KEY (id);


--
-- Name: inventory_gst_list inventory_gst_list_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_gst_list
    ADD CONSTRAINT inventory_gst_list_pkey PRIMARY KEY (id);


--
-- Name: inventory_product_master inventory_product_master_article_code_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_master_article_code_key UNIQUE (article_code);


--
-- Name: inventory_product_master inventory_product_master_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_master_pkey PRIMARY KEY (id);


--
-- Name: inventory_product_master inventory_product_master_product_code_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_master_product_code_key UNIQUE (product_code);


--
-- Name: inventory_product_master inventory_product_master_product_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_master_product_name_key UNIQUE (product_name);


--
-- Name: inventory_producttype inventory_producttype_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_producttype
    ADD CONSTRAINT inventory_producttype_name_key UNIQUE (name);


--
-- Name: inventory_producttype inventory_producttype_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_producttype
    ADD CONSTRAINT inventory_producttype_pkey PRIMARY KEY (id);


--
-- Name: inventory_scheme inventory_scheme_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_scheme
    ADD CONSTRAINT inventory_scheme_pkey PRIMARY KEY (id);


--
-- Name: inventory_std_rate inventory_std_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_std_rate
    ADD CONSTRAINT inventory_std_rate_pkey PRIMARY KEY (id);


--
-- Name: inventory_std_rate inventory_std_rate_product_id_rate_type_4f733de5_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_std_rate
    ADD CONSTRAINT inventory_std_rate_product_id_rate_type_4f733de5_uniq UNIQUE (product_id, rate_type);


--
-- Name: inventory_subbrand inventory_subbrand_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_subbrand
    ADD CONSTRAINT inventory_subbrand_name_key UNIQUE (name);


--
-- Name: inventory_subbrand inventory_subbrand_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_subbrand
    ADD CONSTRAINT inventory_subbrand_pkey PRIMARY KEY (id);


--
-- Name: inventory_subclass inventory_subclass_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_subclass
    ADD CONSTRAINT inventory_subclass_name_key UNIQUE (name);


--
-- Name: inventory_subclass inventory_subclass_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_subclass
    ADD CONSTRAINT inventory_subclass_pkey PRIMARY KEY (id);


--
-- Name: inventory_unitofmeasure inventory_unitofmeasure_name_e10c3ae2_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_unitofmeasure
    ADD CONSTRAINT inventory_unitofmeasure_name_e10c3ae2_uniq UNIQUE (name);


--
-- Name: inventory_unitofmeasure inventory_unitofmeasure_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_unitofmeasure
    ADD CONSTRAINT inventory_unitofmeasure_pkey PRIMARY KEY (id);


--
-- Name: inventory_uqc inventory_uqc_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_uqc
    ADD CONSTRAINT inventory_uqc_pkey PRIMARY KEY (id);


--
-- Name: ledgers_asm ledgers_asm_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm
    ADD CONSTRAINT ledgers_asm_pkey PRIMARY KEY (id);


--
-- Name: ledgers_asm ledgers_asm_zone_id_region_id_zsm_id_rsm_id_name_df60e1b4_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm
    ADD CONSTRAINT ledgers_asm_zone_id_region_id_zsm_id_rsm_id_name_df60e1b4_uniq UNIQUE (zone_id, region_id, zsm_id, rsm_id, name);


--
-- Name: ledgers_city ledgers_city_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_city
    ADD CONSTRAINT ledgers_city_pkey PRIMARY KEY (id);


--
-- Name: ledgers_city ledgers_city_state_id_name_22ed0a27_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_city
    ADD CONSTRAINT ledgers_city_state_id_name_22ed0a27_uniq UNIQUE (state_id, name);


--
-- Name: ledgers_country ledgers_country_name_039a24ef_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_country
    ADD CONSTRAINT ledgers_country_name_039a24ef_uniq UNIQUE (name);


--
-- Name: ledgers_country ledgers_country_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_country
    ADD CONSTRAINT ledgers_country_pkey PRIMARY KEY (id);


--
-- Name: ledgers_currency ledgers_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_currency
    ADD CONSTRAINT ledgers_currency_pkey PRIMARY KEY (id);


--
-- Name: ledgers_division ledgers_division_name_e6669870_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_division
    ADD CONSTRAINT ledgers_division_name_e6669870_uniq UNIQUE (name);


--
-- Name: ledgers_division ledgers_division_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_division
    ADD CONSTRAINT ledgers_division_pkey PRIMARY KEY (id);


--
-- Name: ledgers_group ledgers_group_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_group
    ADD CONSTRAINT ledgers_group_name_key UNIQUE (name);


--
-- Name: ledgers_group ledgers_group_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_group
    ADD CONSTRAINT ledgers_group_pkey PRIMARY KEY (id);


--
-- Name: ledgers_ledgerstype ledgers_ledgerstype_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_ledgerstype
    ADD CONSTRAINT ledgers_ledgerstype_pkey PRIMARY KEY (id);


--
-- Name: ledgers_party_contact_details ledgers_party_contact_details_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_contact_details
    ADD CONSTRAINT ledgers_party_contact_details_pkey PRIMARY KEY (id);


--
-- Name: ledgers_party_master ledgers_party_master_name_group_id_09629175_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_name_group_id_09629175_uniq UNIQUE (name, group_id);


--
-- Name: ledgers_party_master ledgers_party_master_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_pkey PRIMARY KEY (id);


--
-- Name: ledgers_party_master_products ledgers_party_master_pro_party_master_id_product__8436537a_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master_products
    ADD CONSTRAINT ledgers_party_master_pro_party_master_id_product__8436537a_uniq UNIQUE (party_master_id, product_master_id);


--
-- Name: ledgers_party_master_products ledgers_party_master_products_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master_products
    ADD CONSTRAINT ledgers_party_master_products_pkey PRIMARY KEY (id);


--
-- Name: ledgers_party_master ledgers_party_master_vendor_code_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_vendor_code_key UNIQUE (vendor_code);


--
-- Name: ledgers_partytype ledgers_partytype_code_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_partytype
    ADD CONSTRAINT ledgers_partytype_code_key UNIQUE (code);


--
-- Name: ledgers_partytype ledgers_partytype_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_partytype
    ADD CONSTRAINT ledgers_partytype_name_key UNIQUE (name);


--
-- Name: ledgers_partytype ledgers_partytype_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_partytype
    ADD CONSTRAINT ledgers_partytype_pkey PRIMARY KEY (id);


--
-- Name: ledgers_price_level ledgers_price_level_code_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_level
    ADD CONSTRAINT ledgers_price_level_code_key UNIQUE (code);


--
-- Name: ledgers_price_level ledgers_price_level_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_level
    ADD CONSTRAINT ledgers_price_level_pkey PRIMARY KEY (id);


--
-- Name: ledgers_price_list ledgers_price_list_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_list
    ADD CONSTRAINT ledgers_price_list_pkey PRIMARY KEY (id);


--
-- Name: ledgers_price_list ledgers_price_list_price_level_id_product_id_d824ec78_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_list
    ADD CONSTRAINT ledgers_price_list_price_level_id_product_id_d824ec78_uniq UNIQUE (price_level_id, product_id);


--
-- Name: ledgers_region ledgers_region_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_region
    ADD CONSTRAINT ledgers_region_pkey PRIMARY KEY (id);


--
-- Name: ledgers_region ledgers_region_zone_id_name_23159cbb_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_region
    ADD CONSTRAINT ledgers_region_zone_id_name_23159cbb_uniq UNIQUE (zone_id, name);


--
-- Name: ledgers_rsm ledgers_rsm_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_rsm
    ADD CONSTRAINT ledgers_rsm_pkey PRIMARY KEY (id);


--
-- Name: ledgers_rsm ledgers_rsm_zone_id_region_id_zsm_id_name_3a52e90b_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_rsm
    ADD CONSTRAINT ledgers_rsm_zone_id_region_id_zsm_id_name_3a52e90b_uniq UNIQUE (zone_id, region_id, zsm_id, name);


--
-- Name: ledgers_se ledgers_se_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_pkey PRIMARY KEY (id);


--
-- Name: ledgers_se ledgers_se_zone_id_region_id_zsm_id_705b4a50_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_zone_id_region_id_zsm_id_705b4a50_uniq UNIQUE (zone_id, region_id, zsm_id, rsm_id, asm_id, name);


--
-- Name: ledgers_state ledgers_state_country_id_name_b7ded001_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_state
    ADD CONSTRAINT ledgers_state_country_id_name_b7ded001_uniq UNIQUE (country_id, name);


--
-- Name: ledgers_state ledgers_state_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_state
    ADD CONSTRAINT ledgers_state_pkey PRIMARY KEY (id);


--
-- Name: ledgers_zone ledgers_zone_name_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zone
    ADD CONSTRAINT ledgers_zone_name_key UNIQUE (name);


--
-- Name: ledgers_zone ledgers_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zone
    ADD CONSTRAINT ledgers_zone_pkey PRIMARY KEY (id);


--
-- Name: ledgers_zsm ledgers_zsm_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zsm
    ADD CONSTRAINT ledgers_zsm_pkey PRIMARY KEY (id);


--
-- Name: ledgers_zsm ledgers_zsm_zone_id_name_244578bb_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zsm
    ADD CONSTRAINT ledgers_zsm_zone_id_name_244578bb_uniq UNIQUE (zone_id, name);


--
-- Name: planning_bom planning_bom_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bom
    ADD CONSTRAINT planning_bom_pkey PRIMARY KEY (id);


--
-- Name: planning_bomitems planning_bomitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bomitems
    ADD CONSTRAINT planning_bomitems_pkey PRIMARY KEY (id);


--
-- Name: planning_joborder planning_joborder_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_joborder
    ADD CONSTRAINT planning_joborder_pkey PRIMARY KEY (id);


--
-- Name: planning_salesprojection planning_salesprojection_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_salesprojection
    ADD CONSTRAINT planning_salesprojection_pkey PRIMARY KEY (id);


--
-- Name: planning_salesprojection planning_salesprojection_product_id_division_id_f_9c2495f4_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_salesprojection
    ADD CONSTRAINT planning_salesprojection_product_id_division_id_f_9c2495f4_uniq UNIQUE (product_id, division_id, from_date, to_date);


--
-- Name: production_consitems production_consitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consitems
    ADD CONSTRAINT production_consitems_pkey PRIMARY KEY (id);


--
-- Name: production_consumableindent production_consumableindent_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumableindent
    ADD CONSTRAINT production_consumableindent_pkey PRIMARY KEY (id);


--
-- Name: production_consumption production_consumption_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumption
    ADD CONSTRAINT production_consumption_pkey PRIMARY KEY (id);


--
-- Name: production_consumptionitems production_consumptionitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumptionitems
    ADD CONSTRAINT production_consumptionitems_pkey PRIMARY KEY (id);


--
-- Name: production_jobcard production_jobcard_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_jobcard
    ADD CONSTRAINT production_jobcard_pkey PRIMARY KEY (id);


--
-- Name: production_rmindent production_rmindent_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindent
    ADD CONSTRAINT production_rmindent_pkey PRIMARY KEY (id);


--
-- Name: production_rmindentitems production_rmindentitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindentitems
    ADD CONSTRAINT production_rmindentitems_pkey PRIMARY KEY (id);


--
-- Name: production_rmitemgodown production_rmitemgodown_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmitemgodown
    ADD CONSTRAINT production_rmitemgodown_pkey PRIMARY KEY (id);


--
-- Name: purchase_debitnote purchase_debitnote_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnote
    ADD CONSTRAINT purchase_debitnote_pkey PRIMARY KEY (id);


--
-- Name: purchase_debitnoteitems purchase_debitnoteitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnoteitems
    ADD CONSTRAINT purchase_debitnoteitems_pkey PRIMARY KEY (id);


--
-- Name: purchase_grn purchase_grn_company_id_grn_no_4c65735e_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_company_id_grn_no_4c65735e_uniq UNIQUE (company_id, grn_no);


--
-- Name: purchase_grn purchase_grn_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_pkey PRIMARY KEY (id);


--
-- Name: purchase_grnitems_godown purchase_grnitems_godown_grnitems_id_godown_id_496b6a3e_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems_godown
    ADD CONSTRAINT purchase_grnitems_godown_grnitems_id_godown_id_496b6a3e_uniq UNIQUE (grnitems_id, godown_id);


--
-- Name: purchase_grnitems_godown purchase_grnitems_godown_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems_godown
    ADD CONSTRAINT purchase_grnitems_godown_pkey PRIMARY KEY (id);


--
-- Name: purchase_grnitems purchase_grnitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems
    ADD CONSTRAINT purchase_grnitems_pkey PRIMARY KEY (id);


--
-- Name: purchase_piitems purchase_piitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_piitems
    ADD CONSTRAINT purchase_piitems_pkey PRIMARY KEY (id);


--
-- Name: purchase_poitems purchase_poitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_poitems
    ADD CONSTRAINT purchase_poitems_pkey PRIMARY KEY (id);


--
-- Name: purchase_purchase purchase_purchase_company_id_pi_no_7df49b86_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase
    ADD CONSTRAINT purchase_purchase_company_id_pi_no_7df49b86_uniq UNIQUE (company_id, pi_no);


--
-- Name: purchase_purchase_order purchase_purchase_order_company_id_po_no_4aab01de_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_order_company_id_po_no_4aab01de_uniq UNIQUE (company_id, po_no);


--
-- Name: purchase_purchase_order purchase_purchase_order_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_order_pkey PRIMARY KEY (id);


--
-- Name: purchase_purchase_order purchase_purchase_order_ref_no_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_order_ref_no_key UNIQUE (ref_no);


--
-- Name: purchase_purchase purchase_purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase
    ADD CONSTRAINT purchase_purchase_pkey PRIMARY KEY (id);


--
-- Name: purchase_purchasereturn purchase_purchasereturn_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturn
    ADD CONSTRAINT purchase_purchasereturn_pkey PRIMARY KEY (id);


--
-- Name: purchase_purchasereturnitems purchase_purchasereturnitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturnitems
    ADD CONSTRAINT purchase_purchasereturnitems_pkey PRIMARY KEY (id);


--
-- Name: purchase_qdn purchase_qdn_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdn
    ADD CONSTRAINT purchase_qdn_pkey PRIMARY KEY (id);


--
-- Name: purchase_qdnitems purchase_qdnitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdnitems
    ADD CONSTRAINT purchase_qdnitems_pkey PRIMARY KEY (id);


--
-- Name: sales_creditnote sales_creditnote_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnote
    ADD CONSTRAINT sales_creditnote_pkey PRIMARY KEY (id);


--
-- Name: sales_creditnoteitems sales_creditnoteitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnoteitems
    ADD CONSTRAINT sales_creditnoteitems_pkey PRIMARY KEY (id);


--
-- Name: sales_delivery_note sales_delivery_note_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_pkey PRIMARY KEY (id);


--
-- Name: sales_delivery_note sales_delivery_note_sales_order_id_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_sales_order_id_key UNIQUE (sales_order_id);


--
-- Name: sales_dnitems_godown sales_dnitems_godown_dnitems_id_godown_id_3fd124db_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems_godown
    ADD CONSTRAINT sales_dnitems_godown_dnitems_id_godown_id_3fd124db_uniq UNIQUE (dnitems_id, godown_id);


--
-- Name: sales_dnitems_godown sales_dnitems_godown_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems_godown
    ADD CONSTRAINT sales_dnitems_godown_pkey PRIMARY KEY (id);


--
-- Name: sales_dnitems sales_dnitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems
    ADD CONSTRAINT sales_dnitems_pkey PRIMARY KEY (id);


--
-- Name: sales_invitems sales_invitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invitems
    ADD CONSTRAINT sales_invitems_pkey PRIMARY KEY (id);


--
-- Name: sales_invoice sales_invoice_company_id_inv_no_957ded20_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_company_id_inv_no_957ded20_uniq UNIQUE (company_id, inv_no);


--
-- Name: sales_invoice sales_invoice_dn_id_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_dn_id_key UNIQUE (dn_id);


--
-- Name: sales_invoice sales_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_pkey PRIMARY KEY (id);


--
-- Name: sales_loadingsheet sales_loadingsheet_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_loadingsheet
    ADD CONSTRAINT sales_loadingsheet_pkey PRIMARY KEY (id);


--
-- Name: sales_packingsheet sales_packingsheet_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_packingsheet
    ADD CONSTRAINT sales_packingsheet_pkey PRIMARY KEY (id);


--
-- Name: sales_proformainvitems sales_proformainvitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvitems
    ADD CONSTRAINT sales_proformainvitems_pkey PRIMARY KEY (id);


--
-- Name: sales_proformainvoice sales_proformainvoice_dn_id_key; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoice_dn_id_key UNIQUE (dn_id);


--
-- Name: sales_proformainvoice sales_proformainvoice_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoice_pkey PRIMARY KEY (id);


--
-- Name: sales_qdn sales_qdn_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdn
    ADD CONSTRAINT sales_qdn_pkey PRIMARY KEY (id);


--
-- Name: sales_qdnitems sales_qdnitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdnitems
    ADD CONSTRAINT sales_qdnitems_pkey PRIMARY KEY (id);


--
-- Name: sales_rso sales_rso_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rso
    ADD CONSTRAINT sales_rso_pkey PRIMARY KEY (id);


--
-- Name: sales_rsoitems sales_rsoitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rsoitems
    ADD CONSTRAINT sales_rsoitems_pkey PRIMARY KEY (id);


--
-- Name: sales_saleqty sales_saleqty_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_saleqty
    ADD CONSTRAINT sales_saleqty_pkey PRIMARY KEY (id);


--
-- Name: sales_salesorder sales_salesorder_company_id_so_no_6ac52c11_uniq; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder
    ADD CONSTRAINT sales_salesorder_company_id_so_no_6ac52c11_uniq UNIQUE (company_id, so_no);


--
-- Name: sales_salesorder sales_salesorder_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder
    ADD CONSTRAINT sales_salesorder_pkey PRIMARY KEY (id);


--
-- Name: sales_salestarget sales_salestarget_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_pkey PRIMARY KEY (id);


--
-- Name: sales_soitems sales_soitems_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_soitems
    ADD CONSTRAINT sales_soitems_pkey PRIMARY KEY (id);


--
-- Name: todo_todo todo_todo_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.todo_todo
    ADD CONSTRAINT todo_todo_pkey PRIMARY KEY (id);


--
-- Name: warehouse_materialtransferred warehouse_materialtransferred_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_materialtransferred
    ADD CONSTRAINT warehouse_materialtransferred_pkey PRIMARY KEY (id);


--
-- Name: warehouse_pallettransferentry warehouse_pallettransferentry_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_pallettransferentry
    ADD CONSTRAINT warehouse_pallettransferentry_pkey PRIMARY KEY (id);


--
-- Name: warehouse_shortagedamageentry warehouse_shortagedamageentry_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry
    ADD CONSTRAINT warehouse_shortagedamageentry_pkey PRIMARY KEY (id);


--
-- Name: warehouse_stock_summary warehouse_stock_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_stock_summary
    ADD CONSTRAINT warehouse_stock_summary_pkey PRIMARY KEY (id);


--
-- Name: auditlog_logentry_action_229afe39; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auditlog_logentry_action_229afe39 ON public.auditlog_logentry USING btree (action);


--
-- Name: auditlog_logentry_actor_id_959271d2; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auditlog_logentry_actor_id_959271d2 ON public.auditlog_logentry USING btree (actor_id);


--
-- Name: auditlog_logentry_content_type_id_75830218; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auditlog_logentry_content_type_id_75830218 ON public.auditlog_logentry USING btree (content_type_id);


--
-- Name: auditlog_logentry_object_id_09c2eee8; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auditlog_logentry_object_id_09c2eee8 ON public.auditlog_logentry USING btree (object_id);


--
-- Name: auditlog_logentry_object_pk_6e3219c0; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auditlog_logentry_object_pk_6e3219c0 ON public.auditlog_logentry USING btree (object_pk);


--
-- Name: auditlog_logentry_object_pk_6e3219c0_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auditlog_logentry_object_pk_6e3219c0_like ON public.auditlog_logentry USING btree (object_pk varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: inventory_brand_code_d87b66cb_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_brand_code_d87b66cb_like ON public.inventory_brand USING btree (code varchar_pattern_ops);


--
-- Name: inventory_brand_name_a633939c_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_brand_name_a633939c_like ON public.inventory_brand USING btree (name varchar_pattern_ops);


--
-- Name: inventory_category_name_c89a8bc0_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_category_name_c89a8bc0_like ON public.inventory_category USING btree (name varchar_pattern_ops);


--
-- Name: inventory_class_name_c852ed6f_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_class_name_c852ed6f_like ON public.inventory_class USING btree (name varchar_pattern_ops);


--
-- Name: inventory_godown_name_149036a1_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_godown_name_149036a1_like ON public.inventory_godown USING btree (name varchar_pattern_ops);


--
-- Name: inventory_godown_parent_id_681905be; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_godown_parent_id_681905be ON public.inventory_godown USING btree (parent_id);


--
-- Name: inventory_gst_list_product_id_a248d6f0; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_gst_list_product_id_a248d6f0 ON public.inventory_gst_list USING btree (product_id);


--
-- Name: inventory_product_master_additional_units_id_39060db4; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_additional_units_id_39060db4 ON public.inventory_product_master USING btree (additional_units_id);


--
-- Name: inventory_product_master_article_code_21cfa8d7_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_article_code_21cfa8d7_like ON public.inventory_product_master USING btree (article_code varchar_pattern_ops);


--
-- Name: inventory_product_master_brand_id_bcea378f; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_brand_id_bcea378f ON public.inventory_product_master USING btree (brand_id);


--
-- Name: inventory_product_master_category_id_ba2cf3a7; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_category_id_ba2cf3a7 ON public.inventory_product_master USING btree (category_id);


--
-- Name: inventory_product_master_dl_purchase_id_d67204dc; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_dl_purchase_id_d67204dc ON public.inventory_product_master USING btree (dl_purchase_id);


--
-- Name: inventory_product_master_dl_sales_id_bafd2377; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_dl_sales_id_bafd2377 ON public.inventory_product_master USING btree (dl_sales_id);


--
-- Name: inventory_product_master_product_class_id_1a83ec05; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_product_class_id_1a83ec05 ON public.inventory_product_master USING btree (product_class_id);


--
-- Name: inventory_product_master_product_code_744b7efe_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_product_code_744b7efe_like ON public.inventory_product_master USING btree (product_code varchar_pattern_ops);


--
-- Name: inventory_product_master_product_name_dd0d2648_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_product_name_dd0d2648_like ON public.inventory_product_master USING btree (product_name varchar_pattern_ops);


--
-- Name: inventory_product_master_product_type_id_6e52eda5; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_product_type_id_6e52eda5 ON public.inventory_product_master USING btree (product_type_id);


--
-- Name: inventory_product_master_sub_brand_id_86c0db65; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_sub_brand_id_86c0db65 ON public.inventory_product_master USING btree (sub_brand_id);


--
-- Name: inventory_product_master_sub_class_id_2294a951; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_sub_class_id_2294a951 ON public.inventory_product_master USING btree (sub_class_id);


--
-- Name: inventory_product_master_units_of_measure_id_697831de; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_product_master_units_of_measure_id_697831de ON public.inventory_product_master USING btree (units_of_measure_id);


--
-- Name: inventory_producttype_dl_purchase_id_a06b54ee; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_producttype_dl_purchase_id_a06b54ee ON public.inventory_producttype USING btree (dl_purchase_id);


--
-- Name: inventory_producttype_dl_sales_id_547fb4b8; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_producttype_dl_sales_id_547fb4b8 ON public.inventory_producttype USING btree (dl_sales_id);


--
-- Name: inventory_producttype_name_4db68bb1_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_producttype_name_4db68bb1_like ON public.inventory_producttype USING btree (name varchar_pattern_ops);


--
-- Name: inventory_std_rate_product_id_c239ace5; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_std_rate_product_id_c239ace5 ON public.inventory_std_rate USING btree (product_id);


--
-- Name: inventory_subbrand_name_3588bc77_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_subbrand_name_3588bc77_like ON public.inventory_subbrand USING btree (name varchar_pattern_ops);


--
-- Name: inventory_subclass_name_15b2ffd7_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_subclass_name_15b2ffd7_like ON public.inventory_subclass USING btree (name varchar_pattern_ops);


--
-- Name: inventory_unitofmeasure_name_e10c3ae2_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_unitofmeasure_name_e10c3ae2_like ON public.inventory_unitofmeasure USING btree (name varchar_pattern_ops);


--
-- Name: inventory_unitofmeasure_uqc_id_d60e6ebe; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX inventory_unitofmeasure_uqc_id_d60e6ebe ON public.inventory_unitofmeasure USING btree (uqc_id);


--
-- Name: ledgers_asm_region_id_a8ea7b6b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_asm_region_id_a8ea7b6b ON public.ledgers_asm USING btree (region_id);


--
-- Name: ledgers_asm_rsm_id_3eef3f87; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_asm_rsm_id_3eef3f87 ON public.ledgers_asm USING btree (rsm_id);


--
-- Name: ledgers_asm_zone_id_f28d1d00; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_asm_zone_id_f28d1d00 ON public.ledgers_asm USING btree (zone_id);


--
-- Name: ledgers_asm_zsm_id_b349aae1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_asm_zsm_id_b349aae1 ON public.ledgers_asm USING btree (zsm_id);


--
-- Name: ledgers_city_state_id_2478b5a2; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_city_state_id_2478b5a2 ON public.ledgers_city USING btree (state_id);


--
-- Name: ledgers_country_name_039a24ef_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_country_name_039a24ef_like ON public.ledgers_country USING btree (name varchar_pattern_ops);


--
-- Name: ledgers_division_name_e6669870_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_division_name_e6669870_like ON public.ledgers_division USING btree (name varchar_pattern_ops);


--
-- Name: ledgers_group_name_6f01add3_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_group_name_6f01add3_like ON public.ledgers_group USING btree (name varchar_pattern_ops);


--
-- Name: ledgers_ledgerstype_under_id_3419457e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_ledgerstype_under_id_3419457e ON public.ledgers_ledgerstype USING btree (under_id);


--
-- Name: ledgers_party_contact_details_city_id_f4db2692; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_contact_details_city_id_f4db2692 ON public.ledgers_party_contact_details USING btree (city_id);


--
-- Name: ledgers_party_contact_details_country_id_668e9fcf; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_contact_details_country_id_668e9fcf ON public.ledgers_party_contact_details USING btree (country_id);


--
-- Name: ledgers_party_contact_details_party_id_0a2fdbd5; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_contact_details_party_id_0a2fdbd5 ON public.ledgers_party_contact_details USING btree (party_id);


--
-- Name: ledgers_party_contact_details_state_id_a4cdd81a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_contact_details_state_id_a4cdd81a ON public.ledgers_party_contact_details USING btree (state_id);


--
-- Name: ledgers_party_master_asm_id_d8205515; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_asm_id_d8205515 ON public.ledgers_party_master USING btree (asm_id);


--
-- Name: ledgers_party_master_city_id_7bb2dab3; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_city_id_7bb2dab3 ON public.ledgers_party_master USING btree (city_id);


--
-- Name: ledgers_party_master_country_id_efdb3805; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_country_id_efdb3805 ON public.ledgers_party_master USING btree (country_id);


--
-- Name: ledgers_party_master_devision_id_fb7319fc; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_devision_id_fb7319fc ON public.ledgers_party_master USING btree (devision_id);


--
-- Name: ledgers_party_master_group_id_98c77307; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_group_id_98c77307 ON public.ledgers_party_master USING btree (group_id);


--
-- Name: ledgers_party_master_party_type_id_0d0835c1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_party_type_id_0d0835c1 ON public.ledgers_party_master USING btree (party_type_id);


--
-- Name: ledgers_party_master_price_level_id_ea1b4d78; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_price_level_id_ea1b4d78 ON public.ledgers_party_master USING btree (price_level_id);


--
-- Name: ledgers_party_master_products_party_master_id_0c4ed41a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_products_party_master_id_0c4ed41a ON public.ledgers_party_master_products USING btree (party_master_id);


--
-- Name: ledgers_party_master_products_product_master_id_b640438a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_products_product_master_id_b640438a ON public.ledgers_party_master_products USING btree (product_master_id);


--
-- Name: ledgers_party_master_region_id_7a63eac6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_region_id_7a63eac6 ON public.ledgers_party_master USING btree (region_id);


--
-- Name: ledgers_party_master_rsm_id_60157f5b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_rsm_id_60157f5b ON public.ledgers_party_master USING btree (rsm_id);


--
-- Name: ledgers_party_master_se_id_661753ed; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_se_id_661753ed ON public.ledgers_party_master USING btree (se_id);


--
-- Name: ledgers_party_master_state_id_569af902; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_state_id_569af902 ON public.ledgers_party_master USING btree (state_id);


--
-- Name: ledgers_party_master_vendor_code_95b17618_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_vendor_code_95b17618_like ON public.ledgers_party_master USING btree (vendor_code varchar_pattern_ops);


--
-- Name: ledgers_party_master_zone_id_1cc1c389; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_zone_id_1cc1c389 ON public.ledgers_party_master USING btree (zone_id);


--
-- Name: ledgers_party_master_zsm_id_da4e3da5; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_party_master_zsm_id_da4e3da5 ON public.ledgers_party_master USING btree (zsm_id);


--
-- Name: ledgers_partytype_code_cebeeb4b_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_partytype_code_cebeeb4b_like ON public.ledgers_partytype USING btree (code varchar_pattern_ops);


--
-- Name: ledgers_partytype_name_db7ff8d1_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_partytype_name_db7ff8d1_like ON public.ledgers_partytype USING btree (name varchar_pattern_ops);


--
-- Name: ledgers_price_level_code_cca6924e_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_price_level_code_cca6924e_like ON public.ledgers_price_level USING btree (code varchar_pattern_ops);


--
-- Name: ledgers_price_list_price_level_id_3cade415; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_price_list_price_level_id_3cade415 ON public.ledgers_price_list USING btree (price_level_id);


--
-- Name: ledgers_price_list_product_id_9b08ed1e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_price_list_product_id_9b08ed1e ON public.ledgers_price_list USING btree (product_id);


--
-- Name: ledgers_region_zone_id_7828ba57; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_region_zone_id_7828ba57 ON public.ledgers_region USING btree (zone_id);


--
-- Name: ledgers_rsm_region_id_56f2ef76; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_rsm_region_id_56f2ef76 ON public.ledgers_rsm USING btree (region_id);


--
-- Name: ledgers_rsm_zone_id_b42132a9; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_rsm_zone_id_b42132a9 ON public.ledgers_rsm USING btree (zone_id);


--
-- Name: ledgers_rsm_zsm_id_73e3187a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_rsm_zsm_id_73e3187a ON public.ledgers_rsm USING btree (zsm_id);


--
-- Name: ledgers_se_asm_id_8038ebb6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_se_asm_id_8038ebb6 ON public.ledgers_se USING btree (asm_id);


--
-- Name: ledgers_se_region_id_78218558; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_se_region_id_78218558 ON public.ledgers_se USING btree (region_id);


--
-- Name: ledgers_se_rsm_id_c78441d1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_se_rsm_id_c78441d1 ON public.ledgers_se USING btree (rsm_id);


--
-- Name: ledgers_se_zone_id_cff9e636; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_se_zone_id_cff9e636 ON public.ledgers_se USING btree (zone_id);


--
-- Name: ledgers_se_zsm_id_7b9ec584; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_se_zsm_id_7b9ec584 ON public.ledgers_se USING btree (zsm_id);


--
-- Name: ledgers_state_country_id_089c497b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_state_country_id_089c497b ON public.ledgers_state USING btree (country_id);


--
-- Name: ledgers_zone_name_58b51db9_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_zone_name_58b51db9_like ON public.ledgers_zone USING btree (name varchar_pattern_ops);


--
-- Name: ledgers_zsm_zone_id_72ae1e9b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX ledgers_zsm_zone_id_72ae1e9b ON public.ledgers_zsm USING btree (zone_id);


--
-- Name: planning_bom_product_id_4b114863; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_bom_product_id_4b114863 ON public.planning_bom USING btree (product_id);


--
-- Name: planning_bomitems_bom_id_3e986a8c; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_bomitems_bom_id_3e986a8c ON public.planning_bomitems USING btree (bom_id);


--
-- Name: planning_bomitems_item_id_e897c24f; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_bomitems_item_id_e897c24f ON public.planning_bomitems USING btree (item_id);


--
-- Name: planning_joborder_bom_id_ecb5f0a3; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_joborder_bom_id_ecb5f0a3 ON public.planning_joborder USING btree (bom_id);


--
-- Name: planning_joborder_company_id_bb70f360; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_joborder_company_id_bb70f360 ON public.planning_joborder USING btree (company_id);


--
-- Name: planning_joborder_product_id_c4502735; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_joborder_product_id_c4502735 ON public.planning_joborder USING btree (product_id);


--
-- Name: planning_salesprojection_division_id_64f5c68a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_salesprojection_division_id_64f5c68a ON public.planning_salesprojection USING btree (division_id);


--
-- Name: planning_salesprojection_product_id_ae858974; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX planning_salesprojection_product_id_ae858974 ON public.planning_salesprojection USING btree (product_id);


--
-- Name: production_consitems_indent_id_e57e6361; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consitems_indent_id_e57e6361 ON public.production_consitems USING btree (indent_id);


--
-- Name: production_consitems_item_id_f6ae1895; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consitems_item_id_f6ae1895 ON public.production_consitems USING btree (item_id);


--
-- Name: production_consumableindent_company_id_ec7a4e39; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumableindent_company_id_ec7a4e39 ON public.production_consumableindent USING btree (company_id);


--
-- Name: production_consumableindent_drawn_by_id_8b491816; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumableindent_drawn_by_id_8b491816 ON public.production_consumableindent USING btree (drawn_by_id);


--
-- Name: production_consumableindent_issuer_id_ad70cdff; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumableindent_issuer_id_ad70cdff ON public.production_consumableindent USING btree (issuer_id);


--
-- Name: production_consumption_company_id_17b3ec35; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumption_company_id_17b3ec35 ON public.production_consumption USING btree (company_id);


--
-- Name: production_consumption_jobcard_id_0dd6f23d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumption_jobcard_id_0dd6f23d ON public.production_consumption USING btree (jobcard_id);


--
-- Name: production_consumptionitems_consumption_id_cc0483c6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumptionitems_consumption_id_cc0483c6 ON public.production_consumptionitems USING btree (consumption_id);


--
-- Name: production_consumptionitems_item_id_98fb3229; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_consumptionitems_item_id_98fb3229 ON public.production_consumptionitems USING btree (item_id);


--
-- Name: production_jobcard_company_id_20f43857; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_jobcard_company_id_20f43857 ON public.production_jobcard USING btree (company_id);


--
-- Name: production_jobcard_joborder_id_b8b18f04; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_jobcard_joborder_id_b8b18f04 ON public.production_jobcard USING btree (joborder_id);


--
-- Name: production_jobcard_product_id_f0ad9a32; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_jobcard_product_id_f0ad9a32 ON public.production_jobcard USING btree (product_id);


--
-- Name: production_rmindent_company_id_01ae1275; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_rmindent_company_id_01ae1275 ON public.production_rmindent USING btree (company_id);


--
-- Name: production_rmindent_jobcard_id_6c7837c6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_rmindent_jobcard_id_6c7837c6 ON public.production_rmindent USING btree (jobcard_id);


--
-- Name: production_rmindentitems_bom_id_aff02f09; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_rmindentitems_bom_id_aff02f09 ON public.production_rmindentitems USING btree (bom_id);


--
-- Name: production_rmindentitems_item_id_76d2ef8d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_rmindentitems_item_id_76d2ef8d ON public.production_rmindentitems USING btree (item_id);


--
-- Name: production_rmindentitems_rmindent_id_1ab51a1b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_rmindentitems_rmindent_id_1ab51a1b ON public.production_rmindentitems USING btree (rmindent_id);


--
-- Name: production_rmitemgodown_rmitem_id_6754cec5; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX production_rmitemgodown_rmitem_id_6754cec5 ON public.production_rmitemgodown USING btree (rmitem_id);


--
-- Name: purchase_debitnote_company_id_76783a66; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_debitnote_company_id_76783a66 ON public.purchase_debitnote USING btree (company_id);


--
-- Name: purchase_debitnote_pi_no_id_a8531929; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_debitnote_pi_no_id_a8531929 ON public.purchase_debitnote USING btree (pi_no_id);


--
-- Name: purchase_debitnote_seller_id_804acf3a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_debitnote_seller_id_804acf3a ON public.purchase_debitnote USING btree (seller_id);


--
-- Name: purchase_debitnote_shipto_id_f3e34773; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_debitnote_shipto_id_f3e34773 ON public.purchase_debitnote USING btree (shipto_id);


--
-- Name: purchase_debitnoteitems_debitNote_id_d989f200; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX "purchase_debitnoteitems_debitNote_id_d989f200" ON public.purchase_debitnoteitems USING btree ("debitNote_id");


--
-- Name: purchase_debitnoteitems_item_id_c40ed644; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_debitnoteitems_item_id_c40ed644 ON public.purchase_debitnoteitems USING btree (item_id);


--
-- Name: purchase_grn_company_id_bd8138ec; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grn_company_id_bd8138ec ON public.purchase_grn USING btree (company_id);


--
-- Name: purchase_grn_other_ledger_id_d9cb3019; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grn_other_ledger_id_d9cb3019 ON public.purchase_grn USING btree (other_ledger_id);


--
-- Name: purchase_grn_pi_id_2aa5b8be; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grn_pi_id_2aa5b8be ON public.purchase_grn USING btree (pi_id);


--
-- Name: purchase_grn_po_id_c297215e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grn_po_id_c297215e ON public.purchase_grn USING btree (po_id);


--
-- Name: purchase_grn_seller_id_94179f26; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grn_seller_id_94179f26 ON public.purchase_grn USING btree (seller_id);


--
-- Name: purchase_grn_shipto_id_b1ec08ba; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grn_shipto_id_b1ec08ba ON public.purchase_grn USING btree (shipto_id);


--
-- Name: purchase_grnitems_godown_godown_id_5129ab3c; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grnitems_godown_godown_id_5129ab3c ON public.purchase_grnitems_godown USING btree (godown_id);


--
-- Name: purchase_grnitems_godown_grnitems_id_f3e79be7; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grnitems_godown_grnitems_id_f3e79be7 ON public.purchase_grnitems_godown USING btree (grnitems_id);


--
-- Name: purchase_grnitems_grn_id_d9c42744; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grnitems_grn_id_d9c42744 ON public.purchase_grnitems USING btree (grn_id);


--
-- Name: purchase_grnitems_item_id_7438bfde; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_grnitems_item_id_7438bfde ON public.purchase_grnitems USING btree (item_id);


--
-- Name: purchase_piitems_grn_id_d91d1960; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_piitems_grn_id_d91d1960 ON public.purchase_piitems USING btree (grn_id);


--
-- Name: purchase_piitems_item_id_e602d768; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_piitems_item_id_e602d768 ON public.purchase_piitems USING btree (item_id);


--
-- Name: purchase_piitems_pi_id_90040854; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_piitems_pi_id_90040854 ON public.purchase_piitems USING btree (pi_id);


--
-- Name: purchase_poitems_item_id_e619e58e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_poitems_item_id_e619e58e ON public.purchase_poitems USING btree (item_id);


--
-- Name: purchase_poitems_po_id_2dcf3686; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_poitems_po_id_2dcf3686 ON public.purchase_poitems USING btree (po_id);


--
-- Name: purchase_purchase_company_id_fb01341d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_company_id_fb01341d ON public.purchase_purchase USING btree (company_id);


--
-- Name: purchase_purchase_order_company_id_c34232a9; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_order_company_id_c34232a9 ON public.purchase_purchase_order USING btree (company_id);


--
-- Name: purchase_purchase_order_other_ledger_id_9d9421b3; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_order_other_ledger_id_9d9421b3 ON public.purchase_purchase_order USING btree (other_ledger_id);


--
-- Name: purchase_purchase_order_ref_no_2b36dfd2_like; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_order_ref_no_2b36dfd2_like ON public.purchase_purchase_order USING btree (ref_no varchar_pattern_ops);


--
-- Name: purchase_purchase_order_seller_id_6f6bd0a0; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_order_seller_id_6f6bd0a0 ON public.purchase_purchase_order USING btree (seller_id);


--
-- Name: purchase_purchase_order_shipto_id_467c0671; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_order_shipto_id_467c0671 ON public.purchase_purchase_order USING btree (shipto_id);


--
-- Name: purchase_purchase_other_ledger_id_4e12ef76; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_other_ledger_id_4e12ef76 ON public.purchase_purchase USING btree (other_ledger_id);


--
-- Name: purchase_purchase_seller_id_1b771f29; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_seller_id_1b771f29 ON public.purchase_purchase USING btree (seller_id);


--
-- Name: purchase_purchase_shipto_id_0b99f499; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchase_shipto_id_0b99f499 ON public.purchase_purchase USING btree (shipto_id);


--
-- Name: purchase_purchasereturn_company_id_c6c2b8cf; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchasereturn_company_id_c6c2b8cf ON public.purchase_purchasereturn USING btree (company_id);


--
-- Name: purchase_purchasereturn_pi_no_id_75738b62; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchasereturn_pi_no_id_75738b62 ON public.purchase_purchasereturn USING btree (pi_no_id);


--
-- Name: purchase_purchasereturn_seller_id_a8d4398f; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchasereturn_seller_id_a8d4398f ON public.purchase_purchasereturn USING btree (seller_id);


--
-- Name: purchase_purchasereturn_shipto_id_5c06c3c6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchasereturn_shipto_id_5c06c3c6 ON public.purchase_purchasereturn USING btree (shipto_id);


--
-- Name: purchase_purchasereturnitems_item_id_6e3e0108; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchasereturnitems_item_id_6e3e0108 ON public.purchase_purchasereturnitems USING btree (item_id);


--
-- Name: purchase_purchasereturnitems_pr_id_ff484449; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_purchasereturnitems_pr_id_ff484449 ON public.purchase_purchasereturnitems USING btree (pr_id);


--
-- Name: purchase_qdn_company_id_cacd60d8; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_qdn_company_id_cacd60d8 ON public.purchase_qdn USING btree (company_id);


--
-- Name: purchase_qdn_pi_no_id_bed8816c; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_qdn_pi_no_id_bed8816c ON public.purchase_qdn USING btree (pi_no_id);


--
-- Name: purchase_qdn_seller_id_6a7cf76c; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_qdn_seller_id_6a7cf76c ON public.purchase_qdn USING btree (seller_id);


--
-- Name: purchase_qdn_shipto_id_ccf09b4f; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_qdn_shipto_id_ccf09b4f ON public.purchase_qdn USING btree (shipto_id);


--
-- Name: purchase_qdnitems_item_id_394c0e78; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_qdnitems_item_id_394c0e78 ON public.purchase_qdnitems USING btree (item_id);


--
-- Name: purchase_qdnitems_qdn_id_71e7d364; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX purchase_qdnitems_qdn_id_71e7d364 ON public.purchase_qdnitems USING btree (qdn_id);


--
-- Name: sales_creditnote_buyer_id_48af7d9c; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_creditnote_buyer_id_48af7d9c ON public.sales_creditnote USING btree (buyer_id);


--
-- Name: sales_creditnote_company_id_eeca9f69; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_creditnote_company_id_eeca9f69 ON public.sales_creditnote USING btree (company_id);


--
-- Name: sales_creditnote_inv_id_b14f69a4; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_creditnote_inv_id_b14f69a4 ON public.sales_creditnote USING btree (inv_id);


--
-- Name: sales_creditnote_other_ledger_id_4a802d75; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_creditnote_other_ledger_id_4a802d75 ON public.sales_creditnote USING btree (other_ledger_id);


--
-- Name: sales_creditnoteitems_creditNote_id_a419206d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX "sales_creditnoteitems_creditNote_id_a419206d" ON public.sales_creditnoteitems USING btree (inv_id);


--
-- Name: sales_creditnoteitems_item_id_0dd91958; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_creditnoteitems_item_id_0dd91958 ON public.sales_creditnoteitems USING btree (item_id);


--
-- Name: sales_delivery_note_buyer_id_2177e031; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_delivery_note_buyer_id_2177e031 ON public.sales_delivery_note USING btree (buyer_id);


--
-- Name: sales_delivery_note_company_id_e85317d4; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_delivery_note_company_id_e85317d4 ON public.sales_delivery_note USING btree (company_id);


--
-- Name: sales_delivery_note_other_ledger_id_f4babb1a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_delivery_note_other_ledger_id_f4babb1a ON public.sales_delivery_note USING btree (other_ledger_id);


--
-- Name: sales_delivery_note_shipto_id_32731e89; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_delivery_note_shipto_id_32731e89 ON public.sales_delivery_note USING btree (shipto_id);


--
-- Name: sales_dnitems_dn_id_cc91e4ca; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_dnitems_dn_id_cc91e4ca ON public.sales_dnitems USING btree (dn_id);


--
-- Name: sales_dnitems_godown_dnitems_id_b6d08f10; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_dnitems_godown_dnitems_id_b6d08f10 ON public.sales_dnitems_godown USING btree (dnitems_id);


--
-- Name: sales_dnitems_godown_godown_id_0ed94df5; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_dnitems_godown_godown_id_0ed94df5 ON public.sales_dnitems_godown USING btree (godown_id);


--
-- Name: sales_dnitems_item_id_423e8ff2; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_dnitems_item_id_423e8ff2 ON public.sales_dnitems USING btree (item_id);


--
-- Name: sales_invitems_inv_id_abc8540f; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_invitems_inv_id_abc8540f ON public.sales_invitems USING btree (inv_id);


--
-- Name: sales_invitems_item_id_ff78efab; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_invitems_item_id_ff78efab ON public.sales_invitems USING btree (item_id);


--
-- Name: sales_invoice_buyer_id_56622845; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_invoice_buyer_id_56622845 ON public.sales_invoice USING btree (buyer_id);


--
-- Name: sales_invoice_company_id_1f3b101e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_invoice_company_id_1f3b101e ON public.sales_invoice USING btree (company_id);


--
-- Name: sales_invoice_other_ledger_id_8387567a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_invoice_other_ledger_id_8387567a ON public.sales_invoice USING btree (other_ledger_id);


--
-- Name: sales_invoice_shipto_id_5c0f09fa; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_invoice_shipto_id_5c0f09fa ON public.sales_invoice USING btree (shipto_id);


--
-- Name: sales_loadingsheet_company_id_abaf8f62; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_loadingsheet_company_id_abaf8f62 ON public.sales_loadingsheet USING btree (company_id);


--
-- Name: sales_loadingsheet_dn_id_e752dcf1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_loadingsheet_dn_id_e752dcf1 ON public.sales_loadingsheet USING btree (dn_id);


--
-- Name: sales_loadingsheet_item_id_f18f9811; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_loadingsheet_item_id_f18f9811 ON public.sales_loadingsheet USING btree (item_id);


--
-- Name: sales_packingsheet_company_id_3eef23bd; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_packingsheet_company_id_3eef23bd ON public.sales_packingsheet USING btree (company_id);


--
-- Name: sales_packingsheet_dn_id_ed5497d7; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_packingsheet_dn_id_ed5497d7 ON public.sales_packingsheet USING btree (dn_id);


--
-- Name: sales_packingsheet_item_id_8fbf372e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_packingsheet_item_id_8fbf372e ON public.sales_packingsheet USING btree (item_id);


--
-- Name: sales_proformainvitems_inv_id_c2fd6c0f; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_proformainvitems_inv_id_c2fd6c0f ON public.sales_proformainvitems USING btree (inv_id);


--
-- Name: sales_proformainvitems_item_id_02c98424; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_proformainvitems_item_id_02c98424 ON public.sales_proformainvitems USING btree (item_id);


--
-- Name: sales_proformainvoice_buyer_id_ca7a856b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_proformainvoice_buyer_id_ca7a856b ON public.sales_proformainvoice USING btree (buyer_id);


--
-- Name: sales_proformainvoice_company_id_83789ef1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_proformainvoice_company_id_83789ef1 ON public.sales_proformainvoice USING btree (company_id);


--
-- Name: sales_proformainvoice_other_ledger_id_de1f2eae; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_proformainvoice_other_ledger_id_de1f2eae ON public.sales_proformainvoice USING btree (other_ledger_id);


--
-- Name: sales_proformainvoice_shipto_id_77f223cf; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_proformainvoice_shipto_id_77f223cf ON public.sales_proformainvoice USING btree (shipto_id);


--
-- Name: sales_qdn_buyer_id_6ed6fca4; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_qdn_buyer_id_6ed6fca4 ON public.sales_qdn USING btree (buyer_id);


--
-- Name: sales_qdn_company_id_42bcfbfe; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_qdn_company_id_42bcfbfe ON public.sales_qdn USING btree (company_id);


--
-- Name: sales_qdn_inv_id_c1dc7b06; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_qdn_inv_id_c1dc7b06 ON public.sales_qdn USING btree (inv_id);


--
-- Name: sales_qdnitems_item_id_702ea031; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_qdnitems_item_id_702ea031 ON public.sales_qdnitems USING btree (item_id);


--
-- Name: sales_qdnitems_qdn_id_3c5441d0; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_qdnitems_qdn_id_3c5441d0 ON public.sales_qdnitems USING btree (inv_id);


--
-- Name: sales_rso_buyer_id_fb8a2aba; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_rso_buyer_id_fb8a2aba ON public.sales_rso USING btree (buyer_id);


--
-- Name: sales_rso_company_id_3012327a; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_rso_company_id_3012327a ON public.sales_rso USING btree (company_id);


--
-- Name: sales_rso_inv_id_57f9db99; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_rso_inv_id_57f9db99 ON public.sales_rso USING btree (inv_id);


--
-- Name: sales_rsoitems_item_id_e7c4e99e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_rsoitems_item_id_e7c4e99e ON public.sales_rsoitems USING btree (item_id);


--
-- Name: sales_rsoitems_rso_id_3918892d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_rsoitems_rso_id_3918892d ON public.sales_rsoitems USING btree (inv_id);


--
-- Name: sales_saleqty_company_id_bafcd955; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_saleqty_company_id_bafcd955 ON public.sales_saleqty USING btree (company_id);


--
-- Name: sales_saleqty_product_id_75bd4db6; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_saleqty_product_id_75bd4db6 ON public.sales_saleqty USING btree (product_id);


--
-- Name: sales_salesorder_buyer_id_138f55de; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salesorder_buyer_id_138f55de ON public.sales_salesorder USING btree (buyer_id);


--
-- Name: sales_salesorder_company_id_224d4587; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salesorder_company_id_224d4587 ON public.sales_salesorder USING btree (company_id);


--
-- Name: sales_salesorder_other_ledger_id_80d0e9d1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salesorder_other_ledger_id_80d0e9d1 ON public.sales_salesorder USING btree (other_ledger_id);


--
-- Name: sales_salesorder_shipto_id_974fd86d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salesorder_shipto_id_974fd86d ON public.sales_salesorder USING btree (shipto_id);


--
-- Name: sales_salestarget_asm_id_ce94597e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_asm_id_ce94597e ON public.sales_salestarget USING btree (asm_id);


--
-- Name: sales_salestarget_customer_id_58d8a898; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_customer_id_58d8a898 ON public.sales_salestarget USING btree (buyer_id);


--
-- Name: sales_salestarget_region_id_347b6e84; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_region_id_347b6e84 ON public.sales_salestarget USING btree (region_id);


--
-- Name: sales_salestarget_rsm_id_fc863101; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_rsm_id_fc863101 ON public.sales_salestarget USING btree (rsm_id);


--
-- Name: sales_salestarget_se_id_6d5bdc73; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_se_id_6d5bdc73 ON public.sales_salestarget USING btree (se_id);


--
-- Name: sales_salestarget_zone_id_c3f92e82; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_zone_id_c3f92e82 ON public.sales_salestarget USING btree (zone_id);


--
-- Name: sales_salestarget_zsm_id_36c5ce5e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_salestarget_zsm_id_36c5ce5e ON public.sales_salestarget USING btree (zsm_id);


--
-- Name: sales_soitems_item_id_5748dd5d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_soitems_item_id_5748dd5d ON public.sales_soitems USING btree (item_id);


--
-- Name: sales_soitems_so_id_e121e38e; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX sales_soitems_so_id_e121e38e ON public.sales_soitems USING btree (so_id);


--
-- Name: warehouse_materialtransferred_godown_id_6604330d; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_materialtransferred_godown_id_6604330d ON public.warehouse_materialtransferred USING btree (godown_id);


--
-- Name: warehouse_materialtransferred_indent_id_98431067; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_materialtransferred_indent_id_98431067 ON public.warehouse_materialtransferred USING btree (indent_id);


--
-- Name: warehouse_materialtransferred_item_id_f23a5634; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_materialtransferred_item_id_f23a5634 ON public.warehouse_materialtransferred USING btree (item_id);


--
-- Name: warehouse_pallettransferentry_company_id_b5aeae28; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_pallettransferentry_company_id_b5aeae28 ON public.warehouse_pallettransferentry USING btree (company_id);


--
-- Name: warehouse_pallettransferentry_item_id_e8ce6d93; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_pallettransferentry_item_id_e8ce6d93 ON public.warehouse_pallettransferentry USING btree (item_id);


--
-- Name: warehouse_shortagedamageentry_company_id_ce910660; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_shortagedamageentry_company_id_ce910660 ON public.warehouse_shortagedamageentry USING btree (company_id);


--
-- Name: warehouse_shortagedamageentry_godown_id_3881f871; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_shortagedamageentry_godown_id_3881f871 ON public.warehouse_shortagedamageentry USING btree (godown_id);


--
-- Name: warehouse_shortagedamageentry_item_id_631d35bc; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_shortagedamageentry_item_id_631d35bc ON public.warehouse_shortagedamageentry USING btree (item_id);


--
-- Name: warehouse_shortagedamageentry_jobwork_id_46602a85; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_shortagedamageentry_jobwork_id_46602a85 ON public.warehouse_shortagedamageentry USING btree (jobwork_id);


--
-- Name: warehouse_shortagedamageentry_purchase_id_59c03fd1; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_shortagedamageentry_purchase_id_59c03fd1 ON public.warehouse_shortagedamageentry USING btree (purchase_id);


--
-- Name: warehouse_stock_summary_company_id_288c984b; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_stock_summary_company_id_288c984b ON public.warehouse_stock_summary USING btree (company_id);


--
-- Name: warehouse_stock_summary_godown_id_26a3beaa; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_stock_summary_godown_id_26a3beaa ON public.warehouse_stock_summary USING btree (godown_id);


--
-- Name: warehouse_stock_summary_product_id_194a6357; Type: INDEX; Schema: public; Owner: netitest
--

CREATE INDEX warehouse_stock_summary_product_id_194a6357 ON public.warehouse_stock_summary USING btree (product_id);


--
-- Name: accounts_loggedinuser accounts_loggedinuser_user_id_a35f46e4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.accounts_loggedinuser
    ADD CONSTRAINT accounts_loggedinuser_user_id_a35f46e4_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auditlog_logentry auditlog_logentry_actor_id_959271d2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auditlog_logentry
    ADD CONSTRAINT auditlog_logentry_actor_id_959271d2_fk_auth_user_id FOREIGN KEY (actor_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auditlog_logentry auditlog_logentry_content_type_id_75830218_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auditlog_logentry
    ADD CONSTRAINT auditlog_logentry_content_type_id_75830218_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_godown inventory_godown_parent_id_681905be_fk_inventory_godown_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_godown
    ADD CONSTRAINT inventory_godown_parent_id_681905be_fk_inventory_godown_id FOREIGN KEY (parent_id) REFERENCES public.inventory_godown(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_gst_list inventory_gst_list_product_id_a248d6f0_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_gst_list
    ADD CONSTRAINT inventory_gst_list_product_id_a248d6f0_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_additional_units_id_39060db4_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_additional_units_id_39060db4_fk_inventory FOREIGN KEY (additional_units_id) REFERENCES public.inventory_unitofmeasure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_brand_id_bcea378f_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_brand_id_bcea378f_fk_inventory FOREIGN KEY (brand_id) REFERENCES public.inventory_brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_category_id_ba2cf3a7_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_category_id_ba2cf3a7_fk_inventory FOREIGN KEY (category_id) REFERENCES public.inventory_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_dl_purchase_id_d67204dc_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_dl_purchase_id_d67204dc_fk_ledgers_l FOREIGN KEY (dl_purchase_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_dl_sales_id_bafd2377_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_dl_sales_id_bafd2377_fk_ledgers_l FOREIGN KEY (dl_sales_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_product_class_id_1a83ec05_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_product_class_id_1a83ec05_fk_inventory FOREIGN KEY (product_class_id) REFERENCES public.inventory_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_product_type_id_6e52eda5_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_product_type_id_6e52eda5_fk_inventory FOREIGN KEY (product_type_id) REFERENCES public.inventory_producttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_sub_brand_id_86c0db65_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_sub_brand_id_86c0db65_fk_inventory FOREIGN KEY (sub_brand_id) REFERENCES public.inventory_subbrand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_sub_class_id_2294a951_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_sub_class_id_2294a951_fk_inventory FOREIGN KEY (sub_class_id) REFERENCES public.inventory_subclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_product_master inventory_product_ma_units_of_measure_id_697831de_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_product_master
    ADD CONSTRAINT inventory_product_ma_units_of_measure_id_697831de_fk_inventory FOREIGN KEY (units_of_measure_id) REFERENCES public.inventory_unitofmeasure(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_producttype inventory_producttyp_dl_purchase_id_a06b54ee_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_producttype
    ADD CONSTRAINT inventory_producttyp_dl_purchase_id_a06b54ee_fk_ledgers_l FOREIGN KEY (dl_purchase_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_producttype inventory_producttyp_dl_sales_id_547fb4b8_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_producttype
    ADD CONSTRAINT inventory_producttyp_dl_sales_id_547fb4b8_fk_ledgers_l FOREIGN KEY (dl_sales_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_std_rate inventory_std_rate_product_id_c239ace5_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_std_rate
    ADD CONSTRAINT inventory_std_rate_product_id_c239ace5_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_unitofmeasure inventory_unitofmeasure_uqc_id_d60e6ebe_fk_inventory_uqc_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.inventory_unitofmeasure
    ADD CONSTRAINT inventory_unitofmeasure_uqc_id_d60e6ebe_fk_inventory_uqc_id FOREIGN KEY (uqc_id) REFERENCES public.inventory_uqc(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_asm ledgers_asm_region_id_a8ea7b6b_fk_ledgers_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm
    ADD CONSTRAINT ledgers_asm_region_id_a8ea7b6b_fk_ledgers_region_id FOREIGN KEY (region_id) REFERENCES public.ledgers_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_asm ledgers_asm_rsm_id_3eef3f87_fk_ledgers_rsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm
    ADD CONSTRAINT ledgers_asm_rsm_id_3eef3f87_fk_ledgers_rsm_id FOREIGN KEY (rsm_id) REFERENCES public.ledgers_rsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_asm ledgers_asm_zone_id_f28d1d00_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm
    ADD CONSTRAINT ledgers_asm_zone_id_f28d1d00_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_asm ledgers_asm_zsm_id_b349aae1_fk_ledgers_zsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_asm
    ADD CONSTRAINT ledgers_asm_zsm_id_b349aae1_fk_ledgers_zsm_id FOREIGN KEY (zsm_id) REFERENCES public.ledgers_zsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_city ledgers_city_state_id_2478b5a2_fk_ledgers_state_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_city
    ADD CONSTRAINT ledgers_city_state_id_2478b5a2_fk_ledgers_state_id FOREIGN KEY (state_id) REFERENCES public.ledgers_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_ledgerstype ledgers_ledgerstype_under_id_3419457e_fk_ledgers_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_ledgerstype
    ADD CONSTRAINT ledgers_ledgerstype_under_id_3419457e_fk_ledgers_group_id FOREIGN KEY (under_id) REFERENCES public.ledgers_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_contact_details ledgers_party_contac_city_id_f4db2692_fk_ledgers_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_contact_details
    ADD CONSTRAINT ledgers_party_contac_city_id_f4db2692_fk_ledgers_c FOREIGN KEY (city_id) REFERENCES public.ledgers_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_contact_details ledgers_party_contac_country_id_668e9fcf_fk_ledgers_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_contact_details
    ADD CONSTRAINT ledgers_party_contac_country_id_668e9fcf_fk_ledgers_c FOREIGN KEY (country_id) REFERENCES public.ledgers_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_contact_details ledgers_party_contac_party_id_0a2fdbd5_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_contact_details
    ADD CONSTRAINT ledgers_party_contac_party_id_0a2fdbd5_fk_ledgers_p FOREIGN KEY (party_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_contact_details ledgers_party_contac_state_id_a4cdd81a_fk_ledgers_s; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_contact_details
    ADD CONSTRAINT ledgers_party_contac_state_id_a4cdd81a_fk_ledgers_s FOREIGN KEY (state_id) REFERENCES public.ledgers_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_asm_id_d8205515_fk_ledgers_asm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_asm_id_d8205515_fk_ledgers_asm_id FOREIGN KEY (asm_id) REFERENCES public.ledgers_asm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_city_id_7bb2dab3_fk_ledgers_city_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_city_id_7bb2dab3_fk_ledgers_city_id FOREIGN KEY (city_id) REFERENCES public.ledgers_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_country_id_efdb3805_fk_ledgers_country_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_country_id_efdb3805_fk_ledgers_country_id FOREIGN KEY (country_id) REFERENCES public.ledgers_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_devision_id_fb7319fc_fk_ledgers_d; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_devision_id_fb7319fc_fk_ledgers_d FOREIGN KEY (devision_id) REFERENCES public.ledgers_division(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_group_id_98c77307_fk_ledgers_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_group_id_98c77307_fk_ledgers_group_id FOREIGN KEY (group_id) REFERENCES public.ledgers_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master_products ledgers_party_master_party_master_id_0c4ed41a_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master_products
    ADD CONSTRAINT ledgers_party_master_party_master_id_0c4ed41a_fk_ledgers_p FOREIGN KEY (party_master_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_party_type_id_0d0835c1_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_party_type_id_0d0835c1_fk_ledgers_p FOREIGN KEY (party_type_id) REFERENCES public.ledgers_partytype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_price_level_id_ea1b4d78_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_price_level_id_ea1b4d78_fk_ledgers_p FOREIGN KEY (price_level_id) REFERENCES public.ledgers_price_level(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master_products ledgers_party_master_product_master_id_b640438a_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master_products
    ADD CONSTRAINT ledgers_party_master_product_master_id_b640438a_fk_inventory FOREIGN KEY (product_master_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_region_id_7a63eac6_fk_ledgers_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_region_id_7a63eac6_fk_ledgers_region_id FOREIGN KEY (region_id) REFERENCES public.ledgers_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_rsm_id_60157f5b_fk_ledgers_rsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_rsm_id_60157f5b_fk_ledgers_rsm_id FOREIGN KEY (rsm_id) REFERENCES public.ledgers_rsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_se_id_661753ed_fk_ledgers_se_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_se_id_661753ed_fk_ledgers_se_id FOREIGN KEY (se_id) REFERENCES public.ledgers_se(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_state_id_569af902_fk_ledgers_state_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_state_id_569af902_fk_ledgers_state_id FOREIGN KEY (state_id) REFERENCES public.ledgers_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_zone_id_1cc1c389_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_zone_id_1cc1c389_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_party_master ledgers_party_master_zsm_id_da4e3da5_fk_ledgers_zsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_party_master
    ADD CONSTRAINT ledgers_party_master_zsm_id_da4e3da5_fk_ledgers_zsm_id FOREIGN KEY (zsm_id) REFERENCES public.ledgers_zsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_price_list ledgers_price_list_price_level_id_3cade415_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_list
    ADD CONSTRAINT ledgers_price_list_price_level_id_3cade415_fk_ledgers_p FOREIGN KEY (price_level_id) REFERENCES public.ledgers_price_level(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_price_list ledgers_price_list_product_id_9b08ed1e_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_price_list
    ADD CONSTRAINT ledgers_price_list_product_id_9b08ed1e_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_region ledgers_region_zone_id_7828ba57_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_region
    ADD CONSTRAINT ledgers_region_zone_id_7828ba57_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_rsm ledgers_rsm_region_id_56f2ef76_fk_ledgers_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_rsm
    ADD CONSTRAINT ledgers_rsm_region_id_56f2ef76_fk_ledgers_region_id FOREIGN KEY (region_id) REFERENCES public.ledgers_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_rsm ledgers_rsm_zone_id_b42132a9_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_rsm
    ADD CONSTRAINT ledgers_rsm_zone_id_b42132a9_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_rsm ledgers_rsm_zsm_id_73e3187a_fk_ledgers_zsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_rsm
    ADD CONSTRAINT ledgers_rsm_zsm_id_73e3187a_fk_ledgers_zsm_id FOREIGN KEY (zsm_id) REFERENCES public.ledgers_zsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_se ledgers_se_asm_id_8038ebb6_fk_ledgers_asm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_asm_id_8038ebb6_fk_ledgers_asm_id FOREIGN KEY (asm_id) REFERENCES public.ledgers_asm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_se ledgers_se_region_id_78218558_fk_ledgers_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_region_id_78218558_fk_ledgers_region_id FOREIGN KEY (region_id) REFERENCES public.ledgers_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_se ledgers_se_rsm_id_c78441d1_fk_ledgers_rsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_rsm_id_c78441d1_fk_ledgers_rsm_id FOREIGN KEY (rsm_id) REFERENCES public.ledgers_rsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_se ledgers_se_zone_id_cff9e636_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_zone_id_cff9e636_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_se ledgers_se_zsm_id_7b9ec584_fk_ledgers_zsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_se
    ADD CONSTRAINT ledgers_se_zsm_id_7b9ec584_fk_ledgers_zsm_id FOREIGN KEY (zsm_id) REFERENCES public.ledgers_zsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_state ledgers_state_country_id_089c497b_fk_ledgers_country_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_state
    ADD CONSTRAINT ledgers_state_country_id_089c497b_fk_ledgers_country_id FOREIGN KEY (country_id) REFERENCES public.ledgers_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ledgers_zsm ledgers_zsm_zone_id_72ae1e9b_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.ledgers_zsm
    ADD CONSTRAINT ledgers_zsm_zone_id_72ae1e9b_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_bom planning_bom_product_id_4b114863_fk_inventory_product_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bom
    ADD CONSTRAINT planning_bom_product_id_4b114863_fk_inventory_product_master_id FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_bomitems planning_bomitems_bom_id_3e986a8c_fk_planning_bom_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bomitems
    ADD CONSTRAINT planning_bomitems_bom_id_3e986a8c_fk_planning_bom_id FOREIGN KEY (bom_id) REFERENCES public.planning_bom(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_bomitems planning_bomitems_item_id_e897c24f_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_bomitems
    ADD CONSTRAINT planning_bomitems_item_id_e897c24f_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_joborder planning_joborder_bom_id_ecb5f0a3_fk_planning_bom_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_joborder
    ADD CONSTRAINT planning_joborder_bom_id_ecb5f0a3_fk_planning_bom_id FOREIGN KEY (bom_id) REFERENCES public.planning_bom(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_joborder planning_joborder_company_id_bb70f360_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_joborder
    ADD CONSTRAINT planning_joborder_company_id_bb70f360_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_joborder planning_joborder_product_id_c4502735_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_joborder
    ADD CONSTRAINT planning_joborder_product_id_c4502735_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_salesprojection planning_salesprojec_division_id_64f5c68a_fk_ledgers_d; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_salesprojection
    ADD CONSTRAINT planning_salesprojec_division_id_64f5c68a_fk_ledgers_d FOREIGN KEY (division_id) REFERENCES public.ledgers_division(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planning_salesprojection planning_salesprojec_product_id_ae858974_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.planning_salesprojection
    ADD CONSTRAINT planning_salesprojec_product_id_ae858974_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consitems production_consitems_indent_id_e57e6361_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consitems
    ADD CONSTRAINT production_consitems_indent_id_e57e6361_fk_productio FOREIGN KEY (indent_id) REFERENCES public.production_consumableindent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consitems production_consitems_item_id_f6ae1895_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consitems
    ADD CONSTRAINT production_consitems_item_id_f6ae1895_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumableindent production_consumabl_company_id_ec7a4e39_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumableindent
    ADD CONSTRAINT production_consumabl_company_id_ec7a4e39_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumableindent production_consumabl_drawn_by_id_8b491816_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumableindent
    ADD CONSTRAINT production_consumabl_drawn_by_id_8b491816_fk_auth_user FOREIGN KEY (drawn_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumableindent production_consumableindent_issuer_id_ad70cdff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumableindent
    ADD CONSTRAINT production_consumableindent_issuer_id_ad70cdff_fk_auth_user_id FOREIGN KEY (issuer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumption production_consumpti_company_id_17b3ec35_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumption
    ADD CONSTRAINT production_consumpti_company_id_17b3ec35_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumptionitems production_consumpti_consumption_id_cc0483c6_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumptionitems
    ADD CONSTRAINT production_consumpti_consumption_id_cc0483c6_fk_productio FOREIGN KEY (consumption_id) REFERENCES public.production_consumption(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumptionitems production_consumpti_item_id_98fb3229_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumptionitems
    ADD CONSTRAINT production_consumpti_item_id_98fb3229_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_consumption production_consumpti_jobcard_id_0dd6f23d_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_consumption
    ADD CONSTRAINT production_consumpti_jobcard_id_0dd6f23d_fk_productio FOREIGN KEY (jobcard_id) REFERENCES public.production_jobcard(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_jobcard production_jobcard_company_id_20f43857_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_jobcard
    ADD CONSTRAINT production_jobcard_company_id_20f43857_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_jobcard production_jobcard_joborder_id_b8b18f04_fk_planning_joborder_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_jobcard
    ADD CONSTRAINT production_jobcard_joborder_id_b8b18f04_fk_planning_joborder_id FOREIGN KEY (joborder_id) REFERENCES public.planning_joborder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_jobcard production_jobcard_product_id_f0ad9a32_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_jobcard
    ADD CONSTRAINT production_jobcard_product_id_f0ad9a32_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_rmindent production_rmindent_company_id_01ae1275_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindent
    ADD CONSTRAINT production_rmindent_company_id_01ae1275_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_rmindent production_rmindent_jobcard_id_6c7837c6_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindent
    ADD CONSTRAINT production_rmindent_jobcard_id_6c7837c6_fk_productio FOREIGN KEY (jobcard_id) REFERENCES public.production_jobcard(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_rmindentitems production_rmindenti_item_id_76d2ef8d_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindentitems
    ADD CONSTRAINT production_rmindenti_item_id_76d2ef8d_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_rmindentitems production_rmindenti_rmindent_id_1ab51a1b_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindentitems
    ADD CONSTRAINT production_rmindenti_rmindent_id_1ab51a1b_fk_productio FOREIGN KEY (rmindent_id) REFERENCES public.production_rmindent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_rmindentitems production_rmindentitems_bom_id_aff02f09_fk_planning_bom_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmindentitems
    ADD CONSTRAINT production_rmindentitems_bom_id_aff02f09_fk_planning_bom_id FOREIGN KEY (bom_id) REFERENCES public.planning_bom(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: production_rmitemgodown production_rmitemgod_rmitem_id_6754cec5_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.production_rmitemgodown
    ADD CONSTRAINT production_rmitemgod_rmitem_id_6754cec5_fk_productio FOREIGN KEY (rmitem_id) REFERENCES public.production_rmindentitems(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_debitnote purchase_debitnote_company_id_76783a66_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnote
    ADD CONSTRAINT purchase_debitnote_company_id_76783a66_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_debitnote purchase_debitnote_pi_no_id_a8531929_fk_purchase_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnote
    ADD CONSTRAINT purchase_debitnote_pi_no_id_a8531929_fk_purchase_purchase_id FOREIGN KEY (pi_no_id) REFERENCES public.purchase_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_debitnote purchase_debitnote_seller_id_804acf3a_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnote
    ADD CONSTRAINT purchase_debitnote_seller_id_804acf3a_fk_ledgers_p FOREIGN KEY (seller_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_debitnote purchase_debitnote_shipto_id_f3e34773_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnote
    ADD CONSTRAINT purchase_debitnote_shipto_id_f3e34773_fk_company_company_id FOREIGN KEY (shipto_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_debitnoteitems purchase_debitnoteit_debitNote_id_d989f200_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnoteitems
    ADD CONSTRAINT "purchase_debitnoteit_debitNote_id_d989f200_fk_purchase_" FOREIGN KEY ("debitNote_id") REFERENCES public.purchase_debitnote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_debitnoteitems purchase_debitnoteit_item_id_c40ed644_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_debitnoteitems
    ADD CONSTRAINT purchase_debitnoteit_item_id_c40ed644_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grn purchase_grn_company_id_bd8138ec_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_company_id_bd8138ec_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grn purchase_grn_other_ledger_id_d9cb3019_fk_ledgers_ledgerstype_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_other_ledger_id_d9cb3019_fk_ledgers_ledgerstype_id FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grn purchase_grn_pi_id_2aa5b8be_fk_purchase_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_pi_id_2aa5b8be_fk_purchase_purchase_id FOREIGN KEY (pi_id) REFERENCES public.purchase_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grn purchase_grn_po_id_c297215e_fk_purchase_purchase_order_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_po_id_c297215e_fk_purchase_purchase_order_id FOREIGN KEY (po_id) REFERENCES public.purchase_purchase_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grn purchase_grn_seller_id_94179f26_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_seller_id_94179f26_fk_ledgers_party_master_id FOREIGN KEY (seller_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grn purchase_grn_shipto_id_b1ec08ba_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grn
    ADD CONSTRAINT purchase_grn_shipto_id_b1ec08ba_fk_company_company_id FOREIGN KEY (shipto_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grnitems_godown purchase_grnitems_go_godown_id_5129ab3c_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems_godown
    ADD CONSTRAINT purchase_grnitems_go_godown_id_5129ab3c_fk_inventory FOREIGN KEY (godown_id) REFERENCES public.inventory_godown(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grnitems_godown purchase_grnitems_go_grnitems_id_f3e79be7_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems_godown
    ADD CONSTRAINT purchase_grnitems_go_grnitems_id_f3e79be7_fk_purchase_ FOREIGN KEY (grnitems_id) REFERENCES public.purchase_grnitems(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grnitems purchase_grnitems_grn_id_d9c42744_fk_purchase_grn_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems
    ADD CONSTRAINT purchase_grnitems_grn_id_d9c42744_fk_purchase_grn_id FOREIGN KEY (grn_id) REFERENCES public.purchase_grn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_grnitems purchase_grnitems_item_id_7438bfde_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_grnitems
    ADD CONSTRAINT purchase_grnitems_item_id_7438bfde_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_piitems purchase_piitems_grn_id_d91d1960_fk_purchase_grn_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_piitems
    ADD CONSTRAINT purchase_piitems_grn_id_d91d1960_fk_purchase_grn_id FOREIGN KEY (grn_id) REFERENCES public.purchase_grn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_piitems purchase_piitems_item_id_e602d768_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_piitems
    ADD CONSTRAINT purchase_piitems_item_id_e602d768_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_piitems purchase_piitems_pi_id_90040854_fk_purchase_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_piitems
    ADD CONSTRAINT purchase_piitems_pi_id_90040854_fk_purchase_purchase_id FOREIGN KEY (pi_id) REFERENCES public.purchase_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_poitems purchase_poitems_item_id_e619e58e_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_poitems
    ADD CONSTRAINT purchase_poitems_item_id_e619e58e_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_poitems purchase_poitems_po_id_2dcf3686_fk_purchase_purchase_order_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_poitems
    ADD CONSTRAINT purchase_poitems_po_id_2dcf3686_fk_purchase_purchase_order_id FOREIGN KEY (po_id) REFERENCES public.purchase_purchase_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase purchase_purchase_company_id_fb01341d_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase
    ADD CONSTRAINT purchase_purchase_company_id_fb01341d_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase_order purchase_purchase_or_company_id_c34232a9_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_or_company_id_c34232a9_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase_order purchase_purchase_or_other_ledger_id_9d9421b3_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_or_other_ledger_id_9d9421b3_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase_order purchase_purchase_or_seller_id_6f6bd0a0_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_or_seller_id_6f6bd0a0_fk_ledgers_p FOREIGN KEY (seller_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase_order purchase_purchase_or_shipto_id_467c0671_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase_order
    ADD CONSTRAINT purchase_purchase_or_shipto_id_467c0671_fk_company_c FOREIGN KEY (shipto_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase purchase_purchase_other_ledger_id_4e12ef76_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase
    ADD CONSTRAINT purchase_purchase_other_ledger_id_4e12ef76_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase purchase_purchase_seller_id_1b771f29_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase
    ADD CONSTRAINT purchase_purchase_seller_id_1b771f29_fk_ledgers_party_master_id FOREIGN KEY (seller_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchase purchase_purchase_shipto_id_0b99f499_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchase
    ADD CONSTRAINT purchase_purchase_shipto_id_0b99f499_fk_company_company_id FOREIGN KEY (shipto_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchasereturn purchase_purchaseret_company_id_c6c2b8cf_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturn
    ADD CONSTRAINT purchase_purchaseret_company_id_c6c2b8cf_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchasereturnitems purchase_purchaseret_item_id_6e3e0108_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturnitems
    ADD CONSTRAINT purchase_purchaseret_item_id_6e3e0108_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchasereturn purchase_purchaseret_pi_no_id_75738b62_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturn
    ADD CONSTRAINT purchase_purchaseret_pi_no_id_75738b62_fk_purchase_ FOREIGN KEY (pi_no_id) REFERENCES public.purchase_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchasereturnitems purchase_purchaseret_pr_id_ff484449_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturnitems
    ADD CONSTRAINT purchase_purchaseret_pr_id_ff484449_fk_purchase_ FOREIGN KEY (pr_id) REFERENCES public.purchase_purchasereturn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchasereturn purchase_purchaseret_seller_id_a8d4398f_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturn
    ADD CONSTRAINT purchase_purchaseret_seller_id_a8d4398f_fk_ledgers_p FOREIGN KEY (seller_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_purchasereturn purchase_purchaseret_shipto_id_5c06c3c6_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_purchasereturn
    ADD CONSTRAINT purchase_purchaseret_shipto_id_5c06c3c6_fk_company_c FOREIGN KEY (shipto_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_qdn purchase_qdn_company_id_cacd60d8_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdn
    ADD CONSTRAINT purchase_qdn_company_id_cacd60d8_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_qdn purchase_qdn_pi_no_id_bed8816c_fk_purchase_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdn
    ADD CONSTRAINT purchase_qdn_pi_no_id_bed8816c_fk_purchase_purchase_id FOREIGN KEY (pi_no_id) REFERENCES public.purchase_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_qdn purchase_qdn_seller_id_6a7cf76c_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdn
    ADD CONSTRAINT purchase_qdn_seller_id_6a7cf76c_fk_ledgers_party_master_id FOREIGN KEY (seller_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_qdn purchase_qdn_shipto_id_ccf09b4f_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdn
    ADD CONSTRAINT purchase_qdn_shipto_id_ccf09b4f_fk_company_company_id FOREIGN KEY (shipto_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_qdnitems purchase_qdnitems_item_id_394c0e78_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdnitems
    ADD CONSTRAINT purchase_qdnitems_item_id_394c0e78_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_qdnitems purchase_qdnitems_qdn_id_71e7d364_fk_purchase_qdn_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.purchase_qdnitems
    ADD CONSTRAINT purchase_qdnitems_qdn_id_71e7d364_fk_purchase_qdn_id FOREIGN KEY (qdn_id) REFERENCES public.purchase_qdn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_creditnote sales_creditnote_buyer_id_48af7d9c_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnote
    ADD CONSTRAINT sales_creditnote_buyer_id_48af7d9c_fk_ledgers_party_master_id FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_creditnote sales_creditnote_company_id_eeca9f69_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnote
    ADD CONSTRAINT sales_creditnote_company_id_eeca9f69_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_creditnote sales_creditnote_inv_id_b14f69a4_fk_sales_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnote
    ADD CONSTRAINT sales_creditnote_inv_id_b14f69a4_fk_sales_invoice_id FOREIGN KEY (inv_id) REFERENCES public.sales_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_creditnote sales_creditnote_other_ledger_id_4a802d75_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnote
    ADD CONSTRAINT sales_creditnote_other_ledger_id_4a802d75_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_creditnoteitems sales_creditnoteitem_item_id_0dd91958_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnoteitems
    ADD CONSTRAINT sales_creditnoteitem_item_id_0dd91958_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_creditnoteitems sales_creditnoteitems_inv_id_3c3f0ba2_fk_sales_creditnote_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_creditnoteitems
    ADD CONSTRAINT sales_creditnoteitems_inv_id_3c3f0ba2_fk_sales_creditnote_id FOREIGN KEY (inv_id) REFERENCES public.sales_creditnote(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_delivery_note sales_delivery_note_buyer_id_2177e031_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_buyer_id_2177e031_fk_ledgers_p FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_delivery_note sales_delivery_note_company_id_e85317d4_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_company_id_e85317d4_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_delivery_note sales_delivery_note_other_ledger_id_f4babb1a_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_other_ledger_id_f4babb1a_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_delivery_note sales_delivery_note_sales_order_id_f7f27461_fk_sales_sal; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_sales_order_id_f7f27461_fk_sales_sal FOREIGN KEY (sales_order_id) REFERENCES public.sales_salesorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_delivery_note sales_delivery_note_shipto_id_32731e89_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_delivery_note
    ADD CONSTRAINT sales_delivery_note_shipto_id_32731e89_fk_ledgers_p FOREIGN KEY (shipto_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_dnitems sales_dnitems_dn_id_cc91e4ca_fk_sales_delivery_note_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems
    ADD CONSTRAINT sales_dnitems_dn_id_cc91e4ca_fk_sales_delivery_note_id FOREIGN KEY (dn_id) REFERENCES public.sales_delivery_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_dnitems_godown sales_dnitems_godown_dnitems_id_b6d08f10_fk_sales_dnitems_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems_godown
    ADD CONSTRAINT sales_dnitems_godown_dnitems_id_b6d08f10_fk_sales_dnitems_id FOREIGN KEY (dnitems_id) REFERENCES public.sales_dnitems(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_dnitems_godown sales_dnitems_godown_godown_id_0ed94df5_fk_inventory_godown_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems_godown
    ADD CONSTRAINT sales_dnitems_godown_godown_id_0ed94df5_fk_inventory_godown_id FOREIGN KEY (godown_id) REFERENCES public.inventory_godown(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_dnitems sales_dnitems_item_id_423e8ff2_fk_inventory_product_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_dnitems
    ADD CONSTRAINT sales_dnitems_item_id_423e8ff2_fk_inventory_product_master_id FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invitems sales_invitems_inv_id_abc8540f_fk_sales_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invitems
    ADD CONSTRAINT sales_invitems_inv_id_abc8540f_fk_sales_invoice_id FOREIGN KEY (inv_id) REFERENCES public.sales_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invitems sales_invitems_item_id_ff78efab_fk_inventory_product_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invitems
    ADD CONSTRAINT sales_invitems_item_id_ff78efab_fk_inventory_product_master_id FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invoice sales_invoice_buyer_id_56622845_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_buyer_id_56622845_fk_ledgers_party_master_id FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invoice sales_invoice_company_id_1f3b101e_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_company_id_1f3b101e_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invoice sales_invoice_dn_id_5f97d605_fk_sales_delivery_note_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_dn_id_5f97d605_fk_sales_delivery_note_id FOREIGN KEY (dn_id) REFERENCES public.sales_delivery_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invoice sales_invoice_other_ledger_id_8387567a_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_other_ledger_id_8387567a_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_invoice sales_invoice_shipto_id_5c0f09fa_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_invoice
    ADD CONSTRAINT sales_invoice_shipto_id_5c0f09fa_fk_ledgers_party_master_id FOREIGN KEY (shipto_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_loadingsheet sales_loadingsheet_company_id_abaf8f62_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_loadingsheet
    ADD CONSTRAINT sales_loadingsheet_company_id_abaf8f62_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_loadingsheet sales_loadingsheet_dn_id_e752dcf1_fk_sales_delivery_note_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_loadingsheet
    ADD CONSTRAINT sales_loadingsheet_dn_id_e752dcf1_fk_sales_delivery_note_id FOREIGN KEY (dn_id) REFERENCES public.sales_delivery_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_loadingsheet sales_loadingsheet_item_id_f18f9811_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_loadingsheet
    ADD CONSTRAINT sales_loadingsheet_item_id_f18f9811_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_packingsheet sales_packingsheet_company_id_3eef23bd_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_packingsheet
    ADD CONSTRAINT sales_packingsheet_company_id_3eef23bd_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_packingsheet sales_packingsheet_dn_id_ed5497d7_fk_sales_delivery_note_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_packingsheet
    ADD CONSTRAINT sales_packingsheet_dn_id_ed5497d7_fk_sales_delivery_note_id FOREIGN KEY (dn_id) REFERENCES public.sales_delivery_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_packingsheet sales_packingsheet_item_id_8fbf372e_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_packingsheet
    ADD CONSTRAINT sales_packingsheet_item_id_8fbf372e_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvitems sales_proformainvite_inv_id_c2fd6c0f_fk_sales_pro; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvitems
    ADD CONSTRAINT sales_proformainvite_inv_id_c2fd6c0f_fk_sales_pro FOREIGN KEY (inv_id) REFERENCES public.sales_proformainvoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvitems sales_proformainvite_item_id_02c98424_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvitems
    ADD CONSTRAINT sales_proformainvite_item_id_02c98424_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvoice sales_proformainvoic_buyer_id_ca7a856b_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoic_buyer_id_ca7a856b_fk_ledgers_p FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvoice sales_proformainvoic_other_ledger_id_de1f2eae_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoic_other_ledger_id_de1f2eae_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvoice sales_proformainvoic_shipto_id_77f223cf_fk_ledgers_p; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoic_shipto_id_77f223cf_fk_ledgers_p FOREIGN KEY (shipto_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvoice sales_proformainvoice_company_id_83789ef1_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoice_company_id_83789ef1_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_proformainvoice sales_proformainvoice_dn_id_8f8add8a_fk_sales_delivery_note_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_proformainvoice
    ADD CONSTRAINT sales_proformainvoice_dn_id_8f8add8a_fk_sales_delivery_note_id FOREIGN KEY (dn_id) REFERENCES public.sales_delivery_note(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_qdn sales_qdn_buyer_id_6ed6fca4_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdn
    ADD CONSTRAINT sales_qdn_buyer_id_6ed6fca4_fk_ledgers_party_master_id FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_qdn sales_qdn_company_id_42bcfbfe_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdn
    ADD CONSTRAINT sales_qdn_company_id_42bcfbfe_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_qdn sales_qdn_inv_id_c1dc7b06_fk_sales_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdn
    ADD CONSTRAINT sales_qdn_inv_id_c1dc7b06_fk_sales_invoice_id FOREIGN KEY (inv_id) REFERENCES public.sales_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_qdnitems sales_qdnitems_inv_id_1bef1a70_fk_sales_qdn_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdnitems
    ADD CONSTRAINT sales_qdnitems_inv_id_1bef1a70_fk_sales_qdn_id FOREIGN KEY (inv_id) REFERENCES public.sales_qdn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_qdnitems sales_qdnitems_item_id_702ea031_fk_inventory_product_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_qdnitems
    ADD CONSTRAINT sales_qdnitems_item_id_702ea031_fk_inventory_product_master_id FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_rso sales_rso_buyer_id_fb8a2aba_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rso
    ADD CONSTRAINT sales_rso_buyer_id_fb8a2aba_fk_ledgers_party_master_id FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_rso sales_rso_company_id_3012327a_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rso
    ADD CONSTRAINT sales_rso_company_id_3012327a_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_rso sales_rso_inv_id_57f9db99_fk_sales_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rso
    ADD CONSTRAINT sales_rso_inv_id_57f9db99_fk_sales_invoice_id FOREIGN KEY (inv_id) REFERENCES public.sales_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_rsoitems sales_rsoitems_inv_id_457ef3f4_fk_sales_rso_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rsoitems
    ADD CONSTRAINT sales_rsoitems_inv_id_457ef3f4_fk_sales_rso_id FOREIGN KEY (inv_id) REFERENCES public.sales_rso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_rsoitems sales_rsoitems_item_id_e7c4e99e_fk_inventory_product_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_rsoitems
    ADD CONSTRAINT sales_rsoitems_item_id_e7c4e99e_fk_inventory_product_master_id FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_saleqty sales_saleqty_company_id_bafcd955_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_saleqty
    ADD CONSTRAINT sales_saleqty_company_id_bafcd955_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_saleqty sales_saleqty_product_id_75bd4db6_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_saleqty
    ADD CONSTRAINT sales_saleqty_product_id_75bd4db6_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salesorder sales_salesorder_buyer_id_138f55de_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder
    ADD CONSTRAINT sales_salesorder_buyer_id_138f55de_fk_ledgers_party_master_id FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salesorder sales_salesorder_company_id_224d4587_fk_company_company_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder
    ADD CONSTRAINT sales_salesorder_company_id_224d4587_fk_company_company_id FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salesorder sales_salesorder_other_ledger_id_80d0e9d1_fk_ledgers_l; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder
    ADD CONSTRAINT sales_salesorder_other_ledger_id_80d0e9d1_fk_ledgers_l FOREIGN KEY (other_ledger_id) REFERENCES public.ledgers_ledgerstype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salesorder sales_salesorder_shipto_id_974fd86d_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salesorder
    ADD CONSTRAINT sales_salesorder_shipto_id_974fd86d_fk_ledgers_party_master_id FOREIGN KEY (shipto_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_asm_id_ce94597e_fk_ledgers_asm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_asm_id_ce94597e_fk_ledgers_asm_id FOREIGN KEY (asm_id) REFERENCES public.ledgers_asm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_buyer_id_32b32da5_fk_ledgers_party_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_buyer_id_32b32da5_fk_ledgers_party_master_id FOREIGN KEY (buyer_id) REFERENCES public.ledgers_party_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_region_id_347b6e84_fk_ledgers_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_region_id_347b6e84_fk_ledgers_region_id FOREIGN KEY (region_id) REFERENCES public.ledgers_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_rsm_id_fc863101_fk_ledgers_rsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_rsm_id_fc863101_fk_ledgers_rsm_id FOREIGN KEY (rsm_id) REFERENCES public.ledgers_rsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_se_id_6d5bdc73_fk_ledgers_se_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_se_id_6d5bdc73_fk_ledgers_se_id FOREIGN KEY (se_id) REFERENCES public.ledgers_se(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_zone_id_c3f92e82_fk_ledgers_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_zone_id_c3f92e82_fk_ledgers_zone_id FOREIGN KEY (zone_id) REFERENCES public.ledgers_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_salestarget sales_salestarget_zsm_id_36c5ce5e_fk_ledgers_zsm_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_salestarget
    ADD CONSTRAINT sales_salestarget_zsm_id_36c5ce5e_fk_ledgers_zsm_id FOREIGN KEY (zsm_id) REFERENCES public.ledgers_zsm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_soitems sales_soitems_item_id_5748dd5d_fk_inventory_product_master_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_soitems
    ADD CONSTRAINT sales_soitems_item_id_5748dd5d_fk_inventory_product_master_id FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_soitems sales_soitems_so_id_e121e38e_fk_sales_salesorder_id; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.sales_soitems
    ADD CONSTRAINT sales_soitems_so_id_e121e38e_fk_sales_salesorder_id FOREIGN KEY (so_id) REFERENCES public.sales_salesorder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_materialtransferred warehouse_materialtr_godown_id_6604330d_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_materialtransferred
    ADD CONSTRAINT warehouse_materialtr_godown_id_6604330d_fk_inventory FOREIGN KEY (godown_id) REFERENCES public.inventory_godown(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_materialtransferred warehouse_materialtr_indent_id_98431067_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_materialtransferred
    ADD CONSTRAINT warehouse_materialtr_indent_id_98431067_fk_productio FOREIGN KEY (indent_id) REFERENCES public.production_rmindent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_materialtransferred warehouse_materialtr_item_id_f23a5634_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_materialtransferred
    ADD CONSTRAINT warehouse_materialtr_item_id_f23a5634_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_pallettransferentry warehouse_pallettran_company_id_b5aeae28_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_pallettransferentry
    ADD CONSTRAINT warehouse_pallettran_company_id_b5aeae28_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_pallettransferentry warehouse_pallettran_item_id_e8ce6d93_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_pallettransferentry
    ADD CONSTRAINT warehouse_pallettran_item_id_e8ce6d93_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_shortagedamageentry warehouse_shortageda_company_id_ce910660_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry
    ADD CONSTRAINT warehouse_shortageda_company_id_ce910660_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_shortagedamageentry warehouse_shortageda_godown_id_3881f871_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry
    ADD CONSTRAINT warehouse_shortageda_godown_id_3881f871_fk_inventory FOREIGN KEY (godown_id) REFERENCES public.inventory_godown(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_shortagedamageentry warehouse_shortageda_item_id_631d35bc_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry
    ADD CONSTRAINT warehouse_shortageda_item_id_631d35bc_fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_shortagedamageentry warehouse_shortageda_jobwork_id_46602a85_fk_productio; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry
    ADD CONSTRAINT warehouse_shortageda_jobwork_id_46602a85_fk_productio FOREIGN KEY (jobwork_id) REFERENCES public.production_jobcard(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_shortagedamageentry warehouse_shortageda_purchase_id_59c03fd1_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_shortagedamageentry
    ADD CONSTRAINT warehouse_shortageda_purchase_id_59c03fd1_fk_purchase_ FOREIGN KEY (purchase_id) REFERENCES public.purchase_purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_stock_summary warehouse_stock_summ_company_id_288c984b_fk_company_c; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_stock_summary
    ADD CONSTRAINT warehouse_stock_summ_company_id_288c984b_fk_company_c FOREIGN KEY (company_id) REFERENCES public.company_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_stock_summary warehouse_stock_summ_godown_id_26a3beaa_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_stock_summary
    ADD CONSTRAINT warehouse_stock_summ_godown_id_26a3beaa_fk_inventory FOREIGN KEY (godown_id) REFERENCES public.inventory_godown(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_stock_summary warehouse_stock_summ_product_id_194a6357_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: netitest
--

ALTER TABLE ONLY public.warehouse_stock_summary
    ADD CONSTRAINT warehouse_stock_summ_product_id_194a6357_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_product_master(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

