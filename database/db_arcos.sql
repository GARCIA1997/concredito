PGDMP     :                    y           db_arcos    13.3    13.3 c    |           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            }           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ~           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    29584    db_arcos    DATABASE     d   CREATE DATABASE db_arcos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE db_arcos;
                postgres    false                        3079    31947 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            �            1259    29608    arco    TABLE     �  CREATE TABLE public.arco (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(300) NOT NULL,
    cordenadas jsonb NOT NULL,
    frecuencia_sincronizacion smallint NOT NULL,
    ip_servidor character varying(18) NOT NULL,
    ip_rfid character varying(18),
    direccion_log character varying(100) NOT NULL,
    tipo_arco character varying(100) NOT NULL,
    id_cat_estado character varying(2),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    id_sis_entidades uuid NOT NULL
);
    DROP TABLE public.arco;
       public         heap    postgres    false    2            �           0    0 
   TABLE arco    COMMENT     @   COMMENT ON TABLE public.arco IS 'Registro de todos los arcos ';
          public          postgres    false    201            �            1259    29614    arco_usuario    TABLE       CREATE TABLE public.arco_usuario (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    id_usuario uuid,
    id_arco uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
     DROP TABLE public.arco_usuario;
       public         heap    postgres    false    2            �           0    0    TABLE arco_usuario    COMMENT     H   COMMENT ON TABLE public.arco_usuario IS 'detalle entre arco y usuario';
          public          postgres    false    202            �            1259    29617    carril    TABLE     �  CREATE TABLE public.carril (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    orientacion character varying(20) NOT NULL,
    "dispositivo " jsonb NOT NULL,
    id_tipo_dispositivo character varying(4) NOT NULL,
    id_arco uuid NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.carril;
       public         heap    postgres    false    2            �           0    0    TABLE carril    COMMENT     j   COMMENT ON TABLE public.carril IS 'se guardan los carriles en los que estas posicionado un dispositivo ';
          public          postgres    false    203            �            1259    29623 
   cat_alerta    TABLE     �  CREATE TABLE public.cat_alerta (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(300),
    nivel_alerta character varying(20) NOT NULL,
    tipo_alerta character varying(1) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.cat_alerta;
       public         heap    postgres    false    2            �           0    0    TABLE cat_alerta    COMMENT     M   COMMENT ON TABLE public.cat_alerta IS 'se registran los tipos  de alertas ';
          public          postgres    false    204            �           0    0    COLUMN cat_alerta.tipo_alerta    COMMENT     �   COMMENT ON COLUMN public.cat_alerta.tipo_alerta IS 'hay dos tipos alertas, de estado del arco = 0 y de reporte de un carro o lectura  = 1';
          public          postgres    false    204            �            1259    29626 
   cat_estado    TABLE       CREATE TABLE public.cat_estado (
    id character varying(2) DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(50) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.cat_estado;
       public         heap    postgres    false    2            �           0    0    TABLE cat_estado    COMMENT     �   COMMENT ON TABLE public.cat_estado IS 'Se registran todos los estados posibles que puede adquirir un registro de cualquiera de las tablas de esta BD';
          public          postgres    false    205            �            1259    29629    cat_tipo_arco    TABLE     s  CREATE TABLE public.cat_tipo_arco (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(200) NOT NULL,
    id_cat_estado character varying(2) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE public.cat_tipo_arco;
       public         heap    postgres    false    2            �           0    0    TABLE cat_tipo_arco    COMMENT     �   COMMENT ON TABLE public.cat_tipo_arco IS 'Catalogo de tipo de arcos creado solamente para mostrar en front y evitar errores humanos';
          public          postgres    false    206            �            1259    29632    cat_tipo_dispositivo    TABLE     Y  CREATE TABLE public.cat_tipo_dispositivo (
    id character varying(4) DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(500) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 (   DROP TABLE public.cat_tipo_dispositivo;
       public         heap    postgres    false    2            �           0    0    TABLE cat_tipo_dispositivo    COMMENT     i   COMMENT ON TABLE public.cat_tipo_dispositivo IS 'Se registra los dispositivos  como antenas o camaras ';
          public          postgres    false    207            �            1259    29638    fuente_externa    TABLE     C  CREATE TABLE public.fuente_externa (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(80) NOT NULL,
    nombre_corto character varying(30) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 "   DROP TABLE public.fuente_externa;
       public         heap    postgres    false    2            �            1259    29641    lectura_repuve    TABLE     ]  CREATE TABLE public.lectura_repuve (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    fecha_hora timestamp(6) without time zone NOT NULL,
    nci character varying(50),
    tid character varying(50),
    niv character varying(18),
    id_carril uuid NOT NULL,
    fec_lectura date,
    hora_lectura time(6) without time zone,
    num_placa character varying(15),
    marca character varying(25),
    modelo character varying(25),
    color character varying(25),
    img_vehiculo character varying(10485760),
    estatus_vehiculos character varying(2),
    cve_medio_lectura character varying(3)[],
    tipo_cierre boolean,
    cve_lista_negra uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    cve_arco uuid DEFAULT public.uuid_generate_v1() NOT NULL
);
 "   DROP TABLE public.lectura_repuve;
       public         heap    postgres    false    2    2            �            1259    29647    reporte    TABLE     +  CREATE TABLE public.reporte (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    niv character varying(18),
    cordenadas jsonb,
    placas character varying(20),
    id_cat_estado character varying(2) NOT NULL,
    id_cat_alerta uuid NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    nombre character varying(50) NOT NULL,
    marca character varying(50),
    modelo character varying,
    color character varying,
    id_sis_entidades uuid
);
    DROP TABLE public.reporte;
       public         heap    postgres    false    2            �           0    0    COLUMN reporte.nombre    COMMENT     Q   COMMENT ON COLUMN public.reporte.nombre IS 'Nombre identificador para usuarios';
          public          postgres    false    210            �            1259    29653    reporte_lectura_reporte    TABLE     3  CREATE TABLE public.reporte_lectura_reporte (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    id_reporte uuid NOT NULL,
    id_lectura_repuve uuid NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 +   DROP TABLE public.reporte_lectura_reporte;
       public         heap    postgres    false    2            �            1259    29656    sis_entidad    TABLE     @  CREATE TABLE public.sis_entidad (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(80) NOT NULL,
    id_cat_estado character varying(2) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.sis_entidad;
       public         heap    postgres    false    2            �           0    0    TABLE sis_entidad    COMMENT     z   COMMENT ON TABLE public.sis_entidad IS 'Aqui se registran todas las empresas o instituciones que tien acceso al sistema';
          public          postgres    false    212            �            1259    29659 
   sis_perfil    TABLE     a  CREATE TABLE public.sis_perfil (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nombre character varying(50) NOT NULL,
    id_cat_estado character varying(2) NOT NULL,
    id_sis_entidad uuid NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.sis_perfil;
       public         heap    postgres    false    2            �           0    0    TABLE sis_perfil    COMMENT     �   COMMENT ON TABLE public.sis_perfil IS 'se registran los perfiles posibles de una entidad 
Entiendanse perfil como el conjunto de secciones "vistas"  del  sistema';
          public          postgres    false    213            �            1259    29662    sis_perfil_sis_seccion    TABLE     d  CREATE TABLE public.sis_perfil_sis_seccion (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    id_sis_perfil uuid NOT NULL,
    id_sis_seccion uuid NOT NULL,
    id_sis_permiso character varying(2) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 *   DROP TABLE public.sis_perfil_sis_seccion;
       public         heap    postgres    false    2            �           0    0    TABLE sis_perfil_sis_seccion    COMMENT     b   COMMENT ON TABLE public.sis_perfil_sis_seccion IS 'es el detalle entre sis_Perfil y sis_seccion';
          public          postgres    false    214            �            1259    29665    sis_permiso    TABLE     "  CREATE TABLE public.sis_permiso (
    id character varying(2) DEFAULT public.uuid_generate_v1() NOT NULL,
    "nombre " character varying(25) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.sis_permiso;
       public         heap    postgres    false    2            �           0    0    TABLE sis_permiso    COMMENT     �   COMMENT ON TABLE public.sis_permiso IS 'catalogo de permisos que se le pueden dar a un usuario en  una seccion por ejemplo solo lectura';
          public          postgres    false    215            �            1259    29668    sis_seccion    TABLE     C  CREATE TABLE public.sis_seccion (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    "nombre " character varying(50) NOT NULL,
    id_cat_estado character varying(2) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.sis_seccion;
       public         heap    postgres    false    2            �           0    0    TABLE sis_seccion    COMMENT     �   COMMENT ON TABLE public.sis_seccion IS 'Se registran todas las vistas que va a tener el sistema, cada vista es igual a una seccion';
          public          postgres    false    216            �            1259    29671    unidad_repuve    TABLE     �  CREATE TABLE public.unidad_repuve (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    niv character varying(18) NOT NULL,
    placa_rfid character varying(50),
    modelo character varying(50),
    color character varying(50),
    numero_serie_vehiculo character varying(100),
    placa character varying(20),
    marca_vehiculo character varying(50),
    nci character varying(100),
    tid character varying(100),
    id_cat_estado character varying(2),
    tipo_vehiculo character varying(100),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE public.unidad_repuve;
       public         heap    postgres    false    2            �           0    0    TABLE unidad_repuve    COMMENT     <   COMMENT ON TABLE public.unidad_repuve IS 'registro repuve';
          public          postgres    false    217            �            1259    29677    usuario    TABLE     �  CREATE TABLE public.usuario (
    id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    nip character varying(4),
    nombre character varying(100) NOT NULL,
    correo character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    telefono character varying(10),
    id_cat_estado character varying(2) NOT NULL,
    id_sis_entidad uuid NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.usuario;
       public         heap    postgres    false    2            �           0    0    TABLE usuario    COMMENT     W   COMMENT ON TABLE public.usuario IS 'Que mas puedo decir... Pues Usuarios del sistema';
          public          postgres    false    218            h          0    29608    arco 
   TABLE DATA           �   COPY public.arco (id, nombre, descripcion, cordenadas, frecuencia_sincronizacion, ip_servidor, ip_rfid, direccion_log, tipo_arco, id_cat_estado, "createdAt", "updatedAt", id_sis_entidades) FROM stdin;
    public          postgres    false    201   ��       i          0    29614    arco_usuario 
   TABLE DATA           Y   COPY public.arco_usuario (id, id_usuario, id_arco, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    202   �       j          0    29617    carril 
   TABLE DATA           y   COPY public.carril (id, orientacion, "dispositivo ", id_tipo_dispositivo, id_arco, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    203   ��       k          0    29623 
   cat_alerta 
   TABLE DATA           r   COPY public.cat_alerta (id, nombre, descripcion, nivel_alerta, tipo_alerta, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    204   r�       l          0    29626 
   cat_estado 
   TABLE DATA           J   COPY public.cat_estado (id, nombre, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    205   ��       m          0    29629    cat_tipo_arco 
   TABLE DATA           i   COPY public.cat_tipo_arco (id, nombre, descripcion, id_cat_estado, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    206   R�       n          0    29632    cat_tipo_dispositivo 
   TABLE DATA           a   COPY public.cat_tipo_dispositivo (id, nombre, descripcion, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    207   �       o          0    29638    fuente_externa 
   TABLE DATA           \   COPY public.fuente_externa (id, nombre, nombre_corto, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    208   ٕ       p          0    29641    lectura_repuve 
   TABLE DATA             COPY public.lectura_repuve (id, fecha_hora, nci, tid, niv, id_carril, fec_lectura, hora_lectura, num_placa, marca, modelo, color, img_vehiculo, estatus_vehiculos, cve_medio_lectura, tipo_cierre, cve_lista_negra, "createdAt", "updatedAt", cve_arco) FROM stdin;
    public          postgres    false    209   ��       q          0    29647    reporte 
   TABLE DATA           �   COPY public.reporte (id, niv, cordenadas, placas, id_cat_estado, id_cat_alerta, "createdAt", "updatedAt", nombre, marca, modelo, color, id_sis_entidades) FROM stdin;
    public          postgres    false    210   ��       r          0    29653    reporte_lectura_reporte 
   TABLE DATA           n   COPY public.reporte_lectura_reporte (id, id_reporte, id_lectura_repuve, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    211   ʗ       s          0    29656    sis_entidad 
   TABLE DATA           Z   COPY public.sis_entidad (id, nombre, id_cat_estado, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    212   �       t          0    29659 
   sis_perfil 
   TABLE DATA           i   COPY public.sis_perfil (id, nombre, id_cat_estado, id_sis_entidad, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    213   N�       u          0    29662    sis_perfil_sis_seccion 
   TABLE DATA           }   COPY public.sis_perfil_sis_seccion (id, id_sis_perfil, id_sis_seccion, id_sis_permiso, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    214   И       v          0    29665    sis_permiso 
   TABLE DATA           N   COPY public.sis_permiso (id, "nombre ", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    215   ,�       w          0    29668    sis_seccion 
   TABLE DATA           ]   COPY public.sis_seccion (id, "nombre ", id_cat_estado, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    216   ��       x          0    29671    unidad_repuve 
   TABLE DATA           �   COPY public.unidad_repuve (id, niv, placa_rfid, modelo, color, numero_serie_vehiculo, placa, marca_vehiculo, nci, tid, id_cat_estado, tipo_vehiculo, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    217   /�       y          0    29677    usuario 
   TABLE DATA           �   COPY public.usuario (id, nip, nombre, correo, password, telefono, id_cat_estado, id_sis_entidad, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    218   L�       �           2606    29681    arco arco_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.arco
    ADD CONSTRAINT arco_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.arco DROP CONSTRAINT arco_pkey;
       public            postgres    false    201            �           2606    29683    carril carril_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.carril
    ADD CONSTRAINT carril_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.carril DROP CONSTRAINT carril_pkey;
       public            postgres    false    203            �           2606    29685    cat_alerta cat_alertas_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cat_alerta
    ADD CONSTRAINT cat_alertas_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.cat_alerta DROP CONSTRAINT cat_alertas_pkey;
       public            postgres    false    204            �           2606    29687    cat_estado cat_estado_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.cat_estado
    ADD CONSTRAINT cat_estado_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cat_estado DROP CONSTRAINT cat_estado_pkey;
       public            postgres    false    205            �           2606    29689     cat_tipo_arco cat_tipo_arco_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.cat_tipo_arco
    ADD CONSTRAINT cat_tipo_arco_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cat_tipo_arco DROP CONSTRAINT cat_tipo_arco_pkey;
       public            postgres    false    206            �           2606    29691 .   cat_tipo_dispositivo cat_tipo_dispositivo_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.cat_tipo_dispositivo
    ADD CONSTRAINT cat_tipo_dispositivo_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.cat_tipo_dispositivo DROP CONSTRAINT cat_tipo_dispositivo_pkey;
       public            postgres    false    207            �           2606    29693 "   fuente_externa fuente_externa_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.fuente_externa
    ADD CONSTRAINT fuente_externa_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.fuente_externa DROP CONSTRAINT fuente_externa_pkey;
       public            postgres    false    208            �           2606    29695 "   lectura_repuve lectura_repuve_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.lectura_repuve
    ADD CONSTRAINT lectura_repuve_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.lectura_repuve DROP CONSTRAINT lectura_repuve_pkey;
       public            postgres    false    209            �           2606    29697 4   reporte_lectura_reporte reporte_lectura_reporte_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.reporte_lectura_reporte
    ADD CONSTRAINT reporte_lectura_reporte_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.reporte_lectura_reporte DROP CONSTRAINT reporte_lectura_reporte_pkey;
       public            postgres    false    211            �           2606    29699    reporte reporte_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.reporte
    ADD CONSTRAINT reporte_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reporte DROP CONSTRAINT reporte_pkey;
       public            postgres    false    210            �           2606    29701    sis_entidad sis_entidad_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.sis_entidad
    ADD CONSTRAINT sis_entidad_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.sis_entidad DROP CONSTRAINT sis_entidad_pkey;
       public            postgres    false    212            �           2606    29703    sis_perfil sis_perfil_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.sis_perfil
    ADD CONSTRAINT sis_perfil_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.sis_perfil DROP CONSTRAINT sis_perfil_pkey;
       public            postgres    false    213            �           2606    29705 2   sis_perfil_sis_seccion sis_perfil_sis_seccion_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.sis_perfil_sis_seccion
    ADD CONSTRAINT sis_perfil_sis_seccion_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.sis_perfil_sis_seccion DROP CONSTRAINT sis_perfil_sis_seccion_pkey;
       public            postgres    false    214            �           2606    29707    sis_permiso sis_permisos_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.sis_permiso
    ADD CONSTRAINT sis_permisos_pkey PRIMARY KEY (id);
 G   ALTER TABLE ONLY public.sis_permiso DROP CONSTRAINT sis_permisos_pkey;
       public            postgres    false    215            �           2606    29709    sis_seccion sis_seccion_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.sis_seccion
    ADD CONSTRAINT sis_seccion_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.sis_seccion DROP CONSTRAINT sis_seccion_pkey;
       public            postgres    false    216            �           2606    29711     unidad_repuve unidad_repuve_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.unidad_repuve
    ADD CONSTRAINT unidad_repuve_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.unidad_repuve DROP CONSTRAINT unidad_repuve_pkey;
       public            postgres    false    217            �           2606    29713    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    218            �           2606    29714    arco id_arco_cat_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.arco
    ADD CONSTRAINT id_arco_cat_estado FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 A   ALTER TABLE ONLY public.arco DROP CONSTRAINT id_arco_cat_estado;
       public          postgres    false    2995    201    205            �           2606    36913    arco id_arco_sis_entidades    FK CONSTRAINT     �   ALTER TABLE ONLY public.arco
    ADD CONSTRAINT id_arco_sis_entidades FOREIGN KEY (id_sis_entidades) REFERENCES public.sis_entidad(id) NOT VALID;
 D   ALTER TABLE ONLY public.arco DROP CONSTRAINT id_arco_sis_entidades;
       public          postgres    false    201    3009    212            �           2606    29719 !   arco_usuario id_arco_usuario_arco    FK CONSTRAINT        ALTER TABLE ONLY public.arco_usuario
    ADD CONSTRAINT id_arco_usuario_arco FOREIGN KEY (id_arco) REFERENCES public.arco(id);
 K   ALTER TABLE ONLY public.arco_usuario DROP CONSTRAINT id_arco_usuario_arco;
       public          postgres    false    2989    202    201            �           2606    29724 $   arco_usuario id_arco_usuario_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.arco_usuario
    ADD CONSTRAINT id_arco_usuario_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);
 N   ALTER TABLE ONLY public.arco_usuario DROP CONSTRAINT id_arco_usuario_usuario;
       public          postgres    false    202    218    3021            �           2606    29729    carril id_carril_arco    FK CONSTRAINT     s   ALTER TABLE ONLY public.carril
    ADD CONSTRAINT id_carril_arco FOREIGN KEY (id_arco) REFERENCES public.arco(id);
 ?   ALTER TABLE ONLY public.carril DROP CONSTRAINT id_carril_arco;
       public          postgres    false    201    203    2989            �           2606    40546 %   carril id_carril_cat_tipo_dispositivo    FK CONSTRAINT     �   ALTER TABLE ONLY public.carril
    ADD CONSTRAINT id_carril_cat_tipo_dispositivo FOREIGN KEY (id_tipo_dispositivo) REFERENCES public.cat_tipo_dispositivo(id);
 O   ALTER TABLE ONLY public.carril DROP CONSTRAINT id_carril_cat_tipo_dispositivo;
       public          postgres    false    2999    207    203            �           2606    29739 %   sis_seccion id_cat_estado_sis_seccion    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_seccion
    ADD CONSTRAINT id_cat_estado_sis_seccion FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 O   ALTER TABLE ONLY public.sis_seccion DROP CONSTRAINT id_cat_estado_sis_seccion;
       public          postgres    false    205    2995    216            �           2606    29744 )   cat_tipo_arco id_cat_tipo_arco_cat_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.cat_tipo_arco
    ADD CONSTRAINT id_cat_tipo_arco_cat_estado FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 S   ALTER TABLE ONLY public.cat_tipo_arco DROP CONSTRAINT id_cat_tipo_arco_cat_estado;
       public          postgres    false    206    2995    205            �           2606    41208 %   lectura_repuve id_lectura_repuve_arco    FK CONSTRAINT     �   ALTER TABLE ONLY public.lectura_repuve
    ADD CONSTRAINT id_lectura_repuve_arco FOREIGN KEY (cve_arco) REFERENCES public.arco(id) NOT VALID;
 O   ALTER TABLE ONLY public.lectura_repuve DROP CONSTRAINT id_lectura_repuve_arco;
       public          postgres    false    209    2989    201            �           2606    29749 '   lectura_repuve id_lectura_repuve_carril    FK CONSTRAINT     �   ALTER TABLE ONLY public.lectura_repuve
    ADD CONSTRAINT id_lectura_repuve_carril FOREIGN KEY (id_carril) REFERENCES public.carril(id);
 Q   ALTER TABLE ONLY public.lectura_repuve DROP CONSTRAINT id_lectura_repuve_carril;
       public          postgres    false    2991    203    209            �           2606    29754    reporte id_reporte_cat_alerta    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporte
    ADD CONSTRAINT id_reporte_cat_alerta FOREIGN KEY (id_cat_alerta) REFERENCES public.cat_alerta(id);
 G   ALTER TABLE ONLY public.reporte DROP CONSTRAINT id_reporte_cat_alerta;
       public          postgres    false    204    210    2993            �           2606    29759    reporte id_reporte_cat_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporte
    ADD CONSTRAINT id_reporte_cat_estado FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 G   ALTER TABLE ONLY public.reporte DROP CONSTRAINT id_reporte_cat_estado;
       public          postgres    false    205    2995    210            �           2606    29764 @   reporte_lectura_reporte id_reporte_lectura_repuve_lectura_repuve    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporte_lectura_reporte
    ADD CONSTRAINT id_reporte_lectura_repuve_lectura_repuve FOREIGN KEY (id_lectura_repuve) REFERENCES public.lectura_repuve(id) NOT VALID;
 j   ALTER TABLE ONLY public.reporte_lectura_reporte DROP CONSTRAINT id_reporte_lectura_repuve_lectura_repuve;
       public          postgres    false    211    209    3003            �           2606    29769 9   reporte_lectura_reporte id_reporte_lectura_repuve_reporte    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporte_lectura_reporte
    ADD CONSTRAINT id_reporte_lectura_repuve_reporte FOREIGN KEY (id_reporte) REFERENCES public.reporte(id) NOT VALID;
 c   ALTER TABLE ONLY public.reporte_lectura_reporte DROP CONSTRAINT id_reporte_lectura_repuve_reporte;
       public          postgres    false    211    210    3005            �           2606    41366     reporte id_reporte_sis_entidades    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporte
    ADD CONSTRAINT id_reporte_sis_entidades FOREIGN KEY (id_sis_entidades) REFERENCES public.sis_entidad(id) NOT VALID;
 J   ALTER TABLE ONLY public.reporte DROP CONSTRAINT id_reporte_sis_entidades;
       public          postgres    false    212    3009    210            �           2606    29774 &   sis_entidad id_sis_entidad_cat_estados    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_entidad
    ADD CONSTRAINT id_sis_entidad_cat_estados FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 P   ALTER TABLE ONLY public.sis_entidad DROP CONSTRAINT id_sis_entidad_cat_estados;
       public          postgres    false    2995    212    205            �           2606    29779 #   sis_perfil id_sis_perfil_cat_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_perfil
    ADD CONSTRAINT id_sis_perfil_cat_estado FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 M   ALTER TABLE ONLY public.sis_perfil DROP CONSTRAINT id_sis_perfil_cat_estado;
       public          postgres    false    213    205    2995            �           2606    29784 $   sis_perfil id_sis_perfil_sis_entidad    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_perfil
    ADD CONSTRAINT id_sis_perfil_sis_entidad FOREIGN KEY (id_sis_entidad) REFERENCES public.sis_entidad(id);
 N   ALTER TABLE ONLY public.sis_perfil DROP CONSTRAINT id_sis_perfil_sis_entidad;
       public          postgres    false    213    3009    212            �           2606    29789 ;   sis_perfil_sis_seccion id_sis_perfil_sis_seccion_sis_perifl    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_perfil_sis_seccion
    ADD CONSTRAINT id_sis_perfil_sis_seccion_sis_perifl FOREIGN KEY (id_sis_perfil) REFERENCES public.sis_perfil(id);
 e   ALTER TABLE ONLY public.sis_perfil_sis_seccion DROP CONSTRAINT id_sis_perfil_sis_seccion_sis_perifl;
       public          postgres    false    214    213    3011            �           2606    29794 <   sis_perfil_sis_seccion id_sis_perfil_sis_seccion_sis_permiso    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_perfil_sis_seccion
    ADD CONSTRAINT id_sis_perfil_sis_seccion_sis_permiso FOREIGN KEY (id_sis_permiso) REFERENCES public.sis_permiso(id);
 f   ALTER TABLE ONLY public.sis_perfil_sis_seccion DROP CONSTRAINT id_sis_perfil_sis_seccion_sis_permiso;
       public          postgres    false    215    3015    214            �           2606    29799 <   sis_perfil_sis_seccion id_sis_perfil_sis_seccion_sis_seccion    FK CONSTRAINT     �   ALTER TABLE ONLY public.sis_perfil_sis_seccion
    ADD CONSTRAINT id_sis_perfil_sis_seccion_sis_seccion FOREIGN KEY (id_sis_seccion) REFERENCES public.sis_seccion(id);
 f   ALTER TABLE ONLY public.sis_perfil_sis_seccion DROP CONSTRAINT id_sis_perfil_sis_seccion_sis_seccion;
       public          postgres    false    3017    216    214            �           2606    29804 )   unidad_repuve id_unidad_repuve_cat_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.unidad_repuve
    ADD CONSTRAINT id_unidad_repuve_cat_estado FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 S   ALTER TABLE ONLY public.unidad_repuve DROP CONSTRAINT id_unidad_repuve_cat_estado;
       public          postgres    false    2995    217    205            �           2606    29809    usuario id_usuario_cat_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_usuario_cat_estado FOREIGN KEY (id_cat_estado) REFERENCES public.cat_estado(id);
 G   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_usuario_cat_estado;
       public          postgres    false    2995    218    205            �           2606    29814    usuario id_usuario_sis_entidad    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_usuario_sis_entidad FOREIGN KEY (id_sis_entidad) REFERENCES public.sis_entidad(id);
 H   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_usuario_sis_entidad;
       public          postgres    false    212    218    3009            h   L  x���AO�  �s�+H�B�1
�m��l�����`�b�Ճ��ng7�%fу��{��@�t�4H���Z��:T�;�46[.���G�wH�qp8�u�.-����t��8y�G�I]��cS; ٝ�=�xK�%/�۳�����!���i �+Rt�����6�C��h���~7�e	�!sMy�ܴ�/�}�c�=���;�]�K��q��f�&[o2� (7����΄���/����
)b0����S�L�M�{ Ю63{˿�mCk=
.,�ڻi��qN�S
f��9��՜W'�f��sl�G���?;�d���{|Uåү�Y��V�ϣ      i   �   x�����0�s<E �m�Yz�6�?BE��K�3_�?J��*�� ��20�k2s��b�X�wH5f�f�y�����dq�z�-�����������">P��v�^N�d�Ա�"�｛D��r�����j�/Raİ�d�$yB�����P�      j   �  x���=k#1�z�+��'[����I��R3��n���/M��ڄ�f�)�h$�Ì^�!k(VU䪌V�W>d�P�`������}�ڏ��������l�m�ߍ���4�Ǘ�r"��R(�Qr���?ӯki����'9�O���iO��{�x��9�oݼ���1��Ϣ�g� A��cɱ"F�@�Q:*[����n.xmVJ�g���u���.vĦ��OKqT���j�"�
���8O���&�L�ڰ[�����`R%8#�2Vr�3o��p����/�[�1	�e)f%��ZR�pSMs� @��.��8*�LE�6��g���a��q�t��a)�
�w6����ch�[��\���*
je]�����oMs�=��`Q�-i��R�5p��j�y	�
�9b ��3�&���6��;��V      k   9  x����n� �3y
^�	�[Ti��]�	)M��#鴵۴K��e����mQԝfQ:`Bǜk{&��<Xѣ��N�́�@��۾�~�p��1/i$�_BN��p��V0no�hw��I�d�2]�˨�����U�L�Zc�0��^�0�i}(G8��>@k��-Kɾ�9�cH'�G:f���(m����s�K���f.i��>o�-|^��7Lq�D�n{H��3��G�# ��P��������L�oŗ������;����S�$ ��_��ssRyQ��(4
f���3�y��y����B�<lx}j��k�      l   �   x�st�tL.�,��4202�50�52W04�24�22�36671��#����陗H�	A�E�ɩ���[���YZ�����r
�t*-.,MMI$�gGN�ļ�Ԝ�r���V�Z������ZT���I�Q1z\\\ ��X*      m   �   x���A
�0��uz�\ 2���qW���$��R��W
n����1)!Q�NeCNi�A�".X��L'��K}�E��%y��H2R�<q%��j��67ƭZ��~�&=��˶*�6S���6�˿��yx�u)���{�ɷj��Ѥ��z[:��'z��Di�@X����i�bb�      n   �   x���M
�0���)�-I��݉7P�n�d�@��$�b���*u#����y����)v�BoP�1%�(Ϻ#]��At�1C�Q	%+����Z%[��e�l��ǉk��7[�˞�+����P�������j<ÏZf����n���Q��v&�C��b��*CJL�B}�1C���i%�Zs��΅��      o   �   x����
�0���)�'��i���� �8�\�K	�j���\}1-N.n�O�1���"�
�AC�:�Y�:��ź�ơ�j{y䬂����!j�|��<���"���c�A��F�Y�$����?���04��q<�XSy[�0/2ܒO�ı���y�&�3�9�e�r���:V �Zov���?�N��,_D�Q�      p      x������ � �      q   �   x���1K�@�z�+��N��d7�tz �(XX]3�;��j �5�7���!be��y<�,$]d��M
D!z��=2J��ߛ[�Վ��At����e9Fp̐��Os{s��d�w&��O���=�w{�ھG�@C�h�  ��F
���CG����{ D��G��5�K�w�� e��O4qۜ�9�^Au
��)�I���Y�,]���:1��i8��~��sv[�@�%��\�J^N�"�\�-�MUU_?�U      r      x������ � �      s   W   x�}�1� Й����K��f���������|�@ʒ��Fa�׎�h��Ҵd1w�{���'A�AYt�(��,)�?E�'���      t   r   x�}�1�0 �9yp;�m�U|�ŉ� ��_�3�.�y��1: F�f�&*��L��6���}�#m�T&����2GlÆ6Q�HT��\���k�ӬH��P�O9�E %C      u   L  x���KN�0�u{
.�*v�؞B�@B��M��?��M�h�B�([ѧ?�����zĖ!9A@�A��KvS+���ʥ�|5�d����P��b��r�4�w���J�I-�S8��'r��H��N�Y�FA�S�5[
Utt������>�Lƪ�� gf��7�2���b�Ķ �@�N��L9�����igI؃����Y���dp��4�:�o�pv�4:�5c�(��t�����ccv4:#��$�F�8�4����g�X��O�N���|�S�:cj7y
��[^�4p������4�7{����Q�[۱G�:���YG��H��bvX��s;�:?�y�?��vQ      v   [   x������+N-*I,�4202�50�52W04�21�2��360750�#�����\R���YE��>��9���yd�����
tFQ"���qqq ��9�      w   �   x���;� E�V����wQ����Y��d���S�H�4�y�y�+��D�dȁ?IbB-�TK�ou(k,�	`�q"��8X��}_����b�
(E�p(j����}����+R�8���ȶ��/�����AF�      x      x������ � �      y   �   x�}�=�0@�99pU;�t��,��H��
B�N������R�"�Q
�w�Fe��f�����k��w�G]>mi}Z7U޲�Mv��9�����?a�����(k.)GC#!�	(�'�&�!F��I�6Xk�o45�     