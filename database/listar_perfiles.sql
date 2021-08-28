--SE ACTUALIZÓ EL CAMPO "nombre" DE LA TABLA "sis_seccion" YA QUE CONTABA CON UN ESPACIO AL FINAL QUE IMPEDÍA REALIZAR LA CONSULTA CORRECTAMENTE

CREATE OR REPLACE FUNCTION listar_perfiles(entrada_entidad uuid)
    RETURNS TABLE(id_sis_perfil uuid, rol character varying, accesos character varying, usuarios integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	_id_sis_perfil UUID;
	_aux_id_sis_perfil UUID;
	_rol CHARACTER VARYING;
	_accesos CHARACTER VARYING;
	_usuarios INTEGER;
BEGIN
	CREATE TEMP TABLE tmp_perfiles (
		id_sis_perfil UUID,
		rol character varying,
		accesos character varying,
		usuarios integer
	) ON COMMIT DROP;
	
	FOR _id_sis_perfil IN SELECT id 
							FROM sis_perfil
								WHERE id_sis_entidad = entrada_entidad
									AND id_cat_estado LIKE 'AC'
		LOOP
			SELECT perfil.id_sis_perfil, perfil.rol, COUNT(perfil.id_sis_perfil) INTO _aux_id_sis_perfil, _rol, _usuarios
				FROM (SELECT id AS id_sis_perfil, nombre AS rol
						FROM sis_perfil
							WHERE id = _id_sis_perfil) AS perfil	
					INNER JOIN usuario AS usu 
						ON usu.id_sis_perfil = perfil.id_sis_perfil 
							WHERE usu.id_cat_estado LIKE 'AC'
								AND usu.id_sis_entidad = entrada_entidad
							GROUP BY perfil.id_sis_perfil, perfil.rol;

			_accesos := ARRAY_TO_STRING(ARRAY(SELECT seccion.nombre::CHARACTER VARYING
				FROM (SELECT perfil_seccion.id_sis_seccion
					FROM (SELECT perfil.id_sis_perfil, perfil.rol, COUNT(perfil.id_sis_perfil) AS usuarios
						FROM (SELECT id AS id_sis_perfil, nombre AS rol
								FROM sis_perfil
									WHERE id = _id_sis_perfil) AS perfil	
							INNER JOIN usuario AS usu 
								ON usu.id_sis_perfil = perfil.id_sis_perfil 
									WHERE usu.id_cat_estado LIKE 'AC'
										AND usu.id_sis_entidad = entrada_entidad
									GROUP BY perfil.id_sis_perfil, perfil.rol) AS user_perfil
							INNER JOIN sis_perfil_sis_seccion AS perfil_seccion ON user_perfil.id_sis_perfil = perfil_seccion.id_sis_perfil
								GROUP BY user_perfil.id_sis_perfil, user_perfil.rol, user_perfil.usuarios, perfil_seccion.id_sis_seccion) AS seccion_perfil
							INNER JOIN sis_seccion AS seccion ON seccion.id = seccion_perfil.id_sis_seccion), ', ');
							
			INSERT INTO tmp_perfiles(id_sis_perfil, rol, accesos, usuarios) values (_id_sis_perfil, _rol, _accesos, _usuarios);
		END LOOP;
		
	RETURN QUERY SELECT * FROM tmp_perfiles;
	
  END;
$BODY$;

SELECT * from listar_perfiles('3115626e-eef8-11eb-ad1d-1bfaf8b7862e');






