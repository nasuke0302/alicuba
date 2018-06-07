package services;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target(METHOD)
@Retention(RUNTIME)
public @interface Trazable {

    String nombre();

    String accion();

    String claseEntidad();

    String timeLine() default "";

    boolean listar() default false;

    boolean insertar() default false;

    boolean modificar() default false;

    boolean eliminar() default false;
}
