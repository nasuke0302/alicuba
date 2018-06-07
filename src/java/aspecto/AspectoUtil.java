package aspecto;

import services.Trazable;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

public class AspectoUtil {

    public static Trazable getTrazable(Object objeto, String nombreMetodo) {
        Trazable trazable = null;
        Method[] methods = objeto.getClass().getMethods();
        for (Method method : methods) {
            if (method.getName().equals(nombreMetodo)) {
                Annotation[] annotations = method.getDeclaredAnnotations();
                for (Annotation anotacion : annotations) {
                    if (anotacion instanceof Trazable) {
                        return trazable = (Trazable) anotacion;
                    }
                }
            }
        }
        return trazable;
    }

}
